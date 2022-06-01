import 'package:dominhduong/model/doctor_model.dart';
import 'package:dominhduong/page_routes.dart';
import 'package:dominhduong/screens/main_page/tabs/home/widgets/head_box.dart';
import 'package:dominhduong/theme/colors.dart';
import 'package:dominhduong/utils/extensions.dart';
import 'package:dominhduong/widgets/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../res.dart';

class DoctorLayout extends StatefulWidget {
  final List<DoctorModel> doctors;

  const DoctorLayout({Key? key, required this.doctors}) : super(key: key);

  @override
  State<DoctorLayout> createState() => _DoctorLayoutState();
}

class _DoctorLayoutState extends State<DoctorLayout> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      child: Column(
        children: [
          const HeaderBox(title: 'Đội ngũ bác sĩ', viewAllTitle: 'Xem tất cả', pageRoute: PageRoutes.listDoctorPage),
          Column(
            children: [
              SizedBox(
                height: 160,
                child: widget.doctors.isEmpty
                    ? Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 0),
                    decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(8)
                    ),
                  ),
                )
                    : GestureDetector(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.doctorDetailPage, arguments: widget.doctors[0].id);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 0),
                    decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: CustomNetworkImage(url: widget.doctors[0].imageUrl, width: 125, height: 125, backgroundColor: Colors.grey.withOpacity(0.5), isCircle: true, isPlaceholderImage: false),
                        ),
                        Expanded(
                          flex: 6,
                          child: Container(
                            margin: const EdgeInsets.only(left: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    widget.doctors[0].name?.toUpperCase() ?? '',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'RobotoSlab', color: AppColors.primaryColor)
                                ),
                                const SizedBox(height: 5),
                                Text(
                                    widget.doctors[0].position ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.textWhite)
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // Row(
                                    //   children: [
                                    //     SvgPicture.asset(Res.ic_star_outline),
                                    //     const SizedBox(width: 5),
                                    //   ],
                                    // ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.treatment, arguments: [widget.doctors[0].branchId, widget.doctors[0].physicianId]);
                                      },
                                      child: Container(
                                          width: 120,
                                          height: 38,
                                          decoration: BoxDecoration(
                                              color: AppColors.backgroundWhite,
                                              borderRadius: BorderRadius.circular(8)
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Image.asset(Res.ic_calendar_dc, width: 28.36, height: 24,),
                                              const SizedBox(width: 5),
                                              const Text(
                                                  'Đặt lịch',
                                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.secondaryColor)
                                              )
                                            ],
                                          )
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 210,
                child: widget.doctors.isEmpty
                    ? Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: ListView.separated(
                      padding: const EdgeInsets.only(top: 15, bottom: 0, left: 10, right: 10),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        return Container(
                          width: 160,
                          padding: const EdgeInsets.only(top: 25, bottom: 20, left: 15, right: 15),
                          decoration: BoxDecoration(
                            color: AppColors.textWhite,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(width: 1, color: Colors.grey.withOpacity(0.2)),
                          ),
                        );
                      },
                      separatorBuilder: (_, __) {
                        return const SizedBox(width: 10);
                      },
                      itemCount: 3
                  ),
                )
                    : ListView.separated(
                    padding: const EdgeInsets.only(top: 15, bottom: 0, left: 10, right: 10),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      final doctor = widget.doctors[index + 1];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.doctorDetailPage, arguments: doctor.id);
                        },
                        child: Container(
                          width: 160,
                          padding: const EdgeInsets.only(top: 15, bottom: 15, left: 5, right: 5),
                          decoration: BoxDecoration(
                            color: AppColors.backgroundWhite,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              CustomNetworkImage(url: doctor.imageUrl, width: 70, height: 70, backgroundColor: Colors.grey.withOpacity(0.5), isCircle: true, isPlaceholderImage: false),
                              const SizedBox(height: 10),
                              Text(
                                doctor.splitName?.toUpperCase() ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: context.textStyle(color: AppColors.textBlack).size12.fontRobotoSlab,
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.treatment, arguments: [doctor.branchId, doctor.physicianId]);
                                },
                                child: Container(
                                  width: 100,
                                  height: 36,
                                  decoration: BoxDecoration(
                                      color: AppColors.secondaryColor,
                                      borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(Res.ic_calendar_dc, width: 28.36, height: 24,),
                                      const SizedBox(width: 5),
                                      const Text(
                                          'Đặt lịch',
                                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textWhite)
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, __) {
                      return const SizedBox(width: 10);
                    },
                    itemCount: widget.doctors.length - 1
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
