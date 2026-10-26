import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Utilities_Screens/App_Colors/app_colors.dart';
import '../Main_Nav/main_nav_controller.dart';
import 'home_controller.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: AppBar(
        title: const Text('Categories'),
        backgroundColor: AppColors.background(context),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Obx(
            () => GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.3,
          ),
          itemCount: controller.categories.length,
          itemBuilder: (context, i) {
            final cat = controller.categories[i];

            return GestureDetector(
              onTap: () {
                controller.filterByCategory(cat);
                MainNavController.instance.changeTab(0);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.cardBackground(context),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      controller.getCategoryIcon(cat),
                      size: 32,
                      color: AppColors.secondary,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      cat,
                      style: TextStyle(color: AppColors.textPrimary(context)),
                    ),
                    Text(
                      '${controller.categoryCounts[cat] ?? 0} items',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary(context),
                      ),
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