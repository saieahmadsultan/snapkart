// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../App_Routes/routes_view.dart';
// import '../../Utilities_Screens/App_Colors/app_colors.dart';
// import '../../Utilities_Screens/App_Colors/app_widgets.dart';
// import '../../Utilities_Screens/Currency_Service/currency_service.dart';
// import 'cart_controller.dart';
//
// class CartView extends StatelessWidget {
//   const CartView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final CartController controller = CartController.instance;
//
//     return Scaffold(
//       backgroundColor: AppColors.background(context),
//       appBar: AppBar(
//         toolbarHeight: 72,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         surfaceTintColor: Colors.transparent,
//         backgroundColor: AppColors.background(context),
//         foregroundColor: AppColors.textPrimary(context),
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const SnapKartLogo(size: 24),
//             Obx(
//               () => Text(
//                 '${'cart_title'.tr} (${controller.cartItemCount})',
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w700,
//                   color: AppColors.textPrimary(context),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           Obx(() {
//             if (controller.cartItems.isEmpty) return const SizedBox();
//             return TextButton.icon(
//               onPressed: () => _confirmClear(controller),
//               icon: const Icon(
//                 Icons.delete_outline,
//                 color: AppColors.secondary,
//                 size: 20,
//               ),
//               label: Text(
//                 'clear'.tr,
//                 style: const TextStyle(
//                   color: AppColors.secondary,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             );
//           }),
//           const SizedBox(width: 4),
//         ],
//       ),
//       body: Obx(() {
//         if (controller.cartItems.isEmpty) {
//           return _emptyState(context);
//         }
//
//         return Column(
//           children: [
//             Expanded(
//               child: ListView(
//                 padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
//                 children: [
//                   for (int i = 0; i < controller.cartItems.length; i++)
//                     _cartItemCard(
//                       controller,
//                       controller.cartItems[i],
//                       i,
//                       context,
//                     ),
//                   const SizedBox(height: 4),
//                   _orderSummary(controller, context),
//                 ],
//               ),
//             ),
//             _checkoutBar(controller, context),
//           ],
//         );
//       }),
//     );
//   }
//
//   // ── Clear dialog ──
//   void _confirmClear(CartController controller) {
//     Get.dialog(
//       AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         title: Text('cart_clear_question'.tr),
//         content: Text('all_items_removed'.tr),
//         actions: [
//           TextButton(
//             onPressed: () => Get.back(),
//             child: Text(
//               'cancel'.tr,
//               style: const TextStyle(color: Colors.grey),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               controller.clearCart();
//               Get.back();
//             },
//             style: ElevatedButton.styleFrom(
//               minimumSize: const Size(0, 44),
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//             ),
//             child: Text('clear'.tr),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ── Cart Item Card ──
//   Widget _cartItemCard(
//     CartController controller,
//     Map<String, dynamic> item,
//     int index,
//     BuildContext context,
//   ) {
//     final basePrice = (item['price'] as num? ?? 0).toDouble();
//     final qty = (item['quantity'] as int? ?? 1);
//     final name = item['title'] ?? item['name'] ?? 'Product';
//     final image = item['image'] ?? '';
//
//     final unitPrice = controller.getUnitPrice(item);
//     final itemSavings = controller.getItemSavings(item);
//     final hasDiscount = itemSavings > 0 && basePrice > 0;
//     final itemTotal = unitPrice * qty;
//     final baseTotal = basePrice * qty;
//     final discountPercent = hasDiscount
//         ? (((basePrice - unitPrice) / basePrice) * 100).round()
//         : 0;
//
//     // size / color (agar item mein save hon)
//     final List<String> details = [];
//     if ((item['size'] ?? '').toString().isNotEmpty) {
//       details.add('Size: ${item['size']}');
//     }
//     if ((item['color'] ?? '').toString().isNotEmpty) {
//       details.add('Color: ${item['color']}');
//     }
//
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: AppColors.cardBackground(context),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.05),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Product Image
//           Container(
//             width: 84,
//             height: 84,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(14),
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(14),
//               child: Image.network(
//                 image,
//                 fit: BoxFit.contain,
//                 errorBuilder: (_, __, ___) => Container(
//                   color: Colors.grey.shade100,
//                   child: const Icon(
//                     Icons.image_not_supported,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),
//
//           // Info
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // badge + delete
//                 Row(
//                   children: [
//                     if (hasDiscount) DiscountBadge('-$discountPercent%'),
//                     const Spacer(),
//                     GestureDetector(
//                       onTap: () => controller.removeFromCart(index),
//                       child: const Icon(
//                         Icons.delete_outline,
//                         color: AppColors.secondary,
//                         size: 22,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 6),
//
//                 Text(
//                   name,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     fontWeight: FontWeight.w700,
//                     fontSize: 14,
//                     height: 1.2,
//                     color: AppColors.textPrimary(context),
//                   ),
//                 ),
//
//                 if (details.isNotEmpty) ...[
//                   const SizedBox(height: 4),
//                   Text(
//                     details.join('  |  '),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontSize: 11,
//                       color: AppColors.textSecondary(context),
//                     ),
//                   ),
//                 ],
//
//                 const SizedBox(height: 10),
//
//                 // qty controls + price
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     _qtyButton(
//                       context: context,
//                       icon: Icons.remove,
//                       onTap: () => controller.updateQuantity(index, qty - 1),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 12),
//                       child: Text(
//                         '$qty',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 15,
//                           color: AppColors.textPrimary(context),
//                         ),
//                       ),
//                     ),
//                     _qtyButton(
//                       context: context,
//                       icon: Icons.add,
//                       onTap: () => controller.updateQuantity(index, qty + 1),
//                       isPrimary: true,
//                     ),
//                     const Spacer(),
//                     ValueListenableBuilder<String>(
//                       valueListenable: CurrencyService.instance.symbol,
//                       builder: (context, currency, _) {
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text(
//                               '$currency ${itemTotal.toStringAsFixed(0)}',
//                               style: const TextStyle(
//                                 color: AppColors.secondary,
//                                 fontWeight: FontWeight.w900,
//                                 fontSize: 16,
//                               ),
//                             ),
//                             if (hasDiscount)
//                               Text(
//                                 '$currency ${baseTotal.toStringAsFixed(0)}',
//                                 style: TextStyle(
//                                   color: Colors.grey.shade500,
//                                   fontSize: 11,
//                                   decoration: TextDecoration.lineThrough,
//                                 ),
//                               ),
//                           ],
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ── Quantity Button ──
//   Widget _qtyButton({
//     required BuildContext context,
//     required IconData icon,
//     required VoidCallback onTap,
//     bool isPrimary = false,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 32,
//         height: 32,
//         decoration: BoxDecoration(
//           color: isPrimary
//               ? AppColors.secondary
//               : AppColors.textPrimary(context).withValues(alpha: 0.06),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Icon(
//           icon,
//           size: 18,
//           color: isPrimary ? Colors.white : AppColors.textPrimary(context),
//         ),
//       ),
//     );
//   }
//
//   // ── Order Summary ──
//   Widget _orderSummary(CartController controller, BuildContext context) {
//     double subtotal = 0;
//     double savings = 0;
//     for (final item in controller.cartItems) {
//       final base = (item['price'] as num? ?? 0).toDouble();
//       final qty = (item['quantity'] as int? ?? 1);
//       subtotal += base * qty;
//       savings += controller.getItemSavings(item);
//     }
//     final total = controller.totalPrice;
//
//     Widget row(String label, String value, {Color? valueColor}) {
//       return Padding(
//         padding: const EdgeInsets.symmetric(vertical: 5),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: AppColors.textSecondary(context),
//               ),
//             ),
//             Text(
//               value,
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//                 color: valueColor ?? AppColors.textPrimary(context),
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//
//     return ValueListenableBuilder<String>(
//       valueListenable: CurrencyService.instance.symbol,
//       builder: (context, currency, _) {
//         return AppCard(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   const IconBox(Icons.receipt_long_outlined),
//                   const SizedBox(width: 12),
//                   Text(
//                     'Order Summary',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w800,
//                       color: AppColors.textPrimary(context),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),
//               row(
//                 'items_count'.trParams({
//                   'count': controller.cartItemCount.toString(),
//                 }),
//                 '$currency ${subtotal.toStringAsFixed(0)}',
//               ),
//               if (savings > 0)
//                 row(
//                   'Discount',
//                   '- $currency ${savings.toStringAsFixed(0)}',
//                   valueColor: AppColors.success,
//                 ),
//               row('delivery'.tr, 'free'.tr, valueColor: AppColors.success),
//               const Divider(height: 24),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Total Amount',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w800,
//                       color: AppColors.textPrimary(context),
//                     ),
//                   ),
//                   Text(
//                     '$currency ${total.toStringAsFixed(0)}',
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w900,
//                       color: AppColors.secondary,
//                     ),
//                   ),
//                 ],
//               ),
//               if (savings > 0) ...[
//                 const SizedBox(height: 4),
//                 Text(
//                   '${'you_save'.tr} $currency ${savings.toStringAsFixed(0)}',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: AppColors.textSecondary(context),
//                   ),
//                 ),
//               ],
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   // ── Bottom Checkout Button ──
//   Widget _checkoutBar(CartController controller, BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
//       decoration: BoxDecoration(
//         color: AppColors.background(context),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.05),
//             blurRadius: 12,
//             offset: const Offset(0, -4),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         top: false,
//         child: GradientButton(
//           text: 'order_checkout'.tr,
//           icon: Icons.arrow_forward,
//           onTap: () => Get.toNamed(AppRoutes.checkout),
//         ),
//       ),
//     );
//   }
//
//   // ── Empty State ──
//   Widget _emptyState(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.shopping_cart_outlined,
//             size: 80,
//             color: Colors.grey.shade300,
//           ),
//           const SizedBox(height: 16),
//           Text(
//             'cart_empty_title'.tr,
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: AppColors.textPrimary(context),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'no_item_in_cart'.tr,
//             style: TextStyle(color: AppColors.textSecondary(
//                 context)),
//           ),
//           const SizedBox(height: 24),
//           ElevatedButton.icon(
//             onPressed: () => Get.offAllNamed('/home'),
//             icon: const Icon(Icons.shopping_bag_outlined),
//             label: Text('Add to Cart'.tr),
//             style: ElevatedButton.styleFrom(
//               minimumSize: const Size(0, 48),
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../App_Routes/routes_view.dart';
import '../../Utilities_Screens/App_Colors/app_colors.dart';
import '../../Utilities_Screens/App_Colors/app_widgets.dart';
import '../../Utilities_Screens/Currency_Service/currency_service.dart';
import 'cart_controller.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  // Light grey (image box aur minus button dono ke liye same shade)
  static const Color _lightGrey = Color(0xFFF3F4F6);

  static Color _greyBg(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? Colors.white.withValues(alpha: 0.08) : _lightGrey;
  }

  @override
  Widget build(BuildContext context) {
    final CartController controller = CartController.instance;

    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: AppBar(
        toolbarHeight: 72,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.background(context),
        foregroundColor: AppColors.textPrimary(context),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SnapKartLogo(size: 24),
            Obx(
              () => Text(
                '${'cart_title'.tr} (${controller.cartItemCount})',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary(context),
                ),
              ),
            ),
          ],
        ),
        actions: [
          Obx(() {
            if (controller.cartItems.isEmpty) return const SizedBox();
            return TextButton.icon(
              onPressed: () => _confirmClear(controller),
              icon: const Icon(
                Icons.delete_outline,
                color: AppColors.secondary,
                size: 20,
              ),
              label: Text(
                'clear'.tr,
                style: const TextStyle(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }),
          const SizedBox(width: 4),
        ],
      ),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return _emptyState(context);
        }

        return Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                children: [
                  for (int i = 0; i < controller.cartItems.length; i++)
                    _cartItemCard(
                      controller,
                      controller.cartItems[i],
                      i,
                      context,
                    ),
                  const SizedBox(height: 4),
                  _orderSummary(controller, context),
                ],
              ),
            ),
            _checkoutBar(controller, context),
          ],
        );
      }),
    );
  }

  // ── Clear dialog ──
  void _confirmClear(CartController controller) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('cart_clear_question'.tr),
        content: Text('all_items_removed'.tr),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'cancel'.tr,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controller.clearCart();
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(0, 44),
              padding: const EdgeInsets.symmetric(horizontal: 20),
            ),
            child: Text('clear'.tr),
          ),
        ],
      ),
    );
  }

  // ── Product image (light grey container ke andar) ──
  Widget _productImage(BuildContext context, String url) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 84,
      height: 84,
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: _greyBg(context),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Image.network(
        url,
        fit: BoxFit.contain,
        // Light mode mein white background wali JPG images grey mein blend
        // ho jati hain. Agar images transparent PNG hain to ye 2 lines
        // hata sakte ho.
        color: isDark ? null : _lightGrey,
        colorBlendMode: isDark ? null : BlendMode.multiply,
        errorBuilder: (_, __, ___) =>
            const Icon(Icons.image_not_supported, color: Colors.grey, size: 32),
      ),
    );
  }

  // ── Cart Item Card ──
  Widget _cartItemCard(
    CartController controller,
    Map<String, dynamic> item,
    int index,
    BuildContext context,
  ) {
    final basePrice = (item['price'] as num? ?? 0).toDouble();
    final qty = (item['quantity'] as int? ?? 1);
    final name = item['title'] ?? item['name'] ?? 'Product';
    final image = (item['image'] ?? '').toString();

    final unitPrice = controller.getUnitPrice(item);
    final itemSavings = controller.getItemSavings(item);
    final hasDiscount = itemSavings > 0 && basePrice > 0;
    final itemTotal = unitPrice * qty;
    final baseTotal = basePrice * qty;
    final discountPercent = hasDiscount
        ? (((basePrice - unitPrice) / basePrice) * 100).round()
        : 0;

    // size / color (agar item mein save hon)
    final List<String> details = [];
    if ((item['size'] ?? '').toString().isNotEmpty) {
      details.add('Size: ${item['size']}');
    }
    if ((item['color'] ?? '').toString().isNotEmpty) {
      details.add('Color: ${item['color']}');
    }

    return Container(
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
          // Product Image
          _productImage(context, image),
          const SizedBox(width: 12),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // badge + delete
                Row(
                  children: [
                    if (hasDiscount) DiscountBadge('-$discountPercent%'),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => controller.removeFromCart(index),
                      child: const Icon(
                        Icons.delete_outline,
                        color: AppColors.secondary,
                        size: 22,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    height: 1.2,
                    color: AppColors.textPrimary(context),
                  ),
                ),

                if (details.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    details.join('  |  '),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary(context),
                    ),
                  ),
                ],

                const SizedBox(height: 10),

                // qty controls + price
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _qtyButton(
                      context: context,
                      icon: Icons.remove,
                      onTap: () => controller.updateQuantity(index, qty - 1),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        '$qty',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppColors.textPrimary(context),
                        ),
                      ),
                    ),
                    _qtyButton(
                      context: context,
                      icon: Icons.add,
                      onTap: () => controller.updateQuantity(index, qty + 1),
                      isPrimary: true,
                    ),
                    const Spacer(),
                    ValueListenableBuilder<String>(
                      valueListenable: CurrencyService.instance.symbol,
                      builder: (context, currency, _) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '$currency ${itemTotal.toStringAsFixed(0)}',
                              style: const TextStyle(
                                color: AppColors.secondary,
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                              ),
                            ),
                            if (hasDiscount)
                              Text(
                                '$currency ${baseTotal.toStringAsFixed(0)}',
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 11,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Quantity Button ──
  Widget _qtyButton({
    required BuildContext context,
    required IconData icon,
    required VoidCallback onTap,
    bool isPrimary = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          // Minus button ka background ab image box jaisa hi light grey hai
          color: isPrimary ? AppColors.secondary : _greyBg(context),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: 18,
          color: isPrimary ? Colors.white : AppColors.textPrimary(context),
        ),
      ),
    );
  }

  // ── Order Summary ──
  Widget _orderSummary(CartController controller, BuildContext context) {
    double subtotal = 0;
    double savings = 0;
    for (final item in controller.cartItems) {
      final base = (item['price'] as num? ?? 0).toDouble();
      final qty = (item['quantity'] as int? ?? 1);
      subtotal += base * qty;
      savings += controller.getItemSavings(item);
    }
    final total = controller.totalPrice;

    Widget row(String label, String value, {Color? valueColor}) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary(context),
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: valueColor ?? AppColors.textPrimary(context),
              ),
            ),
          ],
        ),
      );
    }

    return ValueListenableBuilder<String>(
      valueListenable: CurrencyService.instance.symbol,
      builder: (context, currency, _) {
        return AppCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const IconBox(Icons.receipt_long_outlined),
                  const SizedBox(width: 12),
                  Text(
                    'Order Summary',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              row(
                'items_count'.trParams({
                  'count': controller.cartItemCount.toString(),
                }),
                '$currency ${subtotal.toStringAsFixed(0)}',
              ),
              if (savings > 0)
                row(
                  'Discount',
                  '- $currency ${savings.toStringAsFixed(0)}',
                  valueColor: AppColors.success,
                ),
              row('delivery'.tr, 'free'.tr, valueColor: AppColors.success),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary(context),
                    ),
                  ),
                  Text(
                    '$currency ${total.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: AppColors.secondary,
                    ),
                  ),
                ],
              ),
              if (savings > 0) ...[
                const SizedBox(height: 4),
                Text(
                  '${'you_save'.tr} $currency ${savings.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary(context),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  // ── Bottom Checkout Button ──
  Widget _checkoutBar(CartController controller, BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      decoration: BoxDecoration(
        color: AppColors.background(context),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: GradientButton(
          text: 'order_checkout'.tr,
          icon: Icons.arrow_forward,
          onTap: () => Get.toNamed(AppRoutes.checkout),
        ),
      ),
    );
  }

  // ── Empty State ──
  Widget _emptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            'cart_empty_title'.tr,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary(context),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'no_item_in_cart'.tr,
            style: TextStyle(color: AppColors.textSecondary(context)),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => Get.offAllNamed('/home'),
            icon: const Icon(Icons.shopping_bag_outlined),
            label: Text('Add to Cart'.tr),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(0, 48),
              padding: const EdgeInsets.symmetric(horizontal: 24),
            ),
          ),
        ],
      ),
    );
  }
}
