import 'package:dominhduong/base/app_provider.dart';
import 'package:dominhduong/enum/bottom_bar_type.dart';
import 'package:dominhduong/page_routes.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  bool showFab = true;

  final homeNav = GlobalKey<NavigatorState>();
  final historyNav = GlobalKey<NavigatorState>();
  final videoNav = GlobalKey<NavigatorState>();
  final accountNav = GlobalKey<NavigatorState>();
  List<TabType> tabs = TabType.values;
  TabType currentTabType = TabType.home;

  late PageController _pageController;
  @override
  void initState() {
    showFab = true;
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    _pageController = PageController();
    Provider.of<AppProvider>(context, listen: false).navigateToTabStream.listen((event) {
      currentTab = event;
    });
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
    showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
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
        floatingActionButton: showFab ? SizedBox(
          width: 40,
          height: 40,
          child: Center(
            child: FloatingActionButton(
              elevation: 0,
              backgroundColor: AppColors.primaryColor,
              child: const Icon(Icons.add_rounded, size: 24, color: AppColors.secondaryColor),
              onPressed: () {

                Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.treatment, arguments: 0);
              },
              tooltip: "Đặt lịch",
            ),
          ),
        ) : null,
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
      return;
    }
    if (state == AppLifecycleState.paused) {
      return;
    }
  }
}
