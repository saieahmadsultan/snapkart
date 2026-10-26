// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:snapkart/App_Routes/routes_view.dart';
//
// import '../../Utilities_Screens/App_Colors/app_colors.dart';
// import '../../Utilities_Screens/App_Colors/app_widgets.dart';
// import '../../Utilities_Screens/App_Model/app_model.dart';
// import '../../Utilities_Screens/Currency_Service/currency_service.dart';
// import '../../Utilities_Screens/Wave_Skelton_Box/wave_skelton_box.dart';
// import '../Cart_Screen/cart_controller.dart';
// import '../Recently_Viewed/recently_view_controller.dart';
// import '../Wishlist_Screen/wishlist_controller.dart';
// import 'home_controller.dart';
//
// class HomeView extends StatelessWidget {
//   const HomeView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final HomeController controller = Get.put(HomeController());
//
//     return Scaffold(
//       backgroundColor: AppColors.background(context),
//       drawer: _buildDrawer(controller, context),
//       appBar: _buildAppBar(controller, context),
//       body: RefreshIndicator(
//         onRefresh: controller.refreshProducts,
//         color: AppColors.secondary,
//         child: CustomScrollView(
//           slivers: [
//             SliverToBoxAdapter(child: _buildSearchBar(controller, context)),
//             SliverToBoxAdapter(child: _buildPromoBanner(controller, context)),
//
//             SliverPersistentHeader(
//               pinned: true,
//               delegate: _StickyHeaderDelegate(
//                 height: 62,
//                 backgroundColor: AppColors.background(context),
//                 child: _buildCategoryChips(controller, context),
//               ),
//             ),
//
//             SliverToBoxAdapter(child: _buildRecentlyViewed(context)),
//
//             Obx(() {
//               if (controller.isLoading.value) {
//                 return _buildSkeletonSliverGrid(context);
//               }
//
//               if (controller.isError.value) {
//                 return SliverFillRemaining(
//                   hasScrollBody: false,
//                   child: _buildErrorState(controller, context),
//                 );
//               }
//
//               if (controller.filteredProductList.isEmpty) {
//                 return SliverFillRemaining(
//                   hasScrollBody: false,
//                   child: _buildEmptyState(controller, context),
//                 );
//               }
//
//               return _buildProductSliverGrid(controller, context);
//             }),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ============================================================
//   // DRAWER
//   // ============================================================
//
//   // Widget _buildDrawer(HomeController controller, BuildContext context) {
//   //   return Drawer(
//   //     backgroundColor: AppColors.cardBackground(context),
//   //     child: SafeArea(
//   //       child: Column(
//   //         crossAxisAlignment: CrossAxisAlignment.start,
//   //         children: [
//   //           // Obx(
//   //           //   () => SizedBox(
//   //           //     height: 220,
//   //           //     width: double.infinity,
//   //           //     child: Image.network(
//   //           //       controller.shoppingImages[controller.imageIndex.value],
//   //           //       fit: BoxFit.cover,
//   //           //       loadingBuilder: (context, child, loadingProgress) {
//   //           //         if (loadingProgress == null) {
//   //           //           return child;
//   //           //         }
//   //           //
//   //           //         return WaveSkeletonBox(
//   //           //           height: 220,
//   //           //           borderRadius: BorderRadius.zero,
//   //           //         );
//   //           //       },
//   //           //       errorBuilder: (context, error, stackTrace) {
//   //           //         return Container(
//   //           //           height: 220,
//   //           //           width: double.infinity,
//   //           //           color: Colors.grey.shade300,
//   //           //           child: const Icon(Icons.image_not_supported, size: 40),
//   //           //         );
//   //           //       },
//   //           //     ),
//   //           //   ),
//   //           // ),
//   //           const SizedBox(height: 8),
//   //
//   //           Obx(() {
//   //             final count = WishlistController.instance.wishlistCount;
//   //
//   //             return _buildDrawerItem(
//   //               icon: Icons.favorite_rounded,
//   //               title: 'my_wishlist'.tr,
//   //               badge: count > 0 ? '$count' : null,
//   //               color: AppColors.secondary,
//   //               onTap: () {
//   //                 Get.back();
//   //                 Get.toNamed(AppRoutes.wishlist);
//   //               },
//   //             );
//   //           }),
//   //
//   //           _buildDrawerItem(
//   //             icon: Icons.shopping_cart_outlined,
//   //             title: 'my_cart'.tr,
//   //             badge: null,
//   //             color: AppColors.secondary,
//   //             onTap: () {
//   //               Get.back();
//   //               Get.toNamed(AppRoutes.cart);
//   //             },
//   //           ),
//   //
//   //           _buildDrawerItem(
//   //             icon: Icons.shopping_bag,
//   //             title: 'order_checkout'.tr,
//   //             badge: null,
//   //             color: AppColors.secondary,
//   //             onTap: () {
//   //               Get.back();
//   //               Get.toNamed(AppRoutes.checkout);
//   //             },
//   //           ),
//   //
//   //           _buildDrawerItem(
//   //             icon: Icons.work_history_outlined,
//   //             title: 'order_history'.tr,
//   //             badge: null,
//   //             color: AppColors.secondary,
//   //             onTap: () {
//   //               Get.back();
//   //               Get.toNamed(AppRoutes.history);
//   //             },
//   //           ),
//   //
//   //           _buildDrawerItem(
//   //             icon: Icons.settings,
//   //             title: 'settings'.tr,
//   //             badge: null,
//   //             color: AppColors.secondary,
//   //             onTap: () {
//   //               Get.back();
//   //               Get.toNamed(AppRoutes.setting);
//   //             },
//   //           ),
//   //
//   //           // const Divider(height: 32, indent: 20, endIndent: 20),
//   //           _buildDrawerItem(
//   //             icon: Icons.info_outline_rounded,
//   //             title: 'about_us'.tr,
//   //             color: AppColors.secondary,
//   //             onTap: () {
//   //               Get.back();
//   //               Get.toNamed(AppRoutes.about);
//   //             },
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
//
//   // Widget _buildDrawer(HomeController controller, BuildContext context) {
//   //   final user = FirebaseAuth.instance.currentUser;
//   //
//   //   // final String name = (user?.displayName?.isNotEmpty ?? false)
//   //   //     ? user!.displayName!
//   //   //     : (user?.email ?? 'Visitor');
//   //   //final String? photo = user?.photoURL;
//   //
//   //   return Drawer(
//   //     backgroundColor: AppColors.cardBackground(context),
//   //     child: SafeArea(
//   //       child: Column(
//   //         crossAxisAlignment: CrossAxisAlignment.start,
//   //         children: [
//   //           // ---------- HEADER (logo + user) ----------
//   //           Padding(
//   //             padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
//   //             child: Column(
//   //               crossAxisAlignment: CrossAxisAlignment.start,
//   //               children: [
//   //                 const SnapKartLogo(size: 28),
//   //                 const SizedBox(height: 20),
//   //                 Row(
//   //                   children: [
//   //                     // Container(
//   //                     //   width: 56,
//   //                     //   height: 56,
//   //                     //   decoration: BoxDecoration(
//   //                     //     shape: BoxShape.circle,
//   //                     //     border: Border.all(
//   //                     //       color: AppColors.secondary,
//   //                     //       width: 1.5,
//   //                     //     ),
//   //                     //   ),
//   //                     //   child: ClipOval(
//   //                     //     child: (photo != null && photo.isNotEmpty)
//   //                     //         ? Image.network(
//   //                     //             photo,
//   //                     //             fit: BoxFit.cover,
//   //                     //             errorBuilder: (_, __, ___) => const Icon(
//   //                     //               Icons.person,
//   //                     //               color: AppColors.secondary,
//   //                     //               size: 28,
//   //                     //             ),
//   //                     //           )
//   //                     //         : const Icon(
//   //                     //             Icons.person,
//   //                     //             color: AppColors.secondary,
//   //                     //             size: 28,
//   //                     //           ),
//   //                     //   ),
//   //                     // ),
//   //                     FutureBuilder<SharedPreferences>(
//   //                       future: SharedPreferences.getInstance(),
//   //                       builder: (context, snap) {
//   //                         final saved =
//   //                             snap.data?.getString(
//   //                               'login_screen_profile_image',
//   //                             ) ??
//   //                             '';
//   //                         final String photo = saved.isNotEmpty
//   //                             ? saved
//   //                             : (user?.photoURL ?? '');
//   //
//   //                         return Container(
//   //                           width: 56,
//   //                           height: 56,
//   //                           decoration: BoxDecoration(
//   //                             shape: BoxShape.circle,
//   //                             border: Border.all(
//   //                               color: AppColors.secondary,
//   //                               width: 1.5,
//   //                             ),
//   //                           ),
//   //                           child: ClipOval(
//   //                             child: photo.isNotEmpty
//   //                                 ? Image.network(
//   //                                     photo,
//   //                                     fit: BoxFit.cover,
//   //                                     errorBuilder: (_, __, ___) => const Icon(
//   //                                       Icons.person,
//   //                                       color: AppColors.secondary,
//   //                                       size: 28,
//   //                                     ),
//   //                                   )
//   //                                 : const Icon(
//   //                                     Icons.person,
//   //                                     color: AppColors.secondary,
//   //                                     size: 28,
//   //                                   ),
//   //                           ),
//   //                         );
//   //                       },
//   //                     ),
//   //
//   //
//   //       Row(
//   //         children: [
//   //           // yahan aap ka photo wala FutureBuilder (jaisa pehle tha)
//   //
//   //           const SizedBox(width: 16),
//   //           Expanded(
//   //             child: Column(
//   //               crossAxisAlignment: CrossAxisAlignment.start,
//   //               mainAxisSize: MainAxisSize.min,
//   //               children: [
//   //                 if (name.isNotEmpty)
//   //                   Text(
//   //                     name,
//   //                     maxLines: 1,
//   //                     overflow: TextOverflow.ellipsis,
//   //                     style: TextStyle(
//   //                       fontSize: 16,
//   //                       fontWeight: FontWeight.w700,
//   //                       color: AppColors.textPrimary(context),
//   //                     ),
//   //                   ),
//   //                 const SizedBox(height: 2),
//   //                 Text(
//   //                   email,
//   //                   maxLines: 1,
//   //                   overflow: TextOverflow.ellipsis,
//   //                   style: TextStyle(
//   //                     fontSize: 12,
//   //                     color: AppColors.textSecondary(context),
//   //                   ),
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //         ],
//   //       ),
//   //
//   //
//   //
//   //
//   //                     const SizedBox(width: 16),
//   //                     // Expanded(
//   //                     //   child: Text(
//   //                     //     name,
//   //                     //     maxLines: 1,
//   //                     //     overflow: TextOverflow.ellipsis,
//   //                     //     style: TextStyle(
//   //                     //       fontSize: 16,
//   //                     //       fontWeight: FontWeight.w600,
//   //                     //       color: AppColors.textPrimary(context),
//   //                     //     ),
//   //                     //   ),
//   //                     // ),
//   //
//   //       final user = FirebaseAuth.instance.currentUser;
//   //
//   //   final String name = (user?.displayName ?? '').trim();
//   //   final String email = user?.email ?? '';
//   //
//   //
//   //                   ],
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //
//   //           const SizedBox(height: 8),
//   //
//   //           // ---------- MENU ITEMS ----------
//   //           Obx(() {
//   //             final count = WishlistController.instance.wishlistCount;
//   //
//   //             return _buildDrawerItem(
//   //               icon: Icons.favorite_rounded,
//   //               title: 'my_wishlist'.tr,
//   //               badge: count > 0 ? '$count' : null,
//   //               color: AppColors.secondary,
//   //               onTap: () {
//   //                 Get.back();
//   //                 Get.toNamed(AppRoutes.wishlist);
//   //               },
//   //             );
//   //           }),
//   //
//   //           _buildDrawerItem(
//   //             icon: Icons.shopping_cart_outlined,
//   //             title: 'my_cart'.tr,
//   //             badge: null,
//   //             color: AppColors.secondary,
//   //             onTap: () {
//   //               Get.back();
//   //               Get.toNamed(AppRoutes.cart);
//   //             },
//   //           ),
//   //
//   //           _buildDrawerItem(
//   //             icon: Icons.shopping_bag,
//   //             title: 'order_checkout'.tr,
//   //             badge: null,
//   //             color: AppColors.secondary,
//   //             onTap: () {
//   //               Get.back();
//   //               Get.toNamed(AppRoutes.checkout);
//   //             },
//   //           ),
//   //
//   //           _buildDrawerItem(
//   //             icon: Icons.work_history_outlined,
//   //             title: 'order_history'.tr,
//   //             badge: null,
//   //             color: AppColors.secondary,
//   //             onTap: () {
//   //               Get.back();
//   //               Get.toNamed(AppRoutes.history);
//   //             },
//   //           ),
//   //
//   //           _buildDrawerItem(
//   //             icon: Icons.settings,
//   //             title: 'settings'.tr,
//   //             badge: null,
//   //             color: AppColors.secondary,
//   //             onTap: () {
//   //               Get.back();
//   //               Get.toNamed(AppRoutes.setting);
//   //             },
//   //           ),
//   //
//   //           _buildDrawerItem(
//   //             icon: Icons.info_outline_rounded,
//   //             title: 'about_us'.tr,
//   //             color: AppColors.secondary,
//   //             onTap: () {
//   //               Get.back();
//   //               Get.toNamed(AppRoutes.about);
//   //             },
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
//
//   Widget _buildDrawer(HomeController controller, BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;
//     final String name = (user?.displayName ?? '').trim();
//     final String email = user?.email ?? '';
//
//     return Drawer(
//       backgroundColor: AppColors.cardBackground(context),
//       child: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // ---------- HEADER (logo + user) ----------
//             Padding(
//               padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SnapKartLogo(size: 28),
//                   const SizedBox(height: 20),
//                   Row(
//                     children: [
//                       FutureBuilder<SharedPreferences>(
//                         future: SharedPreferences.getInstance(),
//                         builder: (context, snap) {
//                           final saved =
//                               snap.data?.getString(
//                                 'login_screen_profile_image',
//                               ) ??
//                               '';
//                           final String photo = saved.isNotEmpty
//                               ? saved
//                               : (user?.photoURL ?? '');
//
//                           return Container(
//                             width: 56,
//                             height: 56,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               border: Border.all(
//                                 color: AppColors.secondary,
//                                 width: 1.5,
//                               ),
//                             ),
//                             child: ClipOval(
//                               child: photo.isNotEmpty
//                                   ? Image.network(
//                                       photo,
//                                       fit: BoxFit.cover,
//                                       errorBuilder: (_, __, ___) => const Icon(
//                                         Icons.person,
//                                         color: AppColors.secondary,
//                                         size: 28,
//                                       ),
//                                     )
//                                   : const Icon(
//                                       Icons.person,
//                                       color: AppColors.secondary,
//                                       size: 28,
//                                     ),
//                             ),
//                           );
//                         },
//                       ),
//                       const SizedBox(width: 16),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             if (name.isNotEmpty)
//                               Text(
//                                 name,
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w700,
//                                   color: AppColors.textPrimary(context),
//                                 ),
//                               ),
//                             const SizedBox(height: 2),
//                             Text(
//                               email,
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: AppColors.textSecondary(context),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 8),
//
//             // ---------- MENU ITEMS ----------
//             Obx(() {
//               final count = WishlistController.instance.wishlistCount;
//
//               return _buildDrawerItem(
//                 icon: Icons.favorite_rounded,
//                 title: 'my_wishlist'.tr,
//                 badge: count > 0 ? '$count' : null,
//                 color: AppColors.secondary,
//                 onTap: () {
//                   Get.back();
//                   Get.toNamed(AppRoutes.wishlist);
//                 },
//               );
//             }),
//
//             _buildDrawerItem(
//               icon: Icons.shopping_cart_outlined,
//               title: 'my_cart'.tr,
//               badge: null,
//               color: AppColors.secondary,
//               onTap: () {
//                 Get.back();
//                 Get.toNamed(AppRoutes.cart);
//               },
//             ),
//
//             _buildDrawerItem(
//               icon: Icons.shopping_bag,
//               title: 'order_checkout'.tr,
//               badge: null,
//               color: AppColors.secondary,
//               onTap: () {
//                 Get.back();
//                 Get.toNamed(AppRoutes.checkout);
//               },
//             ),
//
//             _buildDrawerItem(
//               icon: Icons.work_history_outlined,
//               title: 'order_history'.tr,
//               badge: null,
//               color: AppColors.secondary,
//               onTap: () {
//                 Get.back();
//                 Get.toNamed(AppRoutes.history);
//               },
//             ),
//
//             _buildDrawerItem(
//               icon: Icons.settings,
//               title: 'settings'.tr,
//               badge: null,
//               color: AppColors.secondary,
//               onTap: () {
//                 Get.back();
//                 Get.toNamed(AppRoutes.setting);
//               },
//             ),
//
//             _buildDrawerItem(
//               icon: Icons.info_outline_rounded,
//               title: 'about_us'.tr,
//               color: AppColors.secondary,
//               onTap: () {
//                 Get.back();
//                 Get.toNamed(AppRoutes.about);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDrawerItem({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//     String? badge,
//     Color color = Colors.black87,
//   }) {
//     return ListTile(
//       contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
//       leading: Container(
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: color.withValues(alpha: 0.12),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Icon(icon, color: color, size: 22),
//       ),
//       title: Text(
//         title,
//         style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
//       ),
//       trailing: badge != null
//           ? Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               decoration: BoxDecoration(
//                 color: color,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Text(
//                 badge,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             )
//           : null,
//       onTap: onTap,
//     );
//   }
//
//   // ============================================================
//   // APP BAR
//   // ============================================================
//
//   PreferredSizeWidget _buildAppBar(
//     HomeController controller,
//     BuildContext context,
//   ) {
//     return AppBar(
//       elevation: 0,
//       scrolledUnderElevation: 0,
//       surfaceTintColor: Colors.transparent,
//       backgroundColor: AppColors.background(context),
//       foregroundColor: AppColors.textPrimary(context),
//       title: const SnapKartLogo(size: 26),
//       actions: [
//         // IconButton(
//         //   icon: Icon(Icons.search, color: AppColors.textPrimary(context)),
//         //   onPressed: () => _showSearchDialog(controller),
//         // ),
//         Padding(
//           padding: const EdgeInsets.only(right: 8),
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               IconButton(
//                 icon: Icon(
//                   Icons.shopping_cart_outlined,
//                   color: AppColors.textPrimary(context),
//                 ),
//                 onPressed: () {
//                   Get.toNamed(AppRoutes.cart);
//                 },
//               ),
//
//               Positioned(
//                 right: 4,
//                 top: 8,
//                 child: Obx(() {
//                   CartController.instance.cartItems.value;
//
//                   final count = CartController.instance.cartItemCount;
//
//                   if (count == 0) {
//                     return const SizedBox.shrink();
//                   }
//
//                   return Container(
//                     padding: const EdgeInsets.all(4),
//                     decoration: const BoxDecoration(
//                       color: AppColors.secondary,
//                       shape: BoxShape.circle,
//                     ),
//                     constraints: const BoxConstraints(
//                       minWidth: 18,
//                       minHeight: 18,
//                     ),
//                     child: Text(
//                       '$count',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 10,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   );
//                 }),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   // ============================================================
//   // SEARCH BAR
//   // ============================================================
//
//   // Widget _buildSearchBar(HomeController controller, BuildContext context) {
//   //   return Padding(
//   //     padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
//   //     child: GestureDetector(
//   //       onTap: () => _showSearchDialog(controller),
//   //       child: Container(
//   //         height: 50,
//   //         padding: const EdgeInsets.symmetric(horizontal: 16),
//   //         decoration: BoxDecoration(
//   //           color: AppColors.cardBackground(context),
//   //           borderRadius: BorderRadius.circular(16),
//   //           boxShadow: [
//   //             BoxShadow(
//   //               color: Colors.black.withValues(alpha: 0.05),
//   //               blurRadius: 12,
//   //               offset: const Offset(0, 4),
//   //             ),
//   //           ],
//   //         ),
//   //         child: Row(
//   //           children: [
//   //             Icon(Icons.search, color: AppColors.textSecondary(context)),
//   //             const SizedBox(width: 12),
//   //             Expanded(
//   //               child: Text(
//   //                 'type_product_name'.tr,
//   //                 maxLines: 1,
//   //                 overflow: TextOverflow.ellipsis,
//   //                 style: TextStyle(
//   //                   fontSize: 14,
//   //                   color: AppColors.textSecondary(context),
//   //                 ),
//   //               ),
//   //             ),
//   //             Icon(Icons.tune_rounded, color: AppColors.textSecondary(context)),
//   //           ],
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }
//
//   // Widget _buildSearchBar(HomeController controller, BuildContext context) {
//   //   return Padding(
//   //     padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
//   //     child: Container(
//   //       height: 50,
//   //       padding: const EdgeInsets.symmetric(horizontal: 16),
//   //       decoration: BoxDecoration(
//   //         color: AppColors.cardBackground(context),
//   //         borderRadius: BorderRadius.circular(16),
//   //         boxShadow: [
//   //           BoxShadow(
//   //             color: Colors.black.withValues(alpha: 0.05),
//   //             blurRadius: 12,
//   //             offset: const Offset(0, 4),
//   //           ),
//   //         ],
//   //       ),
//   //       child: Row(
//   //         children: [
//   //           Icon(Icons.search, color: AppColors.textSecondary(context)),
//   //           const SizedBox(width: 12),
//   //           Expanded(
//   //             child: TextField(
//   //               textInputAction: TextInputAction.search,
//   //               style: TextStyle(
//   //                 fontSize: 14,
//   //                 color: AppColors.textPrimary(context),
//   //               ),
//   //               decoration: InputDecoration(
//   //                 hintText: 'type_product_name'.tr,
//   //                 hintStyle: TextStyle(
//   //                   fontSize: 14,
//   //                   color: AppColors.textSecondary(context),
//   //                 ),
//   //                 border: InputBorder.none,
//   //                 enabledBorder: InputBorder.none,
//   //                 focusedBorder: InputBorder.none,
//   //                 filled: false,
//   //                 isDense: true,
//   //               ),
//   //               onSubmitted: (value) {
//   //                 if (value.trim().isEmpty) return;
//   //                 Get.toNamed(AppRoutes.searchresult, arguments: value.trim());
//   //               },
//   //             ),
//   //           ),
//   //           Icon(Icons.tune_rounded, color: AppColors.textSecondary(context)),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
//
//   Widget _buildSearchBar(HomeController controller, BuildContext context) {
//     return const _SearchBarField();
//   }
//
//   // ============================================================
//   // PROMO BANNER
//   // ============================================================
//
//   Widget _buildPromoBanner(HomeController controller, BuildContext context) {
//     return Obx(() {
//       if (controller.isBannersLoading.value) {
//         return Padding(
//           padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
//           child: SizedBox(
//             height: 185,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(24),
//               child: WaveSkeletonBox(borderRadius: BorderRadius.circular(24)),
//             ),
//           ),
//         );
//       }
//
//       if (controller.banners.isEmpty) {
//         return const SizedBox.shrink();
//       }
//
//       return Padding(
//         padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
//         child: Column(
//           children: [
//             CarouselSlider(
//               options: CarouselOptions(
//                 height: 185,
//                 autoPlay: true,
//                 autoPlayInterval: const Duration(seconds: 4),
//                 autoPlayAnimationDuration: const Duration(milliseconds: 700),
//                 enlargeCenterPage: true,
//                 enlargeFactor: 0.08,
//                 viewportFraction: 0.92,
//                 enableInfiniteScroll: controller.banners.length > 1,
//                 onPageChanged: (index, reason) {
//                   controller.bannerIndex.value = index;
//                 },
//               ),
//               items: controller.banners.map((banner) {
//                 return GestureDetector(
//                   onTap: () => controller.handleBannerTap(banner),
//                   child: Container(
//                     width: double.infinity,
//                     margin: const EdgeInsets.symmetric(horizontal: 3),
//                     clipBehavior: Clip.antiAlias,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(24),
//                       boxShadow: [
//                         BoxShadow(
//                           color: AppColors.primaryDark.withValues(alpha: 0.25),
//                           blurRadius: 12,
//                           offset: const Offset(0, 5),
//                         ),
//                       ],
//                     ),
//                     child: Stack(
//                       fit: StackFit.expand,
//                       children: [
//                         // BACKGROUND IMAGE
//                         Image.network(
//                           banner.imageUrl ?? '',
//                           fit: BoxFit.cover,
//                           errorBuilder: (_, __, ___) => Container(
//                             decoration: const BoxDecoration(
//                               gradient: LinearGradient(
//                                 begin: Alignment.topLeft,
//                                 end: Alignment.bottomRight,
//                                 colors: AppColors.primaryGradient,
//                               ),
//                             ),
//                           ),
//                           loadingBuilder: (context, child, loadingProgress) {
//                             if (loadingProgress == null) {
//                               return child;
//                             }
//
//                             return Container(
//                               decoration: const BoxDecoration(
//                                 gradient: LinearGradient(
//                                   begin: Alignment.topLeft,
//                                   end: Alignment.bottomRight,
//                                   colors: AppColors.primaryGradient,
//                                 ),
//                               ),
//                               child: const Center(
//                                 child: CircularProgressIndicator(
//                                   color: Colors.white,
//                                   strokeWidth: 2,
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//
//                         // TEAL OVERLAY
//                         Container(
//                           decoration: const BoxDecoration(
//                             gradient: LinearGradient(
//                               begin: Alignment.centerLeft,
//                               end: Alignment.centerRight,
//                               colors: [
//                                 Color(0xE60B4F4D),
//                                 Color(0x990B4F4D),
//                                 Color(0x100B4F4D),
//                               ],
//                               stops: [0.0, 0.5, 1.0],
//                             ),
//                           ),
//                         ),
//
//                         // TITLE + SHOP NOW
//                         Positioned(
//                           left: 18,
//                           top: 15,
//                           bottom: 15,
//                           right: 120,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 banner.title?.isNotEmpty == true
//                                     ? banner.title!
//                                     : 'MEGA SALE',
//                                 maxLines: 3,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.w900,
//                                   height: 1.1,
//                                 ),
//                               ),
//                               const SizedBox(height: 14),
//                               Container(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 14,
//                                   vertical: 9,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   gradient: const LinearGradient(
//                                     colors: AppColors.secondaryGradient,
//                                   ),
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 child: const Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Text(
//                                       'Shop Now',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w800,
//                                       ),
//                                     ),
//                                     SizedBox(width: 4),
//                                     Icon(
//                                       Icons.arrow_forward,
//                                       color: Colors.white,
//                                       size: 14,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//
//                         // ORANGE DISCOUNT CIRCLE
//                         if ((banner.discountText ?? '').isNotEmpty)
//                           Positioned(
//                             right: 14,
//                             top: 14,
//                             child: Container(
//                               width: 78,
//                               height: 78,
//                               padding: const EdgeInsets.all(8),
//                               decoration: const BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 gradient: LinearGradient(
//                                   begin: Alignment.topLeft,
//                                   end: Alignment.bottomRight,
//                                   colors: AppColors.secondaryGradient,
//                                 ),
//                               ),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const Text(
//                                     'UP TO',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 8,
//                                       fontWeight: FontWeight.bold,
//                                       letterSpacing: 1,
//                                     ),
//                                   ),
//                                   FittedBox(
//                                     fit: BoxFit.scaleDown,
//                                     child: Text(
//                                       banner.discountText!,
//                                       textAlign: TextAlign.center,
//                                       style: const TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.w900,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//
//             // DOTS INDICATOR
//             if (controller.banners.length > 1) ...[
//               const SizedBox(height: 8),
//               Obx(
//                 () => Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: List.generate(controller.banners.length, (index) {
//                     final selected = controller.bannerIndex.value == index;
//
//                     return AnimatedContainer(
//                       duration: const Duration(milliseconds: 200),
//                       margin: const EdgeInsets.symmetric(horizontal: 3),
//                       height: 7,
//                       width: selected ? 20 : 7,
//                       decoration: BoxDecoration(
//                         color: selected
//                             ? AppColors.secondary
//                             : Colors.grey.shade400,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     );
//                   }),
//                 ),
//               ),
//             ],
//           ],
//         ),
//       );
//     });
//   }
//
//   // ============================================================
//   // CATEGORY CHIPS
//   // ============================================================
//
//   Widget _buildCategoryChips(HomeController controller, BuildContext context) {
//     return Obx(
//       () => Container(
//         height: 62,
//         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: controller.categories.length,
//           itemBuilder: (context, index) {
//             final category = controller.categories[index];
//             final count = controller.categoryCounts[category] ?? 0;
//
//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 4),
//               child: Obx(() {
//                 final isSelected =
//                     controller.selectedCategory.value == category;
//
//                 return _buildCategoryChip(
//                   context: context,
//                   category: category,
//                   count: count,
//                   isSelected: isSelected,
//                   onTap: () => controller.filterByCategory(category),
//                   icon: controller.getCategoryIcon(category),
//                 );
//               }),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCategoryChip({
//     required BuildContext context,
//     required String category,
//     required int count,
//     required bool isSelected,
//     required VoidCallback onTap,
//     required IconData icon,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         decoration: BoxDecoration(
//           gradient: isSelected
//               ? const LinearGradient(colors: AppColors.secondaryGradient)
//               : null,
//           color: isSelected ? null : AppColors.cardBackground(context),
//           borderRadius: BorderRadius.circular(30),
//           border: Border.all(
//             color: isSelected ? Colors.transparent : Colors.grey.shade300,
//             width: 1.2,
//           ),
//           boxShadow: isSelected
//               ? [
//                   BoxShadow(
//                     color: AppColors.secondary.withValues(alpha: 0.3),
//                     blurRadius: 10,
//                     offset: const Offset(0, 4),
//                   ),
//                 ]
//               : null,
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(
//               icon,
//               size: 18,
//               color: isSelected ? Colors.white : AppColors.secondary,
//             ),
//             const SizedBox(width: 6),
//             Text(
//               category,
//               style: TextStyle(
//                 fontSize: 13,
//                 fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
//                 color: isSelected
//                     ? Colors.white
//                     : AppColors.textPrimary(context),
//               ),
//             ),
//             const SizedBox(width: 6),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//               decoration: BoxDecoration(
//                 color: isSelected
//                     ? Colors.white.withValues(alpha: 0.25)
//                     : AppColors.orangeSoft(context),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Text(
//                 '$count',
//                 style: TextStyle(
//                   fontSize: 10,
//                   fontWeight: FontWeight.bold,
//                   color: isSelected ? Colors.white : AppColors.secondary,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ============================================================
//   // RECENTLY VIEWED
//   // ============================================================
//
//   Widget _buildRecentlyViewed(BuildContext context) {
//     return Obx(() {
//       final items = RecentlyViewedController.instance.recentItems;
//
//       if (items.isEmpty) {
//         return const SizedBox();
//       }
//
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
//             child: Text(
//               'Recently Viewed'.tr,
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w800,
//                 color: AppColors.textPrimary(context),
//               ),
//             ),
//           ),
//
//           SizedBox(
//             height: 82,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               itemCount: items.length,
//               itemBuilder: (context, index) {
//                 final item = items[index];
//
//                 return GestureDetector(
//                   onTap: () async {
//                     final doc = await FirebaseFirestore.instance
//                         .collection('products')
//                         .doc(item['id'])
//                         .get();
//
//                     if (doc.exists) {
//                       final product = ModelClass.fromFirestore(doc);
//                       Get.toNamed(AppRoutes.productdetail, arguments: product);
//                     }
//                   },
//                   child: Container(
//                     width: 74,
//                     margin: const EdgeInsets.only(right: 10),
//                     decoration: BoxDecoration(
//                       color: AppColors.cardBackground(context),
//                       borderRadius: BorderRadius.circular(14),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withValues(alpha: 0.06),
//                           blurRadius: 8,
//                           offset: const Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // ClipRRect(
//                         //   borderRadius: const BorderRadius.vertical(
//                         //     top: Radius.circular(14),
//                         //   ),
//                         //   child: Container(
//                         //     color: Colors.white,
//                         //     child: Image.network(
//                         //       item['image'] ?? '',
//                         //       height: 58,
//                         //       width: 74,
//                         //       fit: BoxFit.contain,
//                         //       errorBuilder: (_, __, ___) => Container(
//                         //         height: 58,
//                         //         width: 74,
//                         //         color: Colors.grey.shade100,
//                         //         child: const Icon(
//                         //           Icons.image_not_supported,
//                         //           color: Colors.grey,
//                         //           size: 16,
//                         //         ),
//                         //       ),
//                         //     ),
//                         //   ),
//                         // ),
//                         ClipRRect(
//                           borderRadius: const BorderRadius.vertical(
//                             top: Radius.circular(14),
//                           ),
//                           child: Container(
//                             height: 58,
//                             width: 74,
//                             color: Colors.white,
//                             padding: const EdgeInsets.all(6),
//                             alignment: Alignment.center,
//                             child: Image.network(
//                               item['image'] ?? '',
//                               fit: BoxFit.contain,
//                               errorBuilder: (_, __, ___) => const Icon(
//                                 Icons.image_not_supported,
//                                 color: Colors.grey,
//                                 size: 16,
//                               ),
//                             ),
//                           ),
//                         ),
//
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 5,
//                             vertical: 4,
//                           ),
//                           child: Text(
//                             item['title'] ?? '',
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                               fontSize: 9,
//                               color: AppColors.textPrimary(context),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       );
//     });
//   }
//
//   // ============================================================
//   // SEARCH DIALOG
//   // ============================================================
//
//   void _showSearchDialog(HomeController controller) {
//     Get.dialog(
//       Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 'Search Products',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 16),
//               TextField(
//                 autofocus: true,
//                 onSubmitted: (value) {
//                   if (value.trim().isEmpty) {
//                     return;
//                   }
//
//                   Get.back();
//                   Get.toNamed(AppRoutes.searchresult, arguments: value.trim());
//                 },
//                 decoration: InputDecoration(
//                   hintText: 'type_product_name'.tr,
//                   prefixIcon: const Icon(Icons.search),
//                 ),
//               ),
//               const SizedBox(height: 12),
//               TextButton(onPressed: () => Get.back(), child: Text('cancel'.tr)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // ============================================================
//   // ERROR STATE
//   // ============================================================
//
//   Widget _buildErrorState(HomeController controller, BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.error_outline, color: Colors.red.shade300, size: 64),
//             const SizedBox(height: 16),
//             Text(
//               'something_wrong'.tr,
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.textPrimary(context),
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               controller.errorMessage.value.isNotEmpty
//                   ? controller.errorMessage.value
//                   : 'unable_load_products'.tr,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: AppColors.textSecondary(context),
//               ),
//             ),
//             const SizedBox(height: 24),
//             ElevatedButton.icon(
//               onPressed: controller.refreshProducts,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.secondary,
//                 foregroundColor: Colors.white,
//                 minimumSize: const Size(0, 48),
//                 padding: const EdgeInsets.symmetric(horizontal: 24),
//               ),
//               icon: const Icon(Icons.refresh),
//               label: Text('try_again'.tr),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ============================================================
//   // EMPTY STATE
//   // ============================================================
//
//   Widget _buildEmptyState(HomeController controller, BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.shopping_bag_outlined,
//             size: 64,
//             color: Colors.grey.shade300,
//           ),
//           const SizedBox(height: 16),
//           Text(
//             'no_products_found'.tr,
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//               color: AppColors.textPrimary(context),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'try_different_category'.tr,
//             style: TextStyle(
//               fontSize: 14,
//               color: AppColors.textSecondary(context),
//             ),
//           ),
//           const SizedBox(height: 16),
//           ElevatedButton.icon(
//             onPressed: controller.refreshProducts,
//             icon: const Icon(Icons.refresh),
//             label: Text('refresh'.tr),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColors.secondary,
//               foregroundColor: Colors.white,
//               minimumSize: const Size(0, 48),
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ============================================================
//   // PRODUCT GRID
//   // ============================================================
//
//   Widget _buildProductSliverGrid(
//     HomeController controller,
//     BuildContext context,
//   ) {
//     return SliverPadding(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       sliver: SliverGrid(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 12,
//           mainAxisSpacing: 12,
//           childAspectRatio: 0.68,
//         ),
//         delegate: SliverChildBuilderDelegate((context, index) {
//           final product = controller.filteredProductList[index];
//
//           return _buildProductCard(product, controller, context);
//         }, childCount: controller.filteredProductList.length),
//       ),
//     );
//   }
//
//   // ============================================================
//   // SKELETON
//   // ============================================================
//
//   Widget _buildSkeletonSliverGrid(BuildContext context) {
//     return SliverPadding(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       sliver: SliverGrid(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 12,
//           mainAxisSpacing: 12,
//           childAspectRatio: 0.68,
//         ),
//         delegate: SliverChildBuilderDelegate(
//           (context, index) => _skeletonProductCard(context),
//           childCount: 6,
//         ),
//       ),
//     );
//   }
//
//   Widget _skeletonProductCard(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.cardBackground(context),
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.05),
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Expanded(
//             child: WaveSkeletonBox(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(16),
//                 topRight: Radius.circular(16),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 WaveSkeletonBox(
//                   width: double.infinity,
//                   height: 12,
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//                 const SizedBox(height: 6),
//                 const SizedBox(
//                   width: 80,
//                   child: WaveSkeletonBox(
//                     height: 12,
//                     borderRadius: BorderRadius.all(Radius.circular(4)),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 const SizedBox(
//                   width: 60,
//                   child: WaveSkeletonBox(
//                     height: 16,
//                     borderRadius: BorderRadius.all(Radius.circular(4)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ============================================================
//   // PRODUCT CARD
//   // ============================================================
//
//   Widget _buildProductCard(
//     ModelClass product,
//     HomeController controller,
//     BuildContext context,
//   ) {
//     final double oldPrice = product.price ?? 0;
//     final double salePrice = product.discountPrice ?? 0;
//     final int stock = product.stock ?? 0;
//
//     final bool hasDiscount =
//         salePrice > 0 && oldPrice > 0 && salePrice < oldPrice;
//
//     final int discountPercent = hasDiscount
//         ? (((oldPrice - salePrice) / oldPrice) * 100).round()
//         : 0;
//
//     return GestureDetector(
//       onTap: () {
//         controller.goToProductDetail(product);
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: AppColors.cardBackground(context),
//           borderRadius: BorderRadius.circular(18),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withValues(alpha: 0.07),
//               blurRadius: 12,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // IMAGE SECTION
//             Expanded(
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.vertical(
//                   top: Radius.circular(18),
//                 ),
//                 child: Stack(
//                   children: [
//                     Positioned.fill(
//                       child: Container(
//                         color: Colors.white,
//                         padding: const EdgeInsets.only(top: 22, bottom: 14),
//                         child: _ProductImageCarousel(
//                           images: product.images.isNotEmpty
//                               ? product.images
//                               : (product.image != null &&
//                                         product.image!.isNotEmpty
//                                     ? [product.image!]
//                                     : []),
//                         ),
//                       ),
//                     ),
//
//                     // TOP LEFT DISCOUNT (teal)
//                     if (hasDiscount)
//                       Positioned(
//                         left: 8,
//                         top: 8,
//                         child: DiscountBadge('-$discountPercent%'),
//                       ),
//
//                     // TOP RIGHT STOCK
//                     if (stock > 0 && stock <= 10)
//                       Positioned(
//                         right: 8,
//                         top: 8,
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 7,
//                             vertical: 4,
//                           ),
//                           decoration: BoxDecoration(
//                             color: AppColors.secondary,
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Text(
//                             'Only $stock left',
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 9,
//                               fontWeight: FontWeight.w800,
//                             ),
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//
//             // PRODUCT INFORMATION
//             Padding(
//               padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     product.title ?? 'Product',
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontSize: 11,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.textPrimary(context),
//                       height: 1.25,
//                     ),
//                   ),
//
//                   const SizedBox(height: 5),
//
//                   // RATING
//                   Row(
//                     children: [
//                       const Icon(Icons.star, size: 14, color: Colors.amber),
//                       const SizedBox(width: 3),
//                       Text(
//                         product.rating?.rate?.toStringAsFixed(1) ?? '0.0',
//                         style: TextStyle(
//                           fontSize: 11,
//                           color: AppColors.textSecondary(context),
//                         ),
//                       ),
//                       const SizedBox(width: 3),
//                       Text(
//                         '(${product.rating?.count ?? 0})',
//                         style: TextStyle(
//                           fontSize: 10,
//                           color: Colors.grey.shade500,
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 6),
//
//                   // PRICE + CART BUTTON
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Expanded(
//                         child: ValueListenableBuilder<String>(
//                           valueListenable: CurrencyService.instance.symbol,
//                           builder: (context, currency, _) {
//                             final shownPrice = hasDiscount
//                                 ? salePrice
//                                 : oldPrice;
//
//                             return Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 FittedBox(
//                                   fit: BoxFit.scaleDown,
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     '$currency ${shownPrice.toStringAsFixed(0)}',
//                                     style: const TextStyle(
//                                       color: AppColors.secondary,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w900,
//                                     ),
//                                   ),
//                                 ),
//                                 if (hasDiscount)
//                                   Text(
//                                     '$currency ${oldPrice.toStringAsFixed(0)}',
//                                     style: TextStyle(
//                                       color: Colors.grey.shade500,
//                                       fontSize: 10,
//                                       decoration: TextDecoration.lineThrough,
//                                     ),
//                                   ),
//                               ],
//                             );
//                           },
//                         ),
//                       ),
//
//                       const SizedBox(width: 6),
//
//                       _buildCartButton(product, hasDiscount),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ORANGE CART BUTTON (card ke neeche right side)
//   Widget _buildCartButton(ModelClass product, bool hasDiscount) {
//     return GestureDetector(
//       onTap: () {
//         CartController.instance.addToCart({
//           'productId': product.id,
//           'title': product.title,
//           'price': hasDiscount ? product.discountPrice : product.price,
//           'quantity': 1,
//           'image': product.image,
//         });
//
//         Get.snackbar(
//           '🛒 ${'added_exclaim'.tr}',
//           'added_to_cart'.trParams({'product': product.title ?? ''}),
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: AppColors.success.withValues(alpha: 0.15),
//           colorText: AppColors.primaryDark,
//           duration: const Duration(seconds: 1),
//           margin: const EdgeInsets.all(16),
//           borderRadius: 12,
//         );
//       },
//       child: Container(
//         width: 36,
//         height: 36,
//         decoration: BoxDecoration(
//           color: AppColors.secondary,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: AppColors.secondary.withValues(alpha: 0.3),
//               blurRadius: 8,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: const Icon(
//           Icons.shopping_cart_outlined,
//           size: 18,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }
//
// // ============================================================
// // STICKY CATEGORY HEADER
// // ============================================================
//
// class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
//   final Widget child;
//   final double height;
//   final Color backgroundColor;
//
//   _StickyHeaderDelegate({
//     required this.child,
//     required this.height,
//     required this.backgroundColor,
//   });
//
//   @override
//   double get minExtent => height;
//
//   @override
//   double get maxExtent => height;
//
//   @override
//   Widget build(
//     BuildContext context,
//     double shrinkOffset,
//     bool overlapsContent,
//   ) {
//     return Container(color: backgroundColor, child: child);
//   }
//
//   @override
//   bool shouldRebuild(covariant _StickyHeaderDelegate oldDelegate) {
//     return oldDelegate.child != child ||
//         oldDelegate.height != height ||
//         oldDelegate.backgroundColor != backgroundColor;
//   }
// }
//
// // ============================================================
// // PRODUCT CARD IMAGE CAROUSEL (multi image + dots)
// // ============================================================
//
// class _ProductImageCarousel extends StatefulWidget {
//   final List<String> images;
//
//   const _ProductImageCarousel({required this.images});
//
//   @override
//   State<_ProductImageCarousel> createState() => _ProductImageCarouselState();
// }
//
// // class _ProductImageCarouselState extends State<_ProductImageCarousel> {
// //   int _currentIndex = 0;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     if (widget.images.isEmpty) {
// //       return Center(
// //         child: Icon(
// //           Icons.image_not_supported_outlined,
// //           size: 45,
// //           color: Colors.grey.shade300,
// //         ),
// //       );
// //     }
// //
// //     return Stack(
// //       children: [
// //         PageView.builder(
// //           itemCount: widget.images.length,
// //           onPageChanged: (index) {
// //             setState(() => _currentIndex = index);
// //           },
// //           itemBuilder: (context, index) {
// //             return Image.network(
// //               widget.images[index],
// //               fit: BoxFit.contain,
// //               errorBuilder: (context, error, stackTrace) {
// //                 return Center(
// //                   child: Icon(
// //                     Icons.image_not_supported_outlined,
// //                     size: 45,
// //                     color: Colors.grey.shade300,
// //                   ),
// //                 );
// //               },
// //               loadingBuilder: (context, child, loadingProgress) {
// //                 if (loadingProgress == null) return child;
// //                 return const Center(
// //                   child: CircularProgressIndicator(
// //                     strokeWidth: 2,
// //                     color: AppColors.secondary,
// //                   ),
// //                 );
// //               },
// //             );
// //           },
// //         ),
// //
// //         // DOTS (sirf tab jab 1 se zyada image ho)
// //         if (widget.images.length > 1)
// //           Positioned(
// //             bottom: 6,
// //             left: 0,
// //             right: 0,
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: List.generate(widget.images.length, (index) {
// //                 final selected = _currentIndex == index;
// //
// //                 return AnimatedContainer(
// //                   duration: const Duration(milliseconds: 200),
// //                   margin: const EdgeInsets.symmetric(horizontal: 2),
// //                   height: 5,
// //                   width: selected ? 14 : 5,
// //                   decoration: BoxDecoration(
// //                     color: selected
// //                         ? AppColors.secondary
// //                         : Colors.grey.withValues(alpha: 0.5),
// //                     borderRadius: BorderRadius.circular(20),
// //                   ),
// //                 );
// //               }),
// //             ),
// //           ),
// //       ],
// //     );
// //   }
// // }
//
// class _ProductImageCarouselState extends State<_ProductImageCarousel> {
//   int _currentIndex = 0;
//
//   Widget _placeholder(IconData icon, String label) {
//     return Center(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 40, color: Colors.grey.shade300),
//           const SizedBox(height: 4),
//           Text(
//             label,
//             style: TextStyle(fontSize: 10, color: Colors.grey.shade400),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (widget.images.isEmpty) {
//       return _placeholder(Icons.hide_image_outlined, 'No image link');
//     }
//
//     return Stack(
//       children: [
//         PageView.builder(
//           itemCount: widget.images.length,
//           onPageChanged: (index) {
//             setState(() => _currentIndex = index);
//           },
//           itemBuilder: (context, index) {
//             return Image.network(
//               widget.images[index],
//               fit: BoxFit.contain,
//               errorBuilder: (context, error, stackTrace) {
//                 debugPrint('IMAGE ERROR: ${widget.images[index]} -> $error');
//                 return _placeholder(
//                   Icons.broken_image_outlined,
//                   'Failed to load',
//                 );
//               },
//               loadingBuilder: (context, child, loadingProgress) {
//                 if (loadingProgress == null) return child;
//                 return const Center(
//                   child: CircularProgressIndicator(
//                     strokeWidth: 2,
//                     color: AppColors.secondary,
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//
//         // DOTS (sirf tab jab 1 se zyada image ho)
//         if (widget.images.length > 1)
//           Positioned(
//             bottom: 6,
//             left: 0,
//             right: 0,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(widget.images.length, (index) {
//                 final selected = _currentIndex == index;
//
//                 return AnimatedContainer(
//                   duration: const Duration(milliseconds: 200),
//                   margin: const EdgeInsets.symmetric(horizontal: 2),
//                   height: 5,
//                   width: selected ? 14 : 5,
//                   decoration: BoxDecoration(
//                     color: selected
//                         ? AppColors.secondary
//                         : Colors.grey.withValues(alpha: 0.5),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 );
//               }),
//             ),
//           ),
//       ],
//     );
//   }
// }
//
// // this is cross function widget
// class _SearchBarField extends StatefulWidget {
//   const _SearchBarField();
//
//   @override
//   State<_SearchBarField> createState() => _SearchBarFieldState();
// }
//
// class _SearchBarFieldState extends State<_SearchBarField> {
//   final TextEditingController _textController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _textController.addListener(() => setState(() {}));
//   }
//
//   @override
//   void dispose() {
//     _textController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final hasText = _textController.text.isNotEmpty;
//
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
//       child: Container(
//         height: 50,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         decoration: BoxDecoration(
//           color: AppColors.cardBackground(context),
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withValues(alpha: 0.05),
//               blurRadius: 12,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Icon(Icons.search, color: AppColors.textSecondary(context)),
//             const SizedBox(width: 12),
//             Expanded(
//               child: TextField(
//                 controller: _textController,
//                 textInputAction: TextInputAction.search,
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: AppColors.textPrimary(context),
//                 ),
//                 decoration: InputDecoration(
//                   hintText: 'type_product_name'.tr,
//                   hintStyle: TextStyle(
//                     fontSize: 14,
//                     color: AppColors.textSecondary(context),
//                   ),
//                   border: InputBorder.none,
//                   enabledBorder: InputBorder.none,
//                   focusedBorder: InputBorder.none,
//                   filled: false,
//                   isDense: true,
//                 ),
//                 onSubmitted: (value) {
//                   if (value.trim().isEmpty) return;
//                   Get.toNamed(AppRoutes.searchresult, arguments: value.trim());
//                 },
//               ),
//             ),
//
//             // if (hasText)
//             //   GestureDetector(
//             //     onTap: () => _textController.clear(),
//             //     child: Icon(
//             //       Icons.close_rounded,
//             //       color: AppColors.textSecondary(context),
//             //     ),
//             //   )
//             if (hasText)
//               GestureDetector(
//                 onTap: () => _textController.clear(),
//                 child: Icon(
//                   Icons.close_rounded,
//                   color: AppColors.textSecondary(context),
//                 ),
//               ),
//
//             // else
//             //   Icon(Icons.tune_rounded, color: AppColors.textSecondary(context)),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snapkart/App_Routes/routes_view.dart';

import '../../Utilities_Screens/App_Colors/app_colors.dart';
import '../../Utilities_Screens/App_Colors/app_widgets.dart';
import '../../Utilities_Screens/App_Model/app_model.dart';
import '../../Utilities_Screens/Currency_Service/currency_service.dart';
import '../../Utilities_Screens/Wave_Skelton_Box/wave_skelton_box.dart';
import '../Cart_Screen/cart_controller.dart';
import '../Recently_Viewed/recently_view_controller.dart';
import '../Wishlist_Screen/wishlist_controller.dart';
import 'home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: AppColors.background(context),
      drawer: _buildDrawer(controller, context),
      appBar: _buildAppBar(controller, context),
      body: RefreshIndicator(
        onRefresh: controller.refreshProducts,
        color: AppColors.secondary,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildSearchBar(controller, context)),
            SliverToBoxAdapter(child: _buildPromoBanner(controller, context)),

            // NAYA: "Men's Clothing" jaisa category header banner
            SliverToBoxAdapter(
              child: CategoryHeaderBanner(controller: controller),
            ),

            // NAYA: vertical category card chips (sticky)
            SliverPersistentHeader(
              pinned: true,
              delegate: _StickyHeaderDelegate(
                height: 100, // pehle 60 thi
                backgroundColor: AppColors.background(context),
                child: CategoryCardChips(controller: controller),
              ),
            ),

            // NAYA: Sort by + Filter
            SliverToBoxAdapter(child: SortFilterBar(controller: controller)),

            SliverToBoxAdapter(child: _buildRecentlyViewed(context)),

            Obx(() {
              if (controller.isLoading.value) {
                return _buildSkeletonSliverGrid(context);
              }

              if (controller.isError.value) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: _buildErrorState(controller, context),
                );
              }

              if (controller.filteredProductList.isEmpty) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: _buildEmptyState(controller, context),
                );
              }

              return _buildProductSliverGrid(controller, context);
            }),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // DRAWER
  // ============================================================

  Widget _buildDrawer(HomeController controller, BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final String name = (user?.displayName ?? '').trim();
    final String email = user?.email ?? '';

    return Drawer(
      backgroundColor: AppColors.cardBackground(context),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- HEADER (logo + user) ----------
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SnapKartLogo(size: 28),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      FutureBuilder<SharedPreferences>(
                        future: SharedPreferences.getInstance(),
                        builder: (context, snap) {
                          final saved =
                              snap.data?.getString(
                                'login_screen_profile_image',
                              ) ??
                              '';
                          final String photo = saved.isNotEmpty
                              ? saved
                              : (user?.photoURL ?? '');

                          return Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.secondary,
                                width: 1.5,
                              ),
                            ),
                            child: ClipOval(
                              child: photo.isNotEmpty
                                  ? Image.network(
                                      photo,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => const Icon(
                                        Icons.person,
                                        color: AppColors.secondary,
                                        size: 28,
                                      ),
                                    )
                                  : const Icon(
                                      Icons.person,
                                      color: AppColors.secondary,
                                      size: 28,
                                    ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (name.isNotEmpty)
                              Text(
                                name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary(context),
                                ),
                              ),
                            const SizedBox(height: 2),
                            Text(
                              email,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // ---------- MENU ITEMS ----------
            Obx(() {
              final count = WishlistController.instance.wishlistCount;

              return _buildDrawerItem(
                icon: Icons.favorite_rounded,
                title: 'my_wishlist'.tr,
                badge: count > 0 ? '$count' : null,
                color: AppColors.secondary,
                onTap: () {
                  Get.back();
                  Get.toNamed(AppRoutes.wishlist);
                },
              );
            }),

            _buildDrawerItem(
              icon: Icons.shopping_cart_outlined,
              title: 'my_cart'.tr,
              badge: null,
              color: AppColors.secondary,
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.cart);
              },
            ),

            _buildDrawerItem(
              icon: Icons.shopping_bag,
              title: 'order_checkout'.tr,
              badge: null,
              color: AppColors.secondary,
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.checkout);
              },
            ),

            _buildDrawerItem(
              icon: Icons.work_history_outlined,
              title: 'order_history'.tr,
              badge: null,
              color: AppColors.secondary,
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.history);
              },
            ),

            _buildDrawerItem(
              icon: Icons.settings,
              title: 'settings'.tr,
              badge: null,
              color: AppColors.secondary,
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.setting);
              },
            ),

            _buildDrawerItem(
              icon: Icons.info_outline_rounded,
              title: 'about_us'.tr,
              color: AppColors.secondary,
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.about);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    String? badge,
    Color color = Colors.black87,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color, size: 22),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
      trailing: badge != null
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                badge,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
      onTap: onTap,
    );
  }

  // ============================================================
  // APP BAR
  // ============================================================

  PreferredSizeWidget _buildAppBar(
    HomeController controller,
    BuildContext context,
  ) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      backgroundColor: AppColors.background(context),
      foregroundColor: AppColors.textPrimary(context),
      title: const SnapKartLogo(size: 26),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: AppColors.textPrimary(context),
                ),
                onPressed: () {
                  Get.toNamed(AppRoutes.cart);
                },
              ),

              Positioned(
                right: 4,
                top: 8,
                child: Obx(() {
                  CartController.instance.cartItems.value;

                  final count = CartController.instance.cartItemCount;

                  if (count == 0) {
                    return const SizedBox.shrink();
                  }

                  return Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.secondary,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      '$count',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SEARCH BAR
  // ============================================================

  Widget _buildSearchBar(HomeController controller, BuildContext context) {
    return const _SearchBarField();
  }

  // ============================================================
  // PROMO BANNER
  // ============================================================

  Widget _buildPromoBanner(HomeController controller, BuildContext context) {
    return Obx(() {
      if (controller.isBannersLoading.value) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
          child: SizedBox(
            height: 185,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: WaveSkeletonBox(borderRadius: BorderRadius.circular(24)),
            ),
          ),
        );
      }

      if (controller.banners.isEmpty) {
        return const SizedBox.shrink();
      }

      return Padding(
        padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 185,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 4),
                autoPlayAnimationDuration: const Duration(milliseconds: 700),
                enlargeCenterPage: true,
                enlargeFactor: 0.08,
                viewportFraction: 0.92,
                enableInfiniteScroll: controller.banners.length > 1,
                onPageChanged: (index, reason) {
                  controller.bannerIndex.value = index;
                },
              ),
              items: controller.banners.map((banner) {
                return GestureDetector(
                  onTap: () => controller.handleBannerTap(banner),
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryDark.withValues(alpha: 0.25),
                          blurRadius: 12,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // BACKGROUND IMAGE
                        Image.network(
                          banner.imageUrl ?? '',
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: AppColors.primaryGradient,
                              ),
                            ),
                          ),
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }

                            return Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: AppColors.primaryGradient,
                                ),
                              ),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              ),
                            );
                          },
                        ),

                        // TEAL OVERLAY
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xE60B4F4D),
                                Color(0x990B4F4D),
                                Color(0x100B4F4D),
                              ],
                              stops: [0.0, 0.5, 1.0],
                            ),
                          ),
                        ),

                        // TITLE + SHOP NOW
                        Positioned(
                          left: 18,
                          top: 15,
                          bottom: 15,
                          right: 120,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                banner.title?.isNotEmpty == true
                                    ? banner.title!
                                    : 'MEGA SALE',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                  height: 1.1,
                                ),
                              ),
                              const SizedBox(height: 14),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 9,
                                ),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: AppColors.secondaryGradient,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Shop Now',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // ORANGE DISCOUNT CIRCLE
                        if ((banner.discountText ?? '').isNotEmpty)
                          Positioned(
                            right: 14,
                            top: 14,
                            child: Container(
                              width: 78,
                              height: 78,
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: AppColors.secondaryGradient,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'UP TO',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      banner.discountText!,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900,
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
              }).toList(),
            ),

            // DOTS INDICATOR
            if (controller.banners.length > 1) ...[
              const SizedBox(height: 8),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(controller.banners.length, (index) {
                    final selected = controller.bannerIndex.value == index;

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      height: 7,
                      width: selected ? 20 : 7,
                      decoration: BoxDecoration(
                        color: selected
                            ? AppColors.secondary
                            : Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ],
        ),
      );
    });
  }

  // ============================================================
  // RECENTLY VIEWED
  // ============================================================

  Widget _buildRecentlyViewed(BuildContext context) {
    return Obx(() {
      final items = RecentlyViewedController.instance.recentItems;

      if (items.isEmpty) {
        return const SizedBox();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              'Recently Viewed'.tr,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary(context),
              ),
            ),
          ),

          SizedBox(
            height: 82,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];

                return GestureDetector(
                  onTap: () async {
                    final doc = await FirebaseFirestore.instance
                        .collection('products')
                        .doc(item['id'])
                        .get();

                    if (doc.exists) {
                      final product = ModelClass.fromFirestore(doc);
                      Get.toNamed(AppRoutes.productdetail, arguments: product);
                    }
                  },
                  child: Container(
                    width: 74,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground(context),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(14),
                          ),
                          child: Container(
                            height: 58,
                            width: 74,
                            color: Colors.white,
                            padding: const EdgeInsets.all(6),
                            alignment: Alignment.center,
                            child: Image.network(
                              item['image'] ?? '',
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => const Icon(
                                Icons.image_not_supported,
                                color: Colors.grey,
                                size: 16,
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 4,
                          ),
                          child: Text(
                            item['title'] ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 9,
                              color: AppColors.textPrimary(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }

  // ============================================================
  // ERROR STATE
  // ============================================================

  Widget _buildErrorState(HomeController controller, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red.shade300, size: 64),
            const SizedBox(height: 16),
            Text(
              'something_wrong'.tr,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary(context),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              controller.errorMessage.value.isNotEmpty
                  ? controller.errorMessage.value
                  : 'unable_load_products'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary(context),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: controller.refreshProducts,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                foregroundColor: Colors.white,
                minimumSize: const Size(0, 48),
                padding: const EdgeInsets.symmetric(horizontal: 24),
              ),
              icon: const Icon(Icons.refresh),
              label: Text('try_again'.tr),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // EMPTY STATE
  // ============================================================

  Widget _buildEmptyState(HomeController controller, BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 64,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            'no_products_found'.tr,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary(context),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'try_different_category'.tr,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary(context),
            ),
          ),
          const SizedBox(height: 16),
          // Agar filter laga ho to pehle filter reset ka option
          Obx(
            () => controller.hasActiveFilters
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: OutlinedButton(
                      onPressed: controller.resetFilters,
                      child: const Text('Reset filters'),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          ElevatedButton.icon(
            onPressed: controller.refreshProducts,
            icon: const Icon(Icons.refresh),
            label: Text('refresh'.tr),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondary,
              foregroundColor: Colors.white,
              minimumSize: const Size(0, 48),
              padding: const EdgeInsets.symmetric(horizontal: 24),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PRODUCT GRID
  // ============================================================

  Widget _buildProductSliverGrid(
    HomeController controller,
    BuildContext context,
  ) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.68,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          final product = controller.filteredProductList[index];

          return _buildProductCard(product, controller, context);
        }, childCount: controller.filteredProductList.length),
      ),
    );
  }

  // ============================================================
  // SKELETON
  // ============================================================

  Widget _buildSkeletonSliverGrid(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.68,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => _skeletonProductCard(context),
          childCount: 6,
        ),
      ),
    );
  }

  Widget _skeletonProductCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground(context),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            child: WaveSkeletonBox(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WaveSkeletonBox(
                  width: double.infinity,
                  height: 12,
                  borderRadius: BorderRadius.circular(4),
                ),
                const SizedBox(height: 6),
                const SizedBox(
                  width: 80,
                  child: WaveSkeletonBox(
                    height: 12,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),
                const SizedBox(height: 10),
                const SizedBox(
                  width: 60,
                  child: WaveSkeletonBox(
                    height: 16,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PRODUCT CARD
  // ============================================================

  Widget _buildProductCard(
    ModelClass product,
    HomeController controller,
    BuildContext context,
  ) {
    final double oldPrice = product.price ?? 0;
    final double salePrice = product.discountPrice ?? 0;
    final int stock = product.stock ?? 0;

    final bool hasDiscount =
        salePrice > 0 && oldPrice > 0 && salePrice < oldPrice;

    final int discountPercent = hasDiscount
        ? (((oldPrice - salePrice) / oldPrice) * 100).round()
        : 0;

    return GestureDetector(
      onTap: () {
        controller.goToProductDetail(product);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBackground(context),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.07),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE SECTION
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(18),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.only(top: 22, bottom: 14),
                        child: _ProductImageCarousel(
                          images: product.images.isNotEmpty
                              ? product.images
                              : (product.image != null &&
                                        product.image!.isNotEmpty
                                    ? [product.image!]
                                    : []),
                        ),
                      ),
                    ),

                    // TOP LEFT DISCOUNT (teal)
                    if (hasDiscount)
                      Positioned(
                        left: 8,
                        top: 8,
                        child: DiscountBadge('-$discountPercent%'),
                      ),

                    // TOP RIGHT STOCK
                    if (stock > 0 && stock <= 10)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Only $stock left',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // PRODUCT INFORMATION
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title ?? 'Product',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary(context),
                      height: 1.25,
                    ),
                  ),

                  const SizedBox(height: 5),

                  // RATING
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                      const SizedBox(width: 3),
                      Text(
                        product.rating?.rate?.toStringAsFixed(1) ?? '0.0',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary(context),
                        ),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '(${product.rating?.count ?? 0})',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // PRICE + CART BUTTON
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: ValueListenableBuilder<String>(
                          valueListenable: CurrencyService.instance.symbol,
                          builder: (context, currency, _) {
                            final shownPrice = hasDiscount
                                ? salePrice
                                : oldPrice;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '$currency ${shownPrice.toStringAsFixed(0)}',
                                    style: const TextStyle(
                                      color: AppColors.secondary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                if (hasDiscount)
                                  Text(
                                    '$currency ${oldPrice.toStringAsFixed(0)}',
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 10,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      ),

                      const SizedBox(width: 6),

                      _buildCartButton(product, hasDiscount),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ORANGE CART BUTTON (card ke neeche right side)
  Widget _buildCartButton(ModelClass product, bool hasDiscount) {
    return GestureDetector(
      onTap: () {
        CartController.instance.addToCart({
          'productId': product.id,
          'title': product.title,
          'price': hasDiscount ? product.discountPrice : product.price,
          'quantity': 1,
          'image': product.image,
        });

        Get.snackbar(
          '🛒 ${'added_exclaim'.tr}',
          'added_to_cart'.trParams({'product': product.title ?? ''}),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.success.withValues(alpha: 0.15),
          colorText: AppColors.primaryDark,
          duration: const Duration(seconds: 1),
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
        );
      },
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.secondary.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Icon(
          Icons.shopping_cart_outlined,
          size: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}

// ============================================================
// STICKY CATEGORY HEADER
// ============================================================

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;
  final Color backgroundColor;

  _StickyHeaderDelegate({
    required this.child,
    required this.height,
    required this.backgroundColor,
  });

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: backgroundColor, child: child);
  }

  @override
  bool shouldRebuild(covariant _StickyHeaderDelegate oldDelegate) {
    return oldDelegate.child != child ||
        oldDelegate.height != height ||
        oldDelegate.backgroundColor != backgroundColor;
  }
}

// ============================================================
// PRODUCT CARD IMAGE CAROUSEL (multi image + dots)
// ============================================================

class _ProductImageCarousel extends StatefulWidget {
  final List<String> images;

  const _ProductImageCarousel({required this.images});

  @override
  State<_ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<_ProductImageCarousel> {
  int _currentIndex = 0;

  Widget _placeholder(IconData icon, String label) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 40, color: Colors.grey.shade300),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: 10, color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return _placeholder(Icons.hide_image_outlined, 'No image link');
    }

    return Stack(
      children: [
        PageView.builder(
          itemCount: widget.images.length,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          itemBuilder: (context, index) {
            return Image.network(
              widget.images[index],
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                debugPrint('IMAGE ERROR: ${widget.images[index]} -> $error');
                return _placeholder(
                  Icons.broken_image_outlined,
                  'Failed to load',
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.secondary,
                  ),
                );
              },
            );
          },
        ),

        // DOTS (sirf tab jab 1 se zyada image ho)
        if (widget.images.length > 1)
          Positioned(
            bottom: 6,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.images.length, (index) {
                final selected = _currentIndex == index;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  height: 5,
                  width: selected ? 14 : 5,
                  decoration: BoxDecoration(
                    color: selected
                        ? AppColors.secondary
                        : Colors.grey.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              }),
            ),
          ),
      ],
    );
  }
}

