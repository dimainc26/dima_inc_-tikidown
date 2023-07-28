// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables

import 'dart:developer';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:tikidown/API/dio_client.dart';
import 'package:tikidown/CORE/core.dart';

final DioClient _client = DioClient();

List file = [];
List paths = [];
List pathsObject = [];

RxDouble progress = 0.0.obs;

class DirectoryClient {
  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future<RxDouble> checkDirectory(
      {required String link,
      required String fileName,
      required String type}) async {
    Directory? directory;

    try {
      String newPath = "";

      if (Platform.isAndroid) {
        // Check permission status
          directory = await getExternalStorageDirectory();
        if (await _requestPermission(Permission.photos)) {

          // String newPath = "";

          List<String> folders = directory!.path.split("/");

          for (int i = 0; i < folders.length; i++) {
            String folder = folders[i];
            if (folder != "Android") {
              newPath += "/$folder";
            } else {
              break;
            }
          }

          // newPath = "$newPath/DCIM/TikiDowns";
          // directory = Directory(newPath);

          // print("PATH: ${directory.path}");
        } else {
          return 0.0.obs;
        }
// Music
          // directory = await getExternalStorageDirectory();
        if (await _requestPermission(Permission.audio)) {

          // String newPath = "";

          // List<String> folders = directory!.path.split("/");

          // for (int i = 0; i < folders.length; i++) {
          //   String folder = folders[i];
          //   if (folder != "Android") {
          //     newPath += "/$folder";
          //   } else {
          //     break;
          //   }
          // }

          // newPath = "$newPath/Music/TikiDowns";
          // directory = Directory(newPath);

          // log("PATH: ${directory.path}");
        } else {
          return 0.0.obs;
        }
      } else {
        if (await _requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return 0.0.obs;
        }
      }

      if (type == "mp3") {
        newPath = "$newPath/Music/TikiDowns";
      } else {
        newPath = "$newPath/DCIM/TikiDowns";
      }
      directory = Directory(newPath);
    } catch (e) {
      log("----- $e");
    }

    // log("PATH: ${directory?.path}");

    late var saveFile;

    if (!await directory!.exists()) {
      log(" --- creation de dossier en cours ----");
      await directory.create(recursive: true);
    }

    RxBool status = false.obs;
    if (await directory.exists()) {
      saveFile = File("${directory.path}/$fileName.$type");

      saveFile = saveFile.path;

      // log("saveFile:  $saveFile");

      // All good now launch download here

      RxDouble myProgress = 0.0.obs;

      (status, myProgress) =
          await _client.downloadVideo(link: link, filePath: saveFile);

      if (progress.value == 1) status = true.obs;

      progress = myProgress;
      return progress;
    }

    return progress;
  }
}
