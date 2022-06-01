// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:share_plus/share_plus.dart';
// import '../../../../../app_config.dart';
// import '../../../../../enum/satisfaction_level.dart';
// import '../../../../../repository/user_repository.dart';
// import '../../../../../theme/colors.dart';
// import '../../../../feedback_form/feedback_customer_dialog.dart';
// import '../../../../feedback_form/feedback_view_model.dart';
// import '../../../../pages/support_page.dart';
// import '../../../../pages/support_view_model.dart';
//
//
// class FBoxIconLayout extends StatelessWidget {
//   const FBoxIconLayout({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     SatisfactionLevel _satisfaction = SatisfactionLevel.yes;
//     return Container(
//       padding: const EdgeInsets.only(top: 0, bottom: 20, left: 0, right: 0),
//       child: GridView.count(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         childAspectRatio: 1 / 0.4,
//         crossAxisSpacing: 15,
//         mainAxisSpacing: 0,
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         crossAxisCount: 3,
//         children: [
//           FBoxIcon(
//               iconSource: Icons.star_border_outlined,
//               text: "Đánh giá",
//               onSelected: () {
//                 showDialog(
//                   context: context,
//                   builder: (BuildContext ctx){
//                     return ChangeNotifierProvider(create: (_) => FeedbackViewModel(surveyRepo: context.read()), child: FeedbackCustomersDialog(),);
//                   },
//                 );
//               }
//           ),
//           FBoxIcon(
//               iconSource: Icons.share_outlined,
//               text: "Chia sẻ",
//               onSelected: () {
//                 if (Platform.isAndroid) {
//                   Share.share(AppConfig.chPlayLink);
//                 } else if (Platform.isIOS) {
//                   Share.share(AppConfig.appStoreLink);
//                 }
//               }
//           ),
//           FBoxIcon(
//               iconSource: Icons.question_answer_outlined,
//               text: "Phản hồi",
//               onSelected: () {
//                 showModalBottomSheet(
//                     useRootNavigator: true,
//                     isScrollControlled:true,
//                     shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
//                     context: context,
//                     builder: (context) {
//                       return ChangeNotifierProvider(create: (_) => SupportViewModel(repo: context.read(), userRepo: context.read<UserRepository>()), child: const SupportPage());
//                     }
//                 );
//               }
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class FBoxIcon extends StatelessWidget {
//   final IconData iconSource;
//   final String text;
//   final VoidCallback onSelected;
//
//   const FBoxIcon({Key? key, required this.iconSource, required this.text, required this.onSelected}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onSelected,
//       child: Container(
//         decoration: BoxDecoration(
//             color: AppColors.primaryColor.withOpacity(0.5),
//             borderRadius: BorderRadius.circular(8)
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(
//               width: 25,
//               height: 25,
//               child: CircleAvatar(
//                 backgroundColor: AppColors.textWhite,
//                 radius: 20,
//                 child: Icon(iconSource, color: AppColors.textBlack, size: 15),
//               ),
//             ),
//             const SizedBox(width: 8),
//             Text(text, textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textBlack, height: 1.3)),
//           ],
//         ),
//       ),
//     );
//   }
// }
