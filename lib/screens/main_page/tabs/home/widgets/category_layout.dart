import 'package:dominhduong/page_routes.dart';
import 'package:dominhduong/res.dart';
import 'package:flutter/material.dart';
import '../../../../../theme/colors.dart';

class CategoriesLayout extends StatelessWidget {
  const CategoriesLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.treatment, arguments: []),
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Container(
          height: 120,
          width: 120,
          padding: const EdgeInsets.only(top: 20, bottom: 10, left: 0, right: 0),
          decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Res.ic_booking_date, height: 35, width: 35),
              const SizedBox(height: 2),
              const Text("Đặt lịch\nkhám/trị liệu", textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, color: AppColors.secondaryColor, height: 1.3)),
            ],
          ),
        ),
      ),
    );
  }
}