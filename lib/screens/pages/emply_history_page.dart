import 'package:dominhduong/res.dart';
import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class EmptyHistoryPage extends StatelessWidget {
  final String? title;
  final String? titleButton;
  final GestureTapCallback? onPress;
  const EmptyHistoryPage({Key? key, this.title, this.onPress, this.titleButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: const Color(0xFFFFFFFF),
      child: Column(
        children: [
          const SizedBox(height: 60),
          Image.asset(Res.image_empty_data),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Text(title!, style: const TextStyle(fontSize: 14, fontFamily: 'Roboro',fontWeight: FontWeight.w700)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: AppColors.secondaryColor),
              onPressed: onPress,
              child: Text(titleButton!,style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto',fontSize: 16, color: Colors.white)),

          ),
        ],
      ),
    );
  }
}
