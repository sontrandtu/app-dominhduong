import 'package:dominhduong/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class SolidButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback onPressed;

  const SolidButton({Key? key, required this.text, this.isActive = true, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if (isActive) onPressed.call();
        },
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(vertical: 10)),
            backgroundColor: MaterialStateProperty.all<Color>(isActive ? AppColors.secondaryColor : AppColors.secondaryColor.withOpacity(0.4)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ))),
        child: Text(
          text,
          style: context.textStyle(color: AppColors.textWhite).size16.w700.fontRobotoSlab,
        ));
  }
}

class CustomButtonNew extends StatelessWidget {
  final String textButton;
  final bool isActive;
  final VoidCallback onPressed;
  const CustomButtonNew({Key? key, required this.textButton, required this.isActive, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if (isActive) onPressed.call();
      },
      child: Container(
        height: 56,
        width: 382,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: AppColors.secondaryColor,
        ),
        child: Center(
          child: Text(textButton.toUpperCase(), style: context.textStyle(color: AppColors.textWhite).size16.w700.fontRobotoSlab,),
        ),
      ),
    );
  }
}
