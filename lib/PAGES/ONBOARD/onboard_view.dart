import 'package:tikidown/CORE/core.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends GetView<OnBoardController> {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.controller,
            children: const [
              Onboard(
                  txt1: firstOnboard,
                  txt2: firstOnboard1,
                  txt3: firstOnboard2,
                  icon: shareIcon,
                  img: onboardImg1,
                  bgColor: firstColor),
              Onboard(
                  txt1: firstOnboard,
                  txt2: firstOnboard1,
                  txt3: firstOnboard2,
                  icon: shareIcon,
                  img: onboardImg2,
                  bgColor: secondColor),
              Onboard(
                  txt1: firstOnboard,
                  txt2: firstOnboard1,
                  txt3: firstOnboard2,
                  icon: shareIcon,
                  img: onboardImg3,
                  bgColor: thirdColor),
            ],
          ),
          Positioned(
            bottom: 120,
            child: SizedBox(
              width: Get.width,
              child: Center(
                child: SmoothPageIndicator(
                    effect: const WormEffect(
                        dotHeight: 16, dotWidth: 16, activeDotColor: black),
                    controller: controller.controller,
                    count: 3),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            child: SizedBox(
              width: Get.width,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NavigateButton(text: "Skip", color: firstColor),
                    NavigateButton(text: "Next", color: secondColor),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}

