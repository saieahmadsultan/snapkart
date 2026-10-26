// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
//
// import '../../Utilities_Screens/App_Colors/app_colors.dart';
// import '../Signup_Screen/signup_view.dart';
// import 'login_cont.dart';
//
// class LoginView extends StatelessWidget {
//   final LoginController controller = Get.put(
//     LoginController(),
//     permanent: true,
//   );
//   LoginView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: const SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//         statusBarIconBrightness: Brightness.light,
//       ),
//       child: Scaffold(
//         backgroundColor: AppColors.primary,
//         body: SafeArea(
//           child: SingleChildScrollView(
//             physics: const BouncingScrollPhysics(),
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//             child: Obx(
//               () => AnimatedOpacity(
//                 duration: const Duration(milliseconds: 600),
//                 opacity: controller.animationValue.value,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     // TweenAnimationBuilder(
//                     //   tween: Tween<double>(begin: 0, end: 1),
//                     //   duration: const Duration(milliseconds: 800),
//                     //   builder: (context, value, child) {
//                     //     return Transform.scale(
//                     //       scale: value,
//                     //       child: SizedBox(
//                     //         height: 220,
//                     //         width: double.infinity,
//                     //         child: Lottie.asset(
//                     //           "assets/animation/Login.json",
//                     //           fit: BoxFit.contain,
//                     //         ),
//                     //       ),
//                     //     );
//                     //   },
//                     // ),
//                     Obx(() {
//                       if (controller.loginScreenProfileImage.value.isEmpty) {
//                         return const SizedBox.shrink();
//                       }
//                       return Padding(
//                         padding: const EdgeInsets.only(bottom: 12),
//                         child: CircleAvatar(
//                           radius: 60,
//                           backgroundColor: AppColors.secondary.withOpacity(0.2),
//                           backgroundImage: NetworkImage(
//                             controller.loginScreenProfileImage.value,
//                           ),
//                         ),
//                       );
//                     }),
//
//                     const SizedBox(height: 10),
//
//                     Text(
//                       'welcome_back'.tr,
//                       style: const TextStyle(
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         letterSpacing: 0.5,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 8),
//
//                     Text(
//                       'signin_subtitle'.tr,
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey.shade400,
//                         letterSpacing: 0.3,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//
//                     const SizedBox(height: 30),
//
//                     _buildModernTextField(
//                       controller: controller.emailController,
//                       label: 'email_address'.tr,
//                       hintText: 'Enter your email',
//                       errorText: controller.emailError.value,
//                       keyboardType: TextInputType.emailAddress,
//                       prefixIcon: Icons.email_outlined,
//                       onFocusChange: (focused) =>
//                           controller.isEmailFocused.value = focused,
//                     ),
//
//                     const SizedBox(height: 20),
//
//                     _buildModernPasswordField(),
//
//                     const SizedBox(height: 12),
//
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         _buildModernCheckbox(),
//                         _buildModernForgotPasswordButton(),
//                       ],
//                     ),
//
//                     const SizedBox(height: 30),
//
//                     _buildModernLoginButton(),
//
//                     const SizedBox(height: 20),
//
//                     _buildModernDivider(),
//
//                     const SizedBox(height: 20),
//
//                     _buildModernSocialLoginButtons(),
//
//                     const SizedBox(height: 25),
//
//                     _buildModernSignUpRow(),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildModernTextField({
//     required TextEditingController controller,
//     required String label,
//     required String hintText,
//     required String errorText,
//     required TextInputType keyboardType,
//     IconData? prefixIcon,
//     Function(bool)? onFocusChange,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontWeight: FontWeight.w600,
//             fontSize: 14,
//             color: Colors.grey.shade300,
//             letterSpacing: 0.5,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Colors.white.withOpacity(0.08),
//                 Colors.white.withOpacity(0.03),
//               ],
//             ),
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(
//               color: errorText.isNotEmpty
//                   ? Colors.red.shade400
//                   : Colors.white.withOpacity(0.15),
//               width: 1,
//             ),
//           ),
//           child: TextField(
//             controller: controller,
//             keyboardType: keyboardType,
//             style: const TextStyle(color: Colors.white, fontSize: 16),
//             cursorColor: AppColors.secondary,
//             onTap: () {
//               final loginController = Get.find<LoginController>();
//               loginController.emailError.value = '';
//             },
//             decoration: InputDecoration(
//               hintText: hintText,
//               hintStyle: TextStyle(color: Colors.grey.shade600),
//               prefixIcon: prefixIcon != null
//                   ? Icon(prefixIcon, color: AppColors.secondary, size: 22)
//                   : null,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16),
//                 borderSide: BorderSide.none,
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16),
//                 borderSide: BorderSide(color: AppColors.secondary, width: 1.5),
//               ),
//               contentPadding: const EdgeInsets.symmetric(
//                 horizontal: 18,
//                 vertical: 16,
//               ),
//             ),
//           ),
//         ),
//         if (errorText.isNotEmpty)
//           Padding(
//             padding: const EdgeInsets.only(left: 12, top: 8),
//             child: Row(
//               children: [
//                 Icon(Icons.error_outline, size: 14, color: Colors.red.shade400),
//                 const SizedBox(width: 6),
//                 Text(
//                   errorText,
//                   style: TextStyle(fontSize: 12, color: Colors.red.shade400),
//                 ),
//               ],
//             ),
//           ),
//       ],
//     );
//   }
//
//   Widget _buildModernPasswordField() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'password'.tr,
//           style: TextStyle(
//             fontWeight: FontWeight.w600,
//             fontSize: 14,
//             color: Colors.grey.shade300,
//             letterSpacing: 0.5,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Colors.white.withOpacity(0.08),
//                 Colors.white.withOpacity(0.03),
//               ],
//             ),
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(
//               color: controller.passwordError.value.isNotEmpty
//                   ? Colors.red.shade400
//                   : Colors.white.withOpacity(0.15),
//               width: 1,
//             ),
//           ),
//           child: Obx(
//             () => TextField(
//               controller: controller.passwordController,
//               obscureText: !controller.isPasswordVisible.value,
//               style: const TextStyle(color: Colors.white, fontSize: 16),
//               cursorColor: AppColors.secondary,
//               onTap: () {
//                 controller.passwordError.value = '';
//               },
//               decoration: InputDecoration(
//                 hintText: 'enter_your_password'.tr,
//                 hintStyle: TextStyle(color: Colors.grey.shade600),
//                 prefixIcon: const Icon(
//                   Icons.lock_outline,
//                   color: AppColors.secondary,
//                   size: 22,
//                 ),
//                 suffixIcon: IconButton(
//                   icon: Icon(
//                     controller.isPasswordVisible.value
//                         ? Icons.visibility_off
//                         : Icons.visibility,
//                     color: Colors.grey.shade400,
//                     size: 20,
//                   ),
//                   onPressed: controller.togglePasswordVisibility,
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(16),
//                   borderSide: BorderSide.none,
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(16),
//                   borderSide: BorderSide(
//                     color: AppColors.secondary,
//                     width: 1.5,
//                   ),
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 18,
//                   vertical: 16,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         if (controller.passwordError.value.isNotEmpty)
//           Padding(
//             padding: const EdgeInsets.only(left: 12, top: 8),
//             child: Row(
//               children: [
//                 Icon(Icons.error_outline, size: 14, color: Colors.red.shade400),
//                 const SizedBox(width: 6),
//                 Text(
//                   controller.passwordError.value,
//                   style: TextStyle(fontSize: 12, color: Colors.red.shade400),
//                 ),
//               ],
//             ),
//           ),
//       ],
//     );
//   }
//
//   Widget _buildModernCheckbox() {
//     return Obx(
//       () => GestureDetector(
//         onTap: () => controller.toggleRememberMe(!controller.rememberMe.value),
//         child: Row(
//           children: [
//             AnimatedContainer(
//               duration: const Duration(milliseconds: 200),
//               width: 20,
//               height: 20,
//               decoration: BoxDecoration(
//                 color: controller.rememberMe.value
//                     ? AppColors.secondary
//                     : Colors.transparent,
//                 borderRadius: BorderRadius.circular(6),
//                 border: Border.all(
//                   color: controller.rememberMe.value
//                       ? AppColors.secondary
//                       : Colors.grey.shade500,
//                   width: 2,
//                 ),
//               ),
//               child: controller.rememberMe.value
//                   ? const Icon(Icons.check, size: 14, color: Colors.white)
//                   : null,
//             ),
//             const SizedBox(width: 10),
//             Text(
//               'remember_me'.tr,
//               style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildModernForgotPasswordButton() {
//     return TextButton(
//       onPressed: () => _showModernForgotPasswordDialog(),
//       style: TextButton.styleFrom(
//         padding: EdgeInsets.zero,
//         minimumSize: Size.zero,
//         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//       ),
//       child: Text(
//         'forgot_password'.tr,
//         style: TextStyle(
//           fontWeight: FontWeight.w600,
//           color: AppColors.secondary,
//           fontSize: 14,
//           letterSpacing: 0.3,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildModernLoginButton() {
//     return Obx(
//       () => Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [AppColors.secondary, AppColors.secondary.withOpacity(0.8)],
//           ),
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: AppColors.secondary.withOpacity(0.3),
//               blurRadius: 12,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: ElevatedButton(
//           onPressed: controller.isLoading.value
//               ? null
//               : () => controller.login(),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.transparent,
//             foregroundColor: Colors.white,
//             shadowColor: Colors.transparent,
//             padding: const EdgeInsets.symmetric(vertical: 16),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16),
//             ),
//           ),
//           child: controller.isLoading.value
//               ? const SizedBox(
//                   height: 22,
//                   width: 22,
//                   child: CircularProgressIndicator(
//                     strokeWidth: 2.5,
//                     color: Colors.white,
//                   ),
//                 )
//               : Text(
//                   'sign_in'.tr,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 1,
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildModernDivider() {
//     return Row(
//       children: [
//         Expanded(
//           child: Container(height: 1, color: Colors.white.withOpacity(0.1)),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Text(
//             'or_continue_with'.tr,
//             style: TextStyle(
//               color: Colors.grey.shade500,
//               fontSize: 13,
//               letterSpacing: 0.5,
//             ),
//           ),
//         ),
//         Expanded(
//           child: Container(height: 1, color: Colors.white.withOpacity(0.1)),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildModernSocialLoginButtons() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         _buildModernSocialButton(
//           icon: FontAwesomeIcons.google,
//           color: Colors.red.shade400,
//           onTap: controller.googleLogin,
//           isLoading: controller.isGoogleLoading.value,
//         ),
//         const SizedBox(width: 20),
//         _buildModernSocialButton(
//           icon: FontAwesomeIcons.facebook,
//           color: Colors.purple.shade400,
//           onTap: () {
//             Get.snackbar(
//               'coming_soon'.tr,
//               'facebook_soon'.tr,
//               snackPosition: SnackPosition.BOTTOM,
//               backgroundColor: Colors.grey[850],
//               colorText: Colors.white,
//               borderRadius: 12,
//               margin: const EdgeInsets.all(16),
//             );
//           },
//           isLoading: false,
//         ),
//         const SizedBox(width: 20),
//         _buildModernSocialButton(
//           icon: FontAwesomeIcons.linkedinIn,
//           color: Colors.blue.shade700,
//           onTap: () {
//             Get.snackbar(
//               'coming_soon'.tr,
//               'linkedin_soon'.tr,
//               snackPosition: SnackPosition.BOTTOM,
//               backgroundColor: Colors.grey[850],
//               colorText: Colors.white,
//               borderRadius: 12,
//               margin: const EdgeInsets.all(16),
//             );
//           },
//           isLoading: false,
//         ),
//       ],
//     );
//   }
//
//   Widget _buildModernSocialButton({
//     required FaIconData icon,
//     required Color color,
//     required VoidCallback onTap,
//     required bool isLoading,
//   }) {
//     return InkWell(
//       onTap: isLoading ? null : onTap,
//       borderRadius: BorderRadius.circular(16),
//       child: Container(
//         width: 55,
//         height: 55,
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Colors.white.withOpacity(0.1),
//               Colors.white.withOpacity(0.05),
//             ],
//           ),
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: Colors.white.withOpacity(0.15), width: 1),
//         ),
//         child: isLoading
//             ? const SizedBox(
//                 width: 22,
//                 height: 22,
//                 child: CircularProgressIndicator(
//                   strokeWidth: 2,
//                   color: Colors.white,
//                 ),
//               )
//             : FaIcon(icon, color: color, size: 24),
//       ),
//     );
//   }
//
//   Widget _buildModernSignUpRow() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           'dont_have_account'.tr,
//           style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
//         ),
//         TextButton(
//           onPressed: () {
//             Get.to(() => SignupView());
//           },
//           style: TextButton.styleFrom(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             minimumSize: Size.zero,
//             tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//           ),
//           child: Text(
//             'sign_up'.tr,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: AppColors.secondary,
//               fontSize: 16,
//               letterSpacing: 0.5,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   void _showModernForgotPasswordDialog() {
//     final emailController = TextEditingController();
//     Get.dialog(
//       Dialog(
//         backgroundColor: AppColors.primary,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
//         child: Container(
//           padding: const EdgeInsets.all(24),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [AppColors.primary, AppColors.primary.withOpacity(0.95)],
//             ),
//             borderRadius: BorderRadius.circular(24),
//             border: Border.all(color: Colors.white.withOpacity(0.1)),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: AppColors.secondary.withOpacity(0.1),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Icons.lock_reset,
//                   color: AppColors.secondary,
//                   size: 48,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 'reset_password'.tr,
//                 style: const TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               const SizedBox(height: 12),
//               Text(
//                 'reset_password_sub'.tr,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey.shade400,
//                   height: 1.4,
//                 ),
//               ),
//               const SizedBox(height: 24),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.05),
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: TextField(
//                   controller: emailController,
//                   keyboardType: TextInputType.emailAddress,
//                   style: const TextStyle(color: Colors.white),
//                   cursorColor: AppColors.secondary,
//                   decoration: InputDecoration(
//                     hintText: 'Enter your email',
//                     hintStyle: TextStyle(color: Colors.grey.shade600),
//                     prefixIcon: Icon(
//                       Icons.email_outlined,
//                       color: AppColors.secondary,
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(16),
//                       borderSide: BorderSide.none,
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(16),
//                       borderSide: BorderSide(
//                         color: AppColors.secondary,
//                         width: 1.5,
//                       ),
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(
//                       horizontal: 18,
//                       vertical: 16,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 24),
//               Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton(
//                       onPressed: () => Get.back(),
//                       style: OutlinedButton.styleFrom(
//                         foregroundColor: Colors.white,
//                         side: BorderSide(color: Colors.grey.shade600),
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: Text('cancel'.tr),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         if (emailController.text.isNotEmpty) {
//                           controller.emailController.text =
//                               emailController.text;
//                           controller.forgotPassword();
//                           Get.back();
//                         } else {
//                           Get.snackbar(
//                             'error'.tr,
//                             'enter_email_error'.tr,
//                             snackPosition: SnackPosition.BOTTOM,
//                             backgroundColor: Colors.red,
//                             colorText: Colors.white,
//                             borderRadius: 12,
//                             margin: const EdgeInsets.all(16),
//                           );
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.secondary,
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: Text('send_link'.tr),
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
// }









import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../Utilities_Screens/App_Colors/app_colors.dart';
import '../../Utilities_Screens/App_Colors/app_widgets.dart';
import '../Signup_Screen/signup_view.dart';
import 'login_cont.dart';

class LoginView extends StatelessWidget {
  final LoginController controller = Get.put(
    LoginController(),
    permanent: true,
  );
  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background(context),
        body: Stack(
          children: [
            _background(context, size, isDark),
            SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                child: Obx(
                      () => AnimatedOpacity(
                    duration: const Duration(milliseconds: 600),
                    opacity: controller.animationValue.value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _header(context),
                        const SizedBox(height: 28),

                        _field(
                          context: context,
                          label: 'email_address'.tr,
                          hint: 'Enter your email',
                          textController: controller.emailController,
                          error: controller.emailError.value,
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          onTap: () => controller.emailError.value = '',
                        ),
                        const SizedBox(height: 18),

                        _passwordField(context),
                        const SizedBox(height: 14),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _rememberMe(context),
                            _forgotPasswordButton(),
                          ],
                        ),
                        const SizedBox(height: 26),

                        _loginButton(),
                        const SizedBox(height: 22),

                        _divider(context),
                        const SizedBox(height: 22),

                        _socialButtons(context),
                        const SizedBox(height: 24),

                        _signUpRow(context),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // BACKGROUND (splash jaisi teal + orange shapes)
  // ============================================================

  Widget _blob(double size, List<Color> colors, Alignment begin, Alignment end) {
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
            // top-left teal
            Positioned(
              top: -w * 0.4,
              left: -w * 0.4,
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

            // bottom-right orange
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

            // bottom teal
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
  // HEADER
  // ============================================================

  Widget _header(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          final img = controller.loginScreenProfileImage.value;

          // Agar pehle login ki profile image hai to wo, warna app logo
          if (img.isNotEmpty) {
            return Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: AppColors.secondaryGradient),
              ),
              child: CircleAvatar(
                radius: 46,
                backgroundColor: AppColors.cardBackground(context),
                backgroundImage: NetworkImage(img),
              ),
            );
          }

          return Container(
            width: 92,
            height: 92,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: AppColors.primaryGradient,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.secondary.withValues(alpha: 0.25),
                  blurRadius: 24,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(26),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: -24,
                    right: -24,
                    child: Container(
                      width: 62,
                      height: 62,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: AppColors.secondaryGradient,
                        ),
                      ),
                    ),
                  ),
                  ShaderMask(
                    shaderCallback: (rect) => const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white, AppColors.secondaryLight],
                    ).createShader(rect),
                    child: const Icon(
                      Icons.shopping_bag_rounded,
                      size: 54,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),

        const SizedBox(height: 14),
        const SnapKartLogo(size: 32),
        const SizedBox(height: 18),

        Text(
          'welcome_back'.tr,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: AppColors.textPrimary(context),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'signin_subtitle'.tr,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary(context),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // TEXT FIELDS
  // ============================================================

  Widget _field({
    required BuildContext context,
    required String label,
    required String hint,
    required TextEditingController textController,
    required String error,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscure = false,
    Widget? suffix,
    VoidCallback? onTap,
  }) {
    final hasError = error.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: AppColors.textPrimary(context),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: hasError ? Colors.red.shade400 : Colors.transparent,
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
          child: TextField(
            controller: textController,
            keyboardType: keyboardType,
            obscureText: obscure,
            cursorColor: AppColors.secondary,
            onTap: onTap,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textPrimary(context),
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: AppColors.textSecondary(context)),
              filled: true,
              fillColor: AppColors.cardBackground(context),
              prefixIcon: Icon(icon, color: AppColors.secondary, size: 22),
              suffixIcon: suffix,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: AppColors.secondary,
                  width: 1.5,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 16,
              ),
            ),
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 8),
            child: Row(
              children: [
                Icon(Icons.error_outline, size: 14, color: Colors.red.shade400),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    error,
                    style: TextStyle(fontSize: 12, color: Colors.red.shade400),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _passwordField(BuildContext context) {
    return Obx(
          () => _field(
        context: context,
        label: 'password'.tr,
        hint: 'enter_your_password'.tr,
        textController: controller.passwordController,
        error: controller.passwordError.value,
        icon: Icons.lock_outline,
        obscure: !controller.isPasswordVisible.value,
        onTap: () => controller.passwordError.value = '',
        suffix: IconButton(
          icon: Icon(
            controller.isPasswordVisible.value
                ? Icons.visibility_off
                : Icons.visibility,
            color: AppColors.textSecondary(context),
            size: 20,
          ),
          onPressed: controller.togglePasswordVisibility,
        ),
      ),
    );
  }

  // ============================================================
  // REMEMBER ME + FORGOT PASSWORD
  // ============================================================

  Widget _rememberMe(BuildContext context) {
    return Obx(
          () => GestureDetector(
        onTap: () => controller.toggleRememberMe(!controller.rememberMe.value),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: controller.rememberMe.value
                    ? AppColors.secondary
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                  color: controller.rememberMe.value
                      ? AppColors.secondary
                      : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: controller.rememberMe.value
                  ? const Icon(Icons.check, size: 15, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 10),
            Text(
              'remember_me'.tr,
              style: TextStyle(
                color: AppColors.textSecondary(context),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _forgotPasswordButton() {
    return TextButton(
      onPressed: _showForgotPasswordDialog,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        'forgot_password'.tr,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: AppColors.secondary,
          fontSize: 14,
        ),
      ),
    );
  }

  // ============================================================
  // LOGIN BUTTON
  // ============================================================

  Widget _loginButton() {
    return Obx(() {
      final loading = controller.isLoading.value;

      return InkWell(
        onTap: loading ? null : () => controller.login(),
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
            height: 24,
            width: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: Colors.white,
            ),
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'sign_in'.tr,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
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
    });
  }

  // ============================================================
  // DIVIDER + SOCIAL
  // ============================================================

  Widget _divider(BuildContext context) {
    final line = AppColors.textPrimary(context).withValues(alpha: 0.12);

    return Row(
      children: [
        Expanded(child: Container(height: 1, color: line)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'or_continue_with'.tr,
            style: TextStyle(
              color: AppColors.textSecondary(context),
              fontSize: 13,
            ),
          ),
        ),
        Expanded(child: Container(height: 1, color: line)),
      ],
    );
  }

  void _comingSoon(String message) {
    Get.snackbar(
      'coming_soon'.tr,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primaryDark,
      colorText: Colors.white,
      borderRadius: 12,
      margin: const EdgeInsets.all(16),
    );
  }

  Widget _socialButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _socialButton(
          context,
          icon: FontAwesomeIcons.google,
          color: const Color(0xFFDB4437),
          onTap: controller.googleLogin,
          isLoading: controller.isGoogleLoading.value,
        ),
        const SizedBox(width: 18),
        _socialButton(
          context,
          icon: FontAwesomeIcons.facebook,
          color: const Color(0xFF1877F2),
          onTap: () => _comingSoon('facebook_soon'.tr),
          isLoading: false,
        ),
        const SizedBox(width: 18),
        _socialButton(
          context,
          icon: FontAwesomeIcons.linkedinIn,
          color: const Color(0xFF0A66C2),
          onTap: () => _comingSoon('linkedin_soon'.tr),
          isLoading: false,
        ),
      ],
    );
  }

  Widget _socialButton(
      BuildContext context, {
        required FaIconData icon,
        required Color color,
        required VoidCallback onTap,
        required bool isLoading,
      }) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 58,
        height: 58,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.cardBackground(context),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: isLoading
            ? const SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.secondary,
          ),
        )
            : FaIcon(icon, color: color, size: 24),
      ),
    );
  }

  // ============================================================
  // SIGN UP ROW
  // ============================================================

  Widget _signUpRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            'dont_have_account'.tr,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary(context),
            ),
          ),
        ),
        TextButton(
          onPressed: () => Get.to(() => SignupView()),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'sign_up'.tr,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: AppColors.secondary,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // FORGOT PASSWORD DIALOG
  // ============================================================

  void _showForgotPasswordDialog() {
    final emailController = TextEditingController();

    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Builder(
          builder: (context) {
            return Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: AppColors.cardBackground(context),
                borderRadius: BorderRadius.circular(24),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.orangeSoft(context),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.lock_reset,
                        color: AppColors.secondary,
                        size: 44,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'reset_password'.tr,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary(context),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'reset_password_sub'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: AppColors.secondary,
                      style: TextStyle(color: AppColors.textPrimary(context)),
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(
                          color: AppColors.textSecondary(context),
                        ),
                        filled: true,
                        fillColor: AppColors.textPrimary(context)
                            .withValues(alpha: 0.06),
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: AppColors.secondary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Get.back(),
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(0, 48),
                              foregroundColor: AppColors.textPrimary(context),
                              side: BorderSide(
                                color: AppColors.textPrimary(context)
                                    .withValues(alpha: 0.2),
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
                            onPressed: () {
                              if (emailController.text.isNotEmpty) {
                                controller.emailController.text =
                                    emailController.text;
                                controller.forgotPassword();
                                Get.back();
                              } else {
                                Get.snackbar(
                                  'error'.tr,
                                  'enter_email_error'.tr,
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red.shade600,
                                  colorText: Colors.white,
                                  borderRadius: 12,
                                  margin: const EdgeInsets.all(16),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(0, 48),
                            ),
                            child: Text('send_link'.tr),
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
}