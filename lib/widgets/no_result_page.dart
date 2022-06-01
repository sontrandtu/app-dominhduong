import 'package:flutter/material.dart';
import 'package:dominhduong/res.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoResultPage extends StatelessWidget {
  const NoResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(Res.ic_no_result, width: 120, color: Colors.grey),
            const Text('Dữ liệu đang được cập nhật!', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 12, fontFamily: 'RobotoSlab'))
          ],
        )
    );
  }
}