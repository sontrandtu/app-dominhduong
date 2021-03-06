import 'dart:io';
import 'package:dominhduong/app_config.dart';
import 'package:dominhduong/base/app_provider.dart';
import 'package:dominhduong/page_routes.dart';
import 'package:dominhduong/preference/preference.dart';
import 'package:dominhduong/repository/article_repository.dart';
import 'package:dominhduong/repository/booking_repository.dart';
import 'package:dominhduong/repository/doctor_repository.dart';
import 'package:dominhduong/repository/home_repository.dart';
import 'package:dominhduong/repository/location_repository.dart';
import 'package:dominhduong/repository/sign_in_repository.dart';
import 'package:dominhduong/repository/user_repository.dart';
import 'package:dominhduong/repository/widget_repository.dart';
import 'package:dominhduong/screens/doctor/doctor_detail_page.dart';
import 'package:dominhduong/screens/doctor/doctor_detail_view_model.dart';
import 'package:dominhduong/screens/doctor/list_doctor_page.dart';
import 'package:dominhduong/screens/doctor/list_doctor_view_model.dart';
import 'package:dominhduong/screens/history/list_history_page.dart';
import 'package:dominhduong/screens/live_well/list_live_well_page.dart';
import 'package:dominhduong/screens/live_well/list_live_well_view_model.dart';
import 'package:dominhduong/screens/live_well/live_well_detail_page.dart';
import 'package:dominhduong/screens/live_well/live_well_detail_view_model.dart';
import 'package:dominhduong/screens/main_page/main_layout.dart';
import 'package:dominhduong/screens/main_page/main_view_model.dart';
import 'package:dominhduong/screens/news/list_news_page.dart';
import 'package:dominhduong/screens/news/list_news_view_model.dart';
import 'package:dominhduong/screens/news/news_detail_page.dart';
import 'package:dominhduong/screens/news/news_detail_view_model.dart';
import 'package:dominhduong/screens/service/list_service_page.dart';
import 'package:dominhduong/screens/service/list_service_view_model.dart';
import 'package:dominhduong/screens/service/service_detail_page.dart';
import 'package:dominhduong/screens/service/service_detail_view_model.dart';
import 'package:dominhduong/screens/sign_in/enter_otp/enter_otp_page.dart';
import 'package:dominhduong/screens/sign_in/enter_otp/enter_otp_view_model.dart';
import 'package:dominhduong/screens/sign_in/enter_phone_number/enter_phone_number_page.dart';
import 'package:dominhduong/screens/sign_in/enter_phone_number/enter_phone_number_view_model.dart';
import 'package:dominhduong/screens/traditional_medicine/list_traditional_medicine_page.dart';
import 'package:dominhduong/screens/traditional_medicine/list_traditional_medicine_view_model.dart';
import 'package:dominhduong/screens/traditional_medicine/traditional_medicine_detail_page.dart';
import 'package:dominhduong/screens/traditional_medicine/traditional_medicine_detail_view_model.dart';
import 'package:dominhduong/screens/video/video_detail_page.dart';
import 'package:dominhduong/screens/video/video_detail_view_model.dart';
import 'package:dominhduong/theme/colors.dart';
import 'package:dominhduong/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'global_key.dart';
import 'model/article_model.dart';
import 'screens/account/user_info/user_info_page.dart';
import 'screens/account/user_info/user_info_view_model.dart';
import 'screens/booking/booking_page.dart';
import 'screens/booking/booking_view_model.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  timeago.setLocaleMessages('vi', timeago.ViMessages());
  timeago.setLocaleMessages('vi_short', timeago.ViShortMessages());
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await PreferenceManager.init();

  String? token = PreferenceManager.getValue<String>(PreferenceManager.KEY_ACCESS_TOKEN);
  String? userId = PreferenceManager.getValue<String>(PreferenceManager.KEY_USER_ID);
  bool isUserLogged = token != null && token.isNotEmpty && userId != null && userId.isNotEmpty;
  runApp(
      MultiProvider(
          providers: [
            Provider(create: (_) => HomeRepository()),
            Provider(create: (_) => WidgetRepository()),
            Provider(create: (_) => SignInRepository()),
            Provider(create: (_) => BookingRepository()),
            // Provider(create: (_) => CategoryRepository()),
            Provider(create: (_) => ArticleRepository()),
            Provider(create: (_) => DoctorRepository()),
            Provider(create: (_) => UserRepository()),
            // Provider(create: (_) => YoutubeRepository()),
            Provider(create: (_) => LocationRepository()),
            ChangeNotifierProvider(create: (_) => AppProvider()),
            ChangeNotifierProvider(create: (_) => historyVM),
            ChangeNotifierProvider(create: (_) => homeVM),
          ],
          child: MyApp(
            isUserLogged: isUserLogged,
          )
      )
  );
}