// ============================================================
// SEARCH BAR FIELD (clear "x" button ke saath)
// ============================================================

class _SearchBarField extends StatefulWidget {
  const _SearchBarField();

  @override
  State<_SearchBarField> createState() => _SearchBarFieldState();
}

class _SearchBarFieldState extends State<_SearchBarField> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasText = _textController.text.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.cardBackground(context),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: AppColors.textSecondary(context)),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: _textController,
                textInputAction: TextInputAction.search,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textPrimary(context),
                ),
                decoration: InputDecoration(
                  hintText: 'type_product_name'.tr,
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary(context),
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  filled: false,
                  isDense: true,
                ),
                onSubmitted: (value) {
                  if (value.trim().isEmpty) return;
                  Get.toNamed(AppRoutes.searchresult, arguments: value.trim());
                },
              ),
            ),

            if (hasText)
              GestureDetector(
                onTap: () => _textController.clear(),
                child: Icon(
                  Icons.close_rounded,
                  color: AppColors.textSecondary(context),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// 1) CATEGORY HEADER BANNER  ("Men's Clothing" + subtitle + image)
// ============================================================

class CategoryHeaderBanner extends StatelessWidget {
  final HomeController controller;

  const CategoryHeaderBanner({super.key, required this.controller});

  String _title(String category) {
    if (category == 'All') return 'All Products';
    // "men's clothing" -> "Men's Clothing"
    return category
        .split(' ')
        .map((w) => w.isEmpty ? w : w[0].toUpperCase() + w.substring(1))
        .join(' ');
  }

  String _subtitle(String category) {
    final c = category.toLowerCase();
    if (c.contains('clothing')) return 'Stylish essentials for every occasion';
    if (c.contains('electronic')) return 'Latest gadgets at the best prices';
    if (c.contains('jewel')) return 'Shine bright with timeless pieces';
    return 'Top picks just for you';
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final category = controller.selectedCategory.value;
      // category badalne par image bhi badlegi
      final String? imageUrl = controller.categoryImage(category);

      return Container(
        height: 76, // banner ki height
        margin: const EdgeInsets.fromLTRB(16, 4, 16, 0),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.orangeSoft(context),
              AppColors.cardBackground(context),
            ],
          ),
        ),
        child: Stack(
          children: [
            // orange decorative circle
            // Positioned(
            //   right: -25,
            //   top: -20,
            //   child: Container(
            //     width: 125,
            //     height: 125,
            //     decoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       gradient: LinearGradient(
            //         begin: Alignment.topLeft,
            //         end: Alignment.bottomRight,
            //         colors: AppColors.secondaryGradient,
            //       ),
            //     ),
            //   ),
            // ),

            // category ki image (fade animation ke saath badalti hai)
            Positioned(
              right: 8,
              top: 6,
              bottom: 6,
              width: 90, // image ki chaurai
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                child: (imageUrl != null && imageUrl.isNotEmpty)
                    ? Image.network(
                        imageUrl,
                        key: ValueKey(imageUrl),
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                      )
                    : const SizedBox.shrink(key: ValueKey('no-image')),
              ),
            ),

            // text
            Positioned(
              left: 18,
              top: 0,
              bottom: 0,
              right: 110,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _title(category),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 19, // heading ka size
                      fontWeight: FontWeight.w900,
                      height: 1.1,
                      color: AppColors.textPrimary(context),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _subtitle(category),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11, // subtitle ka size
                      color: AppColors.textSecondary(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

// ============================================================
// 2) CATEGORY CARD CHIPS  (vertical: icon on top, text below)
// ============================================================

// class CategoryCardChips extends StatelessWidget {
//   final HomeController controller;
//
//   const CategoryCardChips({super.key, required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final categories = controller.categories;
//       final selected = controller.selectedCategory.value;
//
//       return ListView.builder(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//         itemCount: categories.length,
//         itemBuilder: (context, index) {
//           final category = categories[index];
//           final isSelected = selected == category;
//           final icon = category == 'All'
//               ? Icons.checkroom
//               : controller.getCategoryIcon(category);
//
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 4),
//             child: GestureDetector(
//               onTap: () => controller.filterByCategory(category),
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 250),
//                 width: 60, // chip ki chaurai
//                 padding: const EdgeInsets.symmetric(vertical: 6),
//                 decoration: BoxDecoration(
//                   gradient: isSelected
//                       ? LinearGradient(colors: AppColors.secondaryGradient)
//                       : null,
//                   color: isSelected ? null : AppColors.cardBackground(context),
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(
//                     color: isSelected
//                         ? Colors.transparent
//                         : Colors.grey.shade300,
//                   ),
//                   boxShadow: isSelected
//                       ? [
//                           BoxShadow(
//                             color: AppColors.secondary.withValues(alpha: 0.3),
//                             blurRadius: 10,
//                             offset: const Offset(0, 4),
//                           ),
//                         ]
//                       : null,
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       icon,
//                       size: 17, // chip icon ka size
//                       color: isSelected ? Colors.white : AppColors.secondary,
//                     ),
//                     const SizedBox(height: 3),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 4),
//                       child: Text(
//                         category,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           fontSize: 9, // chip text ka size
//                           fontWeight: isSelected
//                               ? FontWeight.bold
//                               : FontWeight.w500,
//                           color: isSelected
//                               ? Colors.white
//                               : AppColors.textPrimary(context),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       );
//     });
//   }
// }

// ============================================================
// 2) CATEGORY CARD CHIPS  (rounded tile + icon, text neeche)
// ============================================================

class CategoryCardChips extends StatelessWidget {
  final HomeController controller;

  const CategoryCardChips({super.key, required this.controller});

  // Har category ka apna color (screenshot jaisa pastel look)
  Color _colorFor(String category, int index) {
    final c = category.toLowerCase();
    if (category == 'All') return const Color(0xFF7C6CF2); // purple
    if (c.contains('clothing') || c.contains('fashion')) {
      return const Color(0xFFFF6A2B); // orange
    }
    if (c.contains('electronic')) return const Color(0xFF2196F3); // blue
    if (c.contains('jewel') || c.contains('accessor')) {
      return const Color(0xFFF5A623); // gold
    }
    if (c.contains('home')) return const Color(0xFF26A671); // green
    if (c.contains('beauty')) return const Color(0xFFE040B0); // pink

    // baqi categories ke liye palette cycle
    const palette = [
      Color(0xFF26A671),
      Color(0xFFE040B0),
      Color(0xFF2196F3),
      Color(0xFFF5A623),
    ];
    return palette[index % palette.length];
  }

  IconData _iconFor(String category) {
    final c = category.toLowerCase();
    if (category == 'All') return Icons.grid_view_rounded;
    if (c.contains('clothing') || c.contains('fashion')) {
      return Icons.checkroom;
    }
    if (c.contains('electronic')) return Icons.laptop_mac_rounded;
    if (c.contains('jewel')) return Icons.diamond_outlined;
    if (c.contains('home')) return Icons.weekend_rounded;
    if (c.contains('beauty')) return Icons.spa_rounded;
    return controller.getCategoryIcon(category);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // tarteeb wahi: All, phir alphabetical (controller wali list)
      final categories = controller.categories;
      final selected = controller.selectedCategory.value;

      return ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selected == category;
          final color = _colorFor(category, index);

          return GestureDetector(
            onTap: () => controller.filterByCategory(category),
            child: SizedBox(
              width: 72,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ---------- ROUNDED TILE ----------
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: isSelected ? color : color.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: isSelected
                            ? color
                            : color.withValues(alpha: 0.10),
                        width: 1.5,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: color.withValues(alpha: 0.35),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: Icon(
                      _iconFor(category),
                      size: 26,
                      color: isSelected ? Colors.white : color,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // ---------- LABEL ----------
                  Text(
                    category == 'All' ? 'All' : category,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10,
                      height: 1.15,
                      fontWeight: isSelected
                          ? FontWeight.w800
                          : FontWeight.w500,
                      color: isSelected
                          ? color
                          : AppColors.textPrimary(context),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}

// ============================================================
// 3) SORT BY + FILTER BAR
// ============================================================

class SortFilterBar extends StatelessWidget {
  final HomeController controller;

  const SortFilterBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: Obx(
              () => _BarButton(
                icon: Icons.swap_vert_rounded,
                label: 'Sort by',
                value:
                    HomeController.sortLabels[controller.sortOption.value] ??
                    'Featured',
                onTap: () => _showSortSheet(context),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Obx(
              () => _BarButton(
                icon: Icons.tune_rounded,
                label: 'Filter',
                value: controller.hasActiveFilters
                    ? 'Applied'
                    : 'Price, Rating',
                highlight: controller.hasActiveFilters,
                onTap: () => _showFilterSheet(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSortSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        decoration: BoxDecoration(
          color: AppColors.cardBackground(context),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sort by',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary(context),
                ),
              ),
              const SizedBox(height: 8),
              ...HomeController.sortLabels.entries.map((e) {
                return Obx(() {
                  final selected = controller.sortOption.value == e.key;
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      e.value,
                      style: TextStyle(
                        fontWeight: selected
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: selected
                            ? AppColors.secondary
                            : AppColors.textPrimary(context),
                      ),
                    ),
                    trailing: selected
                        ? const Icon(
                            Icons.check_circle,
                            color: AppColors.secondary,
                          )
                        : null,
                    onTap: () {
                      controller.setSort(e.key);
                      Get.back();
                    },
                  );
                });
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    Get.bottomSheet(
      _FilterSheet(controller: controller),
      isScrollControlled: true,
    );
  }
}

class _BarButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;
  final bool highlight;

  const _BarButton({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.cardBackground(context),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: highlight ? AppColors.secondary : Colors.transparent,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textSecondary(context)),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary(context),
                    ),
                  ),
                  Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary(context),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.textSecondary(context),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// FILTER BOTTOM SHEET
// ============================================================

class _FilterSheet extends StatefulWidget {
  final HomeController controller;

  const _FilterSheet({required this.controller});

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  late RangeValues _range;
  late double _minRating;
  late bool _onlyDiscounted;
  late double _maxPrice;

  @override
  void initState() {
    super.initState();
    final c = widget.controller;
    _maxPrice = c.catalogMaxPrice;
    final hi = c.filterMaxPrice.value <= 0
        ? _maxPrice
        : c.filterMaxPrice.value.clamp(0.0, _maxPrice).toDouble();
    final lo = c.filterMinPrice.value.clamp(0.0, hi).toDouble();
    _range = RangeValues(lo, hi);
    _minRating = c.filterMinRating.value;
    _onlyDiscounted = c.filterOnlyDiscounted.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground(context),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary(context),
              ),
            ),
            const SizedBox(height: 16),

            Text(
              'Price range: ${_range.start.round()} - ${_range.end.round()}',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary(context),
              ),
            ),
            RangeSlider(
              values: _range,
              min: 0,
              max: _maxPrice <= 0 ? 1 : _maxPrice,
              activeColor: AppColors.secondary,
              onChanged: (v) => setState(() => _range = v),
            ),

            const SizedBox(height: 8),
            Text(
              'Minimum rating',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary(context),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [0.0, 3.0, 4.0, 4.5].map((r) {
                final selected = _minRating == r;
                return ChoiceChip(
                  label: Text(r == 0 ? 'Any' : '$r+ ★'),
                  selected: selected,
                  selectedColor: AppColors.secondary,
                  labelStyle: TextStyle(
                    color: selected ? Colors.white : null,
                    fontWeight: FontWeight.w600,
                  ),
                  onSelected: (_) => setState(() => _minRating = r),
                );
              }).toList(),
            ),

            const SizedBox(height: 8),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              activeColor: AppColors.secondary,
              title: const Text('Only discounted items'),
              value: _onlyDiscounted,
              onChanged: (v) => setState(() => _onlyDiscounted = v),
            ),

            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      widget.controller.resetFilters();
                      Get.back();
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 48),
                    ),
                    child: const Text('Reset'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      widget.controller.applyFilters(
                        minPrice: _range.start,
                        // full range selected = no max limit
                        maxPrice: _range.end >= _maxPrice ? 0 : _range.end,
                        minRating: _minRating,
                        onlyDiscounted: _onlyDiscounted,
                      );
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(0, 48),
                    ),
                    child: const Text('Apply'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
