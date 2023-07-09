// ignore_for_file: unnecessary_overrides

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:tikidown/CORE/core.dart';

class TestController extends GetxController {
  RxList fileList = <File>[].obs;

  Future<bool> listFiles() async {
    const path = '/storage/emulated/0/DCIM/TikiDowns';
    Directory directory = Directory(path);
    List<FileSystemEntity> files = directory.listSync();

    for (var file in files) {
      if (file is File) {
        fileList.add(file);
        log(file.path);
      }
    }

    if (fileList.isEmpty) {
      return false;
    } else {
      return true;
    }
    
  }

  deleteFile(File file){
    file.deleteSync();
    fileList.remove(file);
    log(fileList.length.toString());
  }

  @override
  void onInit() {
    super.onInit();
  }

  loadData() {}

  @override
  void onReady() {
    super.onReady();
    listFiles();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
