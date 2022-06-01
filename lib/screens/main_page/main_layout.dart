import 'dart:convert';
import 'dart:io';
import 'package:dominhduong/base/app_provider.dart';
import 'package:dominhduong/enum/bottom_bar_type.dart';
import 'package:dominhduong/page_routes.dart';
import 'package:dominhduong/preference/preference.dart';
import 'package:dominhduong/res.dart';
import 'package:dominhduong/screens/account/account_tab/account_tab.dart';
import 'package:dominhduong/screens/account/account_tab/account_tab_view_model.dart';
import 'package:dominhduong/screens/main_page/main_view_model.dart';
import 'package:dominhduong/screens/main_page/tabs/home/home_page.dart';
import 'package:dominhduong/screens/video/list_video_page.dart';
import 'package:dominhduong/screens/video/list_video_view_model.dart';
import 'package:dominhduong/theme/colors.dart';
import 'package:dominhduong/utils/extensions/context_extension.dart';
import 'package:dominhduong/utils/extensions/text_styles_extension.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../global_key.dart';
import '../../utils/dialog_utils.dart';
import '../history/list_history_page.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _TabsPageState();
}

class _TabsPageState extends State<MainLayout> with WidgetsBindingObserver{
  int _currentIndex = 0;
  MainViewModel get viewModel => context.read<MainViewModel>();
  onPressedNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('launch_background');
    const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid,);
    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onSelectNotification: (String? data) async {
          // decreaseBadger();
          final map = jsonDecode(data!) as Map<String, dynamic>;
          actionWhenReceiverNotification(RemoteMessage(data: map));
        }
    );
  }

  onListenerMessage() async {
    if (Platform.isAndroid) {
      await onPressedNotification();
    }

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null && message is RemoteMessage) {
        actionWhenReceiverNotification(message);
      }
    });

    FirebaseMessaging.instance.getToken().then((value) async {
      await PreferenceManager.setValue<String>(PreferenceManager.KEY_FCM_TOKEN, value!);
      context.read<MainViewModel>().pushFCMTokenToBackend(value);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage? message) async {
      RemoteNotification? notification = message?.notification;
      AndroidNotification? android = message?.notification?.android;
      // increaseBadger();
      if (android != null && notification != null) {
        await flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                importance: Importance.max,
                priority: Priority.high,
                icon: '@drawable/ic_launcher_foreground'),
          ),
          payload: jsonEncode(message?.data),
        );
      }
    });

    FirebaseMessaging.onBackgroundMessage((message) async {
      actionWhenReceiverNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // decreaseBadger();
      actionWhenReceiverNotification(message);
    });
    requestPermission();
  }

  actionWhenReceiverNotification(RemoteMessage message) {
    final data = message.data;
    if (data.containsKey('route') && data.containsKey('route_id')) {
      if (data['route'] == '/list_order_page') {
        return Navigator.pushNamed(context, data['route'], arguments: [0, int.parse(data['id'])]);
      }
      return Navigator.pushNamed(context, data['route'], arguments: int.parse(data['id']));
    }
    if (data.containsKey('route')) {
      return Navigator.pushNamed(context, data['route']);
    }
  }

  // increaseBadger() {
  //   if (Platform.isAndroid) {
  //     var count = PreferenceManager.getValue<int>(PreferenceManager.KEY_UNREAD_MESSAGE) ?? 0;
  //     PreferenceManager.setValue(PreferenceManager.KEY_UNREAD_MESSAGE, ++count);
  //     FlutterAppBadger.updateBadgeCount(count);
  //   }
  // }
  // decreaseBadger() {
  //   if (Platform.isAndroid) {
  //     var count = PreferenceManager.getValue<int>(PreferenceManager.KEY_UNREAD_MESSAGE) ?? 0;
  //     PreferenceManager.setValue(PreferenceManager.KEY_UNREAD_MESSAGE, count <= 1 ? 0 : --count);
  //     FlutterAppBadger.updateBadgeCount(count);
  //   } else {
  //     context.read<MainViewModel>().decreaseBadge();
  //   }
  // }

  requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  final homeNav = GlobalKey<NavigatorState>();
  final historyNav = GlobalKey<NavigatorState>();
  final videoNav = GlobalKey<NavigatorState>();
  final accountNav = GlobalKey<NavigatorState>();
  List<TabType> tabs = TabType.values;
  TabType currentTabType = TabType.home;

  late PageController _pageController;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    _pageController = PageController();
    Provider.of<AppProvider>(context, listen: false).navigateToTabStream.listen((event) {
      currentTab = event;
    });
    onListenerMessage();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget navigationItem(TabType tabType, String? icon) {
    return Expanded(
      child: MaterialButton(
        elevation: 0,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        minWidth: 30,
        padding: EdgeInsets.zero,
        onPressed: () {
          icon != null ? currentTab = tabType : false;
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon != null ? SvgPicture.asset(icon, color: currentTabType != tabType ? AppColors.secondaryColor : AppColors.textWhite, height: 20) : const SizedBox(height: 20),
              const SizedBox(height: 2),
              Text(icon != null ? tabType.label : 'Đặt lịch', style: context.textStyle(color: currentTabType != tabType || icon == null ? AppColors.secondaryColor : AppColors.textWhite).size11.fontRobotoSlab),
            ],
          ),
        ),
      ),
    );
  }

  set currentTab(TabType value) {
    currentTabType = value;
    context.hideKeyboard();
    _currentIndex = tabs.indexOf(value);
    _pageController.jumpToPage(_currentIndex);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex == 0) {
          homeNav.currentState?.maybePop().then((stackHasItem) {
            if (!stackHasItem) {
              showDefaultDialog(
                context,
                title: 'Thoát ứng dụng',
                content: 'Bạn có chắc chắn muốn thoát?',
                onPressNo: () => Navigator.of(context).pop(),
                onPressYes: () => SystemNavigator.pop(),
              );
            }
          });
        }
        if (_currentIndex == 1) {
          historyNav.currentState?.maybePop().then((stackHasItem) {
            if (!stackHasItem) {
              currentTab = TabType.home;
            }
          });
        }
        if (_currentIndex == 2) {
          videoNav.currentState?.maybePop().then((stackHasItem) {
            if (!stackHasItem) {
              currentTab = TabType.home;
            }
          });
        }
        if (_currentIndex == 3) {
          accountNav.currentState?.maybePop().then((stackHasItem) {
            if (!stackHasItem) {
              currentTab = TabType.home;
            }
          });
        }
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        // extendBodyBehindAppBar: true,
        extendBody: true,
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            Navigator(
                key: homeNav,
                initialRoute: PageRoutes.home,
                onGenerateRoute: (RouteSettings settings) {
                  WidgetBuilder builder;
                  switch (settings.name) {
                    case PageRoutes.home:
                      builder = (BuildContext _) => ChangeNotifierProvider(
                          create: (_) => homeVM,
                          child: const HomePage()
                      );
                      break;
                    default:
                      throw Exception('HomeNav Invalid Route: ${settings.name}');
                  }
                  return MaterialPageRoute(builder: builder, settings: settings);
                }),
            Navigator(
                key: historyNav,
                initialRoute: PageRoutes.history,
                onGenerateRoute: (RouteSettings settings) {
                  WidgetBuilder builder;
                  switch (settings.name) {
                    case PageRoutes.history:
                      builder = (BuildContext _) => ChangeNotifierProvider(
                          create: (_) => historyVM,
                          child: const ListHistoryPage(isMain: true, canPop: false)
                      );
                      break;
                  // case PageRoutes.treatmentSuccess:
                  //   builder = (BuildContext _) => ChangeNotifierProvider(
                  //       create: (_) => BookingViewModel(
                  //           repo: context.read(),
                  //           doctorRepo: context.read(),
                  //           userRepo: context.read<UserRepository>()),
                  //       child: const BookingSuccessPage());
                  //   break;
                    default:
                      throw Exception('BookingNav Invalid Route: ${settings.name}');
                  }
                  return MaterialPageRoute(builder: builder, settings: settings);
                }),
            Navigator(
              key: videoNav,
              initialRoute: PageRoutes.video,
              onGenerateRoute: (RouteSettings settings) {
                WidgetBuilder builder;
                switch (settings.name) {
                  case PageRoutes.video:
                    builder = (BuildContext _) => ChangeNotifierProvider(
                        create: (_) => ListVideoViewModel(context.read()),
                        child: const ListVideoPage()
                    );
                    break;
                  default:throw Exception('VideoNav Invalid Route: ${settings.name}');
                }
                return MaterialPageRoute(builder: builder, settings: settings);
              },
            ),
            Navigator(
              key: accountNav,
              initialRoute: PageRoutes.account,
              onGenerateRoute: (RouteSettings settings) {
                WidgetBuilder builder;
                switch (settings.name) {
                  case PageRoutes.account:
                    builder = (BuildContext nestedContext) {
                      return ChangeNotifierProvider(
                          create: (_) => AccountTabViewModel(context.read()),
                          child: const AccountTab()
                      );
                    };
                    break;
                  default:
                    throw Exception('AccountNav Invalid Route: ${settings.name}');
                }
                return MaterialPageRoute(builder: builder, settings: settings);
              },
            ),
          ],
        ),
        floatingActionButton: SizedBox(
          width: 40,
          height: 40,
          child: Center(
            child: FloatingActionButton(
              elevation: 0,
              backgroundColor: AppColors.primaryColor,
              child: const Icon(Icons.add_rounded, size: 24, color: AppColors.secondaryColor),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.treatment, arguments: []);
              },
              tooltip: "Đặt lịch",
            ),
          ),
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
        bottomNavigationBar: BottomAppBar(
          color: AppColors.primaryColor,
          elevation: 0,
          shape: const CircularNotchedRectangle(),
          notchMargin: 4,
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                navigationItem(TabType.home, Res.ic_home),
                navigationItem(TabType.booking, Res.ic_calendar),
                navigationItem(TabType.booking, null),
                navigationItem(TabType.video, Res.ic_video),
                navigationItem(TabType.account, Res.ic_user),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      viewModel.updateOnlineStatus(true);
      return;
    }
    if (state == AppLifecycleState.paused) {
      viewModel.updateOnlineStatus(false);
      return;
    }
  }
}
