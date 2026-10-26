// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
//
// import '../../Utilities_Screens/App_Colors/app_colors.dart';
// import 'fetch_controller.dart';
//
// class FetchView extends StatelessWidget {
//   FetchView({super.key});
//
//   final FetchController controller = Get.put(
//     FetchController(),
//     permanent: true,
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background(context),
//       appBar: AppBar(
//         elevation: 0,
//         iconTheme: IconThemeData(color: AppColors.textPrimary(context)),
//         backgroundColor: Colors.transparent,
//         centerTitle: true,
//         title: Text(
//           'user_information'.tr,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 27,
//             color: AppColors.secondary,
//             letterSpacing: 1,
//           ),
//         ),
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value &&
//             controller.firstNameController.text.isEmpty) {
//           return const Center(
//             child: CircularProgressIndicator(color: AppColors.secondary),
//           );
//         }
//
//         return SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             child: Column(
//               children: [
//                 _buildAnimatedHeader(context),
//                 const SizedBox(height: 20),
//                 Obx(() => _buildUserProfileCard(context)),
//                 const SizedBox(height: 24),
//                 _buildSectionTitle('edit_profile_info'.tr),
//                 const SizedBox(height: 16),
//                 _buildModernTextField(
//                   context: context,
//                   controller: controller.firstNameController,
//                   hintText: "John",
//                   labelText: 'first_name'.tr,
//                   icon: Icons.person_outline,
//                 ),
//                 const SizedBox(height: 20),
//                 _buildModernTextField(
//                   context: context,
//                   controller: controller.lastNameController,
//                   hintText: "Doe",
//                   labelText: 'last_name'.tr,
//                   icon: Icons.person_outline,
//                 ),
//                 const SizedBox(height: 20),
//                 _buildModernTextField(
//                   context: context,
//                   controller: controller.emailController,
//                   hintText: "john.doe@example.com",
//                   labelText: 'email_address'.tr,
//                   icon: Icons.email_outlined,
//                   keyboardType: TextInputType.emailAddress,
//                 ),
//                 const SizedBox(height: 40),
//                 _buildUpdateButton(),
//                 const SizedBox(height: 30),
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//   }
//
//   BoxDecoration _glassDecoration(BuildContext context, {double radius = 20}) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     return BoxDecoration(
//       gradient: isDark
//           ? LinearGradient(
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//         colors: [
//           Colors.white.withOpacity(0.1),
//           Colors.white.withOpacity(0.05),
//         ],
//       )
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
//         BoxShadow(
//           color: Colors.black.withOpacity(0.04),
//           blurRadius: 12,
//           offset: const Offset(0, 4),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildAnimatedHeader(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           height: 180,
//           width: 180,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 AppColors.secondary.withOpacity(0.3),
//                 AppColors.secondary.withOpacity(0.1),
//               ],
//             ),
//           ),
//           child: Lottie.asset(
//             "assets/animation/Login.json",
//             fit: BoxFit.contain,
//           ),
//         ),
//         const SizedBox(height: 16),
//         Text(
//           'update_your_profile'.tr,
//           style: TextStyle(
//             color: AppColors.textSecondary(context),
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           height: 3,
//           width: 50,
//           decoration: BoxDecoration(
//             color: AppColors.secondary,
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildUserProfileCard(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: _glassDecoration(context),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: AppColors.secondary.withOpacity(0.2),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               Icons.account_circle,
//               color: AppColors.secondary,
//               size: 40,
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   controller.displayName.value,
//                   style: TextStyle(
//                     color: AppColors.textPrimary(context),
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   controller.displayEmail.value,
//                   style: TextStyle(
//                     color: AppColors.textSecondary(context),
//                     fontSize: 14,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//             decoration: BoxDecoration(
//               color: AppColors.secondary.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Text(
//               'active'.tr,
//               style: TextStyle(
//                 color: AppColors.secondary,
//                 fontSize: 12,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSectionTitle(String title) {
//     return Row(
//       children: [
//         Container(
//           height: 4,
//           width: 30,
//           decoration: BoxDecoration(
//             color: AppColors.secondary,
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         const SizedBox(width: 12),
//         Text(
//           title,
//           style: TextStyle(
//             color: AppColors.secondary,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildModernTextField({
//     required BuildContext context,
//     required TextEditingController controller,
//     required String hintText,
//     required String labelText,
//     required IconData icon,
//     TextInputType keyboardType = TextInputType.text,
//   }) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           labelText,
//           style: TextStyle(
//             color: AppColors.textSecondary(context),
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             color: isDark
//                 ? Colors.white.withOpacity(0.05)
//                 : Colors.black.withOpacity(0.03),
//           ),
//           child: TextField(
//             style: TextStyle(color: AppColors.textPrimary(context)),
//             controller: controller,
//             cursorColor: AppColors.secondary,
//             keyboardType: keyboardType,
//             decoration: InputDecoration(
//               prefixIcon: Icon(icon, color: AppColors.secondary, size: 22),
//               hintText: hintText,
//               hintStyle: TextStyle(
//                 color: AppColors.textSecondary(context).withOpacity(0.7),
//                 fontSize: 14,
//               ),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16),
//                 borderSide: BorderSide.none,
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16),
//                 borderSide: BorderSide(color: AppColors.secondary, width: 1.5),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16),
//                 borderSide: BorderSide(
//                   color: isDark
//                       ? Colors.white.withOpacity(0.1)
//                       : Colors.black.withOpacity(0.08),
//                 ),
//               ),
//               contentPadding: const EdgeInsets.symmetric(
//                 horizontal: 16,
//                 vertical: 16,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildUpdateButton() {
//     return Obx(
//           () => Container(
//         width: double.infinity,
//         height: 55,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [AppColors.secondary, AppColors.secondary.withOpacity(0.7)],
//           ),
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: AppColors.secondary.withOpacity(0.3),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.transparent,
//             shadowColor: Colors.transparent,
//             foregroundColor: Colors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16),
//             ),
//           ),
//           onPressed: controller.isLoading.value
//               ? null
//               : () {
//             controller.updateUser();
//           },
//           child: controller.isLoading.value
//               ? const SizedBox(
//             height: 24,
//             width: 24,
//             child: CircularProgressIndicator(
//               strokeWidth: 2,
//               color: Colors.white,
//             ),
//           )
//               : Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(Icons.save_outlined, size: 22, color: Colors.white),
//               const SizedBox(width: 10),
//               Text(
//                 'update_information'.tr,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 0.5,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utilities_Screens/App_Colors/app_colors.dart';
import '../../Utilities_Screens/App_Colors/app_widgets.dart';
import 'fetch_controller.dart';