class MyApp extends StatelessWidget {
  final bool isUserLogged;

  const MyApp({Key? key, this.isUserLogged = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.primaryColor,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
    final ThemeData theme = ThemeData.light();
    return RefreshConfiguration(
      footerBuilder: () => CustomFooter(
        height: 1,
        builder: (_, __) => const SizedBox(),
      ),
      headerBuilder: () => const MaterialClassicHeader(),
      // Configure default bottom indicator
      headerTriggerDistance: 80.0,
      // header trigger refresh trigger distance
      springDescription:
      const SpringDescription(stiffness: 170, damping: 16, mass: 1.9),
      // custom spring back animate,the props meaning see the flutter api
      maxOverScrollExtent: 100,
      //The maximum dragging range of the head. Set this property if a rush out   of the view area occurs
      maxUnderScrollExtent: 0,
      footerTriggerDistance: 2000,
      // Maximum dragging range at the bottom
      enableScrollWhenRefreshCompleted: true,
      //This property is incompatible with PageView and TabBarView. If you need TabBarView to slide left and right, you need to set it to true.
      enableLoadingWhenFailed: true,
      //In the case of load failure, users can still trigger more loads by gesture pull-up.
      hideFooterWhenNotFull: true,
      // Disable pull-up to load more functionality when Viewport is less than one screen
      enableBallisticLoad: true,
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        navigatorKey: mainKey,
        builder: (context, child) {
          return ResponsiveWrapper.builder(
            BouncingScrollWrapper.builder(context, child!),
            maxWidth: 1200,
            minWidth: 375,
            defaultScale: true,
            breakpoints: [
              const ResponsiveBreakpoint.resize(450, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(800, name: TABLET),
              const ResponsiveBreakpoint.autoScale(1600, name: TABLET),
              const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
              const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
            ],
          );
        },
        supportedLocales: const <Locale>[
          // put all locales you want to support here
          Locale('en', 'US'),
          Locale('vi', 'VI'),
        ],
        title: AppConfig.title,
        theme: ThemeData(
          // Define the default brightness and colors.
            primaryColor: AppColors.primaryColor,
            primarySwatch: AppColors.primaryColor,
            buttonTheme: theme.buttonTheme.copyWith(
              buttonColor: AppColors.secondaryColor,
              textTheme: ButtonTextTheme.primary,
            ),
            dividerColor: Colors.grey.withOpacity(0.1),
            // Define the default font family.
            fontFamily: 'Roboto',
            textTheme: AppStyles.textTheme),
        darkTheme: ThemeData.dark().copyWith(
          primaryColor: Colors.black45,
          cardColor: Colors.black87,
        ),
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        initialRoute: isUserLogged ? PageRoutes.main : PageRoutes.enterPhoneNumber,
        routes: _pageMap(),
      ),
    );
  }

  _pageMap() {
    return <String, WidgetBuilder>{
      PageRoutes.main: (BuildContext context) {
        return ChangeNotifierProvider(create: (_) => MainViewModel(context.read()), child: const MainLayout());
      },
      PageRoutes.enterPhoneNumber: (BuildContext context) {
        return ChangeNotifierProvider(create: (_) => EnterPhoneNumberViewModel(context.read()), child: const EnterPhoneNumberPage());
      },
      PageRoutes.enterOTP: (BuildContext context) {
        final arguments = ModalRoute.of(context)?.settings.arguments as List;
        return ChangeNotifierProvider(create: (_) => EnterOTPViewModel(repo: context.read(), phoneNumber: arguments[0], otp: arguments[1]), child: const EnterOTPPage());
      },
      PageRoutes.listDoctorPage: (BuildContext context) {
        return ChangeNotifierProvider(create: (_) => ListDoctorViewModel(context.read()), child: const ListDoctorPage());
      },
      PageRoutes.doctorDetailPage: (BuildContext context) {
        final doctorId = ModalRoute.of(context)?.settings.arguments as int;
        return ChangeNotifierProvider(create: (_) => DoctorDetailViewModel(repo: context.read<DoctorRepository>(), doctorId: doctorId), child: const DoctorDetailPage());
      },
      PageRoutes.listLiveWellPage: (BuildContext context) {
        return ChangeNotifierProvider(create: (_) => ListLiveWellViewModel(repo: context.read(), userRepo: context.read<UserRepository>()), child: const ListLiveWellPage());
      },
      PageRoutes.liveWellDetailPage: (BuildContext context) {
        final articleId = ModalRoute.of(context)?.settings.arguments as int;
        return ChangeNotifierProvider(create: (_) => LiveWellDetailViewModel(repo: context.read<ArticleRepository>(), articleId: articleId), child: const LiveWellDetailPage());
      },
      PageRoutes.newsPage: (BuildContext context) {
        final catId = ModalRoute.of(context)?.settings.arguments as int;
        return ChangeNotifierProvider(create: (_) => ListNewsViewModel(repo: context.read(), userRepo: context.read<UserRepository>(), catId: catId), child: const ListNewsPage());
      },
      PageRoutes.newsDetailPage: (BuildContext context) {
        final articleId = ModalRoute.of(context)?.settings.arguments as int;
        return ChangeNotifierProvider(create: (_) => NewsDetailViewModel(repo: context.read<ArticleRepository>(), articleId: articleId), child: const NewsDetailPage());
      },
      PageRoutes.servicePage: (BuildContext context) {
        return ChangeNotifierProvider(create: (_) => ListServiceViewModel(context.read()), child: const ListServicePage());
      },
      PageRoutes.serviceDetailPage: (BuildContext context) {
        final articleId = ModalRoute.of(context)?.settings.arguments as int;
        return ChangeNotifierProvider(create: (_) => ServiceDetailViewModel(repo: context.read<ArticleRepository>(), articleId: articleId), child: const ServiceDetailPage());
      },
      PageRoutes.traditionalMedicinePage: (BuildContext context) {
        return ChangeNotifierProvider(create: (_) => ListTraditionalMedicineViewModel(context.read()), child: const ListTraditionalMedicinePage());
      },
      PageRoutes.traditionalMedicineDetailPage: (BuildContext context) {
        final articleId = ModalRoute.of(context)?.settings.arguments as int;
        return ChangeNotifierProvider(create: (_) => TraditionalMedicineDetailViewModel(repo: context.read<ArticleRepository>(), articleId: articleId), child: const TraditionalMedicineDetailPage());
      },
      PageRoutes.userInfoPage: (BuildContext context) {
        return ChangeNotifierProvider(create: (_) => UserInfoViewModel(userRepo: context.read<UserRepository>()), child: const UserInfoPage());
      },
      PageRoutes.videoDetailPage: (BuildContext context) {
        final args = ModalRoute.of(context)?.settings.arguments as List<dynamic>;
        return ChangeNotifierProvider(create: (_) => VideoDetailViewModel(repo: context.read<ArticleRepository>(), articleModel: args[0] as ArticleModel, categoryName: args[1] as String), child: const VideoDetailPage());
      },
      PageRoutes.historyPage: (BuildContext context) {
        return ChangeNotifierProvider(
            create: (_) => historyVM,
            child: const ListHistoryPage()
        );
      },
      PageRoutes.treatment: (BuildContext context) {
        final int arguments = ModalRoute.of(context)?.settings.arguments as int;
        // int branchId = arguments.isNotEmpty ? arguments[0] : 0;
        // int doctorId = arguments.isNotEmpty ? arguments[1] : 0;
        return ChangeNotifierProvider(create: (_) => BookingViewModel(repo: context.read(), doctorRepo: context.read<DoctorRepository>(), userRepo: context.read<UserRepository>(), doctorId: arguments), child: const BookingPage(type: 'main'));
      },
    };
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
