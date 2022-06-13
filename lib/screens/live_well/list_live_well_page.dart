import 'package:dominhduong/repository/user_repository.dart';
import 'package:dominhduong/screens/live_well/list_content_live_well_page.dart';
import 'package:dominhduong/screens/live_well/list_content_live_well_view_model.dart';
import 'package:dominhduong/screens/live_well/list_live_well_view_model.dart';
import 'package:dominhduong/theme/colors.dart';
import 'package:dominhduong/widgets/appbar/appbar_comp.dart';
import 'package:dominhduong/widgets/cover_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListLiveWellPage extends StatefulWidget {
  const ListLiveWellPage({Key? key}) : super(key: key);

  @override
  _ListLiveWellPageState createState() => _ListLiveWellPageState();
}

class _ListLiveWellPageState extends State<ListLiveWellPage> {

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ListLiveWellViewModel>();
    final categories = viewModel.categories;
    return CoverLoading(
      color: Colors.white,
      showLoading: viewModel.isLoading,
      child: Scaffold(
        appBar: PageAppBarComp(
          title: "Sống khỏe".toUpperCase(),
        ),
        backgroundColor: const Color(0xFFFFFFFF),
        body: SafeArea(
          child: Stack(
            children: [
              DefaultTabController(
                length: categories.length,
                child: Column(
                  children: <Widget>[
                    Container(
                      constraints: const BoxConstraints(maxHeight: 100),
                      child: Material(
                        color: Colors.white,
                        child: categories.isNotEmpty
                            ? TabBar(
                                unselectedLabelColor: AppColors.secondaryColor,
                                labelColor: AppColors.primaryColor,
                                indicatorColor: AppColors.primaryColor,
                                indicatorWeight: 3,
                                isScrollable: true,
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                tabs: List.generate(categories.length,
                                    (int index) {
                                  return SizedBox(
                                    height: 40,
                                    child: Tab(
                                      child: Text(
                                        categories[index].name.toString(),
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  );
                                }),
                              )
                            : null,
                      ),
                    ),
                    Expanded(
                      child: categories.isNotEmpty
                          ? TabBarView(
                              children:
                                  List.generate(categories.length, (int index) {
                                return ChangeNotifierProvider(
                                  create: (_) => ListContentLiveWellViewModel(
                                      repo: context.read(),
                                      userRepo: context.read<UserRepository>(),
                                      categoryId: categories[index].id ?? 0),
                                  child: const ListContentLiveWellPage(),
                                );
                              }),
                            )
                          : const SizedBox(width: 0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
