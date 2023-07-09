import 'package:tikidown/CORE/core.dart';

class SwipeScreen extends GetView<SwipeController> {
  const SwipeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DownloadsController());
    Get.lazyPut(() => HomeController());

    return Scaffold(
      body: Container(
        // color: thirdColor,
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color(0xFFF5F7FA),
            Color(0xFFB8C6DB),
          ],
        )),
        child: Stack(
          alignment: Alignment.center,
          children: [
            PageView(
              onPageChanged: (int page) {
                controller.currentIndicator.value = page;
                print(controller.currentIndicator.value);
              },
              controller: controller.pageController,
              children: const [HomeScreen(), DownloadsScreen()],
            ),
            Positioned(
              bottom: 10,
              child: Container(
                width: Get.width / 2,
                height: 65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: white,
                ),
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () => controller.home(),
                        child: Container(
                            child: SvgPicture.asset(
                          home_icon,
                          width: 35,
                          colorFilter: ColorFilter.mode(
                              controller.currentIndicator.value == 0
                                  ? secondColor
                                  : fourthColor,
                              BlendMode.srcIn),
                        )),
                      ),
                      TextButton(
                        onPressed: () => controller.downloads(),
                        child: Container(
                          child: SvgPicture.asset(
                            download_icon,
                            width: 35,
                            colorFilter: ColorFilter.mode(
                                controller.currentIndicator.value == 1
                                    ? secondColor
                                    : fourthColor,
                                BlendMode.srcIn),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
