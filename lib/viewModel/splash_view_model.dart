import 'package:get/get.dart';
import '../view/tabview/main_tabview.dart';

class SplashViewModel extends GetxController {
  void loadView() async {
    await Future.delayed(const Duration(seconds: 1));
    Get.to(() => const MainViewTab());
  }
}
