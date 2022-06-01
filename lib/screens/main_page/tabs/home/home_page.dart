
import 'package:dominhduong/screens/main_page/main_view_model.dart';
import 'package:dominhduong/screens/main_page/tabs/home/home_view_model.dart';
import 'package:dominhduong/screens/main_page/tabs/home/widgets/category_layout.dart';
import 'package:dominhduong/screens/main_page/tabs/home/widgets/doctor_layout.dart';
import 'package:dominhduong/screens/main_page/tabs/home/widgets/fbox_icon_layout.dart';
import 'package:dominhduong/screens/main_page/tabs/home/widgets/news_layout.dart';
import 'package:dominhduong/screens/main_page/tabs/home/widgets/news_topic_layout.dart';
import 'package:dominhduong/screens/main_page/tabs/home/widgets/product_layout.dart';
import 'package:dominhduong/screens/main_page/tabs/home/widgets/services_category_layout.dart';
import 'package:dominhduong/screens/main_page/tabs/home/widgets/slider_layout.dart';
import 'package:dominhduong/screens/main_page/tabs/home/widgets/traditional_medicine_layout.dart';
import 'package:dominhduong/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../widgets/appbar/appbar_comp.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final viewModel = context.watch<HomeViewModel>();
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFFF0EAEA),
      appBar: homeAppBarComp(),
      body: SizedBox(
        child: Stack(
          children: [
            SmartRefresher(
              controller: _refreshController,
              enablePullUp: true,
              onRefresh: () {
                viewModel.loadData(onLoadedCallback: () {
                  _refreshController.refreshCompleted();
                }, errorCallback: (message) {
                  context.showMessage(message, type: MessageType.error);
                });
              },
              child: SafeArea(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    children: [
                      SliderLayout(images: viewModel.slideImages),
                      const CategoriesLayout(),
                      ServicesCategoryLayout(articles: viewModel.medicineServices),
                      TraditionalMedicineLayout(medicines: viewModel.medicines),
                      ProductLayout(products: viewModel.products),
                      DoctorLayout(doctors: viewModel.doctors),
                      NewsLayout(newArticles: viewModel.news, newsId: viewModel.newsId),
                      NewsTopicLayout(newArticles: viewModel.topicsOfInterest),
                      // const FBoxIconLayout(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
