import 'package:dominhduong/res.dart';
import 'package:dominhduong/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookingSuccessPage extends StatelessWidget {
  const BookingSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.secondaryColor),
        elevation: 0,
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.clear_rounded,
                  color: AppColors.secondaryColor, size: 20),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        title: const Text('Đặt lịch thành công!',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.secondaryColor,
                fontSize: 16,
                fontFamily: 'RobotoSlab',
                fontWeight: FontWeight.w700)),
        backgroundColor: AppColors.primaryColor,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColors.primaryColor,
            statusBarIconBrightness: Brightness.dark),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 350,
              width: 350,
              child: SvgPicture.asset(Res.image_booking_success),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 42),
              child: Text(
                "Cảm ơn bạn đã tin tưởng đặt lịch khám/trị liệu tại phòng khám của chúng tôi.",
                maxLines: 2,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    height: 1.5,
                    fontFamily: 'RobotoSlab',
                    color: AppColors.secondaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
