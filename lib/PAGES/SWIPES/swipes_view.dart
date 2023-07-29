import 'dart:io';

import 'package:tikidown/CORE/core.dart';

class SwipeScreen extends GetView<SwipeController> {
  const SwipeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: thirdColor,
        width: Get.width,
        height: Get.height,
        // decoration: const BoxDecoration(
        //     gradient: LinearGradient(
        //   colors: [
        //     Color(0xFFF5F7FA),
        //     Color(0xFFB8C6DB),
        //   ],
        // )),
        child: Stack(
          alignment: Alignment.center,
          children: [
            PageView(
              onPageChanged: (int page) {
                controller.currentIndicator.value = page;
                print(controller.currentIndicator.value);
              },
              controller: controller.pageController,
              children: [
                // Home screen
                Column(
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
                      padding:
                          const EdgeInsets.only(left: 32, top: 4, bottom: 4),
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
                        style:
                            const TextStyle(fontSize: 16, color: secondColor),
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
                                          () => LinearProgressIndicator(
                                            value: controller.progress.value,
                                            color: Colors.white24,
                                            backgroundColor:
                                                thirdColor.withAlpha(20),
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
                                  onTap: () => controller.fetchDatas(
                                      controller.linkController.text),
                                  color: firstColor,
                                ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            TextButton(
                                onPressed: () => controller.deleteStorage(),
                                child: const Text("Banner Ad"))
                          ],
                        ),
                      ),
                    )
                  ],
                ),

                // downlload Screen(),

                Stack(
                  children: [
                    SizedBox(
                      width: Get.width,
                      height: Get.height,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 120,
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Downloads",
                                style: topMenu,
                              ),
                              SizedBox(
                                width: 140,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () => controller
                                          .deleteFile(controller.filesList),
                                      child: SvgPicture.asset(
                                        delete_icon,
                                        width: 38,
                                        colorFilter: const ColorFilter.mode(
                                            fourthColor, BlendMode.srcIn),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => controller.shareFiles(
                                          filesToShare: [controller.filesList]),
                                      child: SvgPicture.asset(
                                        share_icon,
                                        width: 28,
                                        colorFilter: const ColorFilter.mode(
                                            fourthColor, BlendMode.srcIn),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => null,
                                      child: SvgPicture.asset(
                                        settings_icon,
                                        width: 28,
                                        colorFilter: const ColorFilter.mode(
                                            fourthColor, BlendMode.srcIn),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 60,
                          width: Get.width - 76,
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 15),
                          child: TabBar(
                              indicatorColor: secondColor,
                              indicatorPadding:
                                  const EdgeInsets.symmetric(horizontal: 14),
                              labelStyle: topMenu,
                              controller: controller.tabBarController,
                              onTap: (index) {
                                controller.changePage(index);
                              },
                              tabs: const [
                                Tab(
                                  child: Text(
                                    "Videos",
                                    style: formTitle,
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    "Covers",
                                    style: formTitle,
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    "Songs",
                                    style: formTitle,
                                  ),
                                ),
                              ]),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: PageView.builder(
                                itemCount: 3,
                                allowImplicitScrolling: false,
                                physics: const NeverScrollableScrollPhysics(),
                                controller: controller.downPageController,
                                onPageChanged: (int i) {
                                  controller.xselectedPage.value = i;
                                },
                                itemBuilder:
                                    (BuildContext context, int pageIndex) {
                                  return pageIndex == 0
                                      ? Obx(
                                          () => GridView.builder(
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2),
                                              shrinkWrap: true,
                                              itemCount: controller
                                                  .filesList.value.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    controller.deselectAll(list: controller.filesList);

                                                    controller.next(
                                                        videoInfos: controller
                                                            .filesList[index]);
                                                  },
                                                  onLongPress: () {
                                                    if (controller.filesList[
                                                                index]
                                                            ["isSelected"] !=
                                                        null) {
                                                      controller
                                                              .filesList[index]
                                                                  ["isSelected"]
                                                              .value =
                                                          !controller
                                                              .filesList[index]
                                                                  ["isSelected"]
                                                              .value;

                                                      print(controller
                                                          .filesList[index]
                                                              ["isSelected"]
                                                          .value);
                                                    }
                                                    ;
                                                  },
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Obx(
                                                        () => Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 4,
                                                                  horizontal:
                                                                      6),
                                                          width: Get.width,
                                                          height: 130,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            image:
                                                                DecorationImage(
                                                              image: FileImage(
                                                                  File(controller
                                                                              .filesList[
                                                                          index]
                                                                      [
                                                                      "cover"])),
                                                              fit: BoxFit
                                                                  .fitWidth,
                                                              filterQuality:
                                                                  FilterQuality
                                                                      .high,
                                                              colorFilter: controller
                                                                          .filesList[
                                                                              index]
                                                                              [
                                                                              "isSelected"]
                                                                          .value !=
                                                                      null
                                                                  ? controller.filesList[index]["isSelected"].value ==
                                                                          true
                                                                      ? const ColorFilter
                                                                              .mode(
                                                                          Colors
                                                                              .red,
                                                                          BlendMode
                                                                              .color)
                                                                      : const ColorFilter
                                                                              .mode(
                                                                          Colors
                                                                              .transparent,
                                                                          BlendMode
                                                                              .color)
                                                                  : const ColorFilter
                                                                          .mode(
                                                                      Colors
                                                                          .transparent,
                                                                      BlendMode
                                                                          .color),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 20),
                                                        child:
                                                            SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Text(controller
                                                                  .filesList[
                                                              index]['title']),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 20),
                                                        child: Text(
                                                            "@${controller.filesList[index]["username"]}"),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                        )
                                      : Center(
                                          child: Text(
                                          pageIndex.toString(),
                                          style: TextStyle(color: black),
                                        ));
                                }),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
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
                child: Row(
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
          ],
        ),
      ),
    );
  }
}
