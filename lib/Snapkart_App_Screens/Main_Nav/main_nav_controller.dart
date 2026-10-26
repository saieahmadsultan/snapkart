// import 'package:get/get.dart';
//
// class MainNavController extends GetxController {
//   static MainNavController get instance => Get.find();
//
//   final currentIndex = 0.obs;
//
//   void changeTab(int i) => currentIndex.value = i;
// }

import 'package:get/get.dart';

class MainNavController extends GetxController {
  static MainNavController get instance => Get.find();

  final currentIndex = 0.obs;
  final isNavVisible = true.obs; // navbar dikhana hai ya nahi

  void changeTab(int i) {
    currentIndex.value = i;
    isNavVisible.value = true; // tab badalne par bar wapas show
  }

  void showNav() {
    if (!isNavVisible.value) isNavVisible.value = true;
  }

  void hideNav() {
    if (isNavVisible.value) isNavVisible.value = false;
  }
}