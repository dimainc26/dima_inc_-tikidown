import 'package:tikidown/CORE/core.dart';

part 'routes.dart';

GetStorage box = GetStorage();

class AppPages {
  static const initial = Routes.home;
  static const first = Routes.splash;
  static const working = Routes.working;

  static final androidRoutes = [
    // TODO: Current working page
    GetPage(
        name: '/working',
        page: () => const SwipeScreen(),
        binding: SwipeBinding()),

    GetPage(
        name: '/',
        page: () {
          if (box.hasData('account')) {
            return const SwipeScreen();
          } else {
            return const SplashScreen();
          }
        },
        binding: box.hasData('account') ? SwipeBinding() : SplashBinding()),
    GetPage(
        name: '/onboard',
        page: () => const OnBoardingScreen(),
        binding: OnboardBinding()),
    GetPage(
        name: '/swipes',
        page: () => const SwipeScreen(),
        binding: SwipeBinding()),
    GetPage(
        name: '/home', page: () => const SwipeScreen(), binding: SwipeBinding()),
    GetPage(
        name: '/player',
        page: () => const PlayerScreen(),
        binding: PlayerBinding()),
  ];
}
