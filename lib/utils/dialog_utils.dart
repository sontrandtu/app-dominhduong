
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../theme/colors.dart';

Future showPermissionDialog(BuildContext context, {required String title, required String content}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text('Huỷ'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          CupertinoDialogAction(
            child: const Text('Cài đặt'),
            onPressed: () {
              Navigator.of(context).pop();
              openAppSettings();
            },
          ),
        ],
      )
  );
}

Future showDefaultDialog(BuildContext context, {required String title, required String content, String? textNoButton, String? textYesButton, required Function()? onPressNo, required Function()? onPressYes}) {
  return showDialog(
    useRootNavigator: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Center(child: Text(title.toUpperCase(), style: const TextStyle(color: Colors.red))),
        content: Text(content, textAlign: TextAlign.center, style: const TextStyle(color: Colors.black87, height: 1.5)),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actionsPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        actions: <Widget>[
          SizedBox(
            height: 34,
            width: 88,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.grey.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0,
              ),
              child: Text( textNoButton ?? 'Không', style: const  TextStyle(fontSize: 13, fontFamily: 'Roboto', fontWeight: FontWeight.w500)),
              onPressed: onPressNo,
            ),
          ),
          SizedBox(
            height: 34,
            width: 88,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0
              ),
              child: Text( textYesButton ?? 'Có', style: const TextStyle(fontSize: 13, fontFamily: 'Roboto', fontWeight: FontWeight.w700)),
              onPressed: onPressYes,
            ),
          ),
        ],
      )
  );
}

Future requestPermission(Permission permission, BuildContext context, {VoidCallback? onGranted, required String title, required String content}) async {
  final status = await permission.status;
  switch (status) {
    case PermissionStatus.granted:
      onGranted?.call();
      break;
    case PermissionStatus.restricted:
      break;
    case PermissionStatus.limited:
      onGranted?.call();
      break;
    case PermissionStatus.denied:
      {
        permission.request().then((value) {
          if (value == PermissionStatus.granted) {
            onGranted?.call();
          }
        });
      }
      break;
    case PermissionStatus.permanentlyDenied:
      showPermissionDialog(context, title: title, content: content);
      break;
  }
}

showModalBottomSheetImage({required BuildContext context, required Function(dynamic) imageCallBack}){
  showModalBottomSheet(
    useRootNavigator: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      context: context,
      builder: (BuildContext ctx) {
        return SafeArea(
          child: IntrinsicHeight(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: 135,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.camera),
                    title: const Text('Máy ảnh'),
                    onTap: () {
                      Navigator.pop(ctx);
                      requestPermission(
                        Permission.camera,
                        context,
                        content: 'Ứng dụng cần quyền truy cập vào máy ảnh',
                        title: 'Máy ảnh',
                        onGranted: () async {
                          final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
                          if(pickedImage != null){
                            await imageCallBack.call(pickedImage.path);
                          }else{
                            await imageCallBack.call(null);
                          }
                        },
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.image),
                    title: const Text('Thư viện'),
                    onTap: () {
                      Navigator.pop(ctx);
                      requestPermission(
                        Permission.photos,
                        context,
                        content: 'Ứng dụng cần quyền truy cập vào thư viện ảnh',
                        title: 'Thư viện',
                        onGranted: () async {
                          final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                          if(pickedImage != null){
                            await imageCallBack.call(pickedImage.path);
                          }else{
                            await imageCallBack.call(null);
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }
  );
}

showAlertSuccessBooking({required BuildContext context, required GestureTapCallback onTap}) {
  Widget submitButton = ElevatedButton(
    child: Text('Về Trang chủ'.toUpperCase()),
    style: ElevatedButton.styleFrom(
        primary: AppColors.textWhite,
        side: BorderSide(color: AppColors.primaryColor),
        elevation: 0
    ),
    onPressed: onTap,
  );

  AlertDialog dialog = AlertDialog(
      title: const Text('Đặt lịch thành công!'),
      actions: [submitButton]

  );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      });
}
