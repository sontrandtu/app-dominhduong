
import 'package:dominhduong/widgets/appbar/appbar_comp.dart';
import 'package:dominhduong/widgets/cover_loading.dart';
import 'package:dominhduong/widgets/no_result_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dominhduong/screens/pages/medical_examination_guide_view_model.dart';
import '../../page_routes.dart';
import '../../theme/colors.dart';

class MedicalExaminationGuidePage extends StatefulWidget {
  const MedicalExaminationGuidePage({Key? key}) : super(key: key);

  @override
  State<MedicalExaminationGuidePage> createState() => _MedicalExaminationGuidePageState();
}

class _MedicalExaminationGuidePageState extends State<MedicalExaminationGuidePage> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MedicalExaminationGuideViewModel>();
    return Scaffold(
        appBar: PageAppBarComp(title: r'Hướng dẫn đặt lịch & Đặt thuốc'.toUpperCase()),
        body: SafeArea(
          child: Stack(
            children: [
              CoverLoading(
                showLoading: viewModel.isLoading,
                child: (!viewModel.isLoading && viewModel.content.isEmpty)
                    ? const NoResultPage()
                    : Center(
                    child: SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 30),
                          child: Column(
                            children: [
                              const Text(
                                "Nhằm phục vụ tốt nhất nhu cầu khám chữa bệnh của khách hàng; bên cạnh việc tư vấn, khám và điều trị trực tiếp tại nhà thuốc, Đỗ Minh Đường cung cấp dịch vụ tư vấn trực tuyến và gửi thuốc qua đường bưu điện.",
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.0, height: 2.0),
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(height: 20.0,),
                              Container(
                                height: 380,
                                width: 382,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0, top: 16.0, right: 10, bottom: 16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Khám tại nhà thuốc".toUpperCase(),
                                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: AppColors.primaryColor, fontFamily: 'RobotoSlab'),
                                      ),
                                      const SizedBox(height: 12.0),
                                      const Padding(
                                        padding: EdgeInsets.only(right: 13.0),
                                        child: Text(
                                          "Với bệnh nhân ở khu vực Hà Nội và TPHCM có thể đến trực tiếp cơ sở của Nhà thuốc để được Bác sĩ khám và kê đơn thuốc. Quý khách có thể đặt lịch khám qua Tổng đài 0963 302 349 hoặc đặt lịch bên dưới.",
                                          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, height: 1.5),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                      const SizedBox(height: 10.0,),
                                      const Text(
                                        "Địa chỉ: ",
                                        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: Colors.black),
                                      ),
                                      const SizedBox(height: 11.0),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(right: 10.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.location_on_outlined, color: AppColors.primaryColor, size: 26.0),
                                                const SizedBox(width: 8.0),
                                                RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: "Hà Nội:",
                                                        style: TextStyle(color: AppColors.primaryColor, fontSize: 14.0, fontWeight: FontWeight.w700, height: 1.3),
                                                      ),
                                                      const TextSpan(
                                                        text: " Số 37A Ngõ 97 Văn Cao, Liễu Giai,\nBa Đình,Hà Nội (Xem bản đồ)",
                                                        style: TextStyle(color: AppColors.textBlack, fontSize: 14.0, fontWeight: FontWeight.w400, height: 1.3),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 15.0),
                                            Row(
                                              children: [
                                                Icon(Icons.location_on_outlined, color: AppColors.primaryColor, size: 26.0,),
                                                const SizedBox(width: 8.0,),
                                                RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: "Hồ Chí Minh:",
                                                        style: TextStyle(color: AppColors.primaryColor, fontSize: 14.0, fontWeight:FontWeight.w700, height: 1.3),
                                                      ),
                                                      const TextSpan(
                                                        text: " Số 179 Nguyễn Văn Thương,\nPhường 25, quận Bình Thạnh, TP. Hồ Chí Minh\n(Xem bản đồ)",
                                                        style: TextStyle(color: AppColors.textBlack, fontSize: 13.0, fontWeight: FontWeight.w400, height: 1.3),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 13.0),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 42,
                                            width: 160,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.treatment, arguments: []);
                                              },
                                              child: Container(
                                                child: Center(
                                                  child: Text("Đặt lịch khám".toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.textWhite),),),
                                                decoration: BoxDecoration(
                                                  color: AppColors.secondaryColor,
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 5.0),
                                          SizedBox(
                                            height: 42,
                                            width: 160,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.orderMedicinePage);
                                              },
                                              child: Container(
                                                child: Center(
                                                    child: Text("Đặt thuốc".toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.textWhite),),),
                                                decoration: BoxDecoration(
                                                  color: AppColors.secondaryColor,
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24.0),
                              Container(
                                height: 135,
                                width: 382,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 13.0, bottom: 16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Tư vấn trực tuyến".toUpperCase(),
                                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: AppColors.primaryColor, fontFamily: 'RobotoSlab'),
                                      ),
                                      const SizedBox(height: 12.0,),
                                      const Text(
                                        "Với bệnh nhân ở xa vui lòng liên hệ qua Tổng đài 0963 302 349 hoặc 024 6253 6649 để được các bác sĩ của Đỗ Minh Đường tư vấn, giải đáp.",
                                        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, height: 1.6),
                                        textAlign: TextAlign.left,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      // const SizedBox(
                                      //   height: 13.0,
                                      // ),
                                      // SizedBox(
                                      //   height: 42,
                                      //   width: 165,
                                      //   child: GestureDetector(
                                      //     onTap: () {
                                      //       showMessage('Chức năng đang được phát triển');
                                      //     },
                                      //     child: Container(
                                      //       child: Center(
                                      //         child: Text("Video Call".toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.textWhite),),),
                                      //       decoration: BoxDecoration(
                                      //         color: AppColors.secondaryColor,
                                      //         borderRadius: BorderRadius.circular(8.0),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24.0),
                              Container(
                                height: 240,
                                width: 382,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(9.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 13.0, bottom: 16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Gửi thuốc qua đường bưu điện".toUpperCase(),
                                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: AppColors.primaryColor, fontFamily: 'RobotoSlab'),
                                      ),
                                      const SizedBox(height: 12.0),
                                      const Text(
                                        "Quý bệnh nhân ở xa đã bác sĩ được khám và tư vấn (bệnh nhân lấy thuốc để điều trị tiếp…) có thể nhờ nhà thuốc gửi thuốc qua đường bưu điện. Thuốc được bọc, đóng gói kín đáo, có niêm phong. Xem hướng dẫn chi tiết",
                                        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, height: 1.5),
                                        textAlign: TextAlign.start,
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 13.0),
                                      SizedBox(
                                        height: 42,
                                        width: 165,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.orderMedicinePage);
                                          },
                                          child: Container(
                                            child: Center(
                                              child: Text("Đặt mua thuốc".toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.textWhite),),),
                                            decoration: BoxDecoration(
                                              color: AppColors.secondaryColor,
                                              borderRadius: BorderRadius.circular(8.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                    )
                ),
              ),
            ],
          ),
        ),
    );
  }
}
