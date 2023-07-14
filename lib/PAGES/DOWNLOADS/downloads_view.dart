import 'package:tikidown/CORE/core.dart';

class DownloadsScreen extends GetView<DownloadsController> {
  const DownloadsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () =>
                                controller.deleteFile(controller.fileList),
                            child: SvgPicture.asset(
                              delete_icon,
                              width: 38,
                              colorFilter: const ColorFilter.mode(
                                  fourthColor, BlendMode.srcIn),
                            ),
                          ),
                          InkWell(
                            onTap: () => controller.shareFiles(
                                filesToShare: controller.fileList),
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
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
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
                      controller: controller.pageController,
                      onPageChanged: (int index) {
                        controller.selectedPage.value = index;
                      },
                      itemBuilder: (BuildContext context, int pageIndex) {
                        return pageIndex == 0
                            ? Obx(
                                () => GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2),
                                    shrinkWrap: true,
                                    itemCount: controller.totalItems.value,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () => controller.next(
                                            videoInfos:
                                                controller.fileList[index]),
                                        onLongPress: () {
                                          if (controller
                                                  .fileList[index]["isSelected"]
                                                  .value !=
                                              null) {
                                            controller
                                                    .fileList[index]["isSelected"]
                                                    .value =
                                                !controller
                                                    .fileList[index]
                                                        ["isSelected"]
                                                    .value;
                                            print(controller
                                                .fileList[index]["isSelected"]
                                                .value);
                                          } else {}
                                          ;
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Obx(
                                              ()=> Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4,
                                                        horizontal: 6),
                                                width: Get.width,
                                                height: 130,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        controller.fileList[index]
                                                            ["cover"]),
                                                    fit: BoxFit.fitWidth,
                                                    filterQuality:
                                                        FilterQuality.high,
                                                    colorFilter: controller
                                                                        .fileList[
                                                                    index]
                                                                ["isSelected"].value !=
                                                            null
                                                        ? controller
                                                                .fileList[index]
                                                                    ["isSelected"].value
                                                            ? const ColorFilter
                                                                    .mode(
                                                                Colors.red,
                                                                BlendMode.color)
                                                            : const ColorFilter
                                                                    .mode(
                                                                Colors
                                                                    .transparent,
                                                                BlendMode.color)
                                                        : const ColorFilter.mode(
                                                            Colors.transparent,
                                                            BlendMode.color),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Text(controller
                                                    .fileList[index]["title"]),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Text(
                                                  "@${controller.fileList[index]["name"]}"),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              )
                            : Text(pageIndex.toString());
                      }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
