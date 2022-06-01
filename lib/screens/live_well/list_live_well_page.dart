import 'package:dominhduong/repository/user_repository.dart';
import 'package:dominhduong/screens/live_well/list_content_live_well_page.dart';
import 'package:dominhduong/screens/live_well/list_content_live_well_view_model.dart';
import 'package:dominhduong/screens/live_well/list_live_well_view_model.dart';
import 'package:dominhduong/theme/colors.dart';
import 'package:dominhduong/utils/extensions.dart';
import 'package:dominhduong/widgets/appbar/appbar_comp.dart';
import 'package:dominhduong/widgets/cover_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class ListLiveWellPage extends StatefulWidget {
  const ListLiveWellPage({Key? key}) : super(key: key);

  @override
  _ListLiveWellPageState createState() => _ListLiveWellPageState();
}

class _ListLiveWellPageState extends State<ListLiveWellPage> {
  late ListContentLiveWellViewModel _listViewModel;
  late RefreshController _listRefreshController;
  late bool _showSearchBox = false;
  late bool _isFavoriteActive = false;
  bool clearText = false;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ListLiveWellViewModel>();
    final categories = viewModel.categories;
    return CoverLoading(
      color: Colors.white,
      showLoading: viewModel.isLoading,
      child: Scaffold(
        appBar: PageAppBarComp(
          clearText: clearText,
          search: true,
          favorite: true,
          showSearchBox: _showSearchBox,
          isFavoriteActive: _isFavoriteActive,
          title: "Sống khỏe".toUpperCase(),
          searchCallback: (keyword) {
            var oldKeyword = _listViewModel.keyword;
            _listViewModel.keyword = keyword;
            if (_listViewModel.keyword != '' ||
                (oldKeyword != '' && keyword == '')) {
              _listViewModel.refreshData(
                needShowLoading: true,
                onLoadedCallback: () {
                  _listRefreshController.refreshCompleted();
                },
              );
            }
          },
          favoriteCallback: (status) {
            _listViewModel.registerTopic(
                type: status ? 'add' : 'remove',
                successCallback: (value) {
                  context.showMessage((status ? 'Theo dõi' : 'Bỏ theo dõi') +
                      ' chuyên mục thành công!');

                  setState(() {
                    _isFavoriteActive = status;
                  });
                },
                errorCallback: (error) {
                  context.showMessage(
                      (status ? 'Theo dõi' : 'Bỏ theo dõi') +
                          ' chuyên mục thất bại!',
                      type: MessageType.error);
                });
          },
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
                                onTap: (idx) {
                                  setState(() {
                                    _showSearchBox = false;
                                    clearText = !clearText;
                                  });
                                },
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
                                      userRepo:
                                          context.read<UserRepository>(),
                                      categoryId: categories[index].id ?? 0),
                                  child: ListContentLiveWellPage(
                                    modelCallback:
                                        (listViewModel, _refreshController) {
                                      listViewModel.getFavoriteStatus(
                                          categories[index].id!,
                                          successCallback: (value) {
                                        setState(() {
                                          _isFavoriteActive = value;
                                        });
                                      });
                                      _listViewModel = listViewModel;
                                      _listRefreshController =
                                          _refreshController;
                                    },
                                  ),
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
