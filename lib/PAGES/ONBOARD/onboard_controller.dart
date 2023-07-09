// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardController extends GetxController {
  
  final pageController = PageController;

   final controller = PageController(initialPage: 0);


  next() => Get.offNamed('signin');


  @override
  void onInit() {
    super.onInit();
  }

  loadData() {}

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
