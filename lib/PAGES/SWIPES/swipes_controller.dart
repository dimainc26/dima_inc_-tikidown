// ignore_for_file: unnecessary_overrides, unused_local_variable, depend_on_referenced_packages

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:convert';

import 'package:share_plus/share_plus.dart';
import 'package:tikidown/API/dio_client.dart';
import 'package:tikidown/API/directory_client.dart';
import 'package:tikidown/API/videos_class.dart';
import 'package:tikidown/CORE/core.dart';
import 'package:tikidown/MODELS/videos_model.dart';

import 'package:http/http.dart' as http;

class SwipeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Intent ENTRY

  // Intent? _initialIntent;

  // Future<void> _init() async {
  //   final receivedIntent = await ReceiveIntent.getInitialIntent();

  //   _initialIntent = receivedIntent;

  //   if (_initialIntent?.categories != null) {
  //   } else {
  //     if (_initialIntent?.extra?['android.intent.extra.TEXT'] != null &&
  //         _initialIntent?.extra?['android.intent.extra.TEXT'] != "") {
  //       // getVideoDatas(_initialIntent?.extra?['android.intent.extra.TEXT']);

  //       fetchDatas(_initialIntent?.extra?['android.intent.extra.TEXT']);
  //       _initialIntent?.extra?['android.intent.extra.TEXT'] = null;
  //       _initialIntent = null;
  //     }
  //   }
  // }

  Duration duration = const Duration(milliseconds: 500);

  late PageController pageController;

  home() {
    if (pageController.page != 0) {
      pageController.animateToPage(0, duration: duration, curve: Curves.linear);
    }
  }

  downloads() {
    if (pageController.page != 1) {
      pageController.animateToPage(1, duration: duration, curve: Curves.linear);
    }
  }

  RxInt currentIndicator = 0.obs;

  datas() {
    box.write("account", "me").then((value) => box.save());
  }

  @override
  void onInit() {
    super.onInit();
    // _init();
    datas();
    pageController = PageController(initialPage: 0);
    currentIndicator = pageController.initialPage.obs;

    tabBarController = TabController(length: 3, vsync: this, initialIndex: 0);
    downPageController = PageController(initialPage: xselectedPage.value);
    listFiles();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    linkController.dispose();
    tabBarController.dispose();
    pageController.dispose();
    // _initialIntent = null;
  }

