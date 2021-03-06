import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dominhduong/api/response_model/list_response.dart';
import 'package:dominhduong/api/response_model/login_response.dart';
import 'package:dominhduong/app_config.dart';
import 'package:dominhduong/model/article_model.dart';
import 'package:dominhduong/model/booking_model.dart';
import 'package:dominhduong/model/history_model.dart';
import 'package:dominhduong/model/location_model.dart';
import 'package:dominhduong/model/timeslot_model.dart';
import 'package:dominhduong/model/doctor_model.dart';
import 'package:dominhduong/model/user_info_model.dart';
import 'package:dominhduong/model/widget_model.dart';
import 'package:retrofit/retrofit.dart';

part 'res_client.g.dart';
const int pageSize = 20;

@RestApi(baseUrl: AppConfig.prefixUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  //==================== Authenticate Api ====================//
  @MultiPart()
  @POST('/login')
  Future<HttpResponse<LoginResponse>> login({
    @Part(name: "phone") String? phone
  });

  @MultiPart()
  @POST('/verify-otp')
  Future<HttpResponse<UserInfoModel>> verifyOTP({
    @Part(name: "phone") String? phone,
    @Part(name: "otp") String? otp
  });

  @MultiPart()
  @POST('/logout')
  Future<HttpResponse> logOut();
  //==================== Authenticate Api ====================//

  //======================= Account Api ======================//
  @GET('/accounts')
  Future<HttpResponse<UserInfoModel>> getUserInfo();

  @MultiPart()
  @PUT('/update-avatar')
  Future<HttpResponse<UserInfoModel>> updateAvatar({
    @Part() File? image,
    @SendProgress() ProgressCallback? callback
  });

  @MultiPart()
  @PUT('/accounts')
  Future<HttpResponse<UserInfoModel>> updateUserInfo({
    @Part(name: "image") File? image,
    @Part(name: "username") String? username,
    @Part(name: "phone") String? phone,
    @Part(name: "birthday") String? birthday,
    @Part(name: "address") String? address,
    @Part(name: "gender") String? gender,
    @Part(name: 'province_id') int? provinceId,
    @Part(name: 'district_id') int? districtId,
    @Part(name: 'ward_id') int? wardId,
  });
  //======================= Account Api ======================//

  //======================== Doctor Api ======================//
  @GET('/doctors?order_by=sequence&order=desc')
  Future<HttpResponse<ListResponse<List<DoctorModel>>>> getListDoctor({
    @Query('page') int? page,
    @Query('limit') int? limit
  });

  @GET('/doctors')
  Future<HttpResponse<ListResponse<List<DoctorModel>>>> getAllDoctor();

  @GET('/doctors/{id}')
  Future<HttpResponse<DoctorModel>> getDoctorDetail({
    @Path('id') int? id
  });

  //======================== Doctor Api ======================//

  //======================= Widget Api =======================//
  @GET('/widgets/{slug}')
  Future<HttpResponse<WidgetModel>> getWidgetsBySlug({
    @Path('slug') String? slug,
  });
  //======================= Widget Api =======================//

  //====================== Location Api =====================//
  @GET('/location-list-province')
  Future<HttpResponse<ListResponse<List<LocationModel>>>> getListProvince();

  @GET('/location-list-district?province_id={id}')
  Future<HttpResponse<ListResponse<List<LocationModel>>>> getListDistrict({
    @Path('id') int? provinceId
  });

  @GET('/location-list-ward?district_id={id}')
  Future<HttpResponse<ListResponse<List<LocationModel>>>> getListWard({
    @Path('id') int? districtId
  });
  //====================== Location Api =====================//


  //====================== Booking Api =====================//
  @MultiPart()
  @POST('/bookings')
  Future<HttpResponse<BookingModel>> bookingTreatment({
    @Part(name: "doctor") int? doctor,
    @Part(name: "time_slot") int? timeSlot,
    @Part(name: "username") String? username,
    @Part(name: "phone") String? phone,
    @Part(name: "birthday") String? birthday,
    @Part(name: "appointment_date") String? appointmentDate,
    @Part(name: "reason") String? reason
  });

  @GET('/time-slot')
  Future<HttpResponse<ListResponse<List<TimeSlotModel>>>> getTimeSlots();


  @GET('/bookings')
  Future<HttpResponse<ListResponse<List<HistoryModel>>>> getListHistory({
    @Query('page') int? page,
    @Query('limit') int? limit
  });
  //====================== Booking Api =====================//


  //====================== Article Api =====================//
  @GET('/articles/{id}')
  Future<HttpResponse<ArticleModel>> getArticleDetail({
    @Path('id') int? id
  });

  @GET('/article-related/{id}')
  Future<HttpResponse<ListResponse<List<ArticleModel>>>> getArticleRelated({
    @Path('id') int? id,
    @Query('page') int? page,
    @Query('limit') int? limit
  });

  @GET('/article-type/{type}/articles')
  Future<HttpResponse<ListResponse<List<ArticleModel>>>> getArticleByType({
    @Path('type') String? type,
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  @GET('/categories/{id}/articles')
  Future<HttpResponse<ListResponse<List<ArticleModel>>>> getArticleByCategoryAndType({
    @Path('id') int? id,
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Query('type') String? type,
    @Query('keyword') String? keyword
  });
  //====================== Article Api =====================//

}
