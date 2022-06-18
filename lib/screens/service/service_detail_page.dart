import 'package:dominhduong/screens/service/service_detail_view_model.dart';
import 'package:dominhduong/widgets/appbar/appbar_comp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import '../../page_routes.dart';
import '../../res.dart';
import '../../theme/colors.dart';
import '../../widgets/article_related/article_related_comp.dart';
import '../../widgets/article_related/article_related_view_model.dart';
import '../../widgets/cover_loading.dart';
import '../../widgets/html_content.dart';

class ServiceDetailPage extends StatefulWidget {
  const ServiceDetailPage({Key? key}) : super(key: key);

  @override
  _ServiceDetailPageState createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends State<ServiceDetailPage> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ServiceDetailViewModel>();
    return Scaffold(
        appBar: PageAppBarComp(title: 'Dịch vụ'.toUpperCase()),
        body: SafeArea(
          child: Stack(
            children: [
              CoverLoading(
                showLoading: viewModel.isLoading,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: Text(
                            viewModel.article?.name ?? '',
                            textAlign: TextAlign.start,
                            style: const TextStyle(color: AppColors.textBlack, fontSize: 20, fontWeight: FontWeight.w700, height: 1.3)
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SmoothStarRating(
                              rating: viewModel.article?.rating ?? 0,
                              size: 26,
                              filledIconData: Icons.star,
                              halfFilledIconData: Icons.star_half,
                              defaultIconData: Icons.star_border,
                              starCount: 5,
                              allowHalfRating: false,
                              spacing: 2.0,
                              onRatingChanged: (value) {},
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.treatment, arguments: []);
                              },
                              child: Container(
                                  width: 110,
                                  height: 32,
                                  decoration: BoxDecoration(
                                      color: AppColors.secondaryColor,
                                      borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(Res.ic_calendar_dc, width: 28.36, height: 24,),
                                      const SizedBox(width: 8),
                                      const Text(
                                          'Đặt lịch',
                                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textWhite)
                                      )
                                    ],
                                  )
                              ),
                            )
                          ],
                        ),
                      ),
                      HtmlContent(content: viewModel.article?.content ?? ''),
                      const SizedBox(height: 10),
                      ChangeNotifierProvider(create: (_) => ArticleRelatedCompViewModel(repo: context.read(), id: viewModel.articleId), child: const ArticleRelatedComp(title: 'Có thể bạn quan tâm')),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}

/*
* */
