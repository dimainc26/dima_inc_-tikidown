import 'package:get/get.dart';
import 'package:tikidown/PAGES/TESTS/test_controller.dart';

class TestBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TestController>(TestController());
  }
}
