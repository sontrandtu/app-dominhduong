import 'package:flutter/material.dart';

class LineDivider extends StatelessWidget {
  final double thickness;
  final Color? color;
  const LineDivider({Key? key, this.thickness = 8, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: thickness,
      color: color,
    );
  }
}
