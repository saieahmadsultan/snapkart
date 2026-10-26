// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../Utilities_Screens/App_Colors/app_colors.dart';
// import '../../Utilities_Screens/Currency_Service/currency_service.dart';
// import 'order_controller.dart';
//
// class OrderView extends StatelessWidget {
//   OrderView({super.key});
//
//   final OrderController controller = Get.put(OrderController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background(context),
//       body: SafeArea(
//         child: Obx(
//           () => SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   width: 120,
//                   height: 120,
//                   decoration: BoxDecoration(
//                     color: AppColors.secondary.withOpacity(0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     Icons.check_circle_rounded,
//                     size: 80,
//                     color: AppColors.secondary,
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//
//                 Text(
//                   'order_placed'.tr,
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.textPrimary(context),
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'order_placed_sub'.tr,
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: AppColors.textSecondary(context),
//                     height: 1.5,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 36),
//
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: AppColors.cardBackground(context),
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Theme.of(context).brightness == Brightness.dark
//                             ? Colors.black.withOpacity(0.3)
//                             : Colors.black.withOpacity(0.06),
//                         blurRadius: 10,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       _detailRow(
//                         context: context,
//                         icon: Icons.receipt_long,
//                         label: 'order_id'.tr,
//                         value: controller.orderId.value.isNotEmpty
//                             ? '#${controller.orderId.value.substring(0, 8).toUpperCase()}'
//                             : '#N/A',
//                       ),
//                       Divider(
//                         height: 24,
//                         color: Theme.of(context).brightness == Brightness.dark
//                             ? Colors.white.withOpacity(0.08)
//                             : null,
//                       ),
//                       _detailRow(
//                         context: context,
//                         icon: Icons.calendar_today,
//                         label: 'order_date'.tr,
//                         value: controller.orderDate.value.isNotEmpty
//                             ? controller.orderDate.value
//                             : 'today'.tr,
//                       ),
//                       Divider(
//                         height: 24,
//                         color: Theme.of(context).brightness == Brightness.dark
//                             ? Colors.white.withOpacity(0.08)
//                             : null,
//                       ),
//                       _detailRow(
//                         context: context,
//                         icon: Icons.payment,
//                         label: 'payment'.tr,
//                         value: controller.paymentMethod.value.isNotEmpty
//                             ? controller.paymentMethod.value
//                             : 'N/A',
//                       ),
//                       Divider(
//                         height: 24,
//                         color: Theme.of(context).brightness == Brightness.dark
//                             ? Colors.white.withOpacity(0.08)
//                             : null,
//                       ),
//                       ValueListenableBuilder<String>(
//                         valueListenable: CurrencyService.instance.symbol,
//                         builder: (context, currency, _) {
//                           return _detailRow(
//                             context: context,
//                             icon: Icons.attach_money,
//                             label: 'total_amount'.tr,
//                             value:
//                                 '$currency ${controller.totalAmount.value.toStringAsFixed(0)}',
//                             isHighlighted: true,
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//
//                 SizedBox(
//                   width: double.infinity,
//                   height: 54,
//                   child: ElevatedButton.icon(
//                     onPressed: controller.goHome,
//                     icon: const Icon(Icons.home_rounded),
//                     label: Text(
//                       'home'.tr,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.secondary,
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(14),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _detailRow({
//     required BuildContext context,
//     required IconData icon,
//     required String label,
//     required String value,
//     bool isHighlighted = false,
//   }) {
//     return Row(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: AppColors.secondary.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Icon(icon, size: 20, color: AppColors.secondary),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Text(
//             label,
//             style: TextStyle(
//               fontSize: 14,
//               color: AppColors.textSecondary(context),
//             ),
//           ),
//         ),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: 15,
//             fontWeight: FontWeight.bold,
//             color: isHighlighted
//                 ? AppColors.secondary
//                 : AppColors.textPrimary(context),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../App_Routes/routes_view.dart';
import '../../Utilities_Screens/App_Colors/app_colors.dart';
import '../../Utilities_Screens/App_Colors/app_widgets.dart';
import '../../Utilities_Screens/Currency_Service/currency_service.dart';
import 'order_controller.dart';

class OrderView extends StatelessWidget {
  OrderView({super.key});

  final OrderController controller = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: Stack(
        children: [
          _background(context, size, isDark),
          SafeArea(
            child: Obx(
              () => SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SnapKartLogo(size: 28),
                    const SizedBox(height: 30),

                    _successIcon(),
                    const SizedBox(height: 24),

                    Text(
                      'order_placed'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: AppColors.textPrimary(context),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'order_placed_sub'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                    const SizedBox(height: 28),

                    _detailsCard(context),
                    const SizedBox(height: 28),

                    // HOME
                    GradientButton(
                      text: 'home'.tr,
                      icon: Icons.home_rounded,
                      onTap: controller.goHome,
                    ),
                    const SizedBox(height: 12),

                    // MY ORDERS
                    _outlineButton(
                      context,
                      text: 'order_history'.tr,
                      icon: Icons.receipt_long_outlined,
                      onTap: () {
                        Get.offAllNamed('/home');
                        Get.toNamed(AppRoutes.history);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BACKGROUND (login / splash jaisi shapes)
  // ============================================================

  Widget _blob(
    double size,
    List<Color> colors,
    Alignment begin,
    Alignment end,
  ) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(begin: begin, end: end, colors: colors),
      ),
    );
  }

  Widget _background(BuildContext context, Size size, bool isDark) {
    final w = size.width;

    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.background(context) : null,
          gradient: isDark
              ? null
              : const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Color(0xFFEAF6F3), Colors.white],
                ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -w * 0.45,
              left: -w * 0.45,
              child: _blob(
                w * 0.8,
                [
                  AppColors.primaryLight,
                  AppColors.primary,
                  AppColors.primaryDark,
                ],
                Alignment.bottomRight,
                Alignment.topLeft,
              ),
            ),
            Positioned(
              bottom: -w * 0.35,
              right: -w * 0.2,
              child: _blob(
                w * 0.6,
                AppColors.secondaryGradient,
                Alignment.topLeft,
                Alignment.bottomRight,
              ),
            ),
            Positioned(
              bottom: -w * 0.55,
              left: -w * 0.3,
              child: _blob(
                w * 0.8,
                [
                  AppColors.primaryLight,
                  AppColors.primary,
                  AppColors.primaryDark,
                ],
                Alignment.topLeft,
                Alignment.bottomRight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SUCCESS ICON (halka sa pop animation ke saath)
  // ============================================================

  Widget _successIcon() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 700),
      curve: Curves.elasticOut,
      builder: (context, value, child) {
        return Transform.scale(scale: value, child: child);
      },
      child: Container(
        width: 132,
        height: 132,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppColors.secondaryGradient,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.secondary.withValues(alpha: 0.3),
              blurRadius: 24,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: AppColors.primaryGradient,
            ),
          ),
          child: const Icon(Icons.check_rounded, size: 72, color: Colors.white),
        ),
      ),
    );
  }

  // ============================================================
  // DETAILS CARD
  // ============================================================

  Widget _detailsCard(BuildContext context) {
    final id = controller.orderId.value;
    final shortId = id.isEmpty
        ? '#N/A'
        : '#${(id.length >= 8 ? id.substring(0, 8) : id).toUpperCase()}';

    final divider = Divider(
      height: 24,
      color: AppColors.textPrimary(context).withValues(alpha: 0.08),
    );

    return SizedBox(
      width: double.infinity,
      child: AppCard(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            _detailRow(
              context: context,
              icon: Icons.receipt_long,
              color: AppColors.secondary,
              label: 'order_id'.tr,
              value: shortId,
            ),
            divider,
            _detailRow(
              context: context,
              icon: Icons.calendar_today,
              color: AppColors.success,
              label: 'order_date'.tr,
              value: controller.orderDate.value.isNotEmpty
                  ? controller.orderDate.value
                  : 'today'.tr,
            ),
            divider,
            _detailRow(
              context: context,
              icon: Icons.payment,
              color: AppColors.info,
              label: 'payment'.tr,
              value: controller.paymentMethod.value.isNotEmpty
                  ? controller.paymentMethod.value
                  : 'N/A',
            ),
            divider,
            ValueListenableBuilder<String>(
              valueListenable: CurrencyService.instance.symbol,
              builder: (context, currency, _) {
                return _detailRow(
                  context: context,
                  icon: Icons.sell_outlined,
                  color: AppColors.secondary,
                  label: 'total_amount'.tr,
                  value:
                      '$currency ${controller.totalAmount.value.toStringAsFixed(0)}',
                  isHighlighted: true,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailRow({
    required BuildContext context,
    required IconData icon,
    required Color color,
    required String label,
    required String value,
    bool isHighlighted = false,
  }) {
    return Row(
      children: [
        IconBox(icon, color: color),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary(context),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: isHighlighted ? 18 : 15,
              fontWeight: isHighlighted ? FontWeight.w900 : FontWeight.w700,
              color: isHighlighted
                  ? AppColors.secondary
                  : AppColors.textPrimary(context),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // OUTLINE BUTTON
  // ============================================================

  Widget _outlineButton(
    BuildContext context, {
    required String text,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 54,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.cardBackground(context),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.secondary.withValues(alpha: 0.5),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.secondary, size: 20),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                color: AppColors.secondary,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
