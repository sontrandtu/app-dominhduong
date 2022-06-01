import 'package:dominhduong/screens/video/list_video_view_model.dart';
import 'package:dominhduong/theme/colors.dart';
import 'package:dominhduong/widgets/cover_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/appbar/appbar_comp.dart';
import 'list_content_video_page.dart';
import 'list_content_video_view_model.dart';

class ListVideoPage extends StatelessWidget {
  const ListVideoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ListVideoViewModel>();
    final categories = viewModel.categories;
    return CoverLoading(
      color: Colors.white,
      showLoading: viewModel.isLoading,
      child: Scaffold(
        backgroundColor: const Color(0xffffffff),
        appBar: PageAppBarComp(title: 'videos'.toUpperCase(), canPop: false),
        body: Stack(
          children: [
            DefaultTabController(
              length: categories.length,
              child: Column(
                children: <Widget>[
                  Container(
                    constraints: const BoxConstraints(maxHeight: 100),
                    child: Material(
                      color: Colors.white,
                      child: categories.isNotEmpty ? TabBar(
                        unselectedLabelColor: AppColors.secondaryColor,
                        labelColor: AppColors.primaryColor,
                        indicatorColor: AppColors.primaryColor,
                        indicatorWeight: 3,
                        isScrollable: true,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        tabs: List.generate(categories.length,
                              (int index) {
                            return SizedBox(
                              height: 40,
                              child: Tab(
                                child: Text(
                                  categories[index].name.toString(),
                                  style: const TextStyle(fontSize: 14, fontFamily: 'Roboto', fontWeight: FontWeight.w700),
                                ),
                              ),
                            );
                          },
                        ),
                      ) : null,
                    ),
                  ),
                  Expanded(
                    child: categories.isNotEmpty
                        ? TabBarView(
                      children:
                      List.generate(categories.length, (index) {
                        return ChangeNotifierProvider(
                          create: (_) => ListContentVideoViewModel(repo: context.read(),categoryId: categories[index].id ?? 0,categoryName: categories[index].name),
                          child: const ListContentVideoPage());
                        },
                      ),
                    ) : const SizedBox(width: 0),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
