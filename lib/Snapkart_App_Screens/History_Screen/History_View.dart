// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../Utilities_Screens/App_Colors/app_colors.dart';
// import '../../Utilities_Screens/Currency_Service/currency_service.dart';
// import '../../Utilities_Screens/Wave_Skelton_Box/wave_skelton_box.dart';
// import 'History_Controller.dart';
//
// class HistoryView extends StatelessWidget {
//   HistoryView({super.key});
//
//   final HistoryController controller = Get.put(HistoryController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background(context),
//       appBar: AppBar(
//         title: Text(
//           'order_history'.tr,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: AppColors.textPrimary(context),
//           ),
//         ),
//         backgroundColor: AppColors.cardBackground(context),
//         foregroundColor: AppColors.textPrimary(context),
//         elevation: 0.5,
//         actions: [
//           IconButton(
//             onPressed: () => _showClearAllDialog(context),
//             icon: const Icon(Icons.delete_sweep_outlined),
//             tooltip: 'clear_all'.tr,
//           ),
//         ],
//       ),
//       body: Obx(() {
//         // if (controller.isLoading.value) {
//         //   return const Center(
//         //     child: CircularProgressIndicator(color: Color(0xFF6C63FF)),
//         //   );
//         // }
//
//         if (controller.isLoading.value) {
//           return _buildSkeletonList();
//         }
//
//         if (controller.orders.isEmpty) {
//           return _emptyState(context);
//         }
//
//         return RefreshIndicator(
//           onRefresh: controller.fetchOrders,
//           color: const Color(0xFF6C63FF),
//           child: ListView.builder(
//             padding: const EdgeInsets.all(16),
//             itemCount: controller.orders.length,
//             itemBuilder: (context, index) {
//               final order = controller.orders[index];
//               return _orderCard(order, context);
//             },
//           ),
//         );
//       }),
//     );
//   }
//
//   void _showClearAllDialog(BuildContext context) {
//     Get.defaultDialog(
//       title: 'clear_all_history_title'.tr,
//       middleText: 'clear_all_history_msg'.tr,
//       textConfirm: 'clear'.tr,
//       textCancel: 'cancel'.tr,
//       confirmTextColor: Colors.white,
//       buttonColor: Colors.red,
//       onConfirm: () {
//         Get.back();
//         controller.clearAllHistory();
//       },
//     );
//   }
//
//   void _showDeleteDialog(BuildContext context, String orderId) {
//     Get.defaultDialog(
//       title: 'delete_order_title'.tr,
//       middleText: 'delete_order_msg'.tr,
//       textConfirm: 'delete'.tr,
//       textCancel: 'cancel'.tr,
//       confirmTextColor: Colors.white,
//       buttonColor: Colors.red,
//       onConfirm: () {
//         Get.back();
//         controller.deleteOrder(orderId);
//       },
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
//             Icons.receipt_long_outlined,
//             size: 80,
//             color: Colors.grey.shade300,
//           ),
//           const SizedBox(height: 16),
//           Text(
//             'no_order'.tr,
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: AppColors.textPrimary(context),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'no_order_yet'.tr,
//             style: TextStyle(color: AppColors.textSecondary(context)),
//           ),
//           const SizedBox(height: 24),
//           ElevatedButton.icon(
//             onPressed: () => Get.offAllNamed('/home'),
//             icon: const Icon(Icons.shopping_bag_outlined),
//             label: Text('do_shopping'.tr),
//             style: ElevatedButton.styleFrom(
//               backgroundColor:  AppColors.secondary,
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ── Order Card ──
//   Widget _orderCard(Map<String, dynamic> order, BuildContext context) {
//     final orderId = order['orderId'] ?? '';
//     final status = order['status'] ?? 'Pending';
//     final totalAmount = (order['totalAmount'] ?? 0).toDouble();
//     final paymentMethod = order['paymentMethod'] ?? 'N/A';
//     final items = order['items'] as List<dynamic>? ?? [];
//
//     String formattedDate = 'N/A';
//     if (order['createdAt'] != null) {
//       try {
//         final ts = order['createdAt'] as dynamic;
//         final date = ts.toDate();
//         formattedDate = '${date.day}/${date.month}/${date.year}';
//       } catch (_) {}
//     }
//
//     return GestureDetector(
//       onTap: () => controller.goToOrderDetail(order),
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 14),
//         decoration: BoxDecoration(
//           color: AppColors.cardBackground(context),
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.06),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           children: [
//             // ── Card Header ──
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               decoration: const BoxDecoration(
//                 color: AppColors.secondary,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(16),
//                   topRight: Radius.circular(16),
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     '#${orderId.substring(0, 8).toUpperCase()}',
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                   Text(
//                     formattedDate,
//                     style: const TextStyle(color: Colors.white70, fontSize: 13),
//                   ),
//                 ],
//               ),
//             ),
//
//             // ── Card Body ──
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   ...items.take(2).map((item) {
//                     return Padding(
//                       padding: const EdgeInsets.only(bottom: 8),
//                       child: Row(
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(8),
//                             child: Image.network(
//                               item['image'] ?? '',
//                               width: 48,
//                               height: 48,
//                               fit: BoxFit.cover,
//                               errorBuilder: (_, __, ___) => Container(
//                                 width: 48,
//                                 height: 48,
//                                 color: Colors.grey.shade100,
//                                 child: const Icon(
//                                   Icons.image_not_supported,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: Text(
//                               item['name'] ?? '',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 13,
//                                 color: AppColors.textPrimary(context),
//                               ),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                           Text(
//                             'x${item['quantity'] ?? 1}',
//                             style: TextStyle(
//                               color: AppColors.textSecondary(context),
//                               fontSize: 13,
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   }),
//
//                   if (items.length > 2)
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         'more_items'.trParams({
//                           'count': (items.length - 2).toString(),
//                         }),
//                         style: const TextStyle(
//                           color: Color(0xFF6C63FF),
//                           fontSize: 12,
//                         ),
//                       ),
//                     ),
//
//                   const Divider(height: 20),
//
//                   // ── Footer Row ──
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 10,
//                           vertical: 4,
//                         ),
//                         decoration: BoxDecoration(
//                           color: _statusColor(status).withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Text(
//                           '${controller.getStatusEmoji(status)}  $status',
//                           style: TextStyle(
//                             color: _statusColor(status),
//                             fontWeight: FontWeight.w600,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text(
//                             'total'.tr,
//                             style: TextStyle(
//                               color: AppColors.textSecondary(context),
//                               fontSize: 11,
//                             ),
//                           ),
//                           ValueListenableBuilder<String>(
//                             valueListenable: CurrencyService.instance.symbol,
//                             builder: (context, currency, _) {
//                               return Text(
//                                 '$currency ${totalAmount.toStringAsFixed(0)}',
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 15,
//                                   color: Color(0xFF6C63FF),
//                                 ),
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 8),
//
//                   // Payment method
//                   Row(
//                     children: [
//                       const Icon(Icons.payment, size: 14, color: Colors.grey),
//                       const SizedBox(width: 4),
//                       Text(
//                         paymentMethod,
//                         style: TextStyle(
//                           color: AppColors.textSecondary(context),
//                           fontSize: 12,
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 8),
//
//                   // Delete button
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: TextButton.icon(
//                       onPressed: () => _showDeleteDialog(context, orderId),
//                       icon: const Icon(
//                         Icons.delete_outline,
//                         size: 16,
//                         color: Colors.red,
//                       ),
//                       label: Text(
//                         'delete'.tr,
//                         style: const TextStyle(color: Colors.red, fontSize: 12),
//                       ),
//                       style: TextButton.styleFrom(
//                         padding: EdgeInsets.zero,
//                         minimumSize: const Size(0, 0),
//                         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                       ),
//                     ),
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
//   // skelton loader wave
//
//   Widget _buildSkeletonList() {
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: 4, // fake placeholder count
//       itemBuilder: (context, index) => _skeletonOrderCard(),
//     );
//   }
//
//   Widget _skeletonOrderCard() {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 14),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           // header bar
//           const WaveSkeletonBox(
//             height: 44,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(16),
//               topRight: Radius.circular(16),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 // item row 1
//                 Row(
//                   children: [
//                     const WaveSkeletonBox(
//                       width: 48,
//                       height: 48,
//                       borderRadius: BorderRadius.all(Radius.circular(8)),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: WaveSkeletonBox(
//                         height: 14,
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
//                 // item row 2
//                 Row(
//                   children: [
//                     const WaveSkeletonBox(
//                       width: 48,
//                       height: 48,
//                       borderRadius: BorderRadius.all(Radius.circular(8)),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: WaveSkeletonBox(
//                         height: 14,
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     WaveSkeletonBox(
//                       width: 80,
//                       height: 22,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     WaveSkeletonBox(
//                       width: 60,
//                       height: 18,
//                       borderRadius: BorderRadius.circular(6),
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
// }
//
// // ── Status Color ──
// Color _statusColor(String status) {
//   switch (status.toLowerCase()) {
//     case 'pending':
//       return Colors.orange;
//     case 'confirmed':
//       return Colors.blue;
//     case 'shipped':
//       return Colors.indigo;
//     case 'delivered':
//       return Colors.green;
//     case 'cancelled':
//       return Colors.red;
//     default:
//       return Colors.orange;
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../Utilities_Screens/App_Colors/app_colors.dart';
// import '../../Utilities_Screens/App_Colors/app_widgets.dart';
// import '../../Utilities_Screens/Currency_Service/currency_service.dart';
// import '../../Utilities_Screens/Wave_Skelton_Box/wave_skelton_box.dart';
// import 'History_Controller.dart';
//
// class HistoryView extends StatelessWidget {
//   HistoryView({super.key});
//
//   final HistoryController controller = Get.put(HistoryController());
//
//   // Selected filter (view ke andar hi rakha hai, controller ko touch nahi kiya)
//   final RxString _filter = 'All'.obs;
//
//   static const List<String> _filters = [
//     'All',
//     'Processing',
//     'Shipped',
//     'Delivered',
//   ];
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
//         actions: [
//           Obx(() {
//             if (controller.orders.isEmpty) return const SizedBox.shrink();
//             return IconButton(
//               onPressed: _showClearAllDialog,
//               icon: const Icon(
//                 Icons.delete_sweep_outlined,
//                 color: AppColors.secondary,
//               ),
//               tooltip: 'clear_all'.tr,
//             );
//           }),
//           const SizedBox(width: 4),
//         ],
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // TITLE
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'order_history'.tr,
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.w900,
//                     color: AppColors.textPrimary(context),
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   'Track, manage and view all your orders',
//                   style: TextStyle(
//                     fontSize: 13,
//                     color: AppColors.textSecondary(context),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // FILTER CHIPS
//           _filterChips(context),
//
//           // LIST
//           Expanded(
//             child: Obx(() {
//               if (controller.isLoading.value) {
//                 return _buildSkeletonList(context);
//               }
//
//               if (controller.orders.isEmpty) {
//                 return _emptyState(context);
//               }
//
//               final list = _visibleOrders();
//
//               return RefreshIndicator(
//                 onRefresh: controller.fetchOrders,
//                 color: AppColors.secondary,
//                 child: list.isEmpty
//                     ? ListView(
//                   physics: const AlwaysScrollableScrollPhysics(),
//                   children: [
//                     SizedBox(
//                       height: 320,
//                       child: _emptyState(
//                         context,
//                         message: 'No orders in this category',
//                       ),
//                     ),
//                   ],
//                 )
//                     : ListView.builder(
//                   physics: const AlwaysScrollableScrollPhysics(),
//                   padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
//                   itemCount: list.length,
//                   itemBuilder: (context, index) {
//                     return _orderCard(list[index], context);
//                   },
//                 ),
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ============================================================
//   // FILTER + SORT
//   // ============================================================
//
//   String _group(String status) {
//     switch (status.toLowerCase()) {
//       case 'shipped':
//         return 'Shipped';
//       case 'delivered':
//         return 'Delivered';
//       case 'cancelled':
//         return 'Cancelled';
//       default:
//         return 'Processing'; // pending / confirmed / processing
//     }
//   }
//
//   DateTime? _orderDate(Map<String, dynamic> order) {
//     try {
//       return (order['createdAt'] as dynamic).toDate() as DateTime;
//     } catch (_) {
//       return null;
//     }
//   }
//
//   List<Map<String, dynamic>> _visibleOrders() {
//     final selected = _filter.value;
//
//     final list = controller.orders.where((o) {
//       if (selected == 'All') return true;
//       return _group((o['status'] ?? 'Pending').toString()) == selected;
//     }).toList();
//
//     // Naye orders upar (createdAt null = abhi bana hua, sab se naya)
//     list.sort((a, b) {
//       final da = _orderDate(a);
//       final db = _orderDate(b);
//       if (da == null && db == null) return 0;
//       if (da == null) return -1;
//       if (db == null) return 1;
//       return db.compareTo(da);
//     });
//
//     return list;
//   }
//
//   Widget _filterChips(BuildContext context) {
//     return SizedBox(
//       height: 46,
//       child: Obx(() {
//         // Observable yahan, Obx ke builder ke andar hi parhna zaroori hai
//         final selectedFilter = _filter.value;
//
//         return ListView.separated(
//           scrollDirection: Axis.horizontal,
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           itemCount: _filters.length,
//           separatorBuilder: (_, __) => const SizedBox(width: 10),
//           itemBuilder: (context, index) {
//             final f = _filters[index];
//             final selected = selectedFilter == f;
//
//             return GestureDetector(
//               onTap: () => _filter.value = f,
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 250),
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 decoration: BoxDecoration(
//                   gradient: selected
//                       ? const LinearGradient(
//                     colors: AppColors.secondaryGradient,
//                   )
//                       : null,
//                   color: selected ? null : AppColors.cardBackground(context),
//                   borderRadius: BorderRadius.circular(30),
//                   boxShadow: [
//                     BoxShadow(
//                       color: selected
//                           ? AppColors.secondary.withValues(alpha: 0.3)
//                           : Colors.black.withValues(alpha: 0.05),
//                       blurRadius: selected ? 10 : 8,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(
//                       _filterIcon(f),
//                       size: 18,
//                       color: selected
//                           ? Colors.white
//                           : AppColors.textPrimary(context),
//                     ),
//                     const SizedBox(width: 6),
//                     Text(
//                       f,
//                       style: TextStyle(
//                         fontSize: 13,
//                         fontWeight:
//                         selected ? FontWeight.bold : FontWeight.w500,
//                         color: selected
//                             ? Colors.white
//                             : AppColors.textPrimary(context),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
//
//   IconData _filterIcon(String f) {
//     switch (f) {
//       case 'Processing':
//         return Icons.schedule;
//       case 'Shipped':
//         return Icons.local_shipping_outlined;
//       case 'Delivered':
//         return Icons.check_circle_outline;
//       default:
//         return Icons.shopping_bag_outlined;
//     }
//   }
//
//   // ============================================================
//   // STATUS
//   // ============================================================
//
//   Color _statusColor(String status) {
//     switch (_group(status)) {
//       case 'Delivered':
//         return AppColors.success;
//       case 'Shipped':
//         return AppColors.info;
//       case 'Cancelled':
//         return Colors.red.shade600;
//       default:
//         return AppColors.secondary;
//     }
//   }
//
//   IconData _statusIcon(String status) {
//     switch (_group(status)) {
//       case 'Delivered':
//         return Icons.check_circle;
//       case 'Shipped':
//         return Icons.local_shipping;
//       case 'Cancelled':
//         return Icons.cancel;
//       default:
//         return Icons.schedule;
//     }
//   }
//
//   Widget _statusPill(String status) {
//     final color = _statusColor(status);
//
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       decoration: BoxDecoration(
//         color: color.withValues(alpha: 0.12),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(_statusIcon(status), size: 15, color: color),
//           const SizedBox(width: 5),
//           Text(
//             status,
//             style: TextStyle(
//               color: color,
//               fontWeight: FontWeight.w700,
//               fontSize: 12,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ============================================================
//   // DIALOGS
//   // ============================================================
//
//   void _confirm({
//     required String title,
//     required String message,
//     required String confirmText,
//     required VoidCallback onConfirm,
//   }) {
//     Get.dialog(
//       AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         title: Text(title),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Get.back(),
//             child: Text('cancel'.tr, style: const TextStyle(color: Colors.grey)),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Get.back();
//               onConfirm();
//             },
//             style: ElevatedButton.styleFrom(
//               minimumSize: const Size(0, 44),
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//             ),
//             child: Text(confirmText),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showClearAllDialog() {
//     _confirm(
//       title: 'clear_all_history_title'.tr,
//       message: 'clear_all_history_msg'.tr,
//       confirmText: 'clear'.tr,
//       onConfirm: controller.clearAllHistory,
//     );
//   }
//
//   void _showDeleteDialog(String orderId) {
//     _confirm(
//       title: 'delete_order_title'.tr,
//       message: 'delete_order_msg'.tr,
//       confirmText: 'delete'.tr,
//       onConfirm: () => controller.deleteOrder(orderId),
//     );
//   }
//
//   // ============================================================
//   // EMPTY STATE
//   // ============================================================
//
//   Widget _emptyState(BuildContext context, {String? message}) {
//     final showButton = message == null;
//
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(28),
//               decoration: BoxDecoration(
//                 color: AppColors.orangeSoft(context),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.receipt_long_outlined,
//                 size: 64,
//                 color: AppColors.secondary,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               message ?? 'no_order'.tr,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.textPrimary(context),
//               ),
//             ),
//             if (showButton) ...[
//               const SizedBox(height: 8),
//               Text(
//                 'no_order_yet'.tr,
//                 style: TextStyle(color: AppColors.textSecondary(context)),
//               ),
//               const SizedBox(height: 24),
//               ElevatedButton.icon(
//                 onPressed: () => Get.offAllNamed('/home'),
//                 icon: const Icon(Icons.shopping_bag_outlined),
//                 label: Text('do_shopping'.tr),
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: const Size(0, 48),
//                   padding: const EdgeInsets.symmetric(horizontal: 24),
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ============================================================
//   // ORDER CARD
//   // ============================================================
//
//   static const List<String> _months = [
//     'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
//     'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
//   ];
//
//   String _formatDate(DateTime? d) {
//     if (d == null) return 'N/A';
//
//     final hour12 = d.hour % 12 == 0 ? 12 : d.hour % 12;
//     final minute = d.minute.toString().padLeft(2, '0');
//     final ampm = d.hour >= 12 ? 'PM' : 'AM';
//
//     return '${d.day} ${_months[d.month - 1]} ${d.year}, $hour12:$minute $ampm';
//   }
//
//   Widget _imageBox(String url, double size, {double radius = 14}) {
//     return Container(
//       width: size,
//       height: size,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(radius),
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(radius),
//         child: Image.network(
//           url,
//           fit: BoxFit.contain,
//           errorBuilder: (_, __, ___) => Container(
//             color: Colors.grey.shade100,
//             child: Icon(
//               Icons.image_not_supported,
//               color: Colors.grey,
//               size: size * 0.4,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _orderCard(Map<String, dynamic> order, BuildContext context) {
//     final orderId = (order['orderId'] ?? '').toString();
//     final status = (order['status'] ?? 'Pending').toString();
//     final totalAmount = ((order['totalAmount'] ?? 0) as num).toDouble();
//     final items = order['items'] as List<dynamic>? ?? [];
//
//     final shortId = orderId.isEmpty
//         ? 'N/A'
//         : (orderId.length >= 8 ? orderId.substring(0, 8) : orderId)
//         .toUpperCase();
//
//     int itemCount = 0;
//     for (final it in items) {
//       itemCount += ((it['quantity'] ?? 1) as num).toInt();
//     }
//
//     final firstImage = items.isNotEmpty
//         ? (items.first['image'] ?? '').toString()
//         : '';
//
//     const maxThumbs = 3;
//     final thumbs = items.take(maxThumbs).toList();
//     final extra = items.length - maxThumbs;
//
//     return GestureDetector(
//       onTap: () => controller.goToOrderDetail(order),
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 14),
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
//             // BARI IMAGE
//             _imageBox(firstImage, 84),
//             const SizedBox(width: 12),
//
//             // DETAILS
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // id + status
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           'Order #$shortId',
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w800,
//                             color: AppColors.textPrimary(context),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 6),
//                       _statusPill(status),
//                     ],
//                   ),
//
//                   const SizedBox(height: 3),
//
//                   Text(
//                     _formatDate(_orderDate(order)),
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: AppColors.textSecondary(context),
//                     ),
//                   ),
//
//                   const SizedBox(height: 8),
//
//                   // thumbnails
//                   Row(
//                     children: [
//                       for (final it in thumbs) ...[
//                         _imageBox(
//                           (it['image'] ?? '').toString(),
//                           38,
//                           radius: 10,
//                         ),
//                         const SizedBox(width: 6),
//                       ],
//                       if (extra > 0)
//                         Container(
//                           width: 38,
//                           height: 38,
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                             color: AppColors.textPrimary(context)
//                                 .withValues(alpha: 0.06),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Text(
//                             '+$extra',
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w700,
//                               color: AppColors.textSecondary(context),
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 8),
//
//                   // items + total + delete + chevron
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           '$itemCount ${itemCount == 1 ? 'item' : 'items'}',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: AppColors.textSecondary(context),
//                           ),
//                         ),
//                       ),
//                       ValueListenableBuilder<String>(
//                         valueListenable: CurrencyService.instance.symbol,
//                         builder: (context, currency, _) {
//                           return Text(
//                             '$currency ${totalAmount.toStringAsFixed(0)}',
//                             style: const TextStyle(
//                               fontWeight: FontWeight.w900,
//                               fontSize: 16,
//                               color: AppColors.secondary,
//                             ),
//                           );
//                         },
//                       ),
//                       const SizedBox(width: 6),
//                       GestureDetector(
//                         onTap: () => _showDeleteDialog(orderId),
//                         child: Padding(
//                           padding: const EdgeInsets.all(4),
//                           child: Icon(
//                             Icons.delete_outline,
//                             size: 20,
//                             color: Colors.grey.shade500,
//                           ),
//                         ),
//                       ),
//                       Icon(
//                         Icons.chevron_right,
//                         size: 22,
//                         color: AppColors.textSecondary(context),
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
//   // ============================================================
//   // SKELETON
//   // ============================================================
//
//   Widget _buildSkeletonList(BuildContext context) {
//     return ListView.builder(
//       padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
//       itemCount: 4,
//       itemBuilder: (context, index) => _skeletonOrderCard(context),
//     );
//   }
//
//   Widget _skeletonOrderCard(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 14),
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
//           const WaveSkeletonBox(
//             width: 84,
//             height: 84,
//             borderRadius: BorderRadius.all(Radius.circular(14)),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 WaveSkeletonBox(
//                   height: 14,
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 const SizedBox(height: 8),
//                 const SizedBox(
//                   width: 110,
//                   child: WaveSkeletonBox(
//                     height: 12,
//                     borderRadius: BorderRadius.all(Radius.circular(6)),
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 Row(
//                   children: List.generate(
//                     3,
//                         (_) => const Padding(
//                       padding: EdgeInsets.only(right: 6),
//                       child: WaveSkeletonBox(
//                         width: 38,
//                         height: 38,
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 const SizedBox(
//                   width: 80,
//                   child: WaveSkeletonBox(
//                     height: 16,
//                     borderRadius: BorderRadius.all(Radius.circular(6)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utilities_Screens/App_Colors/app_colors.dart';
import '../../Utilities_Screens/App_Colors/app_widgets.dart';
import '../../Utilities_Screens/Currency_Service/currency_service.dart';
import '../../Utilities_Screens/Wave_Skelton_Box/wave_skelton_box.dart';
import 'History_Controller.dart';

class HistoryView extends StatelessWidget {
  HistoryView({super.key});

  final HistoryController controller = Get.put(HistoryController());

  // Selected filter (view ke andar hi rakha hai, controller ko touch nahi kiya)
  final RxString _filter = 'All'.obs;

  static const List<String> _filters = [
    'All',
    'Processing',
    'Shipped',
    'Delivered',
  ];

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
        actions: [
          Obx(() {
            if (controller.orders.isEmpty) return const SizedBox.shrink();
            return IconButton(
              onPressed: _showClearAllDialog,
              icon: const Icon(
                Icons.delete_sweep_outlined,
                color: AppColors.secondary,
              ),
              tooltip: 'clear_all'.tr,
            );
          }),
          const SizedBox(width: 4),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TITLE
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'order_history'.tr,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textPrimary(context),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Track, manage and view all your orders',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary(context),
                  ),
                ),
              ],
            ),
          ),

          // FILTER CHIPS
          _filterChips(context),

          // LIST
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return _buildSkeletonList(context);
              }

              if (controller.orders.isEmpty) {
                return _emptyState(context);
              }

              final list = _visibleOrders();

              return RefreshIndicator(
                onRefresh: controller.fetchOrders,
                color: AppColors.secondary,
                child: list.isEmpty
                    ? ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          SizedBox(
                            height: 320,
                            child: _emptyState(
                              context,
                              message: 'No orders in this category',
                            ),
                          ),
                        ],
                      )
                    : ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return _orderCard(list[index], context);
                        },
                      ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FILTER + SORT
  // ============================================================

  String _group(String status) {
    switch (status.toLowerCase()) {
      case 'shipped':
        return 'Shipped';
      case 'delivered':
        return 'Delivered';
      case 'cancelled':
        return 'Cancelled';
      default:
        return 'Processing'; // pending / confirmed / processing
    }
  }

  DateTime? _orderDate(Map<String, dynamic> order) {
    try {
      return (order['createdAt'] as dynamic).toDate() as DateTime;
    } catch (_) {
      return null;
    }
  }

  List<Map<String, dynamic>> _visibleOrders() {
    final selected = _filter.value;

    final list = controller.orders.where((o) {
      if (selected == 'All') return true;
      return _group((o['status'] ?? 'Pending').toString()) == selected;
    }).toList();

    // Naye orders upar (createdAt null = abhi bana hua, sab se naya)
    list.sort((a, b) {
      final da = _orderDate(a);
      final db = _orderDate(b);
      if (da == null && db == null) return 0;
      if (da == null) return -1;
      if (db == null) return 1;
      return db.compareTo(da);
    });

    return list;
  }

  Widget _filterChips(BuildContext context) {
    return SizedBox(
      height: 46,
      child: Obx(() {
        // Observable yahan, Obx ke builder ke andar hi parhna zaroori hai
        final selectedFilter = _filter.value;

        return ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: _filters.length,
          separatorBuilder: (_, __) => const SizedBox(width: 10),
          itemBuilder: (context, index) {
            final f = _filters[index];
            final selected = selectedFilter == f;

            return GestureDetector(
              onTap: () => _filter.value = f,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  gradient: selected
                      ? const LinearGradient(
                          colors: AppColors.secondaryGradient,
                        )
                      : null,
                  color: selected ? null : AppColors.cardBackground(context),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: selected
                          ? AppColors.secondary.withValues(alpha: 0.3)
                          : Colors.black.withValues(alpha: 0.05),
                      blurRadius: selected ? 10 : 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _filterIcon(f),
                      size: 18,
                      color: selected
                          ? Colors.white
                          : AppColors.textPrimary(context),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      f,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: selected
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: selected
                            ? Colors.white
                            : AppColors.textPrimary(context),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  IconData _filterIcon(String f) {
    switch (f) {
      case 'Processing':
        return Icons.schedule;
      case 'Shipped':
        return Icons.local_shipping_outlined;
      case 'Delivered':
        return Icons.check_circle_outline;
      default:
        return Icons.shopping_bag_outlined;
    }
  }

  // ============================================================
  // STATUS
  // ============================================================

  Color _statusColor(String status) {
    switch (_group(status)) {
      case 'Delivered':
        return AppColors.success;
      case 'Shipped':
        return AppColors.info;
      case 'Cancelled':
        return Colors.red.shade600;
      default:
        return AppColors.secondary;
    }
  }

  IconData _statusIcon(String status) {
    switch (_group(status)) {
      case 'Delivered':
        return Icons.check_circle;
      case 'Shipped':
        return Icons.local_shipping;
      case 'Cancelled':
        return Icons.cancel;
      default:
        return Icons.schedule;
    }
  }

  Widget _statusPill(String status) {
    final color = _statusColor(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_statusIcon(status), size: 15, color: color),
          const SizedBox(width: 5),
          Text(
            status,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DIALOGS
  // ============================================================

  void _confirm({
    required String title,
    required String message,
    required String confirmText,
    required VoidCallback onConfirm,
  }) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(title),
        content: Text(message),
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
              Get.back();
              onConfirm();
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(0, 44),
              padding: const EdgeInsets.symmetric(horizontal: 20),
            ),
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  void _showClearAllDialog() {
    _confirm(
      title: 'clear_all_history_title'.tr,
      message: 'clear_all_history_msg'.tr,
      confirmText: 'clear'.tr,
      onConfirm: controller.clearAllHistory,
    );
  }

  void _showDeleteDialog(String orderId) {
    _confirm(
      title: 'delete_order_title'.tr,
      message: 'delete_order_msg'.tr,
      confirmText: 'delete'.tr,
      onConfirm: () => controller.deleteOrder(orderId),
    );
  }

  // ============================================================
  // EMPTY STATE
  // ============================================================

  Widget _emptyState(BuildContext context, {String? message}) {
    final showButton = message == null;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: AppColors.orangeSoft(context),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.receipt_long_outlined,
                size: 64,
                color: AppColors.secondary,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              message ?? 'no_order'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary(context),
              ),
            ),
            if (showButton) ...[
              const SizedBox(height: 8),
              Text(
                'no_order_yet'.tr,
                style: TextStyle(color: AppColors.textSecondary(context)),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => Get.offAllNamed('/home'),
                icon: const Icon(Icons.shopping_bag_outlined),
                label: Text('do_shopping'.tr),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(0, 48),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ============================================================
  // ORDER CARD
  // ============================================================

  static const List<String> _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  String _formatDate(DateTime? d) {
    if (d == null) return 'N/A';

    final hour12 = d.hour % 12 == 0 ? 12 : d.hour % 12;
    final minute = d.minute.toString().padLeft(2, '0');
    final ampm = d.hour >= 12 ? 'PM' : 'AM';

    return '${d.day} ${_months[d.month - 1]} ${d.year}, $hour12:$minute $ampm';
  }

  // Light grey container, uske andar product image (padding ke sath)
  Widget _imageBox(
    BuildContext context,
    String url,
    double size, {
    double radius = 14,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const lightGrey = Color(0xFFF3F4F6);

    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(size * 0.08),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.08) : lightGrey,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Image.network(
        url,
        fit: BoxFit.contain,
        // Light mode mein white background wali JPG images grey mein blend
        // ho jati hain. Agar aapki images transparent PNG hain to ye 2 lines
        // hata sakte ho.
        color: isDark ? null : lightGrey,
        colorBlendMode: isDark ? null : BlendMode.multiply,
        errorBuilder: (_, __, ___) => Icon(
          Icons.image_not_supported,
          color: Colors.grey,
          size: size * 0.4,
        ),
      ),
    );
  }

  Widget _orderCard(Map<String, dynamic> order, BuildContext context) {
    final orderId = (order['orderId'] ?? '').toString();
    final status = (order['status'] ?? 'Pending').toString();
    final totalAmount = ((order['totalAmount'] ?? 0) as num).toDouble();
    final items = order['items'] as List<dynamic>? ?? [];

    final shortId = orderId.isEmpty
        ? 'N/A'
        : (orderId.length >= 8 ? orderId.substring(0, 8) : orderId)
              .toUpperCase();

    int itemCount = 0;
    for (final it in items) {
      itemCount += ((it['quantity'] ?? 1) as num).toInt();
    }

    final firstImage = items.isNotEmpty
        ? (items.first['image'] ?? '').toString()
        : '';

    const maxThumbs = 3;
    final thumbs = items.take(maxThumbs).toList();
    final extra = items.length - maxThumbs;

    return GestureDetector(
      onTap: () => controller.goToOrderDetail(order),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
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
            // BARI IMAGE
            _imageBox(context, firstImage, 84),
            const SizedBox(width: 12),

            // DETAILS
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // id + status
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Order #$shortId',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary(context),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      _statusPill(status),
                    ],
                  ),

                  const SizedBox(height: 3),

                  Text(
                    _formatDate(_orderDate(order)),
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary(context),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // thumbnails
                  Row(
                    children: [
                      for (final it in thumbs) ...[
                        _imageBox(
                          context,
                          (it['image'] ?? '').toString(),
                          38,
                          radius: 10,
                        ),
                        const SizedBox(width: 6),
                      ],
                      if (extra > 0)
                        Container(
                          width: 38,
                          height: 38,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.textPrimary(
                              context,
                            ).withValues(alpha: 0.06),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '+$extra',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textSecondary(context),
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // items + total + delete + chevron
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          '$itemCount ${itemCount == 1 ? 'item' : 'items'}',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary(context),
                          ),
                        ),
                      ),
                      ValueListenableBuilder<String>(
                        valueListenable: CurrencyService.instance.symbol,
                        builder: (context, currency, _) {
                          return Text(
                            '$currency ${totalAmount.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: AppColors.secondary,
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: () => _showDeleteDialog(orderId),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Icon(
                            Icons.delete_outline,
                            size: 20,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 22,
                        color: AppColors.textSecondary(context),
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

  // ============================================================
  // SKELETON
  // ============================================================

  Widget _buildSkeletonList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
      itemCount: 4,
      itemBuilder: (context, index) => _skeletonOrderCard(context),
    );
  }

  Widget _skeletonOrderCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
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
          const WaveSkeletonBox(
            width: 84,
            height: 84,
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WaveSkeletonBox(
                  height: 14,
                  borderRadius: BorderRadius.circular(6),
                ),
                const SizedBox(height: 8),
                const SizedBox(
                  width: 110,
                  child: WaveSkeletonBox(
                    height: 12,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: List.generate(
                    3,
                    (_) => const Padding(
                      padding: EdgeInsets.only(right: 6),
                      child: WaveSkeletonBox(
                        width: 38,
                        height: 38,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const SizedBox(
                  width: 80,
                  child: WaveSkeletonBox(
                    height: 16,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
