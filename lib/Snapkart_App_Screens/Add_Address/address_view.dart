// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../Utilities_Screens/App_Colors/app_colors.dart';
// import 'address_controller.dart';
// import 'map_picker_view.dart';
//
// class AddAddressView extends StatelessWidget {
//   AddAddressView({super.key});
//
//   final AddAddressController controller = Get.put(AddAddressController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background(context),
//       appBar: AppBar(
//         title: Obx(
//           () => Text(
//             controller.isEditMode.value
//                 ? 'address_edit_title'.tr
//                 : 'address_add_title'.tr,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: AppColors.textPrimary(context),
//             ),
//           ),
//         ),
//         backgroundColor: AppColors.cardBackground(context),
//         foregroundColor: AppColors.textPrimary(context),
//         elevation: 0.5,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // ── Form Card ──
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: AppColors.cardBackground(context),
//                 borderRadius: BorderRadius.circular(14),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.06),
//                     blurRadius: 8,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   _buildField(
//                     context: context,
//                     controller: controller.nameController,
//                     label: 'your_name'.tr,
//                     hint: 'e.g. Ahmad Sultan',
//                     icon: Icons.person_outline,
//                   ),
//                   const SizedBox(height: 16),
//                   _buildField(
//                     context: context,
//                     controller: controller.phoneController,
//                     label: 'phone_number'.tr,
//                     hint: 'e.g. 03001234567',
//                     icon: Icons.phone_outlined,
//                     keyboardType: TextInputType.phone,
//                   ),
//                   const SizedBox(height: 16),
//                   _buildField(
//                     context: context,
//                     controller: controller.streetController,
//                     label: 'street'.tr,
//                     hint: 'e.g. House 12, Street 5, Gulberg',
//                     icon: Icons.home_outlined,
//                   ),
//                   const SizedBox(height: 16),
//                   _buildField(
//                     context: context,
//                     controller: controller.cityController,
//                     label: 'city'.tr,
//                     hint: 'e.g. Lahore',
//                     icon: Icons.location_city_outlined,
//                   ),
//                   const SizedBox(height: 16),
//                   _buildField(
//                     context: context,
//                     controller: controller.provinceController,
//                     label: 'province'.tr,
//                     hint: 'e.g. Punjab',
//                     icon: Icons.map_outlined,
//                   ),
//
//                   // const SizedBox(height: 16),
//                   // _buildField(
//                   //   context: context,
//                   //   controller: controller.provinceController,
//                   //   label: 'province'.tr,
//                   //   hint: 'e.g. Punjab',
//                   //   icon: Icons.map_outlined,
//                   // ),
//                   const SizedBox(height: 110),
//
//                   // NEW: Pick on Map button
//                   SizedBox(
//                     width: double.infinity,
//                     height: 48,
//                     child: OutlinedButton.icon(
//                       onPressed: () async {
//                         final result = await Get.to(
//                           () => const MapPickerView(),
//                         );
//                         if (result != null) {
//                           controller.setPickedLocation(
//                             result['lat'],
//                             result['lng'],
//                             result['address'],
//                           );
//                         }
//                       },
//                       icon: const Icon(
//                         Icons.location_on_outlined,
//                         color: AppColors.secondary,
//                       ),
//                       label: Text(
//                         'pick_on_map'.tr,
//                         style: const TextStyle(
//                           color: AppColors.secondary,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       style: OutlinedButton.styleFrom(
//                         side: const BorderSide(color: AppColors.secondary),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 30),
//
//             // ── Save Button ──
//             Obx(
//               () => SizedBox(
//                 width: double.infinity,
//                 height: 54,
//                 child: ElevatedButton(
//                   onPressed: controller.isSaving.value
//                       ? null
//                       : controller.saveAddress,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.secondary,
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                   ),
//                   child: controller.isSaving.value
//                       ? const CircularProgressIndicator(color: Colors.white)
//                       : Text(
//                           controller.isEditMode.value
//                               ? 'address_update_btn'.tr
//                               : 'address_save_btn'.tr,
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildField({
//     required BuildContext context,
//     required TextEditingController controller,
//     required String label,
//     required String hint,
//     required IconData icon,
//     TextInputType keyboardType = TextInputType.text,
//   }) {
//     return TextField(
//       controller: controller,
//       keyboardType: keyboardType,
//       style: TextStyle(color: AppColors.textPrimary(context)),
//       decoration: InputDecoration(
//         labelText: label,
//         hintText: hint,
//         prefixIcon: Icon(icon, color: AppColors.secondary),
//         filled: true,
//         fillColor: AppColors.background(context),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color:  AppColors.secondary, width: 1.5),
//         ),
//         labelStyle: TextStyle(color: AppColors.textSecondary(context)),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../Utilities_Screens/App_Colors/app_colors.dart';
// import '../../Utilities_Screens/App_Colors/app_widgets.dart';
// import 'address_controller.dart';
// import 'map_picker_view.dart';
//
// class AddAddressView extends StatelessWidget {
//   AddAddressView({super.key});
//
//   final AddAddressController controller = Get.put(AddAddressController());
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
//         title: Obx(
//           () => Text(
//             controller.isEditMode.value
//                 ? 'address_edit_title'.tr
//                 : 'address_add_title'.tr,
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.w900,
//               color: AppColors.textPrimary(context),
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//         padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // ── Pick on Map ──
//             _mapButton(context),
//             const SizedBox(height: 20),
//
//             // ── Section title ──
//             Row(
//               children: [
//                 const IconBox(
//                   Icons.location_on_outlined,
//                   color: AppColors.success,
//                 ),
//                 const SizedBox(width: 12),
//                 Text(
//                   'delivery_address'.tr,
//                   style: TextStyle(
//                     fontSize: 17,
//                     fontWeight: FontWeight.w800,
//                     color: AppColors.textPrimary(context),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//
//             // ── Fields ──
//             _buildField(
//               context: context,
//               textController: controller.nameController,
//               label: 'your_name'.tr,
//               hint: 'e.g. Ahmad Sultan',
//               icon: Icons.person_outline,
//             ),
//             const SizedBox(height: 18),
//             _buildField(
//               context: context,
//               textController: controller.phoneController,
//               label: 'phone_number'.tr,
//               hint: 'e.g. 03001234567',
//               icon: Icons.phone_outlined,
//               keyboardType: TextInputType.phone,
//             ),
//             const SizedBox(height: 18),
//             _buildField(
//               context: context,
//               textController: controller.streetController,
//               label: 'street'.tr,
//               hint: 'e.g. House 12, Street 5, Gulberg',
//               icon: Icons.home_outlined,
//             ),
//             const SizedBox(height: 18),
//             _buildField(
//               context: context,
//               textController: controller.cityController,
//               label: 'city'.tr,
//               hint: 'e.g. Lahore',
//               icon: Icons.location_city_outlined,
//             ),
//             const SizedBox(height: 18),
//             _buildField(
//               context: context,
//               textController: controller.provinceController,
//               label: 'province'.tr,
//               hint: 'e.g. Punjab',
//               icon: Icons.map_outlined,
//             ),
//
//             const SizedBox(height: 32),
//
//             // ── Save Button ──
//             _saveButton(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ============================================================
//   // PICK ON MAP
//   // ============================================================
//
//   Widget _mapButton(BuildContext context) {
//     return InkWell(
//       onTap: () async {
//         final result = await Get.to(() => const MapPickerView());
//         if (result != null) {
//           controller.setPickedLocation(
//             result['lat'],
//             result['lng'],
//             result['address'],
//           );
//         }
//       },
//       borderRadius: BorderRadius.circular(20),
//       child: Container(
//         padding: const EdgeInsets.all(14),
//         decoration: BoxDecoration(
//           color: AppColors.orangeSoft(context),
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(
//             color: AppColors.secondary.withValues(alpha: 0.4),
//             width: 1.5,
//           ),
//         ),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(10),
//               decoration: const BoxDecoration(
//                 color: AppColors.secondary,
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.my_location,
//                 color: Colors.white,
//                 size: 22,
//               ),
//             ),
//             const SizedBox(width: 14),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'pick_on_map'.tr,
//                     style: const TextStyle(
//                       color: AppColors.secondary,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w800,
//                     ),
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     'Fill your street automatically from the map',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: AppColors.textSecondary(context),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const Icon(
//               Icons.chevron_right,
//               color: AppColors.secondary,
//               size: 24,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ============================================================
//   // TEXT FIELD
//   // ============================================================
//
//   Widget _buildField({
//     required BuildContext context,
//     required TextEditingController textController,
//     required String label,
//     required String hint,
//     required IconData icon,
//     TextInputType keyboardType = TextInputType.text,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontWeight: FontWeight.w700,
//             fontSize: 14,
//             color: AppColors.textPrimary(context),
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withValues(alpha: 0.05),
//                 blurRadius: 12,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: TextField(
//             controller: textController,
//             keyboardType: keyboardType,
//             cursorColor: AppColors.secondary,
//             style: TextStyle(
//               fontSize: 16,
//               color: AppColors.textPrimary(context),
//             ),
//             decoration: InputDecoration(
//               hintText: hint,
//               hintStyle: TextStyle(
//                 color: AppColors.textSecondary(context).withValues(alpha: 0.7),
//               ),
//               filled: true,
//               fillColor: AppColors.cardBackground(context),
//               prefixIcon: Icon(icon, color: AppColors.secondary, size: 22),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16),
//                 borderSide: BorderSide.none,
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16),
//                 borderSide: BorderSide.none,
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16),
//                 borderSide: const BorderSide(
//                   color: AppColors.secondary,
//                   width: 1.5,
//                 ),
//               ),
//               contentPadding: const EdgeInsets.symmetric(
//                 horizontal: 18,
//                 vertical: 16,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   // ============================================================
//   // SAVE BUTTON
//   // ============================================================
//
//   Widget _saveButton() {
//     return Obx(() {
//       final saving = controller.isSaving.value;
//       final edit = controller.isEditMode.value;
//
//       return InkWell(
//         onTap: saving ? null : controller.saveAddress,
//         borderRadius: BorderRadius.circular(16),
//         child: Container(
//           height: 54,
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: saving
//                   ? [Colors.grey.shade400, Colors.grey.shade500]
//                   : AppColors.secondaryGradient,
//             ),
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: AppColors.secondary.withValues(alpha: 0.3),
//                 blurRadius: 12,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: saving
//               ? const SizedBox(
//                   height: 24,
//                   width: 24,
//                   child: CircularProgressIndicator(
//                     strokeWidth: 2.5,
//                     color: Colors.white,
//                   ),
//                 )
//               : Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       edit ? Icons.check_circle_outline : Icons.save_outlined,
//                       color: Colors.white,
//                       size: 22,
//                     ),
//                     const SizedBox(width: 10),
//                     Text(
//                       edit ? 'address_update_btn'.tr : 'address_save_btn'.tr,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w800,
//                       ),
//                     ),
//                   ],
//                 ),
//         ),
//       );
//     });
//   }
// }




import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utilities_Screens/App_Colors/app_colors.dart';
import '../../Utilities_Screens/App_Colors/app_widgets.dart';
import 'address_controller.dart';
import 'map_picker_view.dart';

class AddAddressView extends StatelessWidget {
  AddAddressView({super.key});

  final AddAddressController controller = Get.put(AddAddressController());

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
        title: Obx(
              () => Text(
            controller.isEditMode.value
                ? 'address_edit_title'.tr
                : 'address_add_title'.tr,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary(context),
            ),
          ),
        ),
        // NAYA - Clear button (right side): poora form khali kar deta hai
        actions: [
          TextButton.icon(
            onPressed: controller.clearForm,
            icon: const Icon(
              Icons.delete_sweep_outlined,
              size: 20,
              color: AppColors.secondary,
            ),
            label: const Text(
              'Clear',
              style: TextStyle(
                color: AppColors.secondary,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Pick on Map ──
            _mapButton(context),
            const SizedBox(height: 20),

            // ── Section title ──
            Row(
              children: [
                const IconBox(
                  Icons.location_on_outlined,
                  color: AppColors.success,
                ),
                const SizedBox(width: 12),
                Text(
                  'delivery_address'.tr,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // ── Fields ──
            _buildField(
              context: context,
              textController: controller.nameController,
              label: 'your_name'.tr,
              hint: 'e.g. Ahmad Sultan',
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 18),
            _buildField(
              context: context,
              textController: controller.phoneController,
              label: 'phone_number'.tr,
              hint: 'e.g. 03001234567',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 18),
            _buildField(
              context: context,
              textController: controller.streetController,
              label: 'street'.tr,
              hint: 'e.g. House 12, Street 5, Gulberg',
              icon: Icons.home_outlined,
            ),
            const SizedBox(height: 18),
            _buildField(
              context: context,
              textController: controller.cityController,
              label: 'city'.tr,
              hint: 'e.g. Lahore',
              icon: Icons.location_city_outlined,
            ),
            const SizedBox(height: 18),
            _buildField(
              context: context,
              textController: controller.provinceController,
              label: 'province'.tr,
              hint: 'e.g. Punjab',
              icon: Icons.map_outlined,
            ),

            const SizedBox(height: 32),

            // ── Save Button ──
            _saveButton(),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // PICK ON MAP
  // ============================================================

  Widget _mapButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        final result = await Get.to(() => const MapPickerView());
        if (result != null) {
          controller.setPickedLocation(
            result['lat'],
            result['lng'],
            result['address'],
          );
        }
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.orangeSoft(context),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.secondary.withValues(alpha: 0.4),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: AppColors.secondary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.my_location,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'pick_on_map'.tr,
                    style: const TextStyle(
                      color: AppColors.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Fill your street automatically from the map',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary(context),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.secondary,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // TEXT FIELD
  // ============================================================

  Widget _buildField({
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
  // SAVE BUTTON
  // ============================================================

  Widget _saveButton() {
    return Obx(() {
      final saving = controller.isSaving.value;
      final edit = controller.isEditMode.value;

      return InkWell(
        onTap: saving ? null : controller.saveAddress,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 54,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: saving
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
          child: saving
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
              Icon(
                edit ? Icons.check_circle_outline : Icons.save_outlined,
                color: Colors.white,
                size: 22,
              ),
              const SizedBox(width: 10),
              Text(
                edit ? 'address_update_btn'.tr : 'address_save_btn'.tr,
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