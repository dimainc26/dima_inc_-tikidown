import 'package:tikidown/CORE/core.dart';
import 'package:rive/rive.dart';
import 'package:video_player/video_player.dart';
import 'package:share_plus/share_plus.dart';

class PlayerScreen extends GetView<PlayerController> {
  const PlayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          InteractiveViewer(
            constrained: false,
            scaleEnabled: true,
            maxScale: 4,
            child: InkWell(
              onTap: () {
                controller.videoPlayerController.value.isPlaying
                    ? controller.videoPlayerController.pause()
                    : controller.videoPlayerController.play();
                controller.pausedContent.value =
                    !controller.pausedContent.value;
              },
              child: Container(
                width: Get.width,
                height: Get.height,
                child: AspectRatio(
                  aspectRatio:
                      controller.videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(controller.videoPlayerController),
                ),
              ),
            ),
          ),
          Obx(
            () => Positioned(
                top: controller.pausedContent.value == true ? 100 : -100,
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {},
                        child:
                            Container(color: Colors.red, child: Text("share"))),
                  ],
                )),
          ),
          Obx(
            () => Positioned(
                bottom: controller.pausedContent.value == true ? 140 : -100,
                child: Column(
                  children: [
                    Container(
                      width: Get.width,
                      child: VideoProgressIndicator(
                                          controller.videoPlayerController,
                                          allowScrubbing: true,
                                          colors: const VideoProgressColors(
                                              playedColor: Colors.white,
                                              bufferedColor: Color(0xff7577CC)),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 6, horizontal: 9),
                                        ),
                    ),
                    Row(children: [
                      IconButton(
                                        onPressed: () {
                                            controller.videoPlayerController.value.volume != 0
                                                ? controller.videoPlayerController.setVolume(0)
                                                : controller.videoPlayerController.setVolume(.6);
                                        },
                                        icon: const Icon(Icons.volume_mute),
                                        color: Colors.white,
                                        iconSize: 45,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                            controller.videoPlayerController.value.isPlaying
                                                ? controller.videoPlayerController.pause()
                                                : controller.videoPlayerController.play();
                                                 controller.pausedContent.value =
                    !controller.pausedContent.value;
                                        },
                                        icon: Icon(controller.videoPlayerController.value.isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow),
                                        color: Colors.white,
                                        iconSize: 45,
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          await Share.shareXFiles(
                                              [XFile("${controller.datas["path"]}")],
                                              text: controller.labelSign);
                                        },
                                        icon: const Icon(Icons.share),
                                        color: Colors.white,
                                        iconSize: 30,
                                      ),
                    ],)
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
