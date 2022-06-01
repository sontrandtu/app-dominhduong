
import 'package:dominhduong/screens/pages/single_page_view_model.dart';
import 'package:dominhduong/widgets/appbar/appbar_comp.dart';
import 'package:dominhduong/widgets/cover_loading.dart';
import 'package:dominhduong/widgets/html_content.dart';
import 'package:dominhduong/widgets/no_result_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../enum/slug.dart';
import '../../repository/user_repository.dart';

class SinglePage extends StatefulWidget {
  const SinglePage({Key? key}) : super(key: key);

  @override
  State<SinglePage> createState() => _SinglePageState();
}

class _SinglePageState extends State<SinglePage> {
  // Future.delayed(const Duration(seconds: 3), () => showAlert(context: context,screenRoute: PageRoutes.singlePage));
  @override
  Widget build(BuildContext context) {
    return Consumer<SinglePageViewModel>(
      builder:(context, viewModel, child) => Scaffold(
        appBar: PageAppBarComp(title: viewModel.page?.name!.toUpperCase() ?? ''),
        body: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                CoverLoading(
                  showLoading: viewModel.isLoading,
                  child: viewModel.isLoading ? const NoResultPage() : SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HtmlContent(content: viewModel.page?.content ?? ''),
                        SizedBox(height: viewModel.slug == Slug.aboutPage ? 10 : 0),
                        SizedBox(height: viewModel.slug == Slug.aboutPage ? 16: 0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
