import 'package:dominhduong/screens/main_page/tabs/home/home_view_model.dart';
import 'package:dominhduong/theme/colors.dart';
import 'package:dominhduong/utils/extensions/context_extension.dart';
import 'package:dominhduong/utils/extensions/text_styles_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dominhduong/page_routes.dart';
import 'package:provider/provider.dart';

import '../../../../../app_config.dart';

class HeaderBox extends StatelessWidget {
  final String title;
  final String viewAllTitle;
  final String pageRoute;
  final int arguments;
  const HeaderBox({Key? key, required this.title, this.viewAllTitle = '', this.pageRoute = PageRoutes.home, this.arguments = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
      child: Row(
        children: [
          Text(
              title,
              style: context.textStyle(color: AppColors.textBlack).size16.w700.fontRobotoSlab,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          GestureDetector(
            child: Text(
                viewAllTitle,
                style: context.textStyle(color: AppColors.textBlack).w400.size12.fontRobotoSlab,
              textAlign: TextAlign.center,
            ),
            onTap: () {
              if(pageRoute == PageRoutes.listLiveWellPage) {
                Navigator.of(context, rootNavigator: true).pushNamed(pageRoute).then((value) => Provider.of<HomeViewModel>(context, listen: false).loadHomeTopic());
              } else if(pageRoute == PageRoutes.newsPage) {
                Navigator.of(context, rootNavigator: true).pushNamed(pageRoute, arguments: AppConfig.newsId).then((value) => Provider.of<HomeViewModel>(context, listen: false).loadHomeTopic());
              } else {
                if(arguments != 0) {
                  Navigator.of(context, rootNavigator: true).pushNamed(pageRoute, arguments: arguments);
                } else if(pageRoute.isNotEmpty) {
                  Navigator.of(context, rootNavigator: true).pushNamed(pageRoute);
                }
              }
            },
          )
        ],
      ),
    );
  }
}
