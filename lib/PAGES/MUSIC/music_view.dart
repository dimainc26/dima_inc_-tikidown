// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:tikidown/CORE/core.dart';

class MusicScreen extends GetView<MusicController> {
  const MusicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: Get.width,
      height: Get.height,
      decoration: const BoxDecoration(
        color: firstColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          StreamBuilder<Playing?>(
              stream: controller.assetsAudioPlayer.current,
              builder: (context, playing) {
                if (playing.data != null) {
                  final myAudio = controller.find(
                      controller.audios, playing.data!.audio.assetAudioPath);
                  log(playing.data!.audio.assetAudioPath);
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: myAudio.metas.image?.path == null
                              ? FileImage(
                                  File(controller.datas["cover"]),
                                )
                              : FileImage(
                                  File(myAudio.metas.image!.path),
                                ),
                          fit: BoxFit.fitHeight,
                          filterQuality: FilterQuality.high,
                          opacity: .5),
                    ),
                    width: Get.width,
                    height: Get.height - 180,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          myAudio.metas.title.toString(),
                          style: topMenu.copyWith(color: black),
                        ),
                        Container(
                          width: Get.width - 160,
                          height: Get.width - 160,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 80, vertical: 30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                              image: myAudio.metas.image?.path == null
                                  ? FileImage(
                                      File(controller.datas["cover"]),
                                    )
                                  : FileImage(
                                      File(myAudio.metas.image!.path),
                                    ),
                              fit: BoxFit.fitWidth,
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                          child: Center(
                              child: SvgPicture.asset(
                            music_icon,
                            height: 80,
                          )),
                        ),
                        Text(
                          "@${ myAudio.metas.artist}",
                          style: topMenu.copyWith(
                              color: black,
                              decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  );
                }
                return SizedBox.shrink();
              }),
          SizedBox(
            width: Get.width,
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child:
                      controller.assetsAudioPlayer.builderRealtimePlayingInfos(
                    builder: (context, RealtimePlayingInfos? infos) {
                      if (infos == null) {
                        return  SizedBox(
                          child: SvgPicture.asset(play_icon),
                        );
                      }
                      //print('infos: $infos');
                      return Column(
                        children: [
                          PositionSeekWidget(
                            currentPosition: infos.currentPosition,
                            duration: infos.duration,
                            seekTo: (to) {
                              controller.assetsAudioPlayer.seek(to);
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        controller.assetsAudioPlayer.previous();
                      },
                      child: SvgPicture.asset(
                        left_icon,
                        width: 30,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.assetsAudioPlayer.playOrPause();
                        log("play button");
                      },
                      child: SvgPicture.asset(
                        controller.assetsAudioPlayer.isPlaying.value ?  pause_icon : play_icon,
                        width: 30,
                        colorFilter: const ColorFilter.mode(
                            secondColor, BlendMode.srcIn),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.assetsAudioPlayer.next();
                      },
                      child: SvgPicture.asset(
                        right_icon,
                        width: 30,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