class FetchView extends StatelessWidget {
  FetchView({super.key});

  final FetchController controller = Get.put(
    FetchController(),
    permanent: true,
  );

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
          'user_information'.tr,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: AppColors.textPrimary(context),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value &&
            controller.firstNameController.text.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.secondary),
          );
        }

        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _profileCard(context),
              const SizedBox(height: 22),

              Row(
                children: [
                  const IconBox(Icons.edit_outlined),
                  const SizedBox(width: 12),
                  Text(
                    'edit_profile_info'.tr,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              _field(
                context: context,
                textController: controller.firstNameController,
                label: 'first_name'.tr,
                hint: 'John',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 18),

              _field(
                context: context,
                textController: controller.lastNameController,
                label: 'last_name'.tr,
                hint: 'Doe',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 18),

              _field(
                context: context,
                textController: controller.emailController,
                label: 'email_address'.tr,
                hint: 'john.doe@example.com',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6, top: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 14,
                      color: AppColors.textSecondary(context),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'If you change your email, a verification link will be sent to the new address.',
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.3,
                          color: AppColors.textSecondary(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),
              _updateButton(),
            ],
          ),
        );
      }),
    );
  }

  // ============================================================
  // PROFILE CARD
  // ============================================================

  Widget _profileCard(BuildContext context) {
    return Obx(() {
      final name = controller.displayName.value;
      final email = controller.displayEmail.value;
      final photo = controller.profileImage.value;
      final hasPhoto = photo.isNotEmpty;

      return Container(
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
                  // avatar (naam ka pehla harf)
                  // Container(
                  //   width: 64,
                  //   height: 64,
                  //   alignment: Alignment.center,
                  //   decoration: const BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     gradient: LinearGradient(
                  //       begin: Alignment.topLeft,
                  //       end: Alignment.bottomRight,
                  //       colors: AppColors.secondaryGradient,
                  //     ),
                  //   ),
                  //   child: Text(
                  //     name.isNotEmpty ? name[0].toUpperCase() : '?',
                  //     style: const TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 26,
                  //       fontWeight: FontWeight.w900,
                  //     ),
                  //   ),
                  // ),
                  Container(
                    width: 64,
                    height: 64,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: AppColors.secondaryGradient,
                      ),
                      image: hasPhoto
                          ? DecorationImage(
                              image: NetworkImage(photo),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: hasPhoto
                        ? null
                        : Text(
                            name.isNotEmpty ? name[0].toUpperCase() : '?',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                  ),

                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name.isEmpty ? '—' : name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary(context),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          email,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary(context),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.success.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 7,
                                height: 7,
                                decoration: const BoxDecoration(
                                  color: AppColors.success,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'active'.tr,
                                style: const TextStyle(
                                  color: AppColors.success,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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

  // ============================================================
  // TEXT FIELD
  // ============================================================

  Widget _field({
    required BuildContext context,
    required TextEditingController textController,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
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
            cursorColor: AppColors.secondary,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textPrimary(context),
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: AppColors.textSecondary(context).withValues(alpha: 0.7),
              ),
              filled: true,
              fillColor: AppColors.cardBackground(context),
              prefixIcon: Icon(icon, color: AppColors.secondary, size: 22),
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
      ],
    );
  }

  // ============================================================
  // UPDATE BUTTON
  // ============================================================

  Widget _updateButton() {
    return Obx(() {
      final loading = controller.isLoading.value;

      return InkWell(
        onTap: loading ? null : controller.updateUser,
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
                    const Icon(
                      Icons.save_outlined,
                      size: 22,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'update_information'.tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
        ),
      );
    });
  }
}
