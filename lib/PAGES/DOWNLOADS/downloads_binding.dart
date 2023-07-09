import 'package:get/get.dart';
import 'package:tikidown/PAGES/DOWNLOADS/downloads_controller.dart';

class DownloadsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DownloadsController>(DownloadsController());
  }
}
