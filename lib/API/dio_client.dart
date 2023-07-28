import 'dart:developer';

import 'package:dio/dio.dart' as d;
import 'package:tikidown/API/videos_class.dart';
import 'package:tikidown/CORE/core.dart';

class DioClient {
  final d.Dio _dio = d.Dio();

  final _baseUrl = 'https://www.tikwm.com';

  dynamic videoData;

  // POST: Get videos datas
  Future<VideoInfo?> infoVideo({required String url}) async {
    VideoInfo? retrievedVideo;

    try {
      d.Response response = await _dio.post(
          queryParameters: {
            "sec-ch-ua":
                'Chromium";v="104", " Not A;Brand";v="99", "Google Chrome";v="104"',
            "accept": "application/json, text/javascript, */*; q=0.01",
            "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
            "user-agent":
                "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36",
          },
          '$_baseUrl/api/',
          data: {"url": url});

      var datas = response.data;

      retrievedVideo = VideoInfo(
        url: url,
        code: datas["code"],
        id: datas["data"]["id"],
        region: datas["data"]["region"],
        title: datas["data"]["title"],
        cover: datas["data"]["cover"],
        origin_cover: datas["data"]["origin_cover"],
        video: datas["data"]["play"],
        wm_video: datas["data"]["wmplay"],
        music: datas["data"]["music"],
        music_title: datas["data"]["music_info"]["title"],
        music_cover: datas["data"]["music_info"]["cover"],
        plays: datas["data"]["play_count"].toString(),
        comments: datas["data"]["comment_count"].toString(),
        shares: datas["data"]["share_count"].toString(),
        downloads: datas["data"]["download_count"].toString(),
        author_id: datas["data"]["author"]["id"],
        name: datas["data"]["author"]["unique_id"],
        username: datas["data"]["author"]["nickname"],
        avatar: datas["data"]["author"]["avatar"],
      );
    } catch (e) {
      debugPrint(
          "Erreur lors du chargement des donnees de l'utilisateur user: \n $e");
    }

    return retrievedVideo;
  }

  saveImage(imgUrl) async {
    final response = await _dio.get(imgUrl);

    return response;
  }

  Future<(RxBool, RxDouble)> downloadVideo(
      {required String link, required String filePath}) async {
    var progress = 0.0.obs;
    try {
      await _dio.download(link, filePath,
          onReceiveProgress: (download, totalSize) {
        progress.value = download / totalSize;
      });

      Get.bottomSheet(Container(
        width: Get.width,
        height: 120,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          color: thirdColor,
        ),
        child: Center(
            child: LargeButton(
                onTap: () => Get.back(),
                color: firstColor,
                text: "Telechargement Terminer")),
      ));

      log("--- telechargement terminer");
      return (true.obs, progress);
    } catch (e) {
      log("*************** $e");
    }

    return (false.obs, progress);
  }
}