// Home screen Controllers

  RxBool loading = false.obs;
  RxDouble progress = 0.0.obs;
  bool isDownloadLink = false;
  final linkController = TextEditingController();
  final DioClient _client = DioClient();
  final DirectoryClient _directoryClient = DirectoryClient();
  dynamic videoData = VideoInfo(url: "");

  RxList downList = RxList();
  RxList filesList = RxList();
  late VideoModel fileModel;
  var totalItems = 0.obs;

  fetchDatas(String link) async {
    var linkTest = link.contains(RegExp('https://'));
    if (linkTest) {
      videoData = await _client.infoVideo(url: link);

      // print(videoData?.code.toString());
      // print(videoData?.region);
      // print(videoData?.title);
      // print(videoData?.cover);
      // print(videoData?.origin_cover);

      // log(videoData?.video);
      // print(videoData?.wm_video);

      // log("musique : ${videoData?.music}");
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
        isDownloadLink = true;
        var name = videoData?.username;
        var title = videoData?.title;

        String splitTilte = title.split(" ").join("-");
        if (splitTilte.length > 30) splitTilte = splitTilte.substring(0, 29);

        Get.bottomSheet(
          Container(
              height: Get.height / 2 + 40,
              width: Get.width,
              decoration: const BoxDecoration(
                color: white,
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
                              color: secondColor.withOpacity(.4),
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
                            bottom: 40,
                            left: 120,
                            child: Text(
                              "@${videoData.name!} / ${videoData.username!}",
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            )),
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
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(music_icon, width: 40,),
                              ),
                            ),
                          ),
                        ),
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
    // log(actualTime);

    return actualTime;
  }

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

    progress = await _directoryClient.checkDirectory(
        type: mode == "music"
            ? "mp3"
            : mode == "cover"
                ? "jpg"
                : "mp4",
        link: link,
        fileName: currentDate);

    // Sauver img dans bdd;
    late File coverFile;
    if (mode == "natural" || mode == "watermark") {
      coverFile = await urlImageToFile(currentDate, videoData?.cover);
    } else if (mode == "music") {
      coverFile = await urlImageToFile(currentDate, videoData?.music_cover);
    }

    // Sauver dans db
    Map<String, dynamic> fileModel = ({
      "id": UniqueKey().toString(),
      "title": mode == "music" ? videoData?.music_title : videoData?.title,
      "name": videoData?.username,
      "username": videoData?.name,
      "type": mode == "natural" || mode == "watermark"
          ? "mp4"
          : mode == "music"
              ? "mp3"
              : "jpg",
      "avatar": videoData?.avatar,
      "date": currentDate,
      "cover": coverFile.path,
    });

    linkController.value = TextEditingValue.empty;

    for (Map<String, dynamic> l in downList) {
      l.remove("isSelected");
      // l.remove("path");
    }

    downList.add(fileModel);
    // log("||| - $downList");

    final dataSave = jsonEncode(downList);
    box.write("files", dataSave);
    // log(box.read("files").toString());

    filesList.value = [];
    listFiles();

    // for (Map<String, dynamic> l in filesList) {
    //   l.remove("isSelected");
    //   l.remove("path");
    // }

    // final noFilteredSave = jsonEncode(filesList);
    // box.write("noFilteredList", noFilteredSave);

    if (progress.value == 1) loading.value = false;
  }

  Future<File> urlImageToFile(date, url) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    // log('$tempPath$date.gif');
    File file = File('$tempPath$date.gif');

    http.Response response = await http.get(Uri.parse(url));

    await file.writeAsBytes(response.bodyBytes);
    return file;
  }

  readStorage() async {
    late List<dynamic> datas;
    if (box.hasData("files")) {
      datas = jsonDecode(box.read("files"));
      log(">>> datas in storage = ${datas.length}");
      // log("${datas}");
    } else {
      datas = [];
      log(" ---- AUcune donnee");
    }

    downList.value = datas;
  }

  deleteStorage() async {
    box.erase();
    box.save();
  }

  // Download controllers

  final path = '/storage/emulated/0/DCIM/TikiDowns';
  final musicPath = '/storage/emulated/0/Music/TikiDowns';
  late TabController tabBarController;
  late PageController downPageController;
  RxBool goodDeleted = false.obs;
  RxInt selectedPage = 0.obs;
  RxInt xselectedPage = 0.obs;

  RxList constantList = [].obs;

  restoreDataToFilter() {
    List<dynamic> myList = jsonDecode(box.read("noFilteredList"));

    for (var element in myList) {
      element.addAll({
        "isSelected": false.obs,
      });
    }
    return myList;
  }

  changePage(pageSelected) {
    if (pageSelected == 0) {
      filesList.value = restoreDataToFilter();
      filesList.value =
          filesList.where((type) => type["type"] == "mp4").toList();
      // log("actual List = ${filesList.length}");
    } else if (pageSelected == 1) {
      filesList.value = restoreDataToFilter();

      filesList.value =
          filesList.where((type) => type["type"] == "jpg").toList();
      // log("actual List = ${filesList.length}");
    } else if (pageSelected == 2) {
      filesList.value = restoreDataToFilter();

      filesList.value =
          filesList.where((type) => type["type"] == "mp3").toList();
      // log("actual List = ${filesList.length}");
    }

    downPageController.animateToPage(pageSelected,
        duration: duration, curve: Curves.ease);
  }

  next({required videoInfos}) {
    // Get.toNamed("/player", arguments: videoInfos);
  }

  play({required videoInfos}) {
    Get.toNamed("/music", arguments: videoInfos);
  }

  listFiles() async {
    await readStorage();

    List paths = [path, musicPath];

    for (var myPath in paths) {
      // log("--- $myPath");
      Directory directory = Directory(myPath);
      late List<FileSystemEntity> files;

      if (directory.existsSync()) {
        files = directory.listSync();
      } else {
        directory.create().then((value) {
          // log(directory.path);
          files = directory.listSync();
        });
      }

      for (var file in files) {
        if (file is File) {
          String nameWithType = file.path.split("/").last;
          String name = nameWithType.split(".").first;
          String type = nameWithType.split(".").last;

          for (var downloadFile in downList) {
            if (downloadFile["date"] == name) {
              Map<String, dynamic> x = downloadFile;

              x.addAll({
                "isSelected": false.obs,
                "path": file.path,
              });

              // Videos - Musics -Covers
              // if (type == "mp4") {
              filesList.add(x);
              // }
            }
          }

          // log(" $name ------ $type ");
        }
      }
    }

    totalItems.value = filesList.length;

    for (Map<String, dynamic> l in filesList) {
      l.remove("isSelected");
    }
    final noFilteredSave = jsonEncode(filesList);
    box.write("noFilteredList", noFilteredSave);

    for (Map<String, dynamic> l in filesList) {
      l.addAll({"isSelected": false.obs});
    }

    log(">>> totalFiles ${filesList.length}");
  }

  var toRemove = [];

  deleteFile(List files) async {
    Get.bottomSheet(Container(
      padding: const EdgeInsets.only(top: 30),
      width: Get.width,
      height: 260,
      // margin: const EdgeInsets.symmetric(horizontal: 25),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        color: thirdColor,
      ),
      child: Column(
        children: [
          const Text(
            delete_text,
            style: formTitle,
          ),
          SizedBox(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LargeButton(
                  onTap: () {
                    for (var element in filesList) {
                      if (element["isSelected"].value == true) {
                        // log(element.toString());
                        File delFile = File(element["path"]);
                        // log(delFile.path);
                        delFile.deleteSync();
                        toRemove.add(element);
                      }
                    }

                    filesList
                        .removeWhere((element) => toRemove.contains(element));

                    for (Map<String, dynamic> l in filesList) {
                      l.remove("isSelected");
                      l.remove("path");
                    }
                    final dataSave = jsonEncode(filesList);
                    box.write("files", dataSave);

                    filesList.value = [];
                    listFiles();

                    totalItems.value = filesList.length;
                    Get.back();
                  },
                  color: secondColor,
                  text: "Oui",
                ),
                LargeButton(
                  onTap: () => Get.back(),
                  color: firstColor,
                  text: "Non",
                )
              ],
            ),
          )
        ],
      ),
    ));
  }

  deselectAll({required RxList list}) {
    for (var deselect in list) {
      // log("$deselect");

      if (deselect["isSelected"].value == true) {
        deselect["isSelected"].value = false;
      }
    }
  }

  Future<bool> shareFiles({required List filesToShare}) async {
    List<XFile>? shares = [];
    RxBool goodShare = false.obs;

    for (var shareElement in filesToShare) {
      for (var share in shareElement) {
        // log("$share");

        if (share["isSelected"] == true.obs) {
          shares.add(XFile(share["path"]));
          goodShare.value = false;
        }
      }
    }
    goodShare.value = true;
    if (shares.isNotEmpty) {
      if (goodShare.value == true) await Share.shareXFiles(shares);
    }
    return true;
  }
}
