// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:snapkart/App_Routes/routes_view.dart';
// import 'package:snapkart/Snapkart_App_Screens/Wishlist_Screen/wishlist_controller.dart';
//
// import '../../Utilities_Screens/App_Colors/app_colors.dart';
// import '../../Utilities_Screens/App_Model/app_model.dart';
// import '../../Utilities_Screens/Currency_Service/currency_service.dart';
// import '../../Utilities_Screens/Wave_Skelton_Box/wave_skelton_box.dart';
//
// class WishlistView extends StatelessWidget {
//   const WishlistView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = WishlistController.instance;
//
//     return Scaffold(
//       backgroundColor: AppColors.background(context),
//       body: SafeArea(
//         child: Column(
//           children: [
//             _buildAppBar(context),
//             Expanded(
//               child: Obx(() {
//                 if (controller.wishlistItems.isEmpty) {
//                   return _buildEmptyState(context);
//                 }
//                 return _buildWishlistGrid(context, controller);
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildAppBar(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       color: AppColors.cardBackground(context),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           GestureDetector(
//             onTap: () => Get.back(),
//             child: Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Theme.of(context).brightness == Brightness.dark
//                     ? Colors.white.withOpacity(0.08)
//                     : Colors.grey.shade100,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Icon(
//                 Icons.arrow_back,
//                 size: 22,
//                 color: AppColors.textPrimary(context),
//               ),
//             ),
//           ),
//           Text(
//             'my_wishlist'.tr,
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//               color: AppColors.textPrimary(context),
//             ),
//           ),
//           Obx(() {
//             final count = WishlistController.instance.wishlistCount;
//             return Container(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               decoration: BoxDecoration(
//                 color: AppColors.secondary.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Text(
//                 'wishlist_items'.trParams({'count': count.toString()}),
//                 style: TextStyle(
//                   color: AppColors.secondary,
//                   fontWeight: FontWeight.w600,
//                   fontSize: 13,
//                 ),
//               ),
//             );
//           }),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildEmptyState(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(32),
//             decoration: BoxDecoration(
//               color: isDark
//                   ? AppColors.secondary.withOpacity(0.12)
//                   : Colors.pink.shade50,
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               Icons.favorite_border_rounded,
//               size: 80,
//               color: AppColors.secondary,
//             ),
//           ),
//           const SizedBox(height: 24),
//           Text(
//             'wishlist_empty'.tr,
//             style: TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//               color: AppColors.textPrimary(context),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'wishlist_empty_sub'.tr,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 15,
//               color: AppColors.textSecondary(context),
//               height: 1.5,
//             ),
//           ),
//           const SizedBox(height: 32),
//           ElevatedButton.icon(
//             onPressed: () => Get.back(),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColors.secondary,
//               foregroundColor: Colors.white,
//               padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               elevation: 0,
//             ),
//             icon: const Icon(Icons.shopping_bag_outlined),
//             label: Text(
//               'shopping_it'.tr,
//               style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildWishlistGrid(
//     BuildContext context,
//     WishlistController controller,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: GridView.builder(
//         physics: const BouncingScrollPhysics(),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 12,
//           mainAxisSpacing: 12,
//           childAspectRatio: 0.72,
//         ),
//         itemCount: controller.wishlistItems.length,
//         itemBuilder: (context, index) {
//           final product = controller.wishlistItems[index];
//           return _buildWishlistCard(context, product, controller);
//         },
//       ),
//     );
//   }
//
//   Widget _buildWishlistCard(
//     BuildContext context,
//     ModelClass product,
//     WishlistController controller,
//   ) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return GestureDetector(
//       onTap: () {
//         Get.toNamed(AppRoutes.productdetail, arguments: product);
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: AppColors.cardBackground(context),
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: isDark
//                   ? Colors.black.withOpacity(0.3)
//                   : Colors.grey.shade100,
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: Stack(
//                 children: [
//                   ClipRRect(
//                     borderRadius: const BorderRadius.vertical(
//                       top: Radius.circular(16),
//                     ),
//                     child: Container(
//                       width: double.infinity,
//                       color: isDark
//                           ? Colors.white.withOpacity(0.04)
//                           : Colors.grey.shade50,
//                       child: Image.network(
//                         product.image ?? '',
//                         fit: BoxFit.contain,
//                         errorBuilder: (context, error, stackTrace) => Center(
//                           child: Icon(
//                             Icons.broken_image,
//                             size: 50,
//                             color: isDark
//                                 ? Colors.grey.shade700
//                                 : Colors.grey.shade300,
//                           ),
//                         ),
//                         loadingBuilder: (context, child, loadingProgress) {
//                           if (loadingProgress == null) return child;
//                           return const WaveSkeletonBox(
//                             borderRadius: BorderRadius.zero,
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: 8,
//                     right: 8,
//                     child: GestureDetector(
//                       onTap: () => controller.toggleWishlist(product),
//                       child: Container(
//                         padding: const EdgeInsets.all(6),
//                         decoration: BoxDecoration(
//                           color: AppColors.cardBackground(context),
//                           shape: BoxShape.circle,
//                           boxShadow: [
//                             BoxShadow(
//                               color: isDark
//                                   ? Colors.black.withOpacity(0.3)
//                                   : Colors.grey.shade200,
//                               blurRadius: 6,
//                             ),
//                           ],
//                         ),
//                         child: Icon(
//                           Icons.favorite_rounded,
//                           color: AppColors.secondary,
//                           size: 18,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     product.title ?? '',
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       height: 1.3,
//                       color: AppColors.textPrimary(context),
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 6),
//                   Row(
//                     children: [
//                       const Icon(
//                         Icons.star_rounded,
//                         color: Colors.amber,
//                         size: 14,
//                       ),
//                       const SizedBox(width: 2),
//                       Text(
//                         product.rating?.rate?.toStringAsFixed(1) ?? '0.0',
//                         style: TextStyle(
//                           fontSize: 11,
//                           color: AppColors.textSecondary(context),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 6),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       ValueListenableBuilder<String>(
//                         valueListenable: CurrencyService.instance.symbol,
//                         builder: (context, currency, _) {
//                           return Text(
//                             '$currency ${product.price?.toStringAsFixed(0) ?? '0'}',
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                               color: AppColors.secondary,
//                             ),
//                           );
//                         },
//                       ),
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
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:snapkart/App_Routes/routes_view.dart';
// import 'package:snapkart/Snapkart_App_Screens/Wishlist_Screen/wishlist_controller.dart';
//
// import '../../Utilities_Screens/App_Colors/app_colors.dart';
// import '../../Utilities_Screens/App_Colors/app_widgets.dart';
// import '../../Utilities_Screens/App_Model/app_model.dart';
// import '../../Utilities_Screens/Currency_Service/currency_service.dart';
// import '../../Utilities_Screens/Wave_Skelton_Box/wave_skelton_box.dart';
// import '../Cart_Screen/cart_controller.dart';
//
// class WishlistView extends StatelessWidget {
//   const WishlistView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = WishlistController.instance;
//
//     return Scaffold(
//       backgroundColor: AppColors.background(context),
//       body: SafeArea(
//         child: Column(
//           children: [
//             _buildHeader(context),
//             Expanded(
//               child: Obx(() {
//                 if (controller.wishlistItems.isEmpty) {
//                   return _buildEmptyState(context);
//                 }
//                 return _buildWishlistList(context, controller);
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ── Header ──
//   Widget _buildHeader(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
//       child: Row(
//         children: [
//           GestureDetector(
//             onTap: () => Get.back(),
//             child: Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: AppColors.orangeSoft(context),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.arrow_back,
//                 size: 22,
//                 color: AppColors.secondary,
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'my_wishlist'.tr,
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.w800,
//                     color: AppColors.textPrimary(context),
//                   ),
//                 ),
//                 Text(
//                   'Your saved items, all in one place.',
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: AppColors.textSecondary(context),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(width: 8),
//           Obx(() {
//             final count = WishlistController.instance.wishlistCount;
//             return Container(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
//               decoration: BoxDecoration(
//                 color: AppColors.orangeSoft(context),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Text(
//                 'wishlist_items'.trParams({'count': count.toString()}),
//                 style: const TextStyle(
//                   color: AppColors.secondary,
//                   fontWeight: FontWeight.w700,
//                   fontSize: 13,
//                 ),
//               ),
//             );
//           }),
//         ],
//       ),
//     );
//   }
//
//   // ── Empty state ──
//   Widget _buildEmptyState(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(32),
//               decoration: BoxDecoration(
//                 color: AppColors.orangeSoft(context),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.favorite_border_rounded,
//                 size: 80,
//                 color: AppColors.secondary,
//               ),
//             ),
//             const SizedBox(height: 24),
//             Text(
//               'wishlist_empty'.tr,
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.textPrimary(context),
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'wishlist_empty_sub'.tr,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 15,
//                 color: AppColors.textSecondary(context),
//                 height: 1.5,
//               ),
//             ),
//             const SizedBox(height: 32),
//             ElevatedButton.icon(
//               onPressed: () => Get.back(),
//               style: ElevatedButton.styleFrom(
//                 minimumSize: const Size(0, 50),
//                 padding: const EdgeInsets.symmetric(horizontal: 32),
//               ),
//               icon: const Icon(Icons.shopping_bag_outlined),
//               label: Text(
//                 'shopping_it'.tr,
//                 style: const TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ── List ──
//   Widget _buildWishlistList(
//     BuildContext context,
//     WishlistController controller,
//   ) {
//     return ListView.builder(
//       physics: const BouncingScrollPhysics(),
//       padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
//       itemCount: controller.wishlistItems.length,
//       itemBuilder: (context, index) {
//         final product = controller.wishlistItems[index];
//         return _buildWishlistCard(context, product, controller);
//       },
//     );
//   }
//
//   // ── Card ──
//   Widget _buildWishlistCard(
//     BuildContext context,
//     ModelClass product,
//     WishlistController controller,
//   ) {
//     final double oldPrice = product.price ?? 0;
//     final double salePrice = product.discountPrice ?? 0;
//
//     final bool hasDiscount =
//         salePrice > 0 && oldPrice > 0 && salePrice < oldPrice;
//
//     final int discountPercent = hasDiscount
//         ? (((oldPrice - salePrice) / oldPrice) * 100).round()
//         : 0;
//
//     final double shownPrice = hasDiscount ? salePrice : oldPrice;
//
//     return GestureDetector(
//       onTap: () {
//         Get.toNamed(AppRoutes.productdetail, arguments: product);
//       },
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 12),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: AppColors.cardBackground(context),
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withValues(alpha: 0.05),
//               blurRadius: 12,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // IMAGE + DISCOUNT BADGE
//             SizedBox(
//               width: 108,
//               height: 150,
//               child: Stack(
//                 children: [
//                   Positioned.fill(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       clipBehavior: Clip.antiAlias,
//                       child: Image.network(
//                         product.image ?? '',
//                         fit: BoxFit.contain,
//                         errorBuilder: (context, error, stackTrace) => Center(
//                           child: Icon(
//                             Icons.broken_image,
//                             size: 40,
//                             color: Colors.grey.shade300,
//                           ),
//                         ),
//                         loadingBuilder: (context, child, loadingProgress) {
//                           if (loadingProgress == null) return child;
//                           return const WaveSkeletonBox(
//                             borderRadius: BorderRadius.zero,
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                   if (hasDiscount)
//                     Positioned(
//                       left: 6,
//                       top: 6,
//                       child: DiscountBadge('-$discountPercent%'),
//                     ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(width: 12),
//
//             // DETAILS
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // title + heart
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           product.title ?? '',
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w700,
//                             height: 1.25,
//                             color: AppColors.textPrimary(context),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 6),
//                       GestureDetector(
//                         onTap: () => controller.toggleWishlist(product),
//                         child: Container(
//                           padding: const EdgeInsets.all(7),
//                           decoration: BoxDecoration(
//                             color: AppColors.orangeSoft(context),
//                             shape: BoxShape.circle,
//                           ),
//                           child: const Icon(
//                             Icons.favorite_rounded,
//                             color: AppColors.secondary,
//                             size: 18,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 6),
//
//                   // rating
//                   Row(
//                     children: [
//                       const Icon(
//                         Icons.star_rounded,
//                         color: Colors.amber,
//                         size: 16,
//                       ),
//                       const SizedBox(width: 3),
//                       Text(
//                         product.rating?.rate?.toStringAsFixed(1) ?? '0.0',
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.textPrimary(context),
//                         ),
//                       ),
//                       const SizedBox(width: 3),
//                       Text(
//                         '(${product.rating?.count ?? 0})',
//                         style: TextStyle(
//                           fontSize: 11,
//                           color: AppColors.textSecondary(context),
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 6),
//
//                   // price
//                   ValueListenableBuilder<String>(
//                     valueListenable: CurrencyService.instance.symbol,
//                     builder: (context, currency, _) {
//                       return Wrap(
//                         crossAxisAlignment: WrapCrossAlignment.center,
//                         spacing: 8,
//                         children: [
//                           Text(
//                             '$currency ${shownPrice.toStringAsFixed(0)}',
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w900,
//                               color: AppColors.secondary,
//                             ),
//                           ),
//                           if (hasDiscount)
//                             Text(
//                               '$currency ${oldPrice.toStringAsFixed(0)}',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.grey.shade500,
//                                 decoration: TextDecoration.lineThrough,
//                               ),
//                             ),
//                         ],
//                       );
//                     },
//                   ),
//
//                   const SizedBox(height: 10),
//
//                   // BUTTONS
//                   Row(
//                     children: [
//                       // Remove
//                       Expanded(
//                         flex: 3,
//                         child: GestureDetector(
//                           onTap: () => controller.toggleWishlist(product),
//                           child: Container(
//                             height: 38,
//                             decoration: BoxDecoration(
//                               color: AppColors.textPrimary(
//                                 context,
//                               ).withValues(alpha: 0.06),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: FittedBox(
//                               fit: BoxFit.scaleDown,
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Icon(
//                                     Icons.delete_outline,
//                                     size: 18,
//                                     color: AppColors.textPrimary(context),
//                                   ),
//                                   const SizedBox(width: 4),
//                                   Text(
//                                     'Remove',
//                                     style: TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w600,
//                                       color: AppColors.textPrimary(context),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       const SizedBox(width: 8),
//
//                       // Move to Cart
//                       Expanded(
//                         flex: 3,
//                         child: GestureDetector(
//                           onTap: () =>
//                               _moveToCart(product, hasDiscount, controller),
//                           child: Container(
//                             height: 38,
//                             padding: const EdgeInsets.symmetric(horizontal: 9),
//                             decoration: BoxDecoration(
//                               gradient: const LinearGradient(
//                                 colors: AppColors.secondaryGradient,
//                               ),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: const FittedBox(
//                               fit: BoxFit.scaleDown,
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Icon(
//                                     Icons.shopping_cart_outlined,
//                                     size: 18,
//                                     color: Colors.white,
//                                   ),
//                                   SizedBox(width: 4),
//                                   Text(
//                                     'Move to Cart',
//                                     style: TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w700,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
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
//   // ── Move to Cart ──
//   void _moveToCart(
//     ModelClass product,
//     bool hasDiscount,
//     WishlistController controller,
//   ) {
//     CartController.instance.addToCart({
//       'productId': product.id,
//       'title': product.title,
//       'price': hasDiscount ? product.discountPrice : product.price,
//       'quantity': 1,
//       'image': product.image,
//     });
//
//     controller.removeFromWishlist(product.id);
//
//     Get.snackbar(
//       '🛒 ${'added_exclaim'.tr}',
//       'added_to_cart'.trParams({'product': product.title ?? ''}),
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: AppColors.success.withValues(alpha: 0.15),
//       colorText: AppColors.primaryDark,
//       duration: const Duration(seconds: 1),
//       margin: const EdgeInsets.all(16),
//       borderRadius: 12,
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:snapkart/App_Routes/routes_view.dart';
// import 'package:snapkart/Snapkart_App_Screens/Wishlist_Screen/wishlist_controller.dart';
//
// import '../../Utilities_Screens/App_Colors/app_colors.dart';
// import '../../Utilities_Screens/App_Colors/app_widgets.dart';
// import '../../Utilities_Screens/App_Model/app_model.dart';
// import '../../Utilities_Screens/Currency_Service/currency_service.dart';
// import '../../Utilities_Screens/Wave_Skelton_Box/wave_skelton_box.dart';
// import '../Cart_Screen/cart_controller.dart';
//
// class WishlistView extends StatelessWidget {
//   const WishlistView({super.key});
//
//   // Light grey (image box aur Remove button dono ke liye same shade)
//   static const Color _lightGrey = Color(0xFFF3F4F6);
//
//   static Color _greyBg(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     return isDark ? Colors.white.withValues(alpha: 0.08) : _lightGrey;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = WishlistController.instance;
//
//     return Scaffold(
//       backgroundColor: AppColors.background(context),
//       body: SafeArea(
//         child: Column(
//           children: [
//             _buildHeader(context),
//             Expanded(
//               child: Obx(() {
//                 if (controller.wishlistItems.isEmpty) {
//                   return _buildEmptyState(context);
//                 }
//                 return _buildWishlistList(context, controller);
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ── Header ──
//   Widget _buildHeader(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
//       child: Row(
//         children: [
//           GestureDetector(
//             onTap: () => Get.back(),
//             child: Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: AppColors.orangeSoft(context),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.arrow_back,
//                 size: 22,
//                 color: AppColors.secondary,
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'my_wishlist'.tr,
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.w800,
//                     color: AppColors.textPrimary(context),
//                   ),
//                 ),
//                 Text(
//                   'Your saved items, all in one place.',
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: AppColors.textSecondary(context),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(width: 8),
//           Obx(() {
//             final count = WishlistController.instance.wishlistCount;
//             return Container(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
//               decoration: BoxDecoration(
//                 color: AppColors.orangeSoft(context),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Text(
//                 'wishlist_items'.trParams({'count': count.toString()}),
//                 style: const TextStyle(
//                   color: AppColors.secondary,
//                   fontWeight: FontWeight.w700,
//                   fontSize: 13,
//                 ),
//               ),
//             );
//           }),
//         ],
//       ),
//     );
//   }
//
//   // ── Empty state ──
//   Widget _buildEmptyState(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(32),
//               decoration: BoxDecoration(
//                 color: AppColors.orangeSoft(context),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.favorite_border_rounded,
//                 size: 80,
//                 color: AppColors.secondary,
//               ),
//             ),
//             const SizedBox(height: 24),
//             Text(
//               'wishlist_empty'.tr,
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.textPrimary(context),
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'wishlist_empty_sub'.tr,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 15,
//                 color: AppColors.textSecondary(context),
//                 height: 1.5,
//               ),
//             ),
//             const SizedBox(height: 32),
//             ElevatedButton.icon(
//               onPressed: () => Get.back(),
//               style: ElevatedButton.styleFrom(
//                 minimumSize: const Size(0, 50),
//                 padding: const EdgeInsets.symmetric(horizontal: 32),
//               ),
//               icon: const Icon(Icons.shopping_bag_outlined),
//               label: Text(
//                 'shopping_it'.tr,
//                 style: const TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ── List ──
//   Widget _buildWishlistList(
//     BuildContext context,
//     WishlistController controller,
//   ) {
//     return ListView.builder(
//       physics: const BouncingScrollPhysics(),
//       padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
//       itemCount: controller.wishlistItems.length,
//       itemBuilder: (context, index) {
//         final product = controller.wishlistItems[index];
//         return _buildWishlistCard(context, product, controller);
//       },
//     );
//   }
//
//   // ── Card ──
//   Widget _buildWishlistCard(
//     BuildContext context,
//     ModelClass product,
//     WishlistController controller,
//   ) {
//     final double oldPrice = product.price ?? 0;
//     final double salePrice = product.discountPrice ?? 0;
//
//     final bool hasDiscount =
//         salePrice > 0 && oldPrice > 0 && salePrice < oldPrice;
//
//     final int discountPercent = hasDiscount
//         ? (((oldPrice - salePrice) / oldPrice) * 100).round()
//         : 0;
//
//     final double shownPrice = hasDiscount ? salePrice : oldPrice;
//
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return GestureDetector(
//       onTap: () {
//         Get.toNamed(AppRoutes.productdetail, arguments: product);
//       },
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 12),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: AppColors.cardBackground(context),
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withValues(alpha: 0.05),
//               blurRadius: 12,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // IMAGE (light grey container ke andar) + DISCOUNT BADGE
//             SizedBox(
//               width: 108,
//               height: 150,
//               child: Stack(
//                 children: [
//                   Positioned.fill(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: _greyBg(context),
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       clipBehavior: Clip.antiAlias,
//                       padding: const EdgeInsets.all(8),
//                       child: Image.network(
//                         product.image ?? '',
//                         fit: BoxFit.contain,
//                         // Light mode mein white background wali JPG images
//                         // grey mein blend ho jati hain. Agar images transparent
//                         // PNG hain to ye 2 lines hata sakte ho.
//                         color: isDark ? null : _lightGrey,
//                         colorBlendMode: isDark ? null : BlendMode.multiply,
//                         errorBuilder: (context, error, stackTrace) => Center(
//                           child: Icon(
//                             Icons.broken_image,
//                             size: 40,
//                             color: Colors.grey.shade300,
//                           ),
//                         ),
//                         loadingBuilder: (context, child, loadingProgress) {
//                           if (loadingProgress == null) return child;
//                           return const WaveSkeletonBox(
//                             borderRadius: BorderRadius.zero,
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                   if (hasDiscount)
//                     Positioned(
//                       left: 6,
//                       top: 6,
//                       child: DiscountBadge('-$discountPercent%'),
//                     ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(width: 12),
//
//             // DETAILS
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // title + heart
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           product.title ?? '',
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w700,
//                             height: 1.25,
//                             color: AppColors.textPrimary(context),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 6),
//                       GestureDetector(
//                         onTap: () => controller.toggleWishlist(product),
//                         child: Container(
//                           padding: const EdgeInsets.all(7),
//                           decoration: BoxDecoration(
//                             color: AppColors.orangeSoft(context),
//                             shape: BoxShape.circle,
//                           ),
//                           child: const Icon(
//                             Icons.favorite_rounded,
//                             color: AppColors.secondary,
//                             size: 18,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 6),
//
//                   // rating
//                   Row(
//                     children: [
//                       const Icon(
//                         Icons.star_rounded,
//                         color: Colors.amber,
//                         size: 16,
//                       ),
//                       const SizedBox(width: 3),
//                       Text(
//                         product.rating?.rate?.toStringAsFixed(1) ?? '0.0',
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.textPrimary(context),
//                         ),
//                       ),
//                       const SizedBox(width: 3),
//                       Text(
//                         '(${product.rating?.count ?? 0})',
//                         style: TextStyle(
//                           fontSize: 11,
//                           color: AppColors.textSecondary(context),
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 6),
//
//                   // price
//                   ValueListenableBuilder<String>(
//                     valueListenable: CurrencyService.instance.symbol,
//                     builder: (context, currency, _) {
//                       return Wrap(
//                         crossAxisAlignment: WrapCrossAlignment.center,
//                         spacing: 8,
//                         children: [
//                           Text(
//                             '$currency ${shownPrice.toStringAsFixed(0)}',
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w900,
//                               color: AppColors.secondary,
//                             ),
//                           ),
//                           if (hasDiscount)
//                             Text(
//                               '$currency ${oldPrice.toStringAsFixed(0)}',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.grey.shade500,
//                                 decoration: TextDecoration.lineThrough,
//                               ),
//                             ),
//                         ],
//                       );
//                     },
//                   ),
//
//                   const SizedBox(height: 10),
//
//                   // BUTTONS
//                   Row(
//                     children: [
//                       // Remove
//                       Expanded(
//                         flex: 3,
//                         child: GestureDetector(
//                           onTap: () => controller.toggleWishlist(product),
//                           child: Container(
//                             height: 38,
//                             decoration: BoxDecoration(
//                               // Image box jaisi hi light grey shade
//                               color: _greyBg(context),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: FittedBox(
//                               fit: BoxFit.scaleDown,
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Icon(
//                                     Icons.delete_outline,
//                                     size: 18,
//                                     color: AppColors.textPrimary(context),
//                                   ),
//                                   const SizedBox(width: 4),
//                                   Text(
//                                     'Remove',
//                                     style: TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w600,
//                                       color: AppColors.textPrimary(context),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       const SizedBox(width: 8),
//
//                       // Move to Cart
//                       Expanded(
//                         flex: 3,
//                         child: GestureDetector(
//                           onTap: () =>
//                               _moveToCart(product, hasDiscount, controller),
//                           child: Container(
//                             height: 38,
//                             padding: const EdgeInsets.symmetric(horizontal: 9),
//                             decoration: BoxDecoration(
//                               gradient: const LinearGradient(
//                                 colors: AppColors.secondaryGradient,
//                               ),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: const FittedBox(
//                               fit: BoxFit.scaleDown,
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Icon(
//                                     Icons.shopping_cart_outlined,
//                                     size: 18,
//                                     color: Colors.white,
//                                   ),
//                                   SizedBox(width: 4),
//                                   Text(
//                                     'Move to Cart',
//                                     style: TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w700,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
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
//   // ── Move to Cart ──
//   void _moveToCart(
//     ModelClass product,
//     bool hasDiscount,
//     WishlistController controller,
//   ) {
//     CartController.instance.addToCart({
//       'productId': product.id,
//       'title': product.title,
//       'price': hasDiscount ? product.discountPrice : product.price,
//       'quantity': 1,
//       'image': product.image,
//     });
//
//     controller.removeFromWishlist(product.id);
//
//     Get.snackbar(
//       '🛒 ${'added_exclaim'.tr}',
//       'added_to_cart'.trParams({'product': product.title ?? ''}),
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: AppColors.success.withValues(alpha: 0.15),
//       colorText: AppColors.primaryDark,
//       duration: const Duration(seconds: 1),
//       margin: const EdgeInsets.all(16),
//       borderRadius: 12,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snapkart/App_Routes/routes_view.dart';
import 'package:snapkart/Snapkart_App_Screens/Wishlist_Screen/wishlist_controller.dart';

import '../../Utilities_Screens/App_Colors/app_colors.dart';
import '../../Utilities_Screens/App_Colors/app_widgets.dart';
import '../../Utilities_Screens/App_Model/app_model.dart';
import '../../Utilities_Screens/Currency_Service/currency_service.dart';
import '../../Utilities_Screens/Wave_Skelton_Box/wave_skelton_box.dart';
import '../Cart_Screen/cart_controller.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  // Light grey (image box aur Remove button dono ke liye same shade)
  static const Color _lightGrey = Color(0xFFF3F4F6);

  static Color _greyBg(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? Colors.white.withValues(alpha: 0.08) : _lightGrey;
  }

  // ── Size / Color helpers ──
  // Pehle user ka chuna hua (wishlist mein save), warna product ka default.
  static String? _sizeFor(ModelClass p, WishlistController c) {
    final saved = c.variantSize(p.id);
    if (saved != null && saved.isNotEmpty) return saved;
    return p.sizes.firstWhereOrNull((s) => s.stock > 0)?.label;
  }

  static String? _colorFor(ModelClass p, WishlistController c) {
    final saved = c.variantColor(p.id);
    if (saved != null && saved.isNotEmpty) return saved;
    return p.colors.isNotEmpty ? p.colors.first.name : null;
  }

  static String _variantText(ModelClass p, WishlistController c) {
    final parts = <String>[];
    final size = _sizeFor(p, c);
    final color = _colorFor(p, c);
    if (size != null && size.isNotEmpty) parts.add('Size: $size');
    if (color != null && color.isNotEmpty) parts.add('Color: $color');
    return parts.join('  |  ');
  }

  @override
  Widget build(BuildContext context) {
    final controller = WishlistController.instance;

    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: Obx(() {
                if (controller.wishlistItems.isEmpty) {
                  return _buildEmptyState(context);
                }
                return _buildWishlistList(context, controller);
              }),
            ),
          ],
        ),
      ),
    );
  }

  // ── Header ──
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.orangeSoft(context),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back,
                size: 22,
                color: AppColors.secondary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'my_wishlist'.tr,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary(context),
                  ),
                ),
                Text(
                  'Your saved items, all in one place.',
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
          const SizedBox(width: 8),
          Obx(() {
            final count = WishlistController.instance.wishlistCount;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: AppColors.orangeSoft(context),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'wishlist_items'.trParams({'count': count.toString()}),
                style: const TextStyle(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // ── Empty state ──
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppColors.orangeSoft(context),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_border_rounded,
                size: 80,
                color: AppColors.secondary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'wishlist_empty'.tr,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary(context),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'wishlist_empty_sub'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: AppColors.textSecondary(context),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(0, 50),
                padding: const EdgeInsets.symmetric(horizontal: 32),
              ),
              icon: const Icon(Icons.shopping_bag_outlined),
              label: Text(
                'shopping_it'.tr,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── List ──
  Widget _buildWishlistList(
    BuildContext context,
    WishlistController controller,
  ) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
      itemCount: controller.wishlistItems.length,
      itemBuilder: (context, index) {
        final product = controller.wishlistItems[index];
        return _buildWishlistCard(context, product, controller);
      },
    );
  }

  // ── Card ──
  Widget _buildWishlistCard(
    BuildContext context,
    ModelClass product,
    WishlistController controller,
  ) {
    final double oldPrice = product.price ?? 0;
    final double salePrice = product.discountPrice ?? 0;

    final bool hasDiscount =
        salePrice > 0 && oldPrice > 0 && salePrice < oldPrice;

    final int discountPercent = hasDiscount
        ? (((oldPrice - salePrice) / oldPrice) * 100).round()
        : 0;

    final double shownPrice = hasDiscount ? salePrice : oldPrice;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    final String variant = _variantText(product, controller);

    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.productdetail, arguments: product);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.cardBackground(context),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE (light grey container ke andar) + DISCOUNT BADGE
            SizedBox(
              width: 108,
              height: 150,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: _greyBg(context),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      clipBehavior: Clip.antiAlias,
                      padding: const EdgeInsets.all(8),
                      child: Image.network(
                        product.image ?? '',
                        fit: BoxFit.contain,
                        // Light mode mein white background wali JPG images
                        // grey mein blend ho jati hain. Agar images transparent
                        // PNG hain to ye 2 lines hata sakte ho.
                        color: isDark ? null : _lightGrey,
                        colorBlendMode: isDark ? null : BlendMode.multiply,
                        errorBuilder: (context, error, stackTrace) => Center(
                          child: Icon(
                            Icons.broken_image,
                            size: 40,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const WaveSkeletonBox(
                            borderRadius: BorderRadius.zero,
                          );
                        },
                      ),
                    ),
                  ),
                  if (hasDiscount)
                    Positioned(
                      left: 6,
                      top: 6,
                      child: DiscountBadge('-$discountPercent%'),
                    ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // DETAILS
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title + heart
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          product.title ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            height: 1.25,
                            color: AppColors.textPrimary(context),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: () => controller.toggleWishlist(product),
                        child: Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: AppColors.orangeSoft(context),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.favorite_rounded,
                            color: AppColors.secondary,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // rating
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                        size: 16,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        product.rating?.rate?.toStringAsFixed(1) ?? '0.0',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary(context),
                        ),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '(${product.rating?.count ?? 0})',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary(context),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // price
                  ValueListenableBuilder<String>(
                    valueListenable: CurrencyService.instance.symbol,
                    builder: (context, currency, _) {
                      return Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8,
                        children: [
                          Text(
                            '$currency ${shownPrice.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: AppColors.secondary,
                            ),
                          ),
                          if (hasDiscount)
                            Text(
                              '$currency ${oldPrice.toStringAsFixed(0)}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade500,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      );
                    },
                  ),

                  // SIZE | COLOR line
                  if (variant.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      variant,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                  ],

                  const SizedBox(height: 10),

                  // BUTTONS
                  Row(
                    children: [
                      // Remove (chota)
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () => controller.toggleWishlist(product),
                          child: Container(
                            height: 38,
                            decoration: BoxDecoration(
                              // Image box jaisi hi light grey shade
                              color: _greyBg(context),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.delete_outline,
                                    size: 18,
                                    color: AppColors.textPrimary(context),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Remove',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      // Move to Cart (bara)
                      Expanded(
                        flex: 3,
                        child: GestureDetector(
                          onTap: () =>
                              _moveToCart(product, hasDiscount, controller),
                          child: Container(
                            height: 38,
                            padding: const EdgeInsets.symmetric(horizontal: 9),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: AppColors.secondaryGradient,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.shopping_cart_outlined,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Move to Cart',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
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

  // ── Move to Cart ──
  void _moveToCart(
    ModelClass product,
    bool hasDiscount,
    WishlistController controller,
  ) {
    CartController.instance.addToCart({
      'productId': product.id,
      'title': product.title,
      'price': hasDiscount ? product.discountPrice : product.price,
      'quantity': 1,
      'image': product.image,
      'size': _sizeFor(product, controller),
      'color': _colorFor(product, controller),
    });

    controller.removeFromWishlist(product.id);

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
  }
}
