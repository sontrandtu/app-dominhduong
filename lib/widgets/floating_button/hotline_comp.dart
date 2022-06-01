import 'package:dominhduong/model/branch_children_model.dart';
import 'package:dominhduong/theme/colors.dart';
import 'package:dominhduong/utils/extensions.dart';
import 'package:dominhduong/widgets/cover_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../res.dart';
import 'hotline_view_model.dart';

class HotlineComp extends StatelessWidget{
  const HotlineComp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HotlineViewModel>();
    return SafeArea(
      child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: StatefulBuilder(
              builder:(BuildContext context, StateSetter setState) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: DefaultTabController(
                      length: viewModel.branches.length,
                      child: CoverLoading(
                        showLoading: viewModel.isLoading,
                        child: Scaffold(
                          backgroundColor: Colors.transparent,
                          appBar: viewModel.branches.isNotEmpty ? TabBar(
                            unselectedLabelColor: AppColors.secondaryColor,
                            labelColor: AppColors.primaryColor,
                            indicatorColor: AppColors.primaryColor,
                            indicatorWeight: 3,
                            // isScrollable: true,
                            tabs: List.generate(viewModel.branches.length, (int index) {
                              return SizedBox(
                                height: 40,
                                child: Tab(
                                  child: Text(
                                    viewModel.branches[index].name.toString(),
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                                  ),
                                ),
                              );
                            }),
                            // indicator: ShapeDecoration(
                            //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(18.0), topLeft: Radius.circular(18.0))),
                            //     color: Colors.red
                            // ),
                          ) : null,
                          body: viewModel.branches.isNotEmpty ? TabBarView(
                            children: List.generate(viewModel.branches.length, (int index) {
                              List<BranchChildrenModel>? children = viewModel.branches[index].children ?? [];
                              return ListView.separated(
                                physics: const ClampingScrollPhysics(),
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                                itemBuilder: (_, index) {
                                  return GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
                                            context: context,
                                            isDismissible: true,
                                            useRootNavigator: true,
                                            backgroundColor: Colors.transparent,
                                            builder: (context) {
                                              return Container(
                                                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                                                width: MediaQuery.of(context).size.width,
                                                height: MediaQuery.of(context).size.height / 2,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width: double.infinity,
                                                      height: 48,
                                                      child: ElevatedButton(
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            SvgPicture.asset(Res.ic_phone_2, width: 20, height: 20, color: AppColors.primaryColor),
                                                            const SizedBox(width: 15),
                                                            Text(
                                                              'Zalo   ${children[index].phone!}',
                                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.primaryColor),
                                                            ),
                                                          ],
                                                        ),
                                                        style: ElevatedButton.styleFrom(
                                                          primary: AppColors.backgroundWhite,
                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                        ),
                                                        onPressed: () async{
                                                          String zaloUrl = 'https://zalo.me/${children[index].phone!.replaceAll(RegExp(r"\s+"), "")}';
                                                          await canLaunch(zaloUrl) ? launch(zaloUrl) : context.showMessage('Zalo app not installed!', type: MessageType.error);
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(height: 18),
                                                    SizedBox(
                                                      width: double.infinity,
                                                      height: 48,
                                                      child: ElevatedButton(
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            SvgPicture.asset(Res.ic_phone_2, width: 20, height: 20, color: AppColors.primaryColor),
                                                            const SizedBox(width: 15),
                                                            Text(
                                                              'Gọi   ${children[index].phone!}',
                                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.primaryColor),
                                                            ),
                                                          ],
                                                        ),
                                                        style: ElevatedButton.styleFrom(
                                                          primary: AppColors.backgroundWhite,
                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                        ),
                                                        onPressed: () async{
                                                          // var skypeUrl = 'skype:0982445511';
                                                          // await canLaunch(skypeUrl) ? launch(skypeUrl) : context.showMessage('Skype app not installed!', type: MessageType.error);
                                                          //
                                                          // var zaloUrl = 'https://zalo.me/0982445511';
                                                          // await canLaunch(zaloUrl) ? launch(zaloUrl) : context.showMessage('Zalo app not installed!', type: MessageType.error);
                                                          var telUrl = 'tel:${children[index].phone!.replaceAll(RegExp(r"\s+"), "")}';
                                                          await canLaunch(telUrl) ? launch(telUrl) : context.showMessage('Phone app not installed!', type: MessageType.error);
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(height: 18),
                                                    SizedBox(
                                                      width: double.infinity,
                                                      height: 48,
                                                      child: ElevatedButton(
                                                        child: const Text(
                                                          'Hủy',
                                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                                                        ),
                                                        style: ElevatedButton.styleFrom(
                                                          primary: AppColors.backgroundWhite,
                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border(
                                            bottom: BorderSide(
                                              color: index == children.length - 1 ? Colors.transparent : Colors.black.withOpacity(0.1),
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        padding: const EdgeInsets.only(top: 12, bottom: 12),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                SvgPicture.asset(Res.ic_phone_2, width: 20, height: 20),
                                                const SizedBox(width: 20),
                                                const Text('Gọi điện', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.textBlack)),
                                              ],
                                            ),
                                            Text(children[index].phone!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textBlack))
                                          ],
                                        ),
                                      )
                                  );
                                },
                                itemCount: children.length,
                                separatorBuilder: (_, __) {
                                  return const SizedBox(height: 0);
                                },
                              );
                            }),
                          ) : const SizedBox(width: 0),
                        ),
                      )
                  ),
                );
              }
          )
      ),
    );
  }
}
