// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../Utilities_Screens/App_Colors/app_colors.dart';
// import '../../Utilities_Screens/App_Colors/app_widgets.dart';
// import '../../Utilities_Screens/Currency_Service/currency_service.dart';
// import '../Cart_Screen/cart_controller.dart';
// import 'checkout_controller.dart';
//
// class CheckoutView extends StatelessWidget {
//   CheckoutView({super.key});
//
//   final CheckoutController controller = Get.put(CheckoutController());
//   final CartController cartController = CartController.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background(context),
//       appBar: AppBar(
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         surfaceTintColor: Colors.transparent,
//         backgroundColor: AppColors.background(context),
//         foregroundColor: AppColors.textPrimary(context),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Get.back(),
//         ),
//         titleSpacing: 0,
//         title: const SnapKartLogo(size: 24),
//       ),
//       body: Obx(() {
//         return SingleChildScrollView(
//           padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'checkout'.tr,
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.w900,
//                   color: AppColors.textPrimary(context),
//                 ),
//               ),
//               const SizedBox(height: 2),
//               Text(
//                 'Complete your order in a few simple steps',
//                 style: TextStyle(
//                   fontSize: 13,
//                   color: AppColors.textSecondary(context),
//                 ),
//               ),
//
//               const SizedBox(height: 14),
//               _checkoutStepper(
//                 context,
//                 controller.savedAddresses.isEmpty ? 1 : 2,
//               ),
//               const SizedBox(height: 18),
//
//               // ORDER SUMMARY (header ab card ke andar hai)
//               _orderSummaryCard(context),
//               const SizedBox(height: 20),
//
//               // DELIVERY ADDRESS
//               _sectionHeader(
//                 Icons.location_on_outlined,
//                 'delivery_address'.tr,
//                 context,
//                 color: AppColors.success,
//                 trailing: GestureDetector(
//                   onTap: () async {
//                     await Get.toNamed('/address');
//                     controller.fetchAddresses();
//                   },
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         'address_add'.tr,
//                         style: const TextStyle(
//                           color: AppColors.secondary,
//                           fontWeight: FontWeight.w700,
//                           fontSize: 13,
//                         ),
//                       ),
//                       const Icon(
//                         Icons.chevron_right,
//                         color: AppColors.secondary,
//                         size: 20,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               controller.isLoadingAddresses.value
//                   ? const Padding(
//                       padding: EdgeInsets.all(20),
//                       child: Center(
//                         child: CircularProgressIndicator(
//                           color: AppColors.secondary,
//                         ),
//                       ),
//                     )
//                   : controller.savedAddresses.isEmpty
//                   ? _noAddressCard(context)
//                   : _addressList(context),
//               const SizedBox(height: 20),
//
//               // PAYMENT METHOD
//               _sectionHeader(
//                 Icons.credit_card_outlined,
//                 'payment_method'.tr,
//                 context,
//                 color: AppColors.success,
//               ),
//               _paymentMethodList(context),
//             ],
//           ),
//         );
//       }),
//       bottomNavigationBar: _placeOrderBar(context),
//     );
//   }
//
//   // ── Step indicator (Review > Address > Payment > Confirm) ──
//   Widget _checkoutStepper(BuildContext context, int current) {
//     final steps = [
//       {'label': 'Review', 'icon': Icons.shopping_cart_outlined},
//       {'label': 'Address', 'icon': Icons.location_on_outlined},
//       {'label': 'Payment', 'icon': Icons.credit_card_outlined},
//       {'label': 'Confirm', 'icon': Icons.check_rounded},
//     ];
//
//     Widget stepItem(int i) {
//       final bool done = i < current;
//       final bool active = i == current;
//       final Color color = (done || active)
//           ? AppColors.secondary
//           : Colors.grey.shade400;
//
//       return SizedBox(
//         width: 60,
//         child: Column(
//           children: [
//             Container(
//               width: 44,
//               height: 44,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: done
//                     ? AppColors.secondary
//                     : (active
//                           ? AppColors.orangeSoft(context)
//                           : AppColors.cardBackground(context)),
//                 border: Border.all(color: color, width: 1.5),
//               ),
//               child: Icon(
//                 done ? Icons.check_rounded : steps[i]['icon'] as IconData,
//                 size: 20,
//                 color: done ? Colors.white : color,
//               ),
//             ),
//             const SizedBox(height: 6),
//             Text(
//               steps[i]['label'] as String,
//               maxLines: 1,
//               style: TextStyle(
//                 fontSize: 11,
//                 fontWeight: (done || active)
//                     ? FontWeight.w700
//                     : FontWeight.w500,
//                 color: (done || active)
//                     ? AppColors.secondary
//                     : AppColors.textSecondary(context),
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//
//     Widget connector(int i) {
//       final bool filled = i < current;
//       return Expanded(
//         child: Padding(
//           padding: const EdgeInsets.only(top: 21), // circle ke beech mein
//           child: Container(
//             height: 2,
//             color: filled ? AppColors.secondary : Colors.grey.shade300,
//           ),
//         ),
//       );
//     }
//
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         for (int i = 0; i < steps.length; i++) ...[
//           stepItem(i),
//           if (i != steps.length - 1) connector(i),
//         ],
//       ],
//     );
//   }
//
//   // ── Section header ──
//   Widget _sectionHeader(
//     IconData icon,
//     String title,
//     BuildContext context, {
//     Color color = AppColors.secondary,
//     Widget? trailing,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: Row(
//         children: [
//           IconBox(icon, color: color),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Text(
//               title,
//               style: TextStyle(
//                 fontSize: 17,
//                 fontWeight: FontWeight.w800,
//                 color: AppColors.textPrimary(context),
//               ),
//             ),
//           ),
//           if (trailing != null) trailing,
//         ],
//       ),
//     );
//   }
//
//   // ── Radio circle ──
//   Widget _radio(bool selected) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 200),
//       width: 22,
//       height: 22,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         border: Border.all(
//           color: selected ? AppColors.secondary : Colors.grey.shade400,
//           width: 2,
//         ),
//       ),
//       child: selected
//           ? Center(
//               child: Container(
//                 width: 10,
//                 height: 10,
//                 decoration: const BoxDecoration(
//                   color: AppColors.secondary,
//                   shape: BoxShape.circle,
//                 ),
//               ),
//             )
//           : null,
//     );
//   }
//
//   // ── Order summary (header + items + totals, sab ek card mein) ──
//   Widget _orderSummaryCard(BuildContext context) {
//     return AppCard(
//       padding: const EdgeInsets.all(14),
//       child: ValueListenableBuilder<String>(
//         valueListenable: CurrencyService.instance.symbol,
//         builder: (context, currency, _) {
//           return Obx(() {
//             final bool buyNow = controller.isBuyNow.value;
//
//             final List<Map<String, dynamic>> items = buyNow
//                 ? [
//                     {
//                       'name': controller.buyNowProduct?.title ?? '',
//                       'image': controller.buyNowProduct?.image ?? '',
//                       'price': controller.buyNowPrice,
//                       'quantity': controller.buyNowQuantity,
//                       'size': controller.buyNowSize,
//                     },
//                   ]
//                 : cartController.cartItems.toList();
//
//             final total = controller.displayTotal;
//             final dividerColor = AppColors.textPrimary(
//               context,
//             ).withValues(alpha: 0.08);
//
//             return Column(
//               children: [
//                 // Header: icon + title + "1 Item"
//                 Row(
//                   children: [
//                     const IconBox(
//                       Icons.shopping_cart_outlined,
//                       color: AppColors.secondary,
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: Text(
//                         'order_summary'.tr,
//                         style: TextStyle(
//                           fontSize: 17,
//                           fontWeight: FontWeight.w800,
//                           color: AppColors.textPrimary(context),
//                         ),
//                       ),
//                     ),
//                     Text(
//                       items.length == 1 ? '1 Item' : '${items.length} Items',
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: AppColors.textSecondary(context),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Divider(height: 22, color: dividerColor),
//
//                 // Items
//                 for (int i = 0; i < items.length; i++) ...[
//                   _summaryItem(context, items[i], currency, buyNow),
//                   if (i != items.length - 1)
//                     Divider(height: 18, color: dividerColor),
//                 ],
//
//                 Divider(height: 22, color: dividerColor),
//
//                 // Totals
//                 _priceRow(
//                   context,
//                   'Item Total',
//                   '$currency ${total.toStringAsFixed(0)}',
//                 ),
//                 const SizedBox(height: 6),
//                 _priceRow(context, 'Delivery Fee', '$currency 0'),
//                 Divider(height: 22, color: dividerColor),
//                 _priceRow(
//                   context,
//                   'Total',
//                   '$currency ${total.toStringAsFixed(0)}',
//                   isTotal: true,
//                   labelNote: ' (Incl. VAT)',
//                 ),
//               ],
//             );
//           });
//         },
//       ),
//     );
//   }
//
//   Widget _summaryItem(
//     BuildContext context,
//     Map<String, dynamic> item,
//     String currency,
//     bool buyNow,
//   ) {
//     final qty = (item['quantity'] as int? ?? 1);
//     final unitPrice = buyNow
//         ? (item['price'] as num? ?? 0).toDouble()
//         : cartController.getUnitPrice(item);
//     // Asli (cut) price: cart mein 'price' base hai, Buy Now mein optional 'basePrice'
//     final basePrice = ((item['basePrice'] ?? item['price']) as num? ?? 0)
//         .toDouble();
//     final hasDiscount = basePrice > unitPrice;
//
//     final name = item['name'] ?? item['title'] ?? '';
//     final size = item['size'];
//
//     return Row(
//       children: [
//         Container(
//           width: 76,
//           height: 76,
//           decoration: BoxDecoration(
//             color: Colors.grey.shade100,
//             borderRadius: BorderRadius.circular(14),
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(14),
//             child: Image.network(
//               (item['image'] ?? '').toString(),
//               fit: BoxFit.contain,
//               errorBuilder: (_, __, ___) =>
//                   const Icon(Icons.image_not_supported, color: Colors.grey),
//             ),
//           ),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 name.toString(),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w700,
//                   fontSize: 15,
//                   color: AppColors.textPrimary(context),
//                 ),
//               ),
//               const SizedBox(height: 6),
//               Text(
//                 size != null && size.toString().isNotEmpty
//                     ? 'Size: $size   |   Qty: $qty'
//                     : 'Qty: $qty',
//                 style: TextStyle(
//                   fontSize: 13,
//                   color: AppColors.textSecondary(context),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(width: 8),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Text(
//               '$currency ${(unitPrice * qty).toStringAsFixed(0)}',
//               style: const TextStyle(
//                 fontWeight: FontWeight.w900,
//                 color: AppColors.secondary,
//                 fontSize: 16,
//               ),
//             ),
//             if (hasDiscount) ...[
//               const SizedBox(height: 4),
//               Text(
//                 '$currency ${(basePrice * qty).toStringAsFixed(0)}',
//                 style: TextStyle(
//                   fontSize: 13,
//                   decoration: TextDecoration.lineThrough,
//                   color: AppColors.textSecondary(context),
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _priceRow(
//     BuildContext context,
//     String label,
//     String value, {
//     bool isTotal = false,
//     Color? valueColor,
//     String? labelNote,
//   }) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text.rich(
//           TextSpan(
//             text: label,
//             style: TextStyle(
//               fontSize: isTotal ? 18 : 14,
//               fontWeight: isTotal ? FontWeight.w800 : FontWeight.normal,
//               color: isTotal
//                   ? AppColors.textPrimary(context)
//                   : AppColors.textSecondary(context),
//             ),
//             children: [
//               if (labelNote != null)
//                 TextSpan(
//                   text: labelNote,
//                   style: TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.textSecondary(context),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: isTotal ? 20 : 14,
//             fontWeight: isTotal ? FontWeight.w900 : FontWeight.w600,
//             color: isTotal
//                 ? AppColors.secondary
//                 : (valueColor ?? AppColors.textPrimary(context)),
//           ),
//         ),
//       ],
//     );
//   }
//
//   // ── Address ──
//   Widget _noAddressCard(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: AppCard(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             Icon(Icons.location_off, size: 40, color: Colors.grey.shade400),
//             const SizedBox(height: 8),
//             Text(
//               'no_address_saved'.tr,
//               style: TextStyle(color: AppColors.textSecondary(context)),
//             ),
//             const SizedBox(height: 12),
//             ElevatedButton.icon(
//               onPressed: () async {
//                 await Get.toNamed('/address');
//                 controller.fetchAddresses();
//               },
//               icon: const Icon(Icons.add),
//               label: Text('address_add'.tr),
//               style: ElevatedButton.styleFrom(
//                 minimumSize: const Size(0, 46),
//                 padding: const EdgeInsets.symmetric(horizontal: 24),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _addressList(BuildContext context) {
//     return Column(
//       children: List.generate(controller.savedAddresses.length, (index) {
//         final addr = controller.savedAddresses[index];
//
//         return Obx(() {
//           final selected = controller.selectedAddressIndex.value == index;
//
//           return GestureDetector(
//             onTap: () => controller.selectAddress(index),
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 200),
//               margin: const EdgeInsets.only(bottom: 10),
//               padding: const EdgeInsets.all(14),
//               decoration: BoxDecoration(
//                 color: selected
//                     ? AppColors.success.withValues(alpha: 0.08)
//                     : AppColors.cardBackground(context),
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(
//                   color: selected ? AppColors.success : Colors.transparent,
//                   width: 1.5,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withValues(alpha: 0.05),
//                     blurRadius: 12,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   const IconBox(Icons.home_rounded, color: AppColors.success),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           addr['name'] ?? 'Address ${index + 1}',
//                           style: TextStyle(
//                             fontWeight: FontWeight.w800,
//                             fontSize: 15,
//                             color: AppColors.textPrimary(context),
//                           ),
//                         ),
//                         const SizedBox(height: 3),
//                         Text(
//                           '${addr['street'] ?? ''}, ${addr['city'] ?? ''}, ${addr['province'] ?? ''}',
//                           style: TextStyle(
//                             fontSize: 13,
//                             height: 1.3,
//                             color: AppColors.textSecondary(context),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(
//                       Icons.edit_outlined,
//                       color: AppColors.secondary,
//                       size: 20,
//                     ),
//                     onPressed: () async {
//                       await Get.toNamed('/address', arguments: addr);
//                       controller.fetchAddresses();
//                     },
//                   ),
//                   _radio(selected),
//                 ],
//               ),
//             ),
//           );
//         });
//       }),
//     );
//   }
//
//   // ── Payment ──
//   IconData _paymentIcon(String name) {
//     switch (name) {
//       case 'Cash on Delivery':
//         return Icons.payments_outlined;
//       case 'Credit/Debit Card':
//         return Icons.credit_card;
//       case 'JazzCash / EasyPaisa':
//         return Icons.phone_android;
//       case 'Bank Transfer':
//         return Icons.account_balance_outlined;
//       default:
//         return Icons.payment;
//     }
//   }
//
//   String _paymentSubtitle(String name) {
//     switch (name) {
//       case 'Cash on Delivery':
//         return 'Pay when you receive your order';
//       case 'Credit/Debit Card':
//         return 'Pay securely with your card';
//       case 'JazzCash / EasyPaisa':
//         return 'Pay via mobile wallet';
//       case 'Bank Transfer':
//         return 'Direct bank transfer';
//       default:
//         return '';
//     }
//   }
//
//   Widget _paymentMethodList(BuildContext context) {
//     return Column(
//       children: controller.paymentMethods.map((method) {
//         final name = method['name'] as String;
//
//         return Obx(() {
//           final selected = controller.selectedPayment.value == name;
//
//           return GestureDetector(
//             onTap: () => controller.selectPayment(name),
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 200),
//               margin: const EdgeInsets.only(bottom: 10),
//               padding: const EdgeInsets.all(14),
//               decoration: BoxDecoration(
//                 color: selected
//                     ? AppColors.orangeSoft(context)
//                     : AppColors.cardBackground(context),
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(
//                   color: selected ? AppColors.secondary : Colors.transparent,
//                   width: 1.5,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withValues(alpha: 0.05),
//                     blurRadius: 12,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   _radio(selected),
//                   const SizedBox(width: 12),
//                   IconBox(
//                     _paymentIcon(name),
//                     color: selected ? AppColors.secondary : AppColors.success,
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           name,
//                           style: TextStyle(
//                             fontWeight: FontWeight.w700,
//                             fontSize: 15,
//                             color: AppColors.textPrimary(context),
//                           ),
//                         ),
//                         const SizedBox(height: 2),
//                         Text(
//                           _paymentSubtitle(name),
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: AppColors.textSecondary(context),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//       }).toList(),
//     );
//   }
//
//   // ── Place Order bar (neeche fixed) ──
//   Widget _placeOrderBar(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
//       decoration: BoxDecoration(
//         color: AppColors.background(context),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.06),
//             blurRadius: 12,
//             offset: const Offset(0, -4),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         top: false,
//         child: Obx(() {
//           final loading = controller.isPlacingOrder.value;
//           final total = controller.displayTotal;
//
//           return ValueListenableBuilder<String>(
//             valueListenable: CurrencyService.instance.symbol,
//             builder: (context, currency, _) {
//               return InkWell(
//                 onTap: loading
//                     ? null
//                     : () => controller.placeOrder(
//                         controller.getOrderItems(),
//                         controller.displayTotal,
//                       ),
//                 borderRadius: BorderRadius.circular(16),
//                 child: Container(
//                   height: 54,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: loading
//                           ? [Colors.grey.shade400, Colors.grey.shade500]
//                           : AppColors.secondaryGradient,
//                     ),
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: AppColors.secondary.withValues(alpha: 0.3),
//                         blurRadius: 12,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: loading
//                       ? const SizedBox(
//                           width: 24,
//                           height: 24,
//                           child: CircularProgressIndicator(
//                             color: Colors.white,
//                             strokeWidth: 2.5,
//                           ),
//                         )
//                       : Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Flexible(
//                               child: Text(
//                                 '${'order_place'.tr}  •  $currency ${total.toStringAsFixed(0)}',
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 8),
//                             const Icon(
//                               Icons.arrow_forward,
//                               color: Colors.white,
//                               size: 20,
//                             ),
//                           ],
//                         ),
//                 ),
//               );
//             },
//           );
//         }),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../Utilities_Screens/App_Colors/app_colors.dart';
// import '../../Utilities_Screens/App_Colors/app_widgets.dart';
// import '../../Utilities_Screens/Currency_Service/currency_service.dart';
// import '../Cart_Screen/cart_controller.dart';
// import 'checkout_controller.dart';
//
// class CheckoutView extends StatelessWidget {
//   CheckoutView({super.key});
//
//   final CheckoutController controller = Get.put(CheckoutController());
//   final CartController cartController = CartController.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background(context),
//       appBar: AppBar(
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         surfaceTintColor: Colors.transparent,
//         backgroundColor: AppColors.background(context),
//         foregroundColor: AppColors.textPrimary(context),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Get.back(),
//         ),
//         titleSpacing: 0,
//         title: const SnapKartLogo(size: 24),
//       ),
//       body: Obx(() {
//         return SingleChildScrollView(
//           padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'checkout'.tr,
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.w900,
//                   color: AppColors.textPrimary(context),
//                 ),
//               ),
//               const SizedBox(height: 2),
//               Text(
//                 'Complete your order in a few simple steps',
//                 style: TextStyle(
//                   fontSize: 13,
//                   color: AppColors.textSecondary(context),
//                 ),
//               ),
//
//               const SizedBox(height: 14),
//               _checkoutStepper(
//                 context,
//                 controller.savedAddresses.isEmpty ? 1 : 2,
//               ),
//               const SizedBox(height: 18),
//
//               // ORDER SUMMARY (header ab card ke andar hai)
//               _orderSummaryCard(context),
//               const SizedBox(height: 20),
//
//               // DELIVERY ADDRESS
//               _sectionHeader(
//                 Icons.location_on_outlined,
//                 'delivery_address'.tr,
//                 context,
//                 color: AppColors.success,
//                 trailing: GestureDetector(
//                   onTap: () async {
//                     await Get.toNamed('/address');
//                     controller.fetchAddresses();
//                   },
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         'address_add'.tr,
//                         style: const TextStyle(
//                           color: AppColors.secondary,
//                           fontWeight: FontWeight.w700,
//                           fontSize: 13,
//                         ),
//                       ),
//                       const Icon(
//                         Icons.chevron_right,
//                         color: AppColors.secondary,
//                         size: 20,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               controller.isLoadingAddresses.value
//                   ? const Padding(
//                       padding: EdgeInsets.all(20),
//                       child: Center(
//                         child: CircularProgressIndicator(
//                           color: AppColors.secondary,
//                         ),
//                       ),
//                     )
//                   : controller.savedAddresses.isEmpty
//                   ? _noAddressCard(context)
//                   : _addressList(context),
//               const SizedBox(height: 20),
//
//               // PAYMENT METHOD
//               _sectionHeader(
//                 Icons.credit_card_outlined,
//                 'payment_method'.tr,
//                 context,
//                 color: AppColors.success,
//               ),
//               _paymentMethodList(context),
//             ],
//           ),
//         );
//       }),
//       bottomNavigationBar: _placeOrderBar(context),
//     );
//   }
//
//   // ── Step indicator (Review > Address > Payment > Confirm) ──
//   Widget _checkoutStepper(BuildContext context, int current) {
//     final steps = [
//       {'label': 'Review', 'icon': Icons.shopping_cart_outlined},
//       {'label': 'Address', 'icon': Icons.location_on_outlined},
//       {'label': 'Payment', 'icon': Icons.credit_card_outlined},
//       {'label': 'Confirm', 'icon': Icons.check_rounded},
//     ];
//
//     Widget stepItem(int i) {
//       final bool done = i < current;
//       final bool active = i == current;
//       final Color color = (done || active)
//           ? AppColors.secondary
//           : Colors.grey.shade400;
//
//       return SizedBox(
//         width: 60,
//         child: Column(
//           children: [
//             Container(
//               width: 44,
//               height: 44,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: done
//                     ? AppColors.secondary
//                     : (active
//                           ? AppColors.orangeSoft(context)
//                           : AppColors.cardBackground(context)),
//                 border: Border.all(color: color, width: 1.5),
//               ),
//               child: Icon(
//                 done ? Icons.check_rounded : steps[i]['icon'] as IconData,
//                 size: 20,
//                 color: done ? Colors.white : color,
//               ),
//             ),
//             const SizedBox(height: 6),
//             Text(
//               steps[i]['label'] as String,
//               maxLines: 1,
//               style: TextStyle(
//                 fontSize: 11,
//                 fontWeight: (done || active)
//                     ? FontWeight.w700
//                     : FontWeight.w500,
//                 color: (done || active)
//                     ? AppColors.secondary
//                     : AppColors.textSecondary(context),
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//
//     Widget connector(int i) {
//       final bool filled = i < current;
//       return Expanded(
//         child: Padding(
//           padding: const EdgeInsets.only(top: 21), // circle ke beech mein
//           child: Container(
//             height: 2,
//             color: filled ? AppColors.secondary : Colors.grey.shade300,
//           ),
//         ),
//       );
//     }
//
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         for (int i = 0; i < steps.length; i++) ...[
//           stepItem(i),
//           if (i != steps.length - 1) connector(i),
//         ],
//       ],
//     );
//   }
//
//   // ── Section header ──
//   Widget _sectionHeader(
//     IconData icon,
//     String title,
//     BuildContext context, {
//     Color color = AppColors.secondary,
//     Widget? trailing,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: Row(
//         children: [
//           IconBox(icon, color: color),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Text(
//               title,
//               style: TextStyle(
//                 fontSize: 17,
//                 fontWeight: FontWeight.w800,
//                 color: AppColors.textPrimary(context),
//               ),
//             ),
//           ),
//           if (trailing != null) trailing,
//         ],
//       ),
//     );
//   }
//
//   // ── Radio circle ──
//   Widget _radio(bool selected) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 200),
//       width: 22,
//       height: 22,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         border: Border.all(
//           color: selected ? AppColors.secondary : Colors.grey.shade400,
//           width: 2,
//         ),
//       ),
//       child: selected
//           ? Center(
//               child: Container(
//                 width: 10,
//                 height: 10,
//                 decoration: const BoxDecoration(
//                   color: AppColors.secondary,
//                   shape: BoxShape.circle,
//                 ),
//               ),
//             )
//           : null,
//     );
//   }
//
//   // ── Order summary (header + items + totals, sab ek card mein) ──
//   Widget _orderSummaryCard(BuildContext context) {
//     return AppCard(
//       padding: const EdgeInsets.all(14),
//       child: ValueListenableBuilder<String>(
//         valueListenable: CurrencyService.instance.symbol,
//         builder: (context, currency, _) {
//           return Obx(() {
//             final bool buyNow = controller.isBuyNow.value;
//
//             final List<Map<String, dynamic>> items = buyNow
//                 ? [
//                     {
//                       'name': controller.buyNowProduct?.title ?? '',
//                       'image': controller.buyNowProduct?.image ?? '',
//                       'price': controller.buyNowPrice,
//                       'quantity': controller.buyNowQuantity,
//                       'size': controller.buyNowSize,
//                       'color': controller.buyNowColor,
//                     },
//                   ]
//                 : cartController.cartItems.toList();
//
//             final total = controller.displayTotal;
//             final dividerColor = AppColors.textPrimary(
//               context,
//             ).withValues(alpha: 0.08);
//
//             return Column(
//               children: [
//                 // Header: icon + title + "1 Item"
//                 Row(
//                   children: [
//                     const IconBox(
//                       Icons.shopping_cart_outlined,
//                       color: AppColors.secondary,
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: Text(
//                         'order_summary'.tr,
//                         style: TextStyle(
//                           fontSize: 17,
//                           fontWeight: FontWeight.w800,
//                           color: AppColors.textPrimary(context),
//                         ),
//                       ),
//                     ),
//                     Text(
//                       items.length == 1 ? '1 Item' : '${items.length} Items',
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: AppColors.textSecondary(context),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Divider(height: 22, color: dividerColor),
//
//                 // Items
//                 for (int i = 0; i < items.length; i++) ...[
//                   _summaryItem(context, items[i], currency, buyNow),
//                   if (i != items.length - 1)
//                     Divider(height: 18, color: dividerColor),
//                 ],
//
//                 Divider(height: 22, color: dividerColor),
//
//                 // Totals
//                 _priceRow(
//                   context,
//                   'Item Total',
//                   '$currency ${total.toStringAsFixed(0)}',
//                 ),
//                 const SizedBox(height: 6),
//                 _priceRow(context, 'Delivery Fee', '$currency 0'),
//                 Divider(height: 22, color: dividerColor),
//                 _priceRow(
//                   context,
//                   'Total',
//                   '$currency ${total.toStringAsFixed(0)}',
//                   isTotal: true,
//                   labelNote: ' (Incl. VAT)',
//                 ),
//               ],
//             );
//           });
//         },
//       ),
//     );
//   }
//
//   Widget _summaryItem(
//     BuildContext context,
//     Map<String, dynamic> item,
//     String currency,
//     bool buyNow,
//   ) {
//     final qty = (item['quantity'] as int? ?? 1);
//     final unitPrice = buyNow
//         ? (item['price'] as num? ?? 0).toDouble()
//         : cartController.getUnitPrice(item);
//     // Asli (cut) price: cart mein 'price' base hai, Buy Now mein optional 'basePrice'
//     final basePrice = ((item['basePrice'] ?? item['price']) as num? ?? 0)
//         .toDouble();
//     final hasDiscount = basePrice > unitPrice;
//
//     final name = item['name'] ?? item['title'] ?? '';
//     final size = item['size'];
//     final color = item['color'];
//     final details = <String>[
//       if (color != null && color.toString().isNotEmpty) 'Color: $color',
//       if (size != null && size.toString().isNotEmpty) 'Size: $size',
//       'Qty: $qty',
//     ].join('   |   ');
//
//     return Row(
//       children: [
//         Container(
//           width: 76,
//           height: 76,
//           decoration: BoxDecoration(
//             color: Colors.grey.shade100,
//             borderRadius: BorderRadius.circular(14),
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(14),
//             child: Image.network(
//               (item['image'] ?? '').toString(),
//               fit: BoxFit.contain,
//               errorBuilder: (_, __, ___) =>
//                   const Icon(Icons.image_not_supported, color: Colors.grey),
//             ),
//           ),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 name.toString(),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w700,
//                   fontSize: 15,
//                   color: AppColors.textPrimary(context),
//                 ),
//               ),
//               const SizedBox(height: 6),
//               Text(
//                 details,
//                 style: TextStyle(
//                   fontSize: 13,
//                   color: AppColors.textSecondary(context),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(width: 8),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Text(
//               '$currency ${(unitPrice * qty).toStringAsFixed(0)}',
//               style: const TextStyle(
//                 fontWeight: FontWeight.w900,
//                 color: AppColors.secondary,
//                 fontSize: 16,
//               ),
//             ),
//             if (hasDiscount) ...[
//               const SizedBox(height: 4),
//               Text(
//                 '$currency ${(basePrice * qty).toStringAsFixed(0)}',
//                 style: TextStyle(
//                   fontSize: 13,
//                   decoration: TextDecoration.lineThrough,
//                   color: AppColors.textSecondary(context),
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _priceRow(
//     BuildContext context,
//     String label,
//     String value, {
//     bool isTotal = false,
//     Color? valueColor,
//     String? labelNote,
//   }) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text.rich(
//           TextSpan(
//             text: label,
//             style: TextStyle(
//               fontSize: isTotal ? 18 : 14,
//               fontWeight: isTotal ? FontWeight.w800 : FontWeight.normal,
//               color: isTotal
//                   ? AppColors.textPrimary(context)
//                   : AppColors.textSecondary(context),
//             ),
//             children: [
//               if (labelNote != null)
//                 TextSpan(
//                   text: labelNote,
//                   style: TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.textSecondary(context),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: isTotal ? 20 : 14,
//             fontWeight: isTotal ? FontWeight.w900 : FontWeight.w600,
//             color: isTotal
//                 ? AppColors.secondary
//                 : (valueColor ?? AppColors.textPrimary(context)),
//           ),
//         ),
//       ],
//     );
//   }
//
//   // ── Address ──
//   Widget _noAddressCard(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: AppCard(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             Icon(Icons.location_off, size: 40, color: Colors.grey.shade400),
//             const SizedBox(height: 8),
//             Text(
//               'no_address_saved'.tr,
//               style: TextStyle(color: AppColors.textSecondary(context)),
//             ),
//             const SizedBox(height: 12),
//             ElevatedButton.icon(
//               onPressed: () async {
//                 await Get.toNamed('/address');
//                 controller.fetchAddresses();
//               },
//               icon: const Icon(Icons.add),
//               label: Text('address_add'.tr),
//               style: ElevatedButton.styleFrom(
//                 minimumSize: const Size(0, 46),
//                 padding: const EdgeInsets.symmetric(horizontal: 24),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _addressList(BuildContext context) {
//     return Column(
//       children: List.generate(controller.savedAddresses.length, (index) {
//         final addr = controller.savedAddresses[index];
//
//         return Obx(() {
//           final selected = controller.selectedAddressIndex.value == index;
//
//           return GestureDetector(
//             onTap: () => controller.selectAddress(index),
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 200),
//               margin: const EdgeInsets.only(bottom: 10),
//               padding: const EdgeInsets.all(14),
//               decoration: BoxDecoration(
//                 color: selected
//                     ? AppColors.success.withValues(alpha: 0.08)
//                     : AppColors.cardBackground(context),
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(
//                   color: selected ? AppColors.success : Colors.transparent,
//                   width: 1.5,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withValues(alpha: 0.05),
//                     blurRadius: 12,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   const IconBox(Icons.home_rounded, color: AppColors.success),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           addr['name'] ?? 'Address ${index + 1}',
//                           style: TextStyle(
//                             fontWeight: FontWeight.w800,
//                             fontSize: 15,
//                             color: AppColors.textPrimary(context),
//                           ),
//                         ),
//                         const SizedBox(height: 3),
//                         Text(
//                           '${addr['street'] ?? ''}, ${addr['city'] ?? ''}, ${addr['province'] ?? ''}',
//                           style: TextStyle(
//                             fontSize: 13,
//                             height: 1.3,
//                             color: AppColors.textSecondary(context),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(
//                       Icons.edit_outlined,
//                       color: AppColors.secondary,
//                       size: 20,
//                     ),
//                     onPressed: () async {
//                       await Get.toNamed('/address', arguments: addr);
//                       controller.fetchAddresses();
//                     },
//                   ),
//                   _radio(selected),
//                 ],
//               ),
//             ),
//           );
//         });
//       }),
//     );
//   }
//
//   // ── Payment ──
//   IconData _paymentIcon(String name) {
//     switch (name) {
//       case 'Cash on Delivery':
//         return Icons.payments_outlined;
//       case 'Credit/Debit Card':
//         return Icons.credit_card;
//       case 'JazzCash / EasyPaisa':
//         return Icons.phone_android;
//       case 'Bank Transfer':
//         return Icons.account_balance_outlined;
//       default:
//         return Icons.payment;
//     }
//   }
//
//   String _paymentSubtitle(String name) {
//     switch (name) {
//       case 'Cash on Delivery':
//         return 'Pay when you receive your order';
//       case 'Credit/Debit Card':
//         return 'Pay securely with your card';
//       case 'JazzCash / EasyPaisa':
//         return 'Pay via mobile wallet';
//       case 'Bank Transfer':
//         return 'Direct bank transfer';
//       default:
//         return '';
//     }
//   }
//
//   Widget _paymentMethodList(BuildContext context) {
//     return Column(
//       children: controller.paymentMethods.map((method) {
//         final name = method['name'] as String;
//
//         return Obx(() {
//           final selected = controller.selectedPayment.value == name;
//
//           return GestureDetector(
//             onTap: () => controller.selectPayment(name),
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 200),
//               margin: const EdgeInsets.only(bottom: 10),
//               padding: const EdgeInsets.all(14),
//               decoration: BoxDecoration(
//                 color: selected
//                     ? AppColors.orangeSoft(context)
//                     : AppColors.cardBackground(context),
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(
//                   color: selected ? AppColors.secondary : Colors.transparent,
//                   width: 1.5,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withValues(alpha: 0.05),
//                     blurRadius: 12,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   _radio(selected),
//                   const SizedBox(width: 12),
//                   IconBox(
//                     _paymentIcon(name),
//                     color: selected ? AppColors.secondary : AppColors.success,
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           name,
//                           style: TextStyle(
//                             fontWeight: FontWeight.w700,
//                             fontSize: 15,
//                             color: AppColors.textPrimary(context),
//                           ),
//                         ),
//                         const SizedBox(height: 2),
//                         Text(
//                           _paymentSubtitle(name),
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: AppColors.textSecondary(context),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//       }).toList(),
//     );
//   }
//
//   // ── Place Order bar (neeche fixed) ──
//   Widget _placeOrderBar(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
//       decoration: BoxDecoration(
//         color: AppColors.background(context),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.06),
//             blurRadius: 12,
//             offset: const Offset(0, -4),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         top: false,
//         child: Obx(() {
//           final loading = controller.isPlacingOrder.value;
//           final total = controller.displayTotal;
//
//           return ValueListenableBuilder<String>(
//             valueListenable: CurrencyService.instance.symbol,
//             builder: (context, currency, _) {
//               return InkWell(
//                 onTap: loading
//                     ? null
//                     : () => controller.placeOrder(
//                         controller.getOrderItems(),
//                         controller.displayTotal,
//                       ),
//                 borderRadius: BorderRadius.circular(16),
//                 child: Container(
//                   height: 54,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: loading
//                           ? [Colors.grey.shade400, Colors.grey.shade500]
//                           : AppColors.secondaryGradient,
//                     ),
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: AppColors.secondary.withValues(alpha: 0.3),
//                         blurRadius: 12,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: loading
//                       ? const SizedBox(
//                           width: 24,
//                           height: 24,
//                           child: CircularProgressIndicator(
//                             color: Colors.white,
//                             strokeWidth: 2.5,
//                           ),
//                         )
//                       : Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Flexible(
//                               child: Text(
//                                 '${'order_place'.tr}  •  $currency ${total.toStringAsFixed(0)}',
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 8),
//                             const Icon(
//                               Icons.arrow_forward,
//                               color: Colors.white,
//                               size: 20,
//                             ),
//                           ],
//                         ),
//                 ),
//               );
//             },
//           );
//         }),
//       ),
//     );
//   }
// }










import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utilities_Screens/App_Colors/app_colors.dart';
import '../../Utilities_Screens/App_Colors/app_widgets.dart';
import '../../Utilities_Screens/Currency_Service/currency_service.dart';
import '../Cart_Screen/cart_controller.dart';
import 'checkout_controller.dart';

class CheckoutView extends StatelessWidget {
  CheckoutView({super.key});

  final CheckoutController controller = Get.put(CheckoutController());
  final CartController cartController = CartController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.background(context),
        foregroundColor: AppColors.textPrimary(context),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        titleSpacing: 0,
        title: const SnapKartLogo(size: 24),
      ),
      body: Obx(() {
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'checkout'.tr,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary(context),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Complete your order in a few simple steps',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary(context),
                ),
              ),

              const SizedBox(height: 14),
              _checkoutStepper(
                context,
                controller.isPlacingOrder.value
                    ? 4 // Place Order dabaya -> sab steps done, Confirm bhi orange
                    : (controller.savedAddresses.isEmpty ||
                    !controller.isAddressSelected.value)
                    ? 1
                    : (controller.isPaymentSelected.value ? 3 : 2),
              ),
              const SizedBox(height: 18),

              // ORDER SUMMARY (header ab card ke andar hai)
              _orderSummaryCard(context),
              const SizedBox(height: 20),

              // DELIVERY ADDRESS
              _sectionHeader(
                Icons.location_on_outlined,
                'delivery_address'.tr,
                context,
                color: AppColors.success,
                trailing: GestureDetector(
                  onTap: () => controller.openAddressScreen(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'address_add'.tr,
                        style: const TextStyle(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right,
                        color: AppColors.secondary,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              controller.isLoadingAddresses.value
                  ? const Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.secondary,
                  ),
                ),
              )
                  : controller.savedAddresses.isEmpty
                  ? _noAddressCard(context)
                  : _addressList(context),
              const SizedBox(height: 20),

              // PAYMENT METHOD
              _sectionHeader(
                Icons.credit_card_outlined,
                'payment_method'.tr,
                context,
                color: AppColors.success,
              ),
              _paymentMethodList(context),
            ],
          ),
        );
      }),
      bottomNavigationBar: _placeOrderBar(context),
    );
  }

  // ── Step indicator (Review > Address > Payment > Confirm) ──
  Widget _checkoutStepper(BuildContext context, int current) {
    final steps = [
      {'label': 'Review', 'icon': Icons.shopping_cart_outlined},
      {'label': 'Address', 'icon': Icons.location_on_outlined},
      {'label': 'Payment', 'icon': Icons.credit_card_outlined},
      {'label': 'Confirm', 'icon': Icons.check_rounded},
    ];

    Widget stepItem(int i) {
      final bool done = i < current;
      final bool active = i == current;
      final Color color = (done || active)
          ? AppColors.secondary
          : Colors.grey.shade400;

      return SizedBox(
        width: 60,
        child: Column(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: done
                    ? AppColors.secondary
                    : (active
                    ? AppColors.orangeSoft(context)
                    : AppColors.cardBackground(context)),
                border: Border.all(color: color, width: 1.5),
              ),
              child: Icon(
                done ? Icons.check_rounded : steps[i]['icon'] as IconData,
                size: 20,
                color: done ? Colors.white : color,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              steps[i]['label'] as String,
              maxLines: 1,
              style: TextStyle(
                fontSize: 11,
                fontWeight: (done || active)
                    ? FontWeight.w700
                    : FontWeight.w500,
                color: (done || active)
                    ? AppColors.secondary
                    : AppColors.textSecondary(context),
              ),
            ),
          ],
        ),
      );
    }

    Widget connector(int i) {
      final bool filled = i < current;
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 21), // circle ke beech mein
          child: Container(
            height: 2,
            color: filled ? AppColors.secondary : Colors.grey.shade300,
          ),
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < steps.length; i++) ...[
          stepItem(i),
          if (i != steps.length - 1) connector(i),
        ],
      ],
    );
  }

  // ── Section header ──
  Widget _sectionHeader(
      IconData icon,
      String title,
      BuildContext context, {
        Color color = AppColors.secondary,
        Widget? trailing,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          IconBox(icon, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary(context),
              ),
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }

  // ── Radio circle ──
  Widget _radio(bool selected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? AppColors.secondary : Colors.grey.shade400,
          width: 2,
        ),
      ),
      child: selected
          ? Center(
        child: Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            color: AppColors.secondary,
            shape: BoxShape.circle,
          ),
        ),
      )
          : null,
    );
  }

  // ── Order summary (header + items + totals, sab ek card mein) ──
  Widget _orderSummaryCard(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(14),
      child: ValueListenableBuilder<String>(
        valueListenable: CurrencyService.instance.symbol,
        builder: (context, currency, _) {
          return Obx(() {
            final bool buyNow = controller.isBuyNow.value;

            final List<Map<String, dynamic>> items = buyNow
                ? [
              {
                'name': controller.buyNowProduct?.title ?? '',
                'image': controller.buyNowProduct?.image ?? '',
                'price': controller.buyNowPrice,
                'quantity': controller.buyNowQuantity,
                'size': controller.buyNowSize,
                'color': controller.buyNowColor,
              },
            ]
                : cartController.cartItems.toList();

            final total = controller.displayTotal;
            final dividerColor = AppColors.textPrimary(
              context,
            ).withValues(alpha: 0.08);

            return Column(
              children: [
                // Header: icon + title + "1 Item"
                Row(
                  children: [
                    const IconBox(
                      Icons.shopping_cart_outlined,
                      color: AppColors.secondary,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'order_summary'.tr,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary(context),
                        ),
                      ),
                    ),
                    Text(
                      items.length == 1 ? '1 Item' : '${items.length} Items',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                  ],
                ),
                Divider(height: 22, color: dividerColor),

                // Items
                for (int i = 0; i < items.length; i++) ...[
                  _summaryItem(context, items[i], currency, buyNow),
                  if (i != items.length - 1)
                    Divider(height: 18, color: dividerColor),
                ],

                Divider(height: 22, color: dividerColor),

                // Totals
                _priceRow(
                  context,
                  'Item Total',
                  '$currency ${total.toStringAsFixed(0)}',
                ),
                const SizedBox(height: 6),
                _priceRow(context, 'Delivery Fee', '$currency 0'),
                Divider(height: 22, color: dividerColor),
                _priceRow(
                  context,
                  'Total',
                  '$currency ${total.toStringAsFixed(0)}',
                  isTotal: true,
                  labelNote: ' (Incl. VAT)',
                ),
              ],
            );
          });
        },
      ),
    );
  }

  Widget _summaryItem(
      BuildContext context,
      Map<String, dynamic> item,
      String currency,
      bool buyNow,
      ) {
    final qty = (item['quantity'] as int? ?? 1);
    final unitPrice = buyNow
        ? (item['price'] as num? ?? 0).toDouble()
        : cartController.getUnitPrice(item);
    // Asli (cut) price: cart mein 'price' base hai, Buy Now mein optional 'basePrice'
    final basePrice = ((item['basePrice'] ?? item['price']) as num? ?? 0)
        .toDouble();
    final hasDiscount = basePrice > unitPrice;

    final name = item['name'] ?? item['title'] ?? '';
    final size = item['size'];
    final color = item['color'];
    final details = <String>[
      if (color != null && color.toString().isNotEmpty) 'Color: $color',
      if (size != null && size.toString().isNotEmpty) 'Size: $size',
      'Qty: $qty',
    ].join('   |   ');

    return Row(
      children: [
        Container(
          width: 76,
          height: 76,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(14),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              (item['image'] ?? '').toString(),
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) =>
              const Icon(Icons.image_not_supported, color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name.toString(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: AppColors.textPrimary(context),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                details,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary(context),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '$currency ${(unitPrice * qty).toStringAsFixed(0)}',
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                color: AppColors.secondary,
                fontSize: 16,
              ),
            ),
            if (hasDiscount) ...[
              const SizedBox(height: 4),
              Text(
                '$currency ${(basePrice * qty).toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 13,
                  decoration: TextDecoration.lineThrough,
                  color: AppColors.textSecondary(context),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _priceRow(
      BuildContext context,
      String label,
      String value, {
        bool isTotal = false,
        Color? valueColor,
        String? labelNote,
      }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text.rich(
          TextSpan(
            text: label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.w800 : FontWeight.normal,
              color: isTotal
                  ? AppColors.textPrimary(context)
                  : AppColors.textSecondary(context),
            ),
            children: [
              if (labelNote != null)
                TextSpan(
                  text: labelNote,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary(context),
                  ),
                ),
            ],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 20 : 14,
            fontWeight: isTotal ? FontWeight.w900 : FontWeight.w600,
            color: isTotal
                ? AppColors.secondary
                : (valueColor ?? AppColors.textPrimary(context)),
          ),
        ),
      ],
    );
  }

  // ── Address ──
  Widget _noAddressCard(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AppCard(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(Icons.location_off, size: 40, color: Colors.grey.shade400),
            const SizedBox(height: 8),
            Text(
              'no_address_saved'.tr,
              style: TextStyle(color: AppColors.textSecondary(context)),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () => controller.openAddressScreen(),
              icon: const Icon(Icons.add),
              label: Text('address_add'.tr),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(0, 46),
                padding: const EdgeInsets.symmetric(horizontal: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _addressList(BuildContext context) {
    return Column(
      children: List.generate(controller.savedAddresses.length, (index) {
        final addr = controller.savedAddresses[index];

        return Obx(() {
          final selected = controller.selectedAddressIndex.value == index;

          return GestureDetector(
            onTap: () => controller.selectAddress(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: selected
                    ? AppColors.success.withValues(alpha: 0.08)
                    : AppColors.cardBackground(context),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: selected ? AppColors.success : Colors.transparent,
                  width: 1.5,
                ),
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
                  const IconBox(Icons.home_rounded, color: AppColors.success),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          addr['name'] ?? 'Address ${index + 1}',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            color: AppColors.textPrimary(context),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '${addr['street'] ?? ''}, ${addr['city'] ?? ''}, ${addr['province'] ?? ''}',
                          style: TextStyle(
                            fontSize: 13,
                            height: 1.3,
                            color: AppColors.textSecondary(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.edit_outlined,
                      color: AppColors.secondary,
                      size: 20,
                    ),
                    onPressed: () => controller.openAddressScreen(addr),
                  ),
                  _radio(selected),
                ],
              ),
            ),
          );
        });
      }),
    );
  }

  // ── Payment ──
  IconData _paymentIcon(String name) {
    switch (name) {
      case 'Cash on Delivery':
        return Icons.payments_outlined;
      case 'Credit/Debit Card':
        return Icons.credit_card;
      case 'JazzCash / EasyPaisa':
        return Icons.phone_android;
      case 'Bank Transfer':
        return Icons.account_balance_outlined;
      default:
        return Icons.payment;
    }
  }

  String _paymentSubtitle(String name) {
    switch (name) {
      case 'Cash on Delivery':
        return 'Pay when you receive your order';
      case 'Credit/Debit Card':
        return 'Pay securely with your card';
      case 'JazzCash / EasyPaisa':
        return 'Pay via mobile wallet';
      case 'Bank Transfer':
        return 'Direct bank transfer';
      default:
        return '';
    }
  }

  Widget _paymentMethodList(BuildContext context) {
    return Column(
      children: controller.paymentMethods.map((method) {
        final name = method['name'] as String;

        return Obx(() {
          final selected = controller.selectedPayment.value == name;

          return GestureDetector(
            onTap: () => controller.selectPayment(name),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: selected
                    ? AppColors.orangeSoft(context)
                    : AppColors.cardBackground(context),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: selected ? AppColors.secondary : Colors.transparent,
                  width: 1.5,
                ),
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
                  _radio(selected),
                  const SizedBox(width: 12),
                  IconBox(
                    _paymentIcon(name),
                    color: selected ? AppColors.secondary : AppColors.success,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: AppColors.textPrimary(context),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _paymentSubtitle(name),
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
            ),
          );
        });
      }).toList(),
    );
  }

  // ── Place Order bar (neeche fixed) ──
  Widget _placeOrderBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        color: AppColors.background(context),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Obx(() {
          final loading = controller.isPlacingOrder.value;
          final total = controller.displayTotal;

          return ValueListenableBuilder<String>(
            valueListenable: CurrencyService.instance.symbol,
            builder: (context, currency, _) {
              return InkWell(
                onTap: loading
                    ? null
                    : () => controller.placeOrder(
                  controller.getOrderItems(),
                  controller.displayTotal,
                ),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  height: 54,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: loading
                          ? [Colors.grey.shade400, Colors.grey.shade500]
                          : AppColors.secondaryGradient,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.secondary.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: loading
                      ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          '${'order_place'.tr}  •  $currency ${total.toStringAsFixed(0)}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}