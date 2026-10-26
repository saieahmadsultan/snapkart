// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
//
// import '../../Utilities_Screens/App_Colors/app_colors.dart';
// import 'about_cont.dart';
//
// class AboutView extends GetView<AboutController> {
//   AboutView({super.key});
//   final controller = Get.put(AboutController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background(context),
//       appBar: AppBar(
//         elevation: 0,
//         iconTheme: IconThemeData(color: AppColors.textPrimary(context)),
//         centerTitle: true,
//         title: Text(
//           'about_us'.tr,
//           style: TextStyle(
//             color: AppColors.secondary,
//             fontWeight: FontWeight.bold,
//             fontSize: 25,
//             letterSpacing: 1,
//           ),
//         ),
//         backgroundColor: Colors.transparent,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         child: Column(
//           children: [
//             // Animated Logo Section
//             _buildAnimatedLogo(),
//
//             const SizedBox(height: 20),
//
//             // App Name Card
//             _buildInfoCard(
//               context: context,
//               icon: Icons.phone_android_outlined,
//               title: 'app_name'.tr,
//               value: controller.appName.value,
//               iconColor: AppColors.secondary,
//             ),
//
//             const SizedBox(height: 16),
//
//             // Description Card
//             _buildDescriptionCard(context, 'app_description'.tr),
//
//             const SizedBox(height: 16),
//
//             // Developer Card
//             _buildInfoCard(
//               context: context,
//               icon: Icons.people_alt_outlined,
//               title: 'developed_by'.tr,
//               value: controller.developer.value,
//               iconColor: AppColors.secondary,
//             ),
//
//             const SizedBox(height: 16),
//
//             // Version Card
//             _buildInfoCard(
//               context: context,
//               icon: Icons.label_important_outline,
//               title: 'app_version'.tr,
//               value: controller.version.value,
//               iconColor: AppColors.secondary,
//             ),
//
//             const SizedBox(height: 16),
//
//             // Contact Card with Action
//             _buildContactCard(
//               context: context,
//               icon: Icons.email_outlined,
//               title: 'contact_us'.tr,
//               value: controller.email.value,
//               iconColor: AppColors.secondary,
//               onTap: () => controller.sendEmail(),
//             ),
//
//             const SizedBox(height: 16),
//
//             // Social Links Section
//             _buildSocialLinks(context),
//
//             const SizedBox(height: 16),
//
//             // Complaint Box Section
//             _buildComplaintBox(context),
//
//             const SizedBox(height: 30),
//
//             // Copyright Text
//             _buildCopyright(context),
//           ],
//         ),
//       ),
//     );
//   }
//
//   BoxDecoration _glassDecoration(BuildContext context, {double radius = 20}) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     return BoxDecoration(
//       gradient: isDark
//           ? LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Colors.white.withOpacity(0.1),
//                 Colors.white.withOpacity(0.05),
//               ],
//             )
//           : null,
//       color: isDark ? null : AppColors.cardBackground(context),
//       borderRadius: BorderRadius.circular(radius),
//       border: Border.all(
//         color: isDark
//             ? Colors.white.withOpacity(0.1)
//             : Colors.black.withOpacity(0.06),
//       ),
//       boxShadow: isDark
//           ? null
//           : [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.04),
//                 blurRadius: 12,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//     );
//   }
//
//   Widget _buildAnimatedLogo() {
//     return Container(
//       height: 220,
//       width: 220,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             AppColors.secondary.withOpacity(0.3),
//             AppColors.secondary.withOpacity(0.1),
//           ],
//         ),
//       ),
//       child: Lottie.asset("assets/animation/team.json", fit: BoxFit.contain),
//     );
//   }
//
//   Widget _buildInfoCard({
//     required BuildContext context,
//     required IconData icon,
//     required String title,
//     required String value,
//     required Color iconColor,
//   }) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//       decoration: _glassDecoration(context),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: iconColor.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Icon(icon, color: iconColor, size: 28),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     color: AppColors.textSecondary(context),
//                     fontSize: 12,
//                     letterSpacing: 0.5,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   value,
//                   style: TextStyle(
//                     color: AppColors.textPrimary(context),
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
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
//   Widget _buildDescriptionCard(BuildContext context, String description) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: _glassDecoration(context),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(
//                 Icons.description_outlined,
//                 color: AppColors.secondary,
//                 size: 24,
//               ),
//               const SizedBox(width: 10),
//               Text(
//                 'about_app'.tr,
//                 style: TextStyle(
//                   color: AppColors.secondary,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Text(
//             description,
//             style: TextStyle(
//               color: AppColors.textSecondary(context),
//               fontSize: 15,
//               height: 1.5,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildContactCard({
//     required BuildContext context,
//     required IconData icon,
//     required String title,
//     required String value,
//     required Color iconColor,
//     VoidCallback? onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//         decoration: _glassDecoration(context),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: iconColor.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Icon(icon, color: iconColor, size: 28),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: TextStyle(
//                       color: AppColors.textSecondary(context),
//                       fontSize: 12,
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     value,
//                     style: TextStyle(
//                       color: AppColors.textPrimary(context),
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Icon(Icons.arrow_forward_ios, color: AppColors.secondary, size: 16),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSocialLinks(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 16),
//       decoration: _glassDecoration(context),
//       child: Column(
//         children: [
//           Text(
//             'connect_with_us'.tr,
//             style: TextStyle(
//               color: AppColors.secondary,
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               letterSpacing: 1,
//             ),
//           ),
//           const SizedBox(height: 16),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               _buildSocialIcon(Icons.facebook, () => controller.openFacebook()),
//               const SizedBox(width: 34),
//               _buildSocialIcon(Icons.link, () => controller.openLinkedIn()),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSocialIcon(IconData icon, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: AppColors.secondary.withOpacity(0.2),
//           shape: BoxShape.circle,
//           border: Border.all(color: AppColors.secondary),
//         ),
//         child: Icon(icon, color: AppColors.secondary, size: 24),
//       ),
//     );
//   }
//
//   Widget _buildComplaintBox(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: _glassDecoration(context),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(
//                 Icons.report_problem_outlined,
//                 color: AppColors.secondary,
//                 size: 24,
//               ),
//               const SizedBox(width: 10),
//               Text(
//                 'complaint_box'.tr,
//                 style: TextStyle(
//                   color: AppColors.secondary,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           TextField(
//             controller: controller.complaintController,
//             maxLines: 4,
//             style: TextStyle(color: AppColors.textPrimary(context)),
//             decoration: InputDecoration(
//               hintText: 'write_your_complaint_here'.tr,
//               hintStyle: TextStyle(color: AppColors.textSecondary(context)),
//               filled: true,
//               fillColor: AppColors.background(context),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: BorderSide.none,
//               ),
//               contentPadding: const EdgeInsets.all(14),
//             ),
//           ),
//           const SizedBox(height: 14),
//           Obx(
//             () => SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: controller.isSubmitting.value
//                     ? null
//                     : controller.submitComplaint,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.secondary,
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: controller.isSubmitting.value
//                     ? const SizedBox(
//                         height: 20,
//                         width: 20,
//                         child: CircularProgressIndicator(
//                           color: Colors.white,
//                           strokeWidth: 2,
//                         ),
//                       )
//                     : Text(
//                         'submit_complaint'.tr,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCopyright(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     return Column(
//       children: [
//         Divider(
//           color: isDark
//               ? Colors.white.withOpacity(0.1)
//               : Colors.black.withOpacity(0.08),
//           thickness: 1,
//         ),
//         const SizedBox(height: 10),
//         Text(
//           "© ${DateTime.now().year} SnapKart App. All rights reserved.",
//           style: TextStyle(
//             color: AppColors.textSecondary(context),
//             fontSize: 12,
//           ),
//         ),
//         const SizedBox(height: 20),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../Utilities_Screens/App_Colors/app_colors.dart';
import '../../Utilities_Screens/App_Colors/app_widgets.dart';
import 'about_cont.dart';

