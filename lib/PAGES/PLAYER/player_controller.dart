// ignore_for_file: unnecessary_overrides

import 'dart:async';
import 'dart:developer';
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
    RxBool seeInfos = false.obs;
    if (datas["path"] != null) {
      videoPlayerController = VideoPlayerController.file(File(datas["path"]))
        ..initialize().then((_) async {
          videoPlayerController.play();
          videoPlayerController.addListener(() {
            if (videoPlayerController.value.position ==
                videoPlayerController.value.duration) {
              Get.back();

              Get.bottomSheet(
                  barrierColor: thirdColor.withOpacity(.3),
                  // barrierDismissible: true,
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                      color: thirdColor,
                    ),
                    width: Get.width - 80,
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(datas["avatar"]))),
                        ), 
                        Text("@${datas["username"]}", style: largeText,),
                      ],
                    ),
                  ));
            }
          });
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
