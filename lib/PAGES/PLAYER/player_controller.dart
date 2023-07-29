// ignore_for_file: unnecessary_overrides, unused_local_variable

import 'dart:async';
import 'dart:io';

import 'package:tikidown/CORE/core.dart';
import 'package:video_player/video_player.dart';

class PlayerController extends GetxController {
  Duration duration = const Duration(milliseconds: 2500);

  var datas = Get.arguments;

  final String labelSign = "\u00A9 by TikiDowns";

  late VideoPlayerController videoPlayerController;

  RxBool pausedContent = false.obs;

  initialize() async {
   if(datas["path"] != null) {
     videoPlayerController = VideoPlayerController.file(File(datas["path"]))
      ..initialize().then((_) async {
        videoPlayerController.play();
      });
   }
  }

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  loadData() {}

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    videoPlayerController.dispose();
  }
}
