// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:snapkart/Snapkart_App_Screens/Signup_Screen/signup_cont.dart';
//
// import '../../Utilities_Screens/App_Colors/app_colors.dart';
// import '../../Utilities_Screens/Auth_Services/auth_services.dart';
// import '../Login_Screen/login_view.dart';
//
// class SignupView extends StatelessWidget {
//   final SignupController controller = Get.put(SignupController());
//   final AuthService con = Get.put(AuthService());
//   SignupView({super.key});
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
//         appBar: _buildModernAppBar(),
//         body: SafeArea(
//           child: SingleChildScrollView(
//             physics: const BouncingScrollPhysics(),
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             child: Obx(
//               () => AnimatedOpacity(
//                 duration: const Duration(milliseconds: 600),
//                 opacity: controller.animationValue.value,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     _buildWelcomeText(),
//
//                     Center(
//                       child: Obx(
//                         () => GestureDetector(
//                           onTap: () => controller.pickImage(),
//                           child: Stack(
//                             children: [
//                               CircleAvatar(
//                                 radius: 55,
//                                 backgroundColor: Colors.white.withOpacity(0.08),
//                                 backgroundImage:
//                                     controller.profileImage.value != null
//                                     ? FileImage(controller.profileImage.value!)
//                                     : null,
//                                 child: controller.profileImage.value == null
//                                     ? Icon(
//                                         Icons.person_outline,
//                                         size: 50,
//                                         color: Colors.grey.shade500,
//                                       )
//                                     : null,
//                               ),
//                               Positioned(
//                                 bottom: 0,
//                                 right: 0,
//                                 child: Container(
//                                   padding: const EdgeInsets.all(6),
//                                   decoration: BoxDecoration(
//                                     color: AppColors.secondary,
//                                     shape: BoxShape.circle,
//                                     border: Border.all(
//                                       color: AppColors.primary,
//                                       width: 2,
//                                     ),
//                                   ),
//                                   child: const Icon(
//                                     Icons.camera_alt,
//                                     size: 18,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//
//                     const SizedBox(height: 20),
//
//                     const SizedBox(height: 30),
//
//                     _buildModernTextField(
//                       label: 'first_name'.tr,
//                       hintText: 'Enter your first name',
//                       errorText: controller.firstNameError.value,
//                       onChanged: (value) => controller.firstName.value = value,
//                       prefixIcon: Icons.person_2_outlined,
//                       isFocused: controller.isFirstNameFocused,
//                     ),
//
//                     const SizedBox(height: 18),
//
//                     _buildModernTextField(
//                       label: 'last_name'.tr,
//                       hintText: 'Enter your last name',
//                       errorText: controller.lastNameError.value,
//                       onChanged: (value) => controller.lastName.value = value,
//                       prefixIcon: Icons.person_outline,
//                       isFocused: controller.isLastNameFocused,
//                     ),
//
//                     const SizedBox(height: 18),
//
//                     _buildModernTextField(
//                       label: 'email_address'.tr,
//                       hintText: 'Enter your email',
//                       errorText: controller.emailError.value,
//                       onChanged: (value) => controller.email.value = value,
//                       keyboardType: TextInputType.emailAddress,
//                       prefixIcon: Icons.email_outlined,
//                       isFocused: controller.isEmailFocused,
//                     ),
//
//                     const SizedBox(height: 18),
//
//                     _buildModernPasswordField(
//                       label: 'password'.tr,
//                       hintText: 'Enter your password',
//                       errorText: controller.passwordError.value,
//                       onChanged: (value) => controller.password.value = value,
//                       isVisible: controller.isPasswordVisible,
//                       onToggle: controller.togglePasswordVisibility,
//                       isFocused: controller.isPasswordFocused,
//                     ),
//
//                     const SizedBox(height: 18),
//
//                     _buildModernPasswordField(
//                       label: 'confirm_password'.tr,
//                       hintText: 'Confirm your password',
//                       errorText: controller.confirmPasswordError.value,
//                       onChanged: (value) =>
//                           controller.confirmPassword.value = value,
//                       isVisible: controller.isConfirmPasswordVisible,
//                       onToggle: controller.toggleConfirmPasswordVisibility,
//                       isFocused: controller.isConfirmPasswordFocused,
//                     ),
//
//                     const SizedBox(height: 28),
//
//                     _buildModernRegisterButton(),
//
//                     const SizedBox(height: 16),
//
//                     _buildLoginLink(),
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
//   PreferredSizeWidget _buildModernAppBar() {
//     return AppBar(
//       title: Text(
//         'create_account'.tr,
//         style: const TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 24,
//           color: Colors.white,
//           letterSpacing: 0.5,
//         ),
//       ),
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       centerTitle: true,
//       leading: Container(
//         margin: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: IconButton(
//           icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
//           onPressed: () => Get.back(),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildWelcomeText() {
//     return Column(
//       children: [
//         Text(
//           'join_us_today'.tr,
//           style: TextStyle(
//             fontSize: 28,
//             fontWeight: FontWeight.bold,
//             color: AppColors.secondary,
//             letterSpacing: 0.5,
//           ),
//           textAlign: TextAlign.center,
//         ),
//         const SizedBox(height: 8),
//         Text(
//           'join_us_sub'.tr,
//           style: TextStyle(
//             fontSize: 14,
//             color: Colors.grey.shade400,
//             letterSpacing: 0.3,
//           ),
//           textAlign: TextAlign.center,
//         ),
//       ],
//     );
//   }
//
//   Widget _buildModernTextField({
//     required String label,
//     required String hintText,
//     required String errorText,
//     required Function(String) onChanged,
//     TextInputType keyboardType = TextInputType.text,
//     IconData? prefixIcon,
//     required RxBool isFocused,
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
//             onChanged: onChanged,
//             keyboardType: keyboardType,
//             style: const TextStyle(color: Colors.white, fontSize: 16),
//             cursorColor: AppColors.secondary,
//             onTap: () {
//               if (label == 'first_name'.tr)
//                 controller.firstNameError.value = '';
//               if (label == 'last_name'.tr) controller.lastNameError.value = '';
//               if (label == 'email_address'.tr) controller.emailError.value = '';
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
//   Widget _buildModernPasswordField({
//     required String label,
//     required String hintText,
//     required String errorText,
//     required Function(String) onChanged,
//     required RxBool isVisible,
//     required VoidCallback onToggle,
//     required RxBool isFocused,
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
//           child: Obx(
//             () => TextField(
//               onChanged: onChanged,
//               obscureText: !isVisible.value,
//               style: const TextStyle(color: Colors.white, fontSize: 16),
//               cursorColor: AppColors.secondary,
//               onTap: () {
//                 if (label == 'password'.tr) {
//                   controller.passwordError.value = '';
//                 } else {
//                   controller.confirmPasswordError.value = '';
//                 }
//               },
//               decoration: InputDecoration(
//                 hintText: hintText,
//                 hintStyle: TextStyle(color: Colors.grey.shade600),
//                 prefixIcon: const Icon(
//                   Icons.lock_outline,
//                   color: AppColors.secondary,
//                   size: 22,
//                 ),
//                 suffixIcon: IconButton(
//                   icon: Icon(
//                     isVisible.value ? Icons.visibility_off : Icons.visibility,
//                     color: Colors.grey.shade400,
//                     size: 20,
//                   ),
//                   onPressed: onToggle,
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
//   Widget _buildModernRegisterButton() {
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
//               : () => controller.register(),
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
//                   'create_account'.tr,
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
//   Widget _buildLoginLink() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           'already_have_account'.tr,
//           style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
//         ),
//         TextButton(
//           onPressed: () {
//             Get.offAll(() => LoginView());
//           },
//           style: TextButton.styleFrom(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             minimumSize: Size.zero,
//             tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//           ),
//           child: Text(
//             'login'.tr,
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
// }





import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:snapkart/Snapkart_App_Screens/Signup_Screen/signup_cont.dart';

import '../../Utilities_Screens/App_Colors/app_colors.dart';
import '../../Utilities_Screens/App_Colors/app_widgets.dart';
import '../../Utilities_Screens/Auth_Services/auth_services.dart';
import '../Login_Screen/login_view.dart';

class SignupView extends StatelessWidget {
  final SignupController controller = Get.put(SignupController());
  final AuthService con = Get.put(AuthService());
  SignupView({super.key});

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
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 100),
                child: Obx(
                      () => AnimatedOpacity(
                    duration: const Duration(milliseconds: 600),
                    opacity: controller.animationValue.value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _backButton(),
                        const SizedBox(height: 6),
                        _header(context),
                        const SizedBox(height: 22),

                        _avatarPicker(context),
                        const SizedBox(height: 26),

                        _field(
                          context: context,
                          label: 'first_name'.tr,
                          hint: 'Enter your first name',
                          error: controller.firstNameError.value,
                          icon: Icons.person_2_outlined,
                          onChanged: (v) => controller.firstName.value = v,
                          onTap: () => controller.firstNameError.value = '',
                        ),
                        const SizedBox(height: 18),

                        _field(
                          context: context,
                          label: 'last_name'.tr,
                          hint: 'Enter your last name',
                          error: controller.lastNameError.value,
                          icon: Icons.person_outline,
                          onChanged: (v) => controller.lastName.value = v,
                          onTap: () => controller.lastNameError.value = '',
                        ),
                        const SizedBox(height: 18),

                        _field(
                          context: context,
                          label: 'email_address'.tr,
                          hint: 'Enter your email',
                          error: controller.emailError.value,
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (v) => controller.email.value = v,
                          onTap: () => controller.emailError.value = '',
                        ),
                        const SizedBox(height: 18),

                        _passwordField(
                          context: context,
                          label: 'password'.tr,
                          hint: 'Enter your password',
                          error: controller.passwordError.value,
                          isVisible: controller.isPasswordVisible,
                          onToggle: controller.togglePasswordVisibility,
                          onChanged: (v) => controller.password.value = v,
                          onTap: () => controller.passwordError.value = '',
                        ),
                        const SizedBox(height: 18),

                        _passwordField(
                          context: context,
                          label: 'confirm_password'.tr,
                          hint: 'Confirm your password',
                          error: controller.confirmPasswordError.value,
                          isVisible: controller.isConfirmPasswordVisible,
                          onToggle: controller.toggleConfirmPasswordVisibility,
                          onChanged: (v) =>
                          controller.confirmPassword.value = v,
                          onTap: () =>
                          controller.confirmPasswordError.value = '',
                        ),
                        const SizedBox(height: 28),

                        _registerButton(),
                        const SizedBox(height: 18),

                        _loginLink(context),
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
  // BACKGROUND (login/splash jaisi teal + orange shapes)
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
  // BACK BUTTON + HEADER
  // ============================================================

  Widget _backButton() {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Icon(
            Icons.arrow_back_rounded,
            size: 22,
            color: AppColors.primaryDark,
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Column(
      children: [
        const SnapKartLogo(size: 30),
        const SizedBox(height: 16),
        Text(
          'create_account'.tr,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: AppColors.textPrimary(context),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'join_us_sub'.tr,
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
  // PROFILE PHOTO PICKER
  // ============================================================

  Widget _avatarPicker(BuildContext context) {
    return Center(
      child: Obx(() {
        final file = controller.profileImage.value;

        return GestureDetector(
          onTap: () => controller.pickImage(),
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: AppColors.secondaryGradient),
                ),
                child: CircleAvatar(
                  radius: 52,
                  backgroundColor: AppColors.cardBackground(context),
                  backgroundImage: file != null ? FileImage(file) : null,
                  child: file == null
                      ? Icon(
                    Icons.person_outline,
                    size: 48,
                    color: AppColors.textSecondary(context),
                  )
                      : null,
                ),
              ),
              Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.cardBackground(context),
                      width: 2.5,
                    ),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 17,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // ============================================================
  // TEXT FIELDS
  // ============================================================

  Widget _field({
    required BuildContext context,
    required String label,
    required String hint,
    required String error,
    required IconData icon,
    required Function(String) onChanged,
    required VoidCallback onTap,
    TextInputType keyboardType = TextInputType.text,
    bool obscure = false,
    Widget? suffix,
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
            onChanged: onChanged,
            onTap: onTap,
            keyboardType: keyboardType,
            obscureText: obscure,
            cursorColor: AppColors.secondary,
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

  Widget _passwordField({
    required BuildContext context,
    required String label,
    required String hint,
    required String error,
    required RxBool isVisible,
    required VoidCallback onToggle,
    required Function(String) onChanged,
    required VoidCallback onTap,
  }) {
    // Observable (isVisible.value) Obx ke builder ke andar hi parha ja raha hai
    return Obx(() {
      final visible = isVisible.value;

      return _field(
        context: context,
        label: label,
        hint: hint,
        error: error,
        icon: Icons.lock_outline,
        obscure: !visible,
        onChanged: onChanged,
        onTap: onTap,
        suffix: IconButton(
          icon: Icon(
            visible ? Icons.visibility_off : Icons.visibility,
            color: AppColors.textSecondary(context),
            size: 20,
          ),
          onPressed: onToggle,
        ),
      );
    });
  }

  // ============================================================
  // REGISTER BUTTON
  // ============================================================

  Widget _registerButton() {
    return Obx(() {
      final loading = controller.isLoading.value;

      return InkWell(
        onTap: loading ? null : () => controller.register(),
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
                'create_account'.tr,
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
  // LOGIN LINK
  // ============================================================

  Widget _loginLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            'already_have_account'.tr,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary(context),
            ),
          ),
        ),
        TextButton(
          onPressed: () => Get.offAll(() => LoginView()),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'login'.tr,
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
}