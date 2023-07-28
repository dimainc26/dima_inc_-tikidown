import 'package:tikidown/CORE/core.dart';
import 'package:video_player/video_player.dart';
import 'package:share_plus/share_plus.dart';

class _VideoProgressSlider extends StatelessWidget {
  const _VideoProgressSlider({
    required this.position,
    required this.duration,
    required this.swatch,
  });

  final Duration position;
  final Duration duration;
  final Color swatch;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PlayerController());

    final max = duration.inMilliseconds.toDouble();
    final value = position.inMilliseconds.clamp(0, max).toDouble();
    return SliderTheme(
      data: SliderThemeData(
        disabledActiveTrackColor: Colors.blue,
        disabledInactiveTrackColor: Colors.black12,
        trackHeight: 35,
        minThumbSeparation: 12,
        thumbShape:
            const RoundSliderThumbShape(enabledThumbRadius: 18.0, elevation: 0),
        trackShape: const RoundedRectSliderTrackShape(),
        thumbColor: thirdColor,
        activeTrackColor: thirdColor.withOpacity(.65),
      ),
      child: Slider(
        min: 0,
        max: max,
        value: value,
        onChanged: (value) => controller.videoPlayerController
            .seekTo(Duration(milliseconds: value.toInt())),
        onChangeStart: (_) {
          controller.videoPlayerController.pause();
          controller.pausedContent.value = true;
        },
        onChangeEnd: (_) {
          controller.videoPlayerController.play();
          controller.pausedContent.value = false;
        },
      ),
    );
  }
}

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
              onLongPress: () {},
              child: SizedBox(
                width: (Get.height / 16) * 9,
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
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(controller.datas["avatar"]))),
                    ),
                    Text(" @"+controller.datas["username"], style: topMenu,)
                  ],
                )),
          ),
          Obx(
            () => Positioned(
                bottom: controller.pausedContent.value == true ? 40 : -100,
                child: Column(
                  children: [
                    Container(
                      width: Get.width - 20,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 55,
                            height: 45,
                            decoration: BoxDecoration(
                              color: firstColor.withOpacity(.3),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextButton(
                                onPressed: () async {
                                  await Share.shareXFiles(
                                      [XFile("${controller.datas["path"]}")],
                                      text: controller.labelSign);
                                },
                                child: SvgPicture.asset(
                                  share_icon,
                                  height: 45,
                                  colorFilter: const ColorFilter.mode(
                                      black, BlendMode.srcIn),
                                )),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: firstColor.withOpacity(.3),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: ValueListenableBuilder<VideoPlayerValue>(
                                valueListenable:
                                    controller.videoPlayerController,
                                builder: (context, value, _) =>
                                    _VideoProgressSlider(
                                  position: value.position,
                                  duration: value.duration,
                                  swatch: fourthColor,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 55,
                            height: 45,
                            decoration: BoxDecoration(
                              color: firstColor.withOpacity(.3),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextButton(
                              onPressed: () {
                                controller.videoPlayerController.value.isPlaying
                                    ? controller.videoPlayerController.pause()
                                    : controller.videoPlayerController.play();
                                controller.pausedContent.value =
                                    !controller.pausedContent.value;
                              },
                              child: SvgPicture.asset(
                                controller.videoPlayerController.value.isPlaying
                                    ? pause_icon
                                    : play_icon,
                                height: 35,
                                colorFilter: const ColorFilter.mode(
                                    black, BlendMode.srcIn),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
