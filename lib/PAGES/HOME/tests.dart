import 'package:flutter/material.dart';
import 'package:tikidown/PAGES/HOME/home_controller.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(onPressed: ()=> controller.fetchDatas("https://vm.tiktok.com/ZM2PBcybR/") , child: Text("Fetch Videos Data")),
          // MaterialButton(onPressed: ()=> controller.checkDirectories() , child: Text("Check Directory")),
        ],
      ),
    );
  }
}
