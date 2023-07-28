import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:tikidown/CORE/core.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class MusicController extends GetxController {
  late List<dynamic> dataList;
  List<dynamic> musicList = [];
  late int myIndex;

  final musicPath = '/storage/emulated/0/Music/TikiDowns';

  final audios = <Audio>[];

  final datas = Get.arguments;

  late AssetsAudioPlayer assetsAudioPlayer;
  final List<StreamSubscription> _subscriptions = [];

  @override
  void onInit() {
    super.onInit();
    assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    _subscriptions.add(assetsAudioPlayer.playlistAudioFinished.listen((data) {
      log('playlistAudioFinished : $data');
    }));
    _subscriptions.add(assetsAudioPlayer.audioSessionId.listen((sessionId) {
      log('audioSessionId : $sessionId');
    }));
    loadData();
    openPlayer();
  }

  openPlayer() async {
    try {
      await assetsAudioPlayer.open(

        Playlist(audios: audios, startIndex: myIndex),
        showNotification: false,
        autoStart: true,
      );
    } catch (e) {
      log(e.toString());
    }
  }

  loadData() {
    dataList = jsonDecode(box.read("files"));

    dataList = dataList.where((type) => type["type"] == "mp3").toList();

    Directory directory = Directory(musicPath);
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

        for (var dt in dataList) {
          if (dt["date"] == name) {
            Map<String, dynamic> x = dt;

            x.addAll({
              "path": file.path,
            });
            // Videos - Musics -Covers
            if (type == "mp3") {
              musicList.add(x);
            }
          }
        }
      }
    }

    musicList.forEach((data) {
      audios.add(Audio.file(
        data["path"],
        metas: Metas(
          id: data["id"],
          title: data["title"],
          artist: data["username"],
          album: 'Tikidowns',
          image: MetasImage.file(data["cover"]),
        ),
      ));
    });

    myIndex = musicList.indexWhere((element) => element["id"] == datas["id"]);

    log(myIndex.toString());
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    assetsAudioPlayer.dispose();
  }
}
