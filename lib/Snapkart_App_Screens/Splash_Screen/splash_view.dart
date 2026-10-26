// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:snapkart/Snapkart_App_Screens/Splash_Screen/splash_controller.dart';
//
// class SplashView extends StatelessWidget {
//   const SplashView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final SplashController controller = Get.put(SplashController());
//
//     return Scaffold(
//       backgroundColor: Colors.deepPurple.shade900,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Obx(
//                   () => AnimatedOpacity(
//                 duration: const Duration(milliseconds: 800),
//                 opacity: controller.opacity.value,
//                 child: AnimatedScale(
//                   duration: const Duration(milliseconds: 800),
//                   scale: controller.scale.value,
//                   child: Column(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(30),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.white.withOpacity(0.2),
//                               blurRadius: 30,
//                               spreadRadius: 5,
//                             ),
//                           ],
//                         ),
//                         child: const Icon(
//                           Icons.shopping_bag_rounded,
//                           size: 80,
//                           color: Colors.white,
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       // Brand name "SnapKart" translate nahi hota
//                       const Text(
//                         'SnapKart',
//                         style: TextStyle(
//                           fontSize: 40,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           letterSpacing: 2,
//                           shadows: [
//                             Shadow(blurRadius: 10, color: Colors.white38),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         'modern_shopping'.tr,
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.white.withOpacity(0.7),
//                           letterSpacing: 4,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 60),
//
//             Obx(
//                   () => Column(
//                 children: [
//                   Container(
//                     width: 200,
//                     height: 4,
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: FractionallySizedBox(
//                       alignment: Alignment.centerLeft,
//                       widthFactor: controller.progress.value,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           gradient: const LinearGradient(
//                             colors: [Colors.orange, Colors.pink],
//                           ),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     '${(controller.progress.value * 100).toInt()}%',
//                     style: TextStyle(
//                       color: Colors.white.withOpacity(0.6),
//                       fontSize: 12,
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
// }








import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snapkart/Snapkart_App_Screens/Splash_Screen/splash_controller.dart';
//import 'package:snapkart/core/app_colors.dart';

import 'package:snapkart/Utilities_Screens/App_Colors/app_colors.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashController controller = Get.put(SplashController());
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFEAF6F3), Colors.white],
          ),
        ),
        child: Stack(
          children: [
            // Top-left teal blob
            Positioned(
              top: -size.width * 0.45,
              left: -size.width * 0.45,
              child: Container(
                width: size.width * 1.1,
                height: size.width * 1.1,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [
                      AppColors.primaryLight,
                      AppColors.primary,
                      AppColors.primaryDark,
                    ],
                  ),
                ),
              ),
            ),

            // Bottom-right orange blob
            Positioned(
              bottom: -size.width * 0.35,
              right: -size.width * 0.3,
              child: Container(
                width: size.width * 0.9,
                height: size.width * 0.9,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: AppColors.secondaryGradient,
                  ),
                ),
              ),
            ),

            // Bottom teal blob
            Positioned(
              bottom: -size.width * 0.5,
              left: -size.width * 0.2,
              child: Container(
                width: size.width * 1.4,
                height: size.width * 1.1,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primaryLight,
                      AppColors.primary,
                      AppColors.primaryDark,
                    ],
                  ),
                ),
              ),
            ),

            // Center content
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(
                        () => AnimatedOpacity(
                      duration: const Duration(milliseconds: 800),
                      opacity: controller.opacity.value,
                      child: AnimatedScale(
                        duration: const Duration(milliseconds: 800),
                        scale: controller.scale.value,
                        child: Column(
                          children: [
                            // Logo box
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: AppColors.primaryGradient,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.secondary
                                        .withValues(alpha: 0.25),
                                    blurRadius: 30,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(32),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Positioned(
                                      top: -30,
                                      right: -30,
                                      child: Container(
                                        width: 80,
                                        height: 80,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                            colors: AppColors.secondaryGradient,
                                          ),
                                        ),
                                      ),
                                    ),
                                    ShaderMask(
                                      shaderCallback: (rect) =>
                                          const LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.white,
                                              AppColors.secondaryLight,
                                            ],
                                          ).createShader(rect),
                                      child: const Icon(
                                        Icons.shopping_bag_rounded,
                                        size: 70,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Snap + Kart
                            const Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Snap',
                                    style: TextStyle(color: AppColors.ink),
                                  ),
                                  TextSpan(
                                    text: 'Kart',
                                    style:
                                    TextStyle(color: AppColors.secondary),
                                  ),
                                ],
                              ),
                              style: TextStyle(
                                fontSize: 44,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -1,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'modern_shopping'.tr,
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.ink.withValues(alpha: 0.75),
                                letterSpacing: 4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),

                  // Progress bar
                  Obx(
                        () => Column(
                      children: [
                        Container(
                          width: 220,
                          height: 10,
                          decoration: BoxDecoration(
                            color: AppColors.trackGrey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: controller.progress.value,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    AppColors.secondary,
                                    AppColors.secondaryLight,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${(controller.progress.value * 100).toInt()}%',
                          style: TextStyle(
                            color: AppColors.ink.withValues(alpha: 0.8),
                            fontSize: 13,
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
    );
  }
}