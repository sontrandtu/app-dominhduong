import 'package:dominhduong/api/api_response.dart';
import 'package:dominhduong/api/dio_helper.dart';
import 'package:dominhduong/api/res_client.dart';
import 'package:dominhduong/api/response_model/list_response.dart';
import 'package:dominhduong/model/video/video_model.dart';
import 'package:dominhduong/repository/repository.dart';

class YoutubeRepository extends Repository{
  Future<ApiResponse<ListResponse<List<VideoModel>>>> getYoutubeVideoByPart({required String key,required String channelID, required String part, required String order, required int maxResults  }) async{
    return await RestClient(DioHelper.dioObject!, baseUrl: 'https://www.googleapis.com/youtube/v3').getYoutubeVideoByPart(key: key,channelID: channelID, part: part,oder: order, maxResults: maxResults).wrap();
  }

  Future<ApiResponse<VideoModel>>  getVideoDetail({required String? part, required String? channelID, required String? key}) async {
    return await RestClient(DioHelper.dioObject!, baseUrl: 'https://www.googleapis.com/youtube/v3').getVideoDetail(part: part,channelID: channelID,key: key).wrap();
  }
}