// ignore_for_file: unnecessary_overrides

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:tikidown/CORE/core.dart';
import 'package:share_plus/share_plus.dart';

class DownloadsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final path = '/storage/emulated/0/DCIM/TikiDowns';
  final boxDatas = GetStorage();
  Duration duration = const Duration(milliseconds: 600);

  late TabController tabBarController;
  late PageController pageController;

  RxBool goodDeleted = false.obs;

  RxInt selectedPage = 0.obs;
  RxInt totalItems = 0.obs;

  RxList fileList = <Map<String, dynamic>>[].obs;
  RxList storageList = [].obs;

  readStorage() async {
    var boxVideos = await box.read("videos");
    storageList.value = boxVideos ?? [];

    // log(storageList.toString());
    log(storageList.length.toString());
    log("--- readStorage()");
  }

  eraseStorage() async {
    await box.remove("videos");
    log("--- eraseStorage()");
  }

  changePage(pageSelected) {
    pageController.animateToPage(pageSelected,
        duration: duration, curve: Curves.ease);
  }

  next({required videoInfos}) {
    Get.toNamed("/player", arguments: videoInfos);
  }

  listFiles() async {
    await readStorage();

    Directory directory = Directory(path);
    List<FileSystemEntity> files = directory.listSync();

    for (var file in files) {
      if (file is File) {
        String nameWithType = file.path.split("/").last;
        String name = nameWithType.split(".").first;
        String type = nameWithType.split(".").last;
        // log(" ${name} ------ ${type} ");

        for (var storageData in storageList) {
          if (storageData["date"] == name) {
            storageData.addAll({"isSelected":  false.obs, "path": file.path });

            print("---- $storageData");
            fileList.add(storageData);
          }
        }
      }
    }
    totalItems.value = fileList.length;

    if (fileList.isNotEmpty) {
      log("---- : ${fileList.last} \n");
    }
  }

  deleteFile(List files)async {
    for (var file in files) {
      if (file["isSelected"] == true) {
        log(file.toString());
      }
    }
  }

  Future<bool> shareFiles({required RxList filesToShare}) async {
    List<XFile>? shares = [];
    RxBool goodShare = false.obs;

    for (var shareElement in filesToShare) {
      if (shareElement["isSelected"] == true) {
        shares.add(XFile(shareElement["path"]));
        goodShare.value = false;
      }
    }
    goodShare.value = true;
    if (shares.isNotEmpty) {
      if (goodShare.value == true) await Share.shareXFiles(shares);
    }
    return true;
  }

  @override
  void onInit() {
    super.onInit();
    tabBarController = TabController(length: 3, vsync: this, initialIndex: 0);
    pageController = PageController(initialPage: selectedPage.value);
  }

  @override
  void onReady() {
    super.onReady();
    listFiles();
  }

  @override
  void onClose() {
    super.onClose();
    tabBarController.dispose();
    pageController.dispose();
  }
}
