// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../App_Routes/routes_view.dart';
// import '../../Utilities_Screens/App_Colors/app_colors.dart';
// import '../../Utilities_Screens/Auth_Services/auth_services.dart';
// import '../../Utilities_Screens/Theme_Controller/theme_controller.dart';
// import 'setting_controller.dart';
//
// class SettingView extends StatelessWidget {
//   SettingView({super.key});
//
//   final SettingController controller = Get.put(SettingController());
//   final ThemeController themeController = Get.put(ThemeController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background(context),
//       appBar: AppBar(
//         title: Text(
//           'settings'.tr,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: AppColors.textPrimary(context),
//           ),
//         ),
//         backgroundColor: AppColors.cardBackground(context),
//         foregroundColor: AppColors.textPrimary(context),
//         elevation: 0.5,
//       ),
//       body: Obx(
//         () => SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // ── Notifications ──
//               _sectionTitle('🔔 ${'notifications'.tr}', context),
//               _settingCard(
//                 context: context,
//                 children: [
//                   _switchTile(
//                     context: context,
//                     icon: Icons.shopping_bag_outlined,
//                     title: 'order_updates'.tr,
//                     subtitle: 'order_updates_sub'.tr,
//                     value: controller.orderNotifications.value,
//                     onChanged: controller.toggleOrderNotifications,
//                   ),
//                   _divider(),
//                   _divider(),
//                   _switchTile(
//                     context: context,
//                     icon: Icons.delivery_dining_outlined,
//                     title: 'delivery_updates'.tr,
//                     subtitle: 'delivery_updates_sub'.tr,
//                     value: controller.deliveryNotifications.value,
//                     onChanged: controller.toggleDeliveryNotifications,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//
//               // ── Theme ──
//               _sectionTitle('appearance'.tr, context),
//
//               _settingCard(
//                 context: context,
//                 children: [
//                   _switchTile(
//                     context: context,
//                     icon: Icons.dark_mode_outlined,
//                     title: 'dark_mode'.tr,
//                     subtitle: 'dark_mode_sub'.tr,
//                     value: themeController.isDarkMode.value,
//                     onChanged: (val) => themeController.toggleTheme(),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//
//               _sectionTitle('🌐 ${'language'.tr}', context),
//               _settingCard(
//                 context: context,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 8,
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                             color: AppColors.secondary.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Icon(
//                             Icons.language,
//                             color: AppColors.secondary,
//                             size: 20,
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: Text(
//                             'language'.tr,
//                             style: TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w500,
//                               color: AppColors.textPrimary(context),
//                             ),
//                           ),
//                         ),
//                         DropdownButton<String>(
//                           value: controller.selectedLanguage.value,
//                           underline: const SizedBox(),
//                           dropdownColor: AppColors.cardBackground(context),
//                           style: TextStyle(
//                             color: AppColors.secondary,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 14,
//                           ),
//                           items: controller.languages
//                               .map(
//                                 (lang) => DropdownMenuItem(
//                                   value: lang,
//                                   child: Text(lang),
//                                 ),
//                               )
//                               .toList(),
//                           onChanged: (val) {
//                             if (val != null) controller.changeLanguage(val);
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//
//               // ── Account ──
//               _sectionTitle('👤 ${'account'.tr}', context),
//               _settingCard(
//                 context: context,
//                 children: [
//                   _actionTile(
//                     context: context,
//                     icon: Icons.person_outline,
//                     title: 'edit_profile'.tr,
//                     onTap: () => Get.toNamed('/profilefetch'),
//                   ),
//                   _divider(),
//                   _actionTile(
//                     context: context,
//                     icon: Icons.lock_outline,
//                     title: 'change_password'.tr,
//                     onTap: () => _showChangePasswordDialog(context),
//                   ),
//
//                   _divider(),
//                   _actionTile(
//                     context: context,
//                     icon: Icons.lock_outline,
//                     title: 'delete_account'.tr,
//                     onTap: () => _showDeleteAccountDialog(),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//
//               // ── Other ──
//               _sectionTitle('⚙️ ${'other'.tr}', context),
//               _settingCard(
//                 context: context,
//                 children: [
//                   _actionTile(
//                     context: context,
//                     icon: Icons.logout,
//                     title: 'logout'.tr,
//                     titleColor: Colors.red,
//                     iconColor: Colors.red,
//                     onTap: () => _logout(),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 30),
//
//               // ── Version ──
//               Center(
//                 child: Text(
//                   'SnapKart v1.0.0',
//                   style: TextStyle(
//                     color: AppColors.textSecondary(context),
//                     fontSize: 12,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // ── Section Title ──
//   Widget _sectionTitle(String title, BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: Text(
//         title,
//         style: TextStyle(
//           fontSize: 15,
//           fontWeight: FontWeight.bold,
//           color: AppColors.textPrimary(context),
//         ),
//       ),
//     );
//   }
//
//   // ── Setting Card ──
//   Widget _settingCard({
//     required List<Widget> children,
//     required BuildContext context,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.cardBackground(context),
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(children: children),
//     );
//   }
//
//   // ── Switch Tile ──
//   Widget _switchTile({
//     required BuildContext context,
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required bool value,
//     required Function(bool) onChanged,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: AppColors.secondary.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Icon(icon, color: AppColors.secondary, size: 20),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.textPrimary(context),
//                   ),
//                 ),
//                 Text(
//                   subtitle,
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: AppColors.textSecondary(context),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Switch(
//             value: value,
//             onChanged: onChanged,
//             activeColor: AppColors.secondary,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _actionTile({
//     required BuildContext context,
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//     Color? titleColor,
//     Color? iconColor,
//   }) {
//     return ListTile(
//       onTap: onTap,
//       leading: Container(
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: (iconColor ?? AppColors.secondary).withOpacity(0.1),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Icon(icon, color: iconColor ?? AppColors.secondary, size: 20),
//       ),
//       title: Text(
//         title,
//         style: TextStyle(
//           fontSize: 15,
//           fontWeight: FontWeight.w500,
//           color: titleColor ?? AppColors.textPrimary(context),
//         ),
//       ),
//       trailing: Icon(
//         Icons.arrow_forward_ios,
//         size: 14,
//         color: AppColors.textSecondary(context),
//       ),
//     );
//   }
//
//
//   void _showChangePasswordDialog(BuildContext context) {
//     final oldPassController = TextEditingController();
//     final newPassController = TextEditingController();
//     final confirmPassController = TextEditingController();
//
//     Get.dialog(
//       Dialog(
//         backgroundColor: AppColors.secondary,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
//         insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//         child: SingleChildScrollView(
//           child: Container(
//             padding: const EdgeInsets.all(24),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   AppColors.secondary,
//                   AppColors.secondary.withOpacity(0.95),
//                 ],
//               ),
//               borderRadius: BorderRadius.circular(28),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: Text(
//                     'change_password'.tr,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//
//                 _buildPasswordField(
//                   controller: oldPassController,
//                   hint: 'current_password'.tr,
//                   visible: controller.oldPassVisible,
//                   onToggle: controller.toggleOldPass,
//                 ),
//                 const SizedBox(height: 12),
//
//                 _buildPasswordField(
//                   controller: newPassController,
//                   hint: 'new_password'.tr,
//                   visible: controller.newPassVisible,
//                   onToggle: controller.toggleNewPass,
//                 ),
//                 const SizedBox(height: 12),
//
//                 _buildPasswordField(
//                   controller: confirmPassController,
//                   hint: 'confirm_password'.tr,
//                   visible: controller.confirmPassVisible,
//                   onToggle: controller.toggleConfirmPass,
//                 ),
//                 const SizedBox(height: 20),
//
//                 Row(
//                   children: [
//                     Expanded(
//                       child: OutlinedButton(
//                         onPressed: () => Get.back(),
//                         style: OutlinedButton.styleFrom(
//                           foregroundColor: Colors.white,
//                           side: BorderSide(
//                             color: Colors.white.withOpacity(0.3),
//                           ),
//                           padding: const EdgeInsets.symmetric(vertical: 10),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: Text(
//                           'cancel'.tr,
//                           style: const TextStyle(fontSize: 13),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () async {
//                           String oldPass = oldPassController.text.trim();
//                           String newPass = newPassController.text.trim();
//                           String confirmPass = confirmPassController.text
//                               .trim();
//
//                           if (oldPass.isEmpty ||
//                               newPass.isEmpty ||
//                               confirmPass.isEmpty) {
//                             Get.snackbar(
//                               'error'.tr,
//                               "All fields required",
//                               backgroundColor: Colors.red,
//                               colorText: Colors.white,
//                             );
//                             return;
//                           }
//                           if (newPass != confirmPass) {
//                             Get.snackbar(
//                               'error'.tr,
//                               "Passwords do not match",
//                               backgroundColor: Colors.red,
//                               colorText: Colors.white,
//                             );
//                             return;
//                           }
//
//                           try {
//                             await AuthService().changePassword(
//                               oldPass,
//                               newPass,
//                             );
//                             Get.back();
//                             Get.snackbar(
//                               'success'.tr,
//                               "Password changed successfully",
//                               backgroundColor: Colors.green,
//                               colorText: Colors.white,
//                             );
//                             Get.toNamed(AppRoutes.login);
//                           } catch (e) {
//                             Get.snackbar(
//                               'error'.tr,
//                               e.toString(),
//                               backgroundColor: Colors.red,
//                               colorText: Colors.white,
//                             );
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           foregroundColor: AppColors.secondary,
//                           padding: const EdgeInsets.symmetric(vertical: 10),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: Text(
//                           'change'.tr,
//                           style: const TextStyle(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       barrierDismissible: false,
//     );
//   }
//
//   Widget _buildPasswordField({
//     required TextEditingController controller,
//     required String hint,
//     required RxBool visible,
//     required VoidCallback onToggle,
//   }) {
//     return Obx(
//       () => TextField(
//         controller: controller,
//         obscureText: !visible.value,
//         style: const TextStyle(color: Colors.white),
//         decoration: InputDecoration(
//           hintText: hint,
//           hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
//           filled: true,
//           fillColor: Colors.white.withOpacity(0.1),
//           prefixIcon: Icon(
//             Icons.lock_outline,
//             color: Colors.white.withOpacity(0.7),
//           ),
//           suffixIcon: IconButton(
//             icon: Icon(
//               visible.value ? Icons.visibility : Icons.visibility_off,
//               color: Colors.white.withOpacity(0.7),
//             ),
//             onPressed: onToggle,
//           ),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(16),
//             borderSide: BorderSide.none,
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(16),
//             borderSide: BorderSide.none,
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(16),
//             borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // void _showDeleteAccountDialog() {
//   //   final passwordFieldController = TextEditingController();
//   //   final RxBool isPasswordVisible = false.obs;
//   //
//   //   Get.dialog(
//   //     Dialog(
//   //       backgroundColor: AppColors.primary,
//   //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
//   //       child: Container(
//   //         padding: const EdgeInsets.all(24),
//   //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(28)),
//   //         child: Column(
//   //           mainAxisSize: MainAxisSize.min,
//   //           crossAxisAlignment: CrossAxisAlignment.start,
//   //           children: [
//   //             Container(
//   //               padding: const EdgeInsets.all(12),
//   //               decoration: BoxDecoration(
//   //                 color: Colors.red.withOpacity(0.15),
//   //                 borderRadius: BorderRadius.circular(20),
//   //               ),
//   //               child: const Icon(
//   //                 Icons.warning_rounded,
//   //                 color: Colors.redAccent,
//   //                 size: 28,
//   //               ),
//   //             ),
//   //             const SizedBox(height: 16),
//   //             Text(
//   //               'delete_account'.tr,
//   //               style: const TextStyle(
//   //                 color: Colors.white,
//   //                 fontSize: 22,
//   //                 fontWeight: FontWeight.bold,
//   //               ),
//   //             ),
//   //             const SizedBox(height: 8),
//   //             Text(
//   //               'delete_account_warning'.tr,
//   //               style: TextStyle(color: Colors.white.withOpacity(0.6)),
//   //             ),
//   //             const SizedBox(height: 24),
//   //             Obx(
//   //               () => TextField(
//   //                 controller: passwordFieldController,
//   //                 obscureText: !isPasswordVisible.value,
//   //                 style: const TextStyle(color: Colors.white),
//   //                 decoration: InputDecoration(
//   //                   hintText: 'enter_password_confirm'.tr,
//   //                   hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
//   //                   filled: true,
//   //                   fillColor: Colors.white.withOpacity(0.1),
//   //                   prefixIcon: Icon(
//   //                     Icons.lock_outline,
//   //                     color: Colors.white.withOpacity(0.7),
//   //                   ),
//   //                   suffixIcon: IconButton(
//   //                     onPressed: () {
//   //                       isPasswordVisible.value = !isPasswordVisible.value;
//   //                     },
//   //                     icon: Icon(
//   //                       isPasswordVisible.value
//   //                           ? Icons.visibility
//   //                           : Icons.visibility_off,
//   //                       color: Colors.white.withOpacity(0.7),
//   //                     ),
//   //                   ),
//   //                   border: OutlineInputBorder(
//   //                     borderRadius: BorderRadius.circular(16),
//   //                     borderSide: BorderSide.none,
//   //                   ),
//   //                 ),
//   //               ),
//   //             ),
//   //
//   //             const SizedBox(height: 24),
//   //             Row(
//   //               children: [
//   //                 Expanded(
//   //                   child: OutlinedButton(
//   //                     onPressed: () => Get.back(),
//   //                     style: OutlinedButton.styleFrom(
//   //                       foregroundColor: Colors.white,
//   //                       side: BorderSide(color: Colors.white.withOpacity(0.3)),
//   //                       padding: const EdgeInsets.symmetric(vertical: 12),
//   //                       shape: RoundedRectangleBorder(
//   //                         borderRadius: BorderRadius.circular(16),
//   //                       ),
//   //                     ),
//   //                     child: Text('cancel'.tr),
//   //                   ),
//   //                 ),
//   //                 const SizedBox(width: 12),
//   //                 Expanded(
//   //                   child: ElevatedButton(
//   //                     onPressed: () async {
//   //                       String password = passwordFieldController.text.trim();
//   //                       if (password.isEmpty) {
//   //                         Get.snackbar(
//   //                           'error'.tr,
//   //                           "Please enter password",
//   //                           backgroundColor: Colors.red,
//   //                           colorText: Colors.white,
//   //                         );
//   //                         return;
//   //                       }
//   //
//   //                       try {
//   //                         await AuthService().deleteAccount(password);
//   //                         Get.back();
//   //                         Get.snackbar(
//   //                           'success'.tr,
//   //                           "Account deleted successfully",
//   //                           backgroundColor: Colors.green,
//   //                           colorText: Colors.white,
//   //                         );
//   //                         Get.toNamed(AppRoutes.signup);
//   //                       } catch (e) {
//   //                         Get.snackbar(
//   //                           'error'.tr,
//   //                           e.toString(),
//   //                           backgroundColor: Colors.red,
//   //                           colorText: Colors.white,
//   //                         );
//   //                       }
//   //                     },
//   //                     style: ElevatedButton.styleFrom(
//   //                       backgroundColor: Colors.redAccent,
//   //                       padding: const EdgeInsets.symmetric(vertical: 12),
//   //                       shape: RoundedRectangleBorder(
//   //                         borderRadius: BorderRadius.circular(16),
//   //                       ),
//   //                     ),
//   //                     child: Text('delete'.tr),
//   //                   ),
//   //                 ),
//   //               ],
//   //             ),
//   //           ],
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }
//
//   void _showDeleteAccountDialog() {
//     final passwordFieldController = TextEditingController();
//     final RxBool isPasswordVisible = false.obs;
//
//     Get.dialog(
//       Dialog(
//         backgroundColor: AppColors.secondary,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
//         child: Container(
//           padding: const EdgeInsets.all(24),
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(28)),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.red.withOpacity(0.15),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: const Icon(
//                   Icons.warning_rounded,
//                   color: Colors.redAccent,
//                   size: 28,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 'delete_account'.tr,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 'delete_account_warning'.tr,
//                 style: TextStyle(color: Colors.white.withOpacity(0.6)),
//               ),
//               const SizedBox(height: 24),
//               Obx(
//                 () => TextField(
//                   controller: passwordFieldController,
//                   obscureText: !isPasswordVisible.value,
//                   style: const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     hintText: 'enter_password_confirm'.tr,
//                     hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
//                     filled: true,
//                     fillColor: Colors.white.withOpacity(0.1),
//                     prefixIcon: Icon(
//                       Icons.lock_outline,
//                       color: Colors.white.withOpacity(0.7),
//                     ),
//                     suffixIcon: IconButton(
//                       onPressed: () {
//                         isPasswordVisible.value = !isPasswordVisible.value;
//                       },
//                       icon: Icon(
//                         isPasswordVisible.value
//                             ? Icons.visibility
//                             : Icons.visibility_off,
//                         color: Colors.white.withOpacity(0.7),
//                       ),
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(16),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 24),
//               Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton(
//                       onPressed: () => Get.back(),
//                       style: OutlinedButton.styleFrom(
//                         foregroundColor: Colors.white,
//                         side: BorderSide(color: Colors.white.withOpacity(0.3)),
//                         padding: const EdgeInsets.symmetric(vertical: 12),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                       ),
//                       child: Text('cancel'.tr),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () async {
//                         String password = passwordFieldController.text.trim();
//                         if (password.isEmpty) {
//                           Get.snackbar(
//                             'error'.tr,
//                             "Please enter password",
//                             backgroundColor: Colors.red,
//                             colorText: Colors.white,
//                           );
//                           return;
//                         }
//
//                         try {
//                           await AuthService().deleteAccount(password);
//                           Get.back();
//                           Get.snackbar(
//                             'success'.tr,
//                             "Account deleted successfully",
//                             backgroundColor: Colors.green,
//                             colorText: Colors.white,
//                           );
//                           Get.toNamed(AppRoutes.signup);
//                         } catch (e) {
//                           Get.snackbar(
//                             'error'.tr,
//                             e.toString(),
//                             backgroundColor: Colors.red,
//                             colorText: Colors.white,
//                           );
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.redAccent,
//                         padding: const EdgeInsets.symmetric(vertical: 12),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                       ),
//                       child: Text('delete'.tr),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _logout() async {
//     Get.back();
//     await AuthService().signOut();
//     // Get.snackbar(
//     //   'success'.tr,
//     //   "Logged out successfully",
//     //   backgroundColor: Colors.green,
//     //   colorText: Colors.white,
//     // );
//     Get.toNamed(AppRoutes.login);
//   }
//
//   // ── Divider ──
//   Widget _divider() {
//     return const Divider(height: 1, indent: 56, endIndent: 16);
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../App_Routes/routes_view.dart';
import '../../Utilities_Screens/App_Colors/app_colors.dart';
import '../../Utilities_Screens/App_Colors/app_widgets.dart';
import '../../Utilities_Screens/Auth_Services/auth_services.dart';
import '../../Utilities_Screens/Theme_Controller/theme_controller.dart';
import 'setting_controller.dart';

class SettingView extends StatelessWidget {
  SettingView({super.key});

  final SettingController controller = Get.put(SettingController());
  final ThemeController themeController = Get.put(ThemeController());

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
          'settings'.tr,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: AppColors.textPrimary(context),
          ),
        ),
      ),
      body: Obx(
        () => !controller.isLoaded.value
            ? const SizedBox.shrink()
            : SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _profileCard(context),
                    const SizedBox(height: 14),

                    // ── Notifications ──
                    _section(
                      context,
                      icon: Icons.notifications_none_rounded,
                      title: 'notifications'.tr,
                      subtitle: 'Stay updated with your orders and offers',
                      children: [
                        _switchTile(
                          context: context,
                          icon: Icons.shopping_bag_outlined,
                          color: AppColors.success,
                          title: 'order_updates'.tr,
                          subtitle: 'order_updates_sub'.tr,
                          value: controller.orderNotifications.value,
                          onChanged: controller.toggleOrderNotifications,
                        ),
                        _divider(context),
                        _switchTile(
                          context: context,
                          icon: Icons.delivery_dining_outlined,
                          color: AppColors.success,
                          title: 'delivery_updates'.tr,
                          subtitle: 'delivery_updates_sub'.tr,
                          value: controller.deliveryNotifications.value,
                          onChanged: controller.toggleDeliveryNotifications,
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // ── Appearance ──
                    _section(
                      context,
                      icon: Icons.dark_mode_outlined,
                      title: 'appearance'.tr,
                      subtitle: 'Customize how SnapKart looks',
                      children: [
                        _switchTile(
                          context: context,
                          icon: Icons.nightlight_round,
                          color: AppColors.info,
                          title: 'dark_mode'.tr,
                          subtitle: 'dark_mode_sub'.tr,
                          value: themeController.isDarkMode.value,
                          onChanged: (val) => themeController.toggleTheme(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // ── Language ──
                    _section(
                      context,
                      icon: Icons.language,
                      title: 'language'.tr,
                      subtitle: 'Choose your preferred language',
                      color: AppColors.success,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _languageTile(
                                context,
                                label: 'English',
                                value: 'English',
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _languageTile(
                                context,
                                label: 'اردو',
                                value: 'Urdu',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // ── Account ──
                    _section(
                      context,
                      icon: Icons.person_outline,
                      title: 'account'.tr,
                      subtitle: 'Manage your account and security',
                      color: AppColors.info,
                      children: [
                        _actionTile(
                          context: context,
                          icon: Icons.person_outline,
                          title: 'edit_profile'.tr,
                          subtitle: 'Update your personal information',
                          onTap: () => Get.toNamed('/profilefetch'),
                        ),
                        _divider(context),
                        _actionTile(
                          context: context,
                          icon: Icons.lock_outline,
                          title: 'change_password'.tr,
                          subtitle: 'Keep your account secure',
                          onTap: () => _showChangePasswordDialog(),
                        ),
                        _divider(context),
                        _actionTile(
                          context: context,
                          icon: Icons.delete_outline,
                          title: 'delete_account'.tr,
                          subtitle: 'Permanently delete your account',
                          onTap: () => _showDeleteAccountDialog(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // ── Logout ──
                    AppCard(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      child: _actionTile(
                        context: context,
                        icon: Icons.logout,
                        title: 'logout'.tr,
                        titleColor: Colors.red.shade600,
                        iconColor: Colors.red.shade600,
                        onTap: _confirmLogout,
                      ),
                    ),

                    const SizedBox(height: 24),
                    Center(
                      child: Text(
                        'SnapKart v1.0.0',
                        style: TextStyle(
                          color: AppColors.textSecondary(context),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  // ============================================================
  // PROFILE CARD
  // ============================================================

  Widget _profileCard(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email ?? '';
    final displayName = user?.displayName?.trim() ?? '';
    final name = displayName.isNotEmpty
        ? displayName
        : (email.isNotEmpty ? email.split('@').first : 'Guest');
    // final photo = user?.photoURL;
    final photo = controller.profileImage.value.isNotEmpty
        ? controller.profileImage.value
        : user?.photoURL;

    return GestureDetector(
      onTap: () => Get.toNamed('/profilefetch'),
      child: Container(
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.cardBackground(context),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // soft orange blob
            Positioned(
              right: -40,
              top: -40,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.secondaryLight.withValues(alpha: 0.35),
                      AppColors.secondary.withValues(alpha: 0.12),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // avatar
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: AppColors.secondaryGradient,
                      ),
                      image: photo != null && photo.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(photo),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    alignment: Alignment.center,
                    child: (photo == null || photo.isEmpty)
                        ? Text(
                            name.isNotEmpty ? name[0].toUpperCase() : '?',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary(context),
                          ),
                        ),
                        if (email.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          Text(
                            email,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary(context),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: AppColors.textSecondary(context),
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
  // SECTION CARD
  // ============================================================

  Widget _section(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required List<Widget> children,
    Color color = AppColors.secondary,
  }) {
    return SizedBox(
      width: double.infinity,
      child: AppCard(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconBox(icon, color: color),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary(context),
                        ),
                      ),
                      Text(
                        subtitle,
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
            const SizedBox(height: 10),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _divider(BuildContext context) {
    return Divider(
      height: 1,
      color: AppColors.textPrimary(context).withValues(alpha: 0.08),
    );
  }

  // ============================================================
  // TILES
  // ============================================================

  Widget _switchTile({
    required BuildContext context,
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          IconBox(icon, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary(context),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary(context),
                  ),
                ),
              ],
            ),
          ),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }

  Widget _actionTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    String? subtitle,
    Color? titleColor,
    Color? iconColor,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            IconBox(icon, color: iconColor ?? AppColors.secondary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: titleColor ?? AppColors.textPrimary(context),
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 22,
              color: AppColors.textSecondary(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _languageTile(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    final selected = controller.selectedLanguage.value == value;

    return GestureDetector(
      onTap: () => controller.changeLanguage(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.success.withValues(alpha: 0.1)
              : AppColors.textPrimary(context).withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? AppColors.success : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.language,
              size: 20,
              color: selected
                  ? AppColors.success
                  : AppColors.textSecondary(context),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: selected
                      ? AppColors.success
                      : AppColors.textPrimary(context),
                ),
              ),
            ),
            selected
                ? const Icon(
                    Icons.check_circle,
                    color: AppColors.success,
                    size: 22,
                  )
                : Icon(
                    Icons.radio_button_unchecked,
                    color: Colors.grey.shade400,
                    size: 22,
                  ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // DIALOG HELPERS
  // ============================================================

  Widget _dialogField({
    required BuildContext context,
    required TextEditingController textController,
    required String hint,
    required bool visible,
    required VoidCallback onToggle,
  }) {
    return TextField(
      controller: textController,
      obscureText: !visible,
      style: TextStyle(color: AppColors.textPrimary(context)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: AppColors.textSecondary(context)),
        filled: true,
        fillColor: AppColors.textPrimary(context).withValues(alpha: 0.06),
        prefixIcon: Icon(
          Icons.lock_outline,
          color: AppColors.textSecondary(context),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            visible ? Icons.visibility : Icons.visibility_off,
            color: AppColors.textSecondary(context),
          ),
          onPressed: onToggle,
        ),
      ),
    );
  }

  void _snack(String title, String message, {bool error = true}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: error ? Colors.red.shade600 : AppColors.success,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  // ============================================================
  // CHANGE PASSWORD
  // ============================================================

  void _showChangePasswordDialog() {
    final oldPassController = TextEditingController();
    final newPassController = TextEditingController();
    final confirmPassController = TextEditingController();

    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Builder(
          builder: (context) {
            return Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.cardBackground(context),
                borderRadius: BorderRadius.circular(24),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const IconBox(Icons.lock_outline),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'change_password'.tr,
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    Obx(
                      () => _dialogField(
                        context: context,
                        textController: oldPassController,
                        hint: 'current_password'.tr,
                        visible: controller.oldPassVisible.value,
                        onToggle: controller.toggleOldPass,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Obx(
                      () => _dialogField(
                        context: context,
                        textController: newPassController,
                        hint: 'new_password'.tr,
                        visible: controller.newPassVisible.value,
                        onToggle: controller.toggleNewPass,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Obx(
                      () => _dialogField(
                        context: context,
                        textController: confirmPassController,
                        hint: 'confirm_password'.tr,
                        visible: controller.confirmPassVisible.value,
                        onToggle: controller.toggleConfirmPass,
                      ),
                    ),
                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Get.back(),
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(0, 48),
                              foregroundColor: AppColors.textPrimary(context),
                              side: BorderSide(
                                color: AppColors.textPrimary(
                                  context,
                                ).withValues(alpha: 0.2),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Text('cancel'.tr),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              final oldPass = oldPassController.text.trim();
                              final newPass = newPassController.text.trim();
                              final confirmPass = confirmPassController.text
                                  .trim();

                              if (oldPass.isEmpty ||
                                  newPass.isEmpty ||
                                  confirmPass.isEmpty) {
                                _snack('error'.tr, 'All fields required');
                                return;
                              }
                              if (newPass != confirmPass) {
                                _snack('error'.tr, 'Passwords do not match');
                                return;
                              }

                              try {
                                await AuthService().changePassword(
                                  oldPass,
                                  newPass,
                                );
                                Get.back();
                                _snack(
                                  'success'.tr,
                                  'Password changed successfully',
                                  error: false,
                                );
                                Get.offAllNamed(AppRoutes.login);
                              } catch (e) {
                                _snack('error'.tr, e.toString());
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(0, 48),
                            ),
                            child: Text('change'.tr),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      barrierDismissible: false,
    );
  }

  // ============================================================
  // DELETE ACCOUNT
  // ============================================================

  void _showDeleteAccountDialog() {
    final passwordFieldController = TextEditingController();
    final RxBool isPasswordVisible = false.obs;

    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Builder(
          builder: (context) {
            return Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.cardBackground(context),
                borderRadius: BorderRadius.circular(24),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.warning_rounded,
                        color: Colors.red.shade600,
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'delete_account'.tr,
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary(context),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'delete_account_warning'.tr,
                      style: TextStyle(
                        color: AppColors.textSecondary(context),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 18),

                    Obx(
                      () => _dialogField(
                        context: context,
                        textController: passwordFieldController,
                        hint: 'enter_password_confirm'.tr,
                        visible: isPasswordVisible.value,
                        onToggle: () =>
                            isPasswordVisible.value = !isPasswordVisible.value,
                      ),
                    ),
                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Get.back(),
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(0, 48),
                              foregroundColor: AppColors.textPrimary(context),
                              side: BorderSide(
                                color: AppColors.textPrimary(
                                  context,
                                ).withValues(alpha: 0.2),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Text('cancel'.tr),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              final password = passwordFieldController.text
                                  .trim();

                              if (password.isEmpty) {
                                _snack('error'.tr, 'Please enter password');
                                return;
                              }

                              try {
                                await AuthService().deleteAccount(password);
                                Get.back();
                                _snack(
                                  'success'.tr,
                                  'Account deleted successfully',
                                  error: false,
                                );
                                Get.offAllNamed(AppRoutes.signup);
                              } catch (e) {
                                _snack('error'.tr, e.toString());
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(0, 48),
                              backgroundColor: Colors.red.shade600,
                            ),
                            child: Text('delete'.tr),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ============================================================
  // LOGOUT
  // ============================================================

  void _confirmLogout() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('logout'.tr),
        content: const Text('Do you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'cancel'.tr,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Get.back();
              await AuthService().signOut();
              Get.offAllNamed(AppRoutes.login);
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(0, 44),
              padding: const EdgeInsets.symmetric(horizontal: 20),
            ),
            child: Text('logout'.tr),
          ),
        ],
      ),
    );
  }
}
