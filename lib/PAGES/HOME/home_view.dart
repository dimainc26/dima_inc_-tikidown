import 'package:tikidown/CORE/core.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Get.put(() => DownloadsController());


    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: Get.height / 3,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(logoImg),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 4),
            padding: const EdgeInsets.only(left: 32, top: 4, bottom: 4),
            width: Get.width - 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
            ),
            child: TextFormField(
              controller: controller.linkController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Paste URL Here",
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: fourthColor,
                ),
              ),
              style: const TextStyle(fontSize: 16, color: secondColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Obx(
              () => Container(
                margin: const EdgeInsets.only(top: 6, bottom: 12),
                width: Get.width - 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  // border: Border.all(color: Colors.grey),
                  gradient: const LinearGradient(
                    colors: [secondColor, firstColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: controller.loading.value
                    ? Container(
                        height: 55,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Positioned.fill(
                              child: Obx(
                                ()=> LinearProgressIndicator(
                                  value: controller.progress.value,
                                  color: Colors.white24,
                                  backgroundColor: thirdColor.withAlpha(20),
                                ),
                              ),
                            ),
                            const Center(
                              child: Text('Download...'),
                            )
                          ],
                        ),
                      )
                    : PageButton(
                        onTap: ()=> controller.fetchDatas(controller.linkController.text),
                        color: firstColor,
                      ),
              ),
            ),
          ),
           Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                children: [TextButton( onPressed: ()=> controller.readStorage(), child: Text("Banner Ad"))],
              ),
            ),
          )
        ],
      ),
    );
  }
}
