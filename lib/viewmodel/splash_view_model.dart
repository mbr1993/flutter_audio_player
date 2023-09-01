import 'package:get/get.dart';
import 'package:flutter_audio_player/view/main_tabview/main_tabview.dart';

class SplashViewMode extends GetxController {
  void loadView() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.to(() => const MainViewTab());
  }
}
