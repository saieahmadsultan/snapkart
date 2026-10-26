// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../Utilities_Screens/App_Model/app_model.dart';
//
// class WishlistController extends GetxController {
//   static WishlistController get instance => Get.find();
//
//   var wishlistItems = <ModelClass>[].obs;
//
//   static const String _wishlistKey = 'wishlist_items';
//
//   @override
//   void onInit() {
//     super.onInit();
//     _loadWishlist();
//   }
//
//   Future<void> _loadWishlist() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final String? jsonString = prefs.getString(_wishlistKey);
//
//       if (jsonString != null) {
//         final List<dynamic> jsonList = jsonDecode(jsonString);
//         final items = jsonList
//             .map((json) => ModelClass.fromJson(json))
//             .toList();
//         wishlistItems.assignAll(items);
//       }
//     } catch (e) {
//       debugPrint('Wishlist load error: $e');
//     }
//   }
//
//
//   Future<void> _saveWishlist() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final jsonList = wishlistItems.map((item) => item.toJson()).toList();
//       await prefs.setString(_wishlistKey, jsonEncode(jsonList));
//     } catch (e) {
//       debugPrint('Wishlist save error: $e');
//     }
//   }
//
//
//   void toggleWishlist(ModelClass product) {
//     final exists = wishlistItems.any((item) => item.id == product.id);
//
//     if (exists) {
//       wishlistItems.removeWhere((item) => item.id == product.id);
//       _saveWishlist();
//       Get.snackbar(
//         'Removed from Wishlist',
//         '${product.title ?? 'Product'} removed',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.grey.shade200,
//         colorText: Colors.grey.shade700,
//         duration: const Duration(seconds: 1),
//         margin: const EdgeInsets.all(16),
//         borderRadius: 12,
//       );
//     } else {
//       wishlistItems.add(product);
//       _saveWishlist();
//       Get.snackbar(
//         '❤️ Added to Wishlist',
//         '${product.title ?? 'Product'} added',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.pink.shade100,
//         colorText: Colors.pink.shade900,
//         duration: const Duration(seconds: 1),
//         margin: const EdgeInsets.all(16),
//         borderRadius: 12,
//       );
//     }
//   }
//
//
//   bool isWishlisted(dynamic productId) {
//     return wishlistItems.any((item) => item.id == productId);
//   }
//
//   void removeFromWishlist(dynamic productId) {
//     wishlistItems.removeWhere((item) => item.id == productId);
//     _saveWishlist();
//   }
//
//
//   int get wishlistCount => wishlistItems.length;
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utilities_Screens/App_Model/app_model.dart';

class WishlistController extends GetxController {
  static WishlistController get instance => Get.find();

  var wishlistItems = <ModelClass>[].obs;

  static const String _wishlistKey = 'wishlist_items';
  static const String _variantKey = 'wishlist_variants';

  // productId -> {'size': 'L', 'color': 'Grey & Black'}
  final Map<String, Map<String, String>> _variants = {};

  @override
  void onInit() {
    super.onInit();
    _loadWishlist();
  }

  Future<void> _loadWishlist() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // variants pehle load karein, taake list aate hi size/color mil jaye
      final String? variantString = prefs.getString(_variantKey);
      if (variantString != null) {
        final Map<String, dynamic> decoded = jsonDecode(variantString);
        _variants.clear();
        decoded.forEach((key, value) {
          _variants[key] = Map<String, String>.from(value as Map);
        });
      }

      final String? jsonString = prefs.getString(_wishlistKey);
      if (jsonString != null) {
        final List<dynamic> jsonList = jsonDecode(jsonString);
        final items = jsonList
            .map((json) => ModelClass.fromJson(json))
            .toList();
        wishlistItems.assignAll(items);
      }
    } catch (e) {
      debugPrint('Wishlist load error: $e');
    }
  }

  Future<void> _saveWishlist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = wishlistItems.map((item) => item.toJson()).toList();
      await prefs.setString(_wishlistKey, jsonEncode(jsonList));
      await prefs.setString(_variantKey, jsonEncode(_variants));
    } catch (e) {
      debugPrint('Wishlist save error: $e');
    }
  }

  // ---- selected size / color ----
  String? variantSize(dynamic productId) =>
      _variants[productId.toString()]?['size'];

  String? variantColor(dynamic productId) =>
      _variants[productId.toString()]?['color'];

  void toggleWishlist(ModelClass product, {String? size, String? color}) {
    final exists = wishlistItems.any((item) => item.id == product.id);

    if (exists) {
      wishlistItems.removeWhere((item) => item.id == product.id);
      _variants.remove(product.id.toString());
      _saveWishlist();
      Get.snackbar(
        'Removed from Wishlist',
        '${product.title ?? 'Product'} removed',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.grey.shade200,
        colorText: Colors.grey.shade700,
        duration: const Duration(seconds: 1),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
    } else {
      final v = <String, String>{};
      if (size != null && size.isNotEmpty) v['size'] = size;
      if (color != null && color.isNotEmpty) v['color'] = color;
      if (v.isNotEmpty) _variants[product.id.toString()] = v;

      wishlistItems.add(product);
      _saveWishlist();
      Get.snackbar(
        '❤️ Added to Wishlist',
        '${product.title ?? 'Product'} added',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.pink.shade100,
        colorText: Colors.pink.shade900,
        duration: const Duration(seconds: 1),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
    }
  }

  bool isWishlisted(dynamic productId) {
    return wishlistItems.any((item) => item.id == productId);
  }

  void removeFromWishlist(dynamic productId) {
    wishlistItems.removeWhere((item) => item.id == productId);
    _variants.remove(productId.toString());
    _saveWishlist();
  }

  int get wishlistCount => wishlistItems.length;
}
