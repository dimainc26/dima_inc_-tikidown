import 'package:tikidown/CORE/core.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TikiDown',
      theme: ThemeData(
        fontFamily: 'Helvetica',
        primarySwatch: thirdSwatch,
      ),
      initialRoute: AppPages.initial,
      getPages: AppPages.androidRoutes,
    );
  }
}
