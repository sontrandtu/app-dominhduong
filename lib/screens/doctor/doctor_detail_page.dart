import 'package:dominhduong/theme/colors.dart';
import 'package:dominhduong/widgets/appbar/appbar_comp.dart';
import 'package:dominhduong/widgets/cover_loading.dart';
import 'package:dominhduong/widgets/custom_cached_network_image.dart';
import 'package:dominhduong/widgets/html_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../page_routes.dart';
import '../../res.dart';
import 'doctor_detail_view_model.dart';

class DoctorDetailPage extends StatefulWidget {
  const DoctorDetailPage({Key? key}) : super(key: key);

  @override
  _DoctorDetailPageState createState() => _DoctorDetailPageState();
}

class _DoctorDetailPageState extends State<DoctorDetailPage> {

  final ScrollController scrollController = ScrollController();
  TextEditingController controller = TextEditingController();
  late FocusNode focusNode;
  late int replyId;

  @override
  void initState() {
    replyId = 0;
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  void requestFocus() {
    focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DoctorDetailViewModel>();
    final doctor = viewModel.doctor;
    return GestureDetector(
      onTap: (){
        focusNode.unfocus();
        replyId = 0;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: PageAppBarComp(title: 'Thông tin bác sĩ'.toUpperCase()),
        body: SafeArea(
          child: Stack(
            children: [
              CoverLoading(
                showLoading: viewModel.isLoading,
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24.5,),
                    child: Column(
                      children: [
                        Center(
                          child: Column(
                            children: [
                              CustomNetworkImage(url: doctor?.imageUrl ?? '', width: 128, height: 128, backgroundColor: Colors.grey.withOpacity(0.5), isCircle: true, isPlaceholderImage: true),
                              const SizedBox(height: 14.7),
                              Text(
                                  doctor?.name?.toUpperCase() ?? '',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, fontFamily: 'RobotoSlab', color: AppColors.primaryColor)),
                              Text(
                                  doctor?.position ?? '',
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'RobotoSlab', color: AppColors.secondaryColor)
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15.5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.treatment, arguments: doctor?.id);
                            },
                            child: Container(
                              width: 150,
                              height: 36,
                              decoration: BoxDecoration(
                                  color: AppColors.secondaryColor,
                                  borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(Res.ic_calendar_dc,
                                    width: 23.86, height: 24,
                                  ),
                                  const SizedBox(width: 8.95),
                                  const Text(
                                      'Đặt lịch',
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.textWhite),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24.73,),
                        HtmlContent(content: doctor?.content ?? ''),
                        const SizedBox(height: 20),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
