import 'dart:io';
import 'package:dominhduong/base/app_provider.dart';
import 'package:dominhduong/enum/slug.dart';
import 'package:dominhduong/page_routes.dart';
import 'package:dominhduong/preference/preference.dart';
import 'package:dominhduong/screens/account/account_tab/account_tab_view_model.dart';
import 'package:dominhduong/theme/colors.dart';
import 'package:dominhduong/utils/dialog_utils.dart';
import 'package:dominhduong/utils/extensions.dart';
import 'package:dominhduong/widgets/appbar/appbar_comp.dart';
import 'package:dominhduong/widgets/cover_loading.dart';
import 'package:dominhduong/widgets/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AccountTab extends StatefulWidget {
  const AccountTab({Key? key}) : super(key: key);

  @override
  State<AccountTab> createState() => _AccountTabState();
}

class _AccountTabState extends State<AccountTab> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final viewModel = context.watch<AccountTabViewModel>();
    return Scaffold(
      appBar: PageAppBarComp(title: 'Tài khoản'.toUpperCase(), canPop: false),
      backgroundColor: const Color(0xffeeeeee),
      body: CoverLoading(
        showLoading: viewModel.isLoading,
        isStack: true,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 10),
                      color: AppColors.backgroundWhite,
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheetImage(
                                context: context,
                                imageCallBack: (image) {
                                  if(image != null){
                                   viewModel.updateAvatar(File(image), successCallback: (value) {
                                      Provider.of<AppProvider>(context, listen: false).userInfoModel = value;
                                      context.showMessage('Cập nhật hình ảnh thành công!');
                                    }, errorCallback: (error) {
                                      context.showMessage(error,type: MessageType.error);
                                    });
                                  }
                                },
                              );
                            },
                            child: Stack(
                              children: [
                                CustomNetworkImage(
                                  height: 90,
                                  width: 90,
                                  url: viewModel.userInfoModel?.image != null ? viewModel.userInfoModel!.imageUrl : '',
                                  isCircle: true,
                                  borderWidth: 2.0,
                                  borderColor: AppColors.grey,
                                  isPlaceholderImage: false,
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: SizedBox(
                                    width: 32,
                                    height: 32,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.primary,
                                        shape: BoxShape.circle,
                                        border: Border.all(width: 4, color: Colors.white),
                                      ),
                                      child: const Icon(
                                        Icons.camera_alt_outlined,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ProfileItem(
                      head: Icons.account_box_outlined,
                      title: r'Hồ sơ cá nhân',
                      tail: Icons.arrow_forward_ios_outlined,
                      nav: () {
                        Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.userInfoPage).then((value) => Provider.of<AccountTabViewModel>(context, listen: false).getAccountInfo());
                      },
                    ),
                    const SizedBox(height: 15),
                    ProfileItem(
                      head: Icons.bubble_chart_outlined,
                      title: r'Về chúng tôi',
                      tail: null,
                      nav: () {
                        Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.singlePage, arguments: Slug.aboutPage);
                      },
                    ),
                    ProfileItem(
                      head: Icons.bookmark_added_outlined,
                      title: 'Chủ đề bạn quan tâm',
                      tail: Icons.arrow_forward_ios_outlined,
                      nav: () {
                        Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.listTopicPage);
                      },
                    ),
                    ProfileItem(
                      head: Icons.history_outlined,
                      title: r'Lịch sử đặt lịch Khám & Trị liệu',
                      tail: Icons.arrow_forward_ios_outlined,
                      nav: () {
                        Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.historyPage);
                      },
                    ),
                    Container(height: 5, color: AppColors.backgroundWhite),
                    const SizedBox(height: 15),
                    ProfileItem(
                      head: Icons.book_outlined,
                      title: 'Điều khoản sử dụng',
                      tail: Icons.arrow_forward_ios_outlined,
                      nav: () {
                        Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.singlePage, arguments: Slug.termsPolicyPage);
                      },
                    ),
                    ProfileItem(
                      head: Icons.warning_amber_outlined,
                      title: 'Chính sách giải quyết khiếu nại',
                      tail: Icons.arrow_forward_ios_outlined,
                      nav: () {
                        Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.singlePage, arguments: Slug.complaintsPolicyPage);
                      },
                    ),
                    ProfileItem(
                      head: Icons.security_outlined,
                      title: 'Chính sách quyền riêng tư',
                      tail: Icons.arrow_forward_ios_outlined,
                      nav: () {
                        Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.singlePage, arguments: Slug.privacyPolicyPage);
                      },
                    ),
                    Container(height: 5, color: AppColors.backgroundWhite),
                    const SizedBox(height: 15),
                    ProfileItem(
                      head: Icons.logout_outlined,
                      title: 'Đăng xuất',
                      nav: () {
                        showDefaultDialog(
                          context,
                          title: "Đăng xuất",
                          content: "Bạn có muốn đăng xuất khỏi thiết bị hay không?",
                          onPressNo: () => Navigator.of(context).pop(),
                          onPressYes: (){
                            viewModel.logOut(successCallback: (value) {
                              PreferenceManager.logOut();
                              Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(PageRoutes.enterPhoneNumber, (route) => false);
                            }, errorCallback: (error) {
                              context.showMessage(error, type: MessageType.error);
                            });
                          }
                        );
                      },
                    ),
                    Container(height: 5, color: AppColors.backgroundWhite),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ProfileItem extends StatelessWidget {
  final IconData head;
  final IconData? tail;
  final String title;
  final Color? color;
  final VoidCallback nav;

  const ProfileItem({
    Key? key,
    required this.head,
    required this.title,
    this.color,
    this.tail,
    required this.nav,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 50,
      child: ListTile(
        onTap: nav,
        title: Text(title, style: TextStyle(fontSize: 14, color: color)),
        leading: SizedBox(
          height: 38,
          width: 38,
          child: Card(
            color: const Color.fromRGBO(215, 164, 68, 0.15),
            elevation: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Icon(head, color: AppColors.primaryColor, size: 18),
            ),
          ),
        ),
        trailing: Icon(tail, size: 10),
      ),
    );
  }
}
