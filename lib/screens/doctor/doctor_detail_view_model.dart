import 'package:dominhduong/base/base_view_model.dart';
import 'package:dominhduong/model/doctor_model.dart';
import 'package:dominhduong/repository/doctor_repository.dart';

class DoctorDetailViewModel extends BaseViewModel {
  final DoctorRepository repo;
  DoctorModel? doctor;
  final int doctorId;
  String authorName = '';
  String? authorEmail = '';
  String? phone = '';
  String? status = 'pending';
  String? content;
  int? post;
  int? parent;
  dynamic error;

  DoctorDetailViewModel({this.doctor, required this.repo, required this.doctorId}) : super(repo) {
    getDoctorDetailData();
    getAccountInfo();
  }

  getAccountInfo() async {
    final response = await repo.getUserInfo();
    if (response.isOk) {
      authorName = response.data!.name!;
      phone = response.data!.phone;
      authorEmail = response.data!.email ?? "no-email@gmail.com";
    }
  }

  getDoctorDetailData() async {
    setLoading = true;
    final response = await repo.getDoctorDetail(doctorId);
    if (response.isOk) {
      doctor = response.data;
    }
    setLoading = false;
  }
}
