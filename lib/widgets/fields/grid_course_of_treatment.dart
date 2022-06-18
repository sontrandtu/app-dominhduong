// import 'package:dominhduong/theme/colors.dart';
// import 'package:flutter/material.dart';
//
// class GridCourseOfTreatment extends StatefulWidget {
//   final int? maxCourse;
//   final Function(int)? onAmountSelectedCallback;
//   const GridCourseOfTreatment({Key? key, this.maxCourse, this.onAmountSelectedCallback}) : super(key: key);
//
//   @override
//   _GridCourseOfTreatmentState createState() => _GridCourseOfTreatmentState();
// }
//
// class _GridCourseOfTreatmentState extends State<GridCourseOfTreatment> {
//   int selectedIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return GridView.count(
//       crossAxisCount: 5,
//       childAspectRatio: 1 / 0.8,
//       crossAxisSpacing: 15,
//       mainAxisSpacing: 0,
//       padding: EdgeInsets.zero,
//       physics: const NeverScrollableScrollPhysics(),
//       children: List.generate(widget.maxCourse!, (index){
//         return InkWell(
//           highlightColor: Colors.transparent,
//           splashColor: Colors.transparent,
//           onTap: (){
//             setState(() {
//               selectedIndex = index;
//               widget.onAmountSelectedCallback?.call(index+1);
//             });
//           },
//           child: Container(
//             height: 40,
//             width: 60,
//             decoration: BoxDecoration(
//                 color: (selectedIndex == index) ? AppColors.primaryColor : Colors.white,
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(color: (selectedIndex == index) ? AppColors.primaryColor : Colors.grey.withOpacity(0.5))
//             ),
//             child: Center(
//               child: Text('${index + 1}', style: const TextStyle(fontWeight: FontWeight.w700, fontFamily: 'Roboto', fontSize: 14),),
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
