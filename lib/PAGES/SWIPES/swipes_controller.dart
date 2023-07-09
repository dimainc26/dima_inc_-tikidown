// ignore_for_file: unnecessary_overrides

import 'dart:async';

import 'package:tikidown/CORE/core.dart';

class SwipeController extends GetxController {
  Duration duration = const Duration(milliseconds: 500);

  late PageController pageController;

  home() {
    if (pageController.page != 0) pageController.animateToPage(0, duration: duration, curve: Curves.linear);
  }
  downloads() {
    if (pageController.page != 1) pageController.animateToPage(1, duration: duration, curve: Curves.linear);
  }

  RxInt currentIndicator =     0.obs;

  next() {}

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 0);
    currentIndicator =     pageController.initialPage.obs;
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
