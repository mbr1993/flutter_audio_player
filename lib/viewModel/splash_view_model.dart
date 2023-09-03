import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/tabview/main_tabview.dart';

class SplashViewModel extends GetxController {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  void loadView() async {
    await Future.delayed(const Duration(seconds: 1));
    Get.to(() => const MainViewTab());
  }

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState?.closeDrawer();
  }
}
