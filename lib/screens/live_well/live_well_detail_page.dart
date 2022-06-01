import 'package:dominhduong/screens/live_well/live_well_detail_view_model.dart';
import 'package:dominhduong/widgets/appbar/appbar_comp.dart';
import 'package:dominhduong/widgets/article_related/article_realted_comp.dart';
import 'package:dominhduong/widgets/article_related/article_related_comp_view_model.dart';
import 'package:dominhduong/widgets/cover_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import '../../repository/user_repository.dart';
import '../../theme/colors.dart';
import '../../widgets/custom_cached_network_image.dart';
import '../../widgets/html_content.dart';

class LiveWellDetailPage extends StatefulWidget {
  const LiveWellDetailPage({Key? key}) : super(key: key);

  @override
  _LiveWellDetailPageState createState() => _LiveWellDetailPageState();
}

class _LiveWellDetailPageState extends State<LiveWellDetailPage> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LiveWellDetailViewModel>();
    return Scaffold(
      appBar: PageAppBarComp(title: 'Sống khỏe'.toUpperCase()),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Stack(
            children: [
              CoverLoading(
                showLoading: viewModel.isLoading,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 20),
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        child: Text(viewModel.article?.name ?? '',
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: AppColors.textBlack,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                height: 1.3)),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CustomNetworkImage(
                                          url: viewModel.article?.partnerImageUrl ?? '',
                                          width: 50,
                                          height: 50,
                                          backgroundColor: Colors.grey,
                                          isCircle: true,
                                          isPlaceholderImage: false
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(viewModel.article?.createName ?? ''),
                                          const SizedBox(height: 5),
                                          Text(viewModel.article?.createDate ?? ''),
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
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
                          ],
                        ),
                      ),
                      HtmlContent(content: viewModel.article?.content ?? ''),
                      const SizedBox(height: 10),
                      ChangeNotifierProvider(
                          create: (_) => ArticleRelatedCompViewModel(
                              repo: context.read(), id: viewModel.articleId),
                          child: const ArticleRelatedComp()),
                      const SizedBox(height: 25),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}