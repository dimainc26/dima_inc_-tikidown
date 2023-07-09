import 'package:get/get.dart';
import 'package:tikidown/PAGES/HOME/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
  Get.put<HomeController>(HomeController());
  }

}