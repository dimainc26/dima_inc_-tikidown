import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tikidown/API/dio_client.dart';
import 'package:tikidown/CORE/core.dart';

final DioClient _client = DioClient();

final path = '/storage/emulated/0/DCIM/TikiDowns';
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

  Future<double> checkDirectory(
      {required String link, required String fileName}) async {
    Directory? directory;

    try {
      if (Platform.isAndroid) {
        // Check permission status
        if (await _requestPermission(Permission.photos)) {
          directory = await getExternalStorageDirectory();

          String newPath = "";

          List<String> folders = directory!.path.split("/");

          for (int i = 0; i < folders.length; i++) {
            String folder = folders[i];
            if (folder != "Android") {
              newPath += "/$folder";
            } else {
              break;
            }
          }

          newPath = "$newPath/DCIM/TikiDowns";
          directory = Directory(newPath);

          print("PATH: ${directory.path}");
        } else {
          return 0.0;
        }
      } else {
        if (await _requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return 0.0;
        }
      }
    } catch (e) {
      print(e);
    }

    print(directory?.path);

    late var saveFile;

    if (!await directory!.exists()) {
      print(" --- creation de dossier en cours ----");
      await directory.create(recursive: true);
    }

    if (await directory.exists()) {
      saveFile = File("${directory.path}/$fileName.mp4");

      saveFile = saveFile.path;

      debugPrint("saveFile:  $saveFile");

      // All good now launch download here
      bool status = false;


      progress.value =
          await _client.downloadVideo(link: link, filePath: saveFile);

      if (progress.value == 1) status = true;

      return progress.value;
    }

    return progress.value;
  }
}
