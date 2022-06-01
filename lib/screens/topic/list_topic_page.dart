import 'package:dominhduong/screens/topic/list_topic_view_model.dart';
import 'package:dominhduong/theme/colors.dart';
import 'package:dominhduong/widgets/appbar/appbar_comp.dart';
import 'package:dominhduong/widgets/cover_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dominhduong/utils/extensions.dart';

import '../main_page/tabs/home/home_view_model.dart';

class ListTopicPage extends StatefulWidget {
  const ListTopicPage({Key? key}) : super(key: key);

  @override
  State<ListTopicPage> createState() => _ListTopicPageState();
}

class _ListTopicPageState extends State<ListTopicPage> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ListTopicViewModel>();
    return Scaffold(
        appBar: PageAppBarComp(title: 'Chủ đề bạn quan tâm'.toUpperCase()),
        body: SafeArea(
          child: CoverLoading(
            showLoading: viewModel.isLoading,
            isStack: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: ListView.separated(
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (_, index) {
                        final topic = viewModel.categories[index];
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            topic.isSelected = !topic.isSelected;
                            viewModel.updateData();
                          },
                          child: Container(
                            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1))),
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                            height: 56,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  topic.name!,
                                  style: TextStyle(fontSize: topic.isSelected ? 16 : 14, fontFamily: 'RobotoSlab'),
                                ),
                                Icon(
                                  topic.isSelected ? Icons.check_circle : Icons.circle_outlined,
                                  color: AppColors.primaryColor,
                                  size: 20,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 0);
                      },
                      itemCount: viewModel.categories.length,
                    )
                ),
                if(viewModel.categories.isNotEmpty) Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      child: Text(
                        'Xác nhận'.toUpperCase(),
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Roboto'),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.secondaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        viewModel.registerTopic(successCallback: (value) {
                          context.showMessage('Theo dõi chủ đề thành công!');
                          Navigator.of(context).pop();
                          Provider.of<HomeViewModel>(context, listen: false).loadHomeTopic();
                        }, errorCallback: (error) {
                          context.showMessage(error ?? '', type: MessageType.error);
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        )
    );
  }
}
