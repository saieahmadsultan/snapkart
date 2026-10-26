// import 'package:flutter/material.dart';
//
// class AppColors {
//   static const Color primary = Color(0xFF1A1A2E); // Dark Navy
//   static const Color secondary = Colors.deepOrange; // Vibrant Red/Pink
//   static const Color tertiary = Color(0xFFF5A623); // Golden Orange
//
//   // Gradient Colors
//   static const List<Color> primaryGradient = [
//     Color(0xFF1A1A2E),
//     Color(0xFF16213E),
//   ];
//
//   static const List<Color> secondaryGradient = [
//     Color(0xFFE94560),
//     Color(0xFFF5A623),
//   ];
//
//   static Color background(BuildContext context) {
//     return Theme.of(context).brightness == Brightness.dark
//         ? const Color(0xFF121212)
//         : const Color(0xFFF8F9FA);
//   }
//
//   static Color cardBackground(BuildContext context) {
//     return Theme.of(context).brightness == Brightness.dark
//         ? const Color(0xFF1E1E2E)
//         : Colors.white;
//   }
//
//   static Color textPrimary(BuildContext context) {
//     return Theme.of(context).brightness == Brightness.dark
//         ? Colors.white
//         : const Color(0xFF1A1A2E);
//   }
//
//   static Color textSecondary(BuildContext context) {
//     return Theme.of(context).brightness == Brightness.dark
//         ? Colors.grey[400]!
//         : const Color(0xFF6B7280);
//   }
// }








import 'package:flutter/material.dart';

class AppColors {
  // Brand colors
  static const Color primary = Color(0xFF0E7C74); // Teal
  static const Color primaryDark = Color(0xFF0B4F4D);
  static const Color primaryLight = Color(0xFF7CC4B5);
  static const Color secondary = Color(0xFFFF5A1F); // Brand orange
  static const Color secondaryLight = Color(0xFFFFA45C);
  static const Color tertiary = Color(0xFFF5A623); // Golden

  // Fixed colors
  static const Color ink = Color(0xFF0B1F2A); // "Snap" text ka dark color
  static const Color success = Color(0xFF0E9F8A); // discount badge, Delivered
  static const Color info = Color(0xFF3B82F6); // Shipped
  static const Color trackGrey = Color(0xFFDDE3E3);

  // Gradients
  static const List<Color> primaryGradient = [primary, primaryDark];
  static const List<Color> secondaryGradient = [secondaryLight, secondary];

  // Theme-aware colors
  static bool _dark(BuildContext c) => Theme.of(c).brightness == Brightness.dark;

  static Color background(BuildContext c) =>
      _dark(c) ? const Color(0xFF0F1A1A) : const Color(0xFFF6FAF9);

  static Color cardBackground(BuildContext c) =>
      _dark(c) ? const Color(0xFF17262A) : Colors.white;

  static Color textPrimary(BuildContext c) =>
      _dark(c) ? Colors.white : ink;

  static Color textSecondary(BuildContext c) =>
      _dark(c) ? Colors.grey[400]! : const Color(0xFF6B7280);

  static Color orangeSoft(BuildContext c) =>
      _dark(c) ? secondary.withValues(alpha: 0.15) : const Color(0xFFFFEDE5);
}