class AboutView extends GetView<AboutController> {
  AboutView({super.key});
  final controller = Get.put(AboutController());

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
        title: Text(
          'about_us'.tr,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: AppColors.textPrimary(context),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 20),

            _buildDescriptionCard(context, 'app_description'.tr),
            const SizedBox(height: 14),

            _buildInfoTile(
              context: context,
              icon: Icons.phone_android_outlined,
              color: AppColors.secondary,
              title: 'app_name'.tr,
              value: controller.appName.value,
            ),
            const SizedBox(height: 14),

            _buildInfoTile(
              context: context,
              icon: Icons.people_alt_outlined,
              color: AppColors.success,
              title: 'developed_by'.tr,
              value: controller.developer.value,
            ),
            const SizedBox(height: 14),

            _buildInfoTile(
              context: context,
              icon: Icons.label_important_outline,
              color: AppColors.info,
              title: 'app_version'.tr,
              value: controller.version.value,
            ),
            const SizedBox(height: 14),

            _buildInfoTile(
              context: context,
              icon: Icons.email_outlined,
              color: AppColors.secondary,
              title: 'contact_us'.tr,
              value: controller.email.value,
              onTap: () => controller.sendEmail(),
            ),
            const SizedBox(height: 14),

            _buildSocialLinks(context),
            const SizedBox(height: 14),

