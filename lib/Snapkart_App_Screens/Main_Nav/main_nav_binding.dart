import 'package:get/get.dart';
import '../Home_Screen/home_binding.dart';
import '../Wishlist_Screen/wishlist_binding.dart';
import '../History_Screen/History_Binding.dart';
import '../Setting_Screen/setting_binding.dart';
import 'main_nav_controller.dart';

class MainNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainNavController());
    HomeBinding().dependencies();
    WishlistBinding().dependencies();
    HistoryBinding().dependencies();
    SettingBinding().dependencies();
  }
}