import 'package:dominhduong/screens/traditional_medicine/traditional_medicine_detail_view_model.dart';
import 'package:dominhduong/widgets/appbar/appbar_comp.dart';
import 'package:dominhduong/widgets/cover_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import '../../theme/colors.dart';
import '../../widgets/article_related/article_related_comp.dart';
import '../../widgets/article_related/article_related_view_model.dart';
import '../../widgets/html_content.dart';

class TraditionalMedicineDetailPage extends StatefulWidget {
  const TraditionalMedicineDetailPage({Key? key}) : super(key: key);

  @override
  _TraditionalMedicineDetailPageState createState() => _TraditionalMedicineDetailPageState();
}

class _TraditionalMedicineDetailPageState extends State<TraditionalMedicineDetailPage> {
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TraditionalMedicineDetailViewModel>();
    return Scaffold(
        appBar: PageAppBarComp(title: 'Bài thuốc gia truyền'.toUpperCase()),
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
                        child: SmoothStarRating(
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
                      ),
                      HtmlContent(content: viewModel.article?.content ?? ''),
                      const SizedBox(height: 10),
                      ChangeNotifierProvider(create: (_) => ArticleRelatedCompViewModel(repo: context.read(), id: viewModel.articleId), child: const ArticleRelatedComp()),
                      const SizedBox(height: 25),
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
