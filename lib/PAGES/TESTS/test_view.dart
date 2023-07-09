import 'package:tikidown/CORE/core.dart';

class TestScreen extends GetView<TestController> {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DownloadsController());
    Get.lazyPut(() => HomeController());

    return Scaffold(
      body: Obx(
        ()=> Column(
          children: [
            SizedBox(
              height: 120,
            ),
            Container(
                color: secondColor,
                child: MaterialButton(
                  onPressed: () => controller.listFiles(),
                  child: Text("Lister les fichiers"),
                )),
            Container(
              height: Get.height / 1.5,
              child: ListView.builder(
                itemCount: controller.fileList.length,
                itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: Get.width,
                    height: 120,
                    color: thirdColor,
                    child: Row(
                      children: [
                        SizedBox(
                          width: Get.width - 100,
                          child: Text(controller.fileList[index].path, overflow: TextOverflow.clip, )),
                        IconButton(onPressed: ()=> controller.deleteFile(controller.fileList[index]) , icon: const Icon(Icons.delete))
                      ],
                    )),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
