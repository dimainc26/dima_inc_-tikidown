// ignore_for_file: unnecessary_overrides

import 'dart:convert';
import 'dart:developer';

import 'package:tikidown/API/dio_client.dart';
import 'package:tikidown/API/directory_client.dart';
import 'package:tikidown/API/videos_class.dart';
import 'package:tikidown/CORE/core.dart';
import 'package:tikidown/MODELS/videos_model.dart';

class HomeController extends GetxController {
  final boxDatas = GetStorage();
  List storageList = [];

    readStorage() async {
    var x = await box.read("videos");

    storageList = x != null ? x : [] ;

    log("ici :  --- $storageList");

    log("total: "+ storageList.length.toString());
  }

  final pageController = PageController;

  final linkController = TextEditingController();

  final RxBool loading = false.obs;

  RxDouble progress = 0.0.obs;

  bool isDownloadLink = false;

  final DioClient _client = DioClient();

  final DirectoryClient _directoryClient = DirectoryClient();
  dynamic videoData = VideoInfo(url: "");

  late String fullInfos;

  fetchDatas(String link) async {
    var linkTest = link.contains(RegExp('https://'));

    print("Test link: $linkTest");

    if (linkTest) {
      videoData = await _client.infoVideo(url: link);

      // print(videoData?.code.toString());
      // print(videoData?.region);
      // print(videoData?.title);
      // print(videoData?.cover);
      // print(videoData?.origin_cover);

      print(videoData?.video);
      print(videoData?.wm_video);

      print("musique : ${videoData?.music}");
      // print(videoData?.music_cover);
      // print(videoData?.music_title);

      // print(videoData?.plays);
      // print(videoData?.shares);
      // print(videoData?.comments);
      // print(videoData?.downloads);

      // print(videoData?.author_id);
      // print(videoData?.name);
      // print(videoData?.username);
      // print(videoData?.avatar);

      if (videoData?.video != null && videoData?.video != "") {
        final sigma = "dima_inc26";

        isDownloadLink = true;
        var name = videoData?.username;
        var username = videoData?.name;
        var title = videoData?.title;

        String splitTilte = title.split(" ").join("-");

        if (splitTilte.length > 30) splitTilte = splitTilte.substring(0, 29);

        fullInfos = "${name}-${username}-$splitTilte-$sigma";

        print("Full Infos: $fullInfos");

        Get.bottomSheet(
          Container(
              height: Get.height / 2 + 40,
              width: Get.width,
              decoration: const BoxDecoration(
                color: Color(0xff7577CC),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    height: (Get.height / 2) - 100,
                    child: Stack(
                      children: [
                        Container(
                          width: Get.width - 20,
                          height: (Get.height / 2) - 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey,
                            image: DecorationImage(
                              image: NetworkImage(videoData.cover!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 20,
                          child: Container(
                              width: 180,
                              color: Colors.red.withOpacity(.4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "P: ${videoData!.plays!}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "S: ${videoData.shares!}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "C: ${videoData.comments!}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        ),
                        Positioned(
                          left: 20,
                          bottom: 20,
                          child: Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 2),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(videoData.avatar!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 20,
                          bottom: 20,
                          child: InkWell(
                            onTap: () {
                              checkDirectories(mode: "music");
                              Get.back();
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 2),
                                shape: BoxShape.circle,
                                image: const DecorationImage(
                                  image: AssetImage(logoImg),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: 40,
                            left: 120,
                            child: Text(
                              "@${videoData.name!} / ${videoData.username!}",
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                  LargeButton(
                      text: "Authentik Video",
                      onTap: () {
                        checkDirectories(mode: "natural");
                        Get.back();
                      },
                      color: firstColor),
                  const SizedBox(
                    height: 10,
                  ),
                  LargeButton(
                      text: "Watermark Video",
                      onTap: () {
                        checkDirectories(mode: "watermark");
                        Get.back();
                      },
                      color: thirdColor),
                ],
              )),
          barrierColor: const Color(0xff4E4E74).withOpacity(.6),
          isDismissible: true,
          enableDrag: false,
        );
      }
    }
  }

  actualDate() {
    var dateTime = DateTime.now().toString();
    var splitDate = dateTime.split(" ");
    var date = splitDate[0].split("-");

    var time = splitDate[1].split(".");
    time = time[0].split(":");

    var actualTime = date[0] + date[1] + date[2] + time[0] + time[1] + time[2];
    print(actualTime);

    return actualTime;
  }

  late VideoModel videoModel;

  checkDirectories({required String mode}) async {
    loading.value = true;

    var link = "";

    if (mode == "natural") {
      link = videoData.video;
    } else if (mode == "watermark") {
      link = videoData.wm_video;
    } else if (mode == "music") {
      link = videoData.music;
    }

      String currentDate = actualDate();


    progress.value = await _directoryClient.checkDirectory(

        link: link, fileName: "${currentDate}");

    if (progress.value == 1) loading.value = false;

    saveDatas(mode, currentDate);
  }

  saveDatas(String mode, date) async {

    storageList.add({
      "id": UniqueKey().toString(),
      "title": videoData?.title,
      "type":  mode == "natural" || mode == "watermark" ? "mp4" : "mp3",
      "date": date,
      "name": videoData?.name,
      "username": videoData?.username,
      "avatar": videoData?.avatar,
      "cover":  mode == "natural" || mode == "watermark" ? videoData?.cover : videoData?.music_cover,

    });
    log(storageList.toString());

    box.write("videos", storageList);

    await box.save();

  }

  deleteStorage() async {
    box.erase();
  }

  @override
  void onInit() {
    super.onInit();
    readStorage();
  }

  loadData() {}

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    linkController.dispose();
  }
}