            _buildComplaintBox(context),
            const SizedBox(height: 24),

            _buildCopyright(context),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HEADER (Lottie + logo)
  // ============================================================

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primaryLight.withValues(alpha: 0.45),
                AppColors.secondaryLight.withValues(alpha: 0.25),
              ],
            ),
          ),
          child: Lottie.asset(
            'assets/animation/team.json',
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 14),
        const SnapKartLogo(size: 34),
        const SizedBox(height: 4),
        Text(
          'Modern Shopping',
          style: TextStyle(
            fontSize: 13,
            letterSpacing: 4,
            color: AppColors.textSecondary(context),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // INFO TILE (app name, developer, version, contact)
  // ============================================================

  Widget _buildInfoTile({
    required BuildContext context,
    required IconData icon,
    required Color color,
    required String title,
    required String value,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        child: AppCard(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              IconBox(icon, color: color),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 12,
                        letterSpacing: 0.5,
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary(context),
                      ),
                    ),
                  ],
                ),
              ),
              if (onTap != null)
                Icon(
                  Icons.chevron_right,
                  size: 22,
                  color: AppColors.textSecondary(context),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // DESCRIPTION
  // ============================================================

  Widget _buildDescriptionCard(BuildContext context, String description) {
    return SizedBox(
      width: double.infinity,
      child: AppCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const IconBox(Icons.description_outlined),
                const SizedBox(width: 12),
                Text(
                  'about_app'.tr,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                height: 1.55,
                color: AppColors.textSecondary(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SOCIAL LINKS
  // ============================================================

  Widget _buildSocialLinks(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AppCard(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        child: Column(
          children: [
            Text(
              'connect_with_us'.tr,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary(context),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _socialIcon(
                  Icons.facebook,
                  AppColors.info,
                  () => controller.openFacebook(),
                ),
                const SizedBox(width: 24),
                _socialIcon(
                  Icons.link,
                  AppColors.primary,
                  () => controller.openLinkedIn(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _socialIcon(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          shape: BoxShape.circle,
          border: Border.all(color: color.withValues(alpha: 0.5)),
        ),
        child: Icon(icon, color: color, size: 26),
      ),
    );
  }

  // ============================================================
  // COMPLAINT BOX
  // ============================================================

  Widget _buildComplaintBox(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AppCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const IconBox(Icons.report_problem_outlined),
                const SizedBox(width: 12),
                Text(
                  'complaint_box'.tr,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            TextField(
              controller: controller.complaintController,
              maxLines: 4,
              style: TextStyle(color: AppColors.textPrimary(context)),
              decoration: InputDecoration(
                hintText: 'write_your_complaint_here'.tr,
                hintStyle: TextStyle(color: AppColors.textSecondary(context)),
                filled: true,
                fillColor: AppColors.background(context),
                contentPadding: const EdgeInsets.all(14),
              ),
            ),
            const SizedBox(height: 14),
            Obx(() {
              final loading = controller.isSubmitting.value;

              return InkWell(
                onTap: loading ? null : controller.submitComplaint,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  height: 52,
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
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'submit_complaint'.tr,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.send_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ],
                        ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // COPYRIGHT
  // ============================================================

  Widget _buildCopyright(BuildContext context) {
    return Column(
      children: [
        Divider(color: AppColors.textPrimary(context).withValues(alpha: 0.08)),
        const SizedBox(height: 10),
        Text(
          '© ${DateTime.now().year} SnapKart App. All rights reserved.',
          style: TextStyle(
            color: AppColors.textSecondary(context),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
