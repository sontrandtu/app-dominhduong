import 'package:dominhduong/page_routes.dart';
import 'package:dominhduong/res.dart';
import 'package:flutter/material.dart';
import '../../../../../theme/colors.dart';

class CategoriesLayout extends StatelessWidget {
  const CategoriesLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 10, left: 0, right: 0),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 3/2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 0,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        crossAxisCount: 2,
        children: [
          CategoryIcon(
              iconSource: Res.ic_booking_date,
              text: "Đặt lịch\nkhám/trị liệu",
              width: 35,
              height: 35,
              onSelected: () {
                // Provider.of<AppProvider>(context, listen: false).navigateTo = TabType.booking;
                Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.treatment, arguments: []);
              }
          ),
          CategoryIcon(
              iconSource: Res.ic_booking_consultant,
              text: "Đặt mua thuốc\n",
              width: 35,
              height: 35,
              onSelected: () {
                Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.orderMedicinePage);
              }
          ),
        ],
      ),
    );
  }
}

class CategoryIcon extends StatelessWidget {
  final String iconSource;
  final String text;
  final double width;
  final double height;
  final VoidCallback onSelected;

  const CategoryIcon({Key? key, required this.iconSource, required this.text, required this.onSelected, required this.width, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(8)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconSource, height: width, width: height),
            const SizedBox(height: 2),
            Text(text, textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, color: AppColors.secondaryColor, height: 1.3)),
          ],
        ),
      ),
    );
  }
}
