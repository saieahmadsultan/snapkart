// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../Utilities_Screens/App_Colors/app_colors.dart';
// import '../Home_Screen/home_view.dart';
// import '../Home_Screen/categories_view.dart';
// import '../Wishlist_Screen/wishlist_view.dart';
// import '../History_Screen/History_View.dart';
// import '../Setting_Screen/setting_view.dart';
// import 'main_nav_controller.dart';
//
// class MainNavView extends StatelessWidget {
//   MainNavView({super.key});
//
//   final List<Widget> _pages = [
//     HomeView(),
//     CategoriesView(),
//     WishlistView(),
//     HistoryView(),
//     SettingView(), // Profile tab
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final nav = Get.find<MainNavController>();
//
//     return Obx(() {
//       final i = nav.currentIndex.value;
//
//       return PopScope(
//         canPop: i == 0,
//         onPopInvokedWithResult: (didPop, _) {
//           if (!didPop) nav.changeTab(0); // back par Home par jao
//         },
//         child: Scaffold(
//           body: IndexedStack(index: i, children: _pages),
//           bottomNavigationBar: NavigationBar(
//             selectedIndex: i,
//             onDestinationSelected: nav.changeTab,
//             backgroundColor: AppColors.cardBackground(context),
//             indicatorColor: AppColors.secondary.withValues(alpha: 0.15),
//             surfaceTintColor: Colors.transparent,
//             destinations: const [
//               NavigationDestination(
//                 icon: Icon(Icons.home_outlined),
//                 selectedIcon:
//                 Icon(Icons.home_rounded, color: AppColors.secondary),
//                 label: 'Home',
//               ),
//               NavigationDestination(
//                 icon: Icon(Icons.grid_view_outlined),
//                 selectedIcon:
//                 Icon(Icons.grid_view_rounded, color: AppColors.secondary),
//                 label: 'Categories',
//               ),
//               NavigationDestination(
//                 icon: Icon(Icons.favorite_border),
//                 selectedIcon:
//                 Icon(Icons.favorite, color: AppColors.secondary),
//                 label: 'Wishlist',
//               ),
//               NavigationDestination(
//                 icon: Icon(Icons.inventory_2_outlined),
//                 selectedIcon:
//                 Icon(Icons.inventory_2, color: AppColors.secondary),
//                 label: 'Orders',
//               ),
//               NavigationDestination(
//                 icon: Icon(Icons.person_outline),
//                 selectedIcon:
//                 Icon(Icons.person, color: AppColors.secondary),
//                 label: 'Profile',
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }




import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import '../../Utilities_Screens/App_Colors/app_colors.dart';
import '../Home_Screen/home_view.dart';
import '../Home_Screen/categories_view.dart';
import '../Wishlist_Screen/wishlist_view.dart';
import '../History_Screen/History_View.dart';
import '../Setting_Screen/setting_view.dart';
import 'main_nav_controller.dart';

class MainNavView extends StatelessWidget {
  MainNavView({super.key});

  final List<Widget> _pages = [
    HomeView(),
    CategoriesView(),
    WishlistView(),
    HistoryView(),
    SettingView(),
  ];

  @override
  Widget build(BuildContext context) {
    final nav = Get.find<MainNavController>();

    return Obx(() {
      final i = nav.currentIndex.value;
      final visible = nav.isNavVisible.value;

      return PopScope(
        canPop: i == 0,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) nav.changeTab(0);
        },
        child: Scaffold(
          body: NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              // sirf upar/neeche (vertical) scroll dekho,
              // banner aur chips ka horizontal scroll ignore karo
              if (notification.metrics.axis != Axis.vertical) return false;

              if (notification.direction == ScrollDirection.reverse) {
                nav.hideNav(); // neeche scroll -> hide
              } else if (notification.direction == ScrollDirection.forward) {
                nav.showNav(); // upar scroll -> show
              }
              return false;
            },
            child: IndexedStack(index: i, children: _pages),
          ),
          bottomNavigationBar: ClipRect(
            child: AnimatedAlign(
              alignment: Alignment.topCenter,
              heightFactor: visible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              child: NavigationBar(
                selectedIndex: i,
                onDestinationSelected: nav.changeTab,
                backgroundColor: AppColors.cardBackground(context),
                indicatorColor: AppColors.secondary.withValues(alpha: 0.15),
                surfaceTintColor: Colors.transparent,
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon:
                    Icon(Icons.home_rounded, color: AppColors.secondary),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.grid_view_outlined),
                    selectedIcon: Icon(Icons.grid_view_rounded,
                        color: AppColors.secondary),
                    label: 'Categories',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.favorite_border),
                    selectedIcon:
                    Icon(Icons.favorite, color: AppColors.secondary),
                    label: 'Wishlist',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.inventory_2_outlined),
                    selectedIcon:
                    Icon(Icons.inventory_2, color: AppColors.secondary),
                    label: 'Orders',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.person_outline),
                    selectedIcon:
                    Icon(Icons.person, color: AppColors.secondary),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}