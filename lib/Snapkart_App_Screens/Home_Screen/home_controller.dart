// import 'dart:developer' as developer;
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../Utilities_Screens/App_Model/app_model.dart';
// import '../../Utilities_Screens/Help_Function_Api/helping_function.dart';
// import '../Detail_Screen/detail_view.dart';
//
// class HomeController extends GetxController {
//   var productList = <ModelClass>[].obs;
//   var filteredProductList = <ModelClass>[].obs;
//   var isLoading = true.obs;
//   var isError = false.obs;
//   var errorMessage = ''.obs;
//
//   var selectedCategory = 'All'.obs;
//   var categories = <String>[].obs;
//   var categoryCounts = <String, int>{}.obs;
//   var imageIndex = 0.obs;
//
//   // NAYA - home screen promo banner/carousel
//   var banners = <BannerModel>[].obs;
//   var isBannersLoading = true.obs;
//
//   // NAYA - promo banner carousel ke dots track karne ke liye
//   var bannerIndex = 0.obs;
//
//   // NAYA - track kis kis image ka precache ho chuka hai
//   final Set<int> _precachedIndexes = {};
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchProducts();
//     fetchBanners(); // <-- naya
//     _changeImage();
//   }
//
//   @override
//   void onReady() {
//     super.onReady();
//     // context ab guaranteed available hai, yahan se precache shuru karein
//     _precacheAllImages();
//   }
//
//   final List<String> shoppingImages = [
//     'https://images.unsplash.com/photo-1441986300917-64674bd600d8',
//     'https://images.unsplash.com/photo-1483985988355-763728e1935b',
//     'https://images.unsplash.com/photo-1472851294608-062f824d29cc',
//     'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da',
//     'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d',
//     'https://images.unsplash.com/photo-1519415943484-9fa1873496d4',
//     'https://picsum.photos/id/1005/800/600',
//     'https://picsum.photos/id/1011/800/600',
//     'https://picsum.photos/id/1027/800/600',
//     'https://picsum.photos/id/1035/800/600',
//     'https://picsum.photos/id/1043/800/600',
//     'https://picsum.photos/id/1050/800/600',
//     'https://picsum.photos/id/1062/800/600',
//     'https://picsum.photos/id/1074/800/600',
//   ];
//
//   void _changeImage() async {
//     while (true) {
//       await Future.delayed(const Duration(seconds: 7));
//       imageIndex.value = (imageIndex.value + 1) % shoppingImages.length;
//     }
//   }
//
//   Future<void> _precacheAllImages() async {
//     final context = Get.context;
//     if (context == null) return;
//
//     for (int i = 0; i < shoppingImages.length; i++) {
//       if (_precachedIndexes.contains(i)) continue;
//       try {
//         await precacheImage(NetworkImage(shoppingImages[i]), context);
//         _precachedIndexes.add(i);
//       } catch (e) {
//         developer.log('Precache image error ($i): $e');
//       }
//     }
//   }
//
//   //copy to firebase
//   Future<void> fetchProducts() async {
//     try {
//       isLoading.value = true;
//       isError.value = false;
//       errorMessage.value = '';
//
//       final querySnapshot = await FirebaseFirestore.instance
//           .collection('products')
//           .get();
//
//       productList.value = querySnapshot.docs
//           .map((doc) => ModelClass.fromFirestore(doc))
//           .toList();
//
//       _extractCategories();
//       filterByCategory('All');
//     } catch (e) {
//       isError.value = true;
//       errorMessage.value = 'An error occurred: ${e.toString()}';
//       developer.log('FetchProducts Error: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//   //end of copy to firebase
//
//   // NAYA - Firestore se active banners fetch karna, order field se sort
//   Future<void> fetchBanners() async {
//     try {
//       isBannersLoading.value = true;
//       final snapshot = await FirebaseFirestore.instance
//           .collection('banners')
//           .where('isActive', isEqualTo: true)
//           .orderBy('order')
//           .get();
//
//       banners.value = snapshot.docs
//           .map((doc) => BannerModel.fromFirestore(doc))
//           .toList();
//     } catch (e) {
//       developer.log('FetchBanners Error: $e');
//     } finally {
//       isBannersLoading.value = false;
//     }
//   }
//
//   // NAYA - banner tap hone par kahan navigate karna hai
//   void handleBannerTap(BannerModel banner) {
//     switch (banner.actionType) {
//       case 'category':
//         filterByCategory(banner.actionValue ?? 'All');
//         break;
//       case 'product':
//         FirebaseFirestore.instance
//             .collection('products')
//             .doc(banner.actionValue)
//             .get()
//             .then((doc) {
//               if (doc.exists) {
//                 goToProductDetail(ModelClass.fromFirestore(doc));
//               }
//             });
//         break;
//       case 'url':
//         // agar external link kholni ho to url_launcher use karein
//         break;
//       default:
//         break;
//     }
//   }
//
//   void _extractCategories() {
//     final uniqueCategories = <String>{};
//     final counts = <String, int>{};
//
//     for (var product in productList) {
//       final category = product.category ?? 'Uncategorized';
//       uniqueCategories.add(category);
//       counts[category] = (counts[category] ?? 0) + 1;
//     }
//
//     // Sort categories alphabetically
//     final sortedCategories = uniqueCategories.toList()..sort();
//     categories.value = ['All', ...sortedCategories]; // 'All' at top
//
//     // Add counts for 'All'
//     categoryCounts.value = {'All': productList.length, ...counts};
//   }
//
//   //  Filter products by category
//   void filterByCategory(String category) {
//     selectedCategory.value = category;
//
//     if (category == 'All') {
//       filteredProductList.value = List.from(productList);
//     } else {
//       filteredProductList.value = productList
//           .where((product) => product.category == category)
//           .toList();
//     }
//   }
//
//   //  Navigate to Product Detail
//   void goToProductDetail(ModelClass product) {
//     Get.to(
//       () => const ProductDetailView(),
//       arguments: product,
//       transition: Transition.rightToLeft,
//       duration: const Duration(milliseconds: 300),
//     );
//   }
//
//   Future<void> refreshProducts() async {
//     await fetchProducts();
//   }
//
//   // Title/query se space, hyphen, apostrophe, dot hata kar lowercase karta
//   // hai, taake "tshirt", "t-shirt", "T Shirt" sab match ho jayein.
//   String _normalize(String s) =>
//       s.toLowerCase().replaceAll(RegExp(r"[\s\-'’.]"), '');
//
//   //  Search Products (filter in current category)
//   void searchProducts(String query) {
//     if (query.isEmpty) {
//       filterByCategory(selectedCategory.value);
//     } else {
//       final sourceList = selectedCategory.value == 'All'
//           ? productList
//           : productList
//                 .where((p) => p.category == selectedCategory.value)
//                 .toList();
//
//       final normalizedQuery = _normalize(query);
//
//       final filtered = sourceList.where((product) {
//         final title = product.title ?? '';
//         return _normalize(title).contains(normalizedQuery);
//       }).toList();
//
//       filteredProductList.value = filtered;
//     }
//   }
//
//   //  Add to Cart
//   void addToCart(Map<String, dynamic> productData) async {
//     try {
//       final response = await Functions.sendJson(
//         url: 'https://fakestoreapi.com/carts',
//         method: 'POST',
//         jsonMap: {
//           'userId': 1,
//           'date': DateTime.now().toIso8601String(),
//           'products': productData,
//         },
//       );
//
//       if (response is Map<String, dynamic> && response['DocType'] == 'Error') {
//         Get.snackbar(
//           'Error',
//           response['Message'] ?? 'Failed to add to cart',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red.shade100,
//           colorText: Colors.red.shade900,
//         );
//       } else {
//         Get.snackbar(
//           'Success! ',
//           'Product added to cart!',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.green.shade100,
//           colorText: Colors.green.shade900,
//         );
//       }
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Failed to add to cart: ${e.toString()}',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }
//
//   //  Get icon for category
//   IconData getCategoryIcon(String category) {
//     switch (category.toLowerCase()) {
//       case 'men\'s clothing':
//       case 'women\'s clothing':
//         return Icons.checkroom;
//       case 'jewelery':
//         return Icons.diamond;
//       case 'electronics':
//         return Icons.electrical_services;
//       default:
//         return Icons.category;
//     }
//   }
//
//   //  Get color for category
//   Color getCategoryColor(String category) {
//     switch (category.toLowerCase()) {
//       case 'men\'s clothing':
//         return Colors.blue;
//       case 'women\'s clothing':
//         return Colors.pink;
//       case 'jewelery':
//         return Colors.amber;
//       case 'electronics':
//         return Colors.green;
//       default:
//         return Colors.grey;
//     }
//   }
// }

import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utilities_Screens/App_Model/app_model.dart';
import '../../Utilities_Screens/Help_Function_Api/helping_function.dart';
import '../Detail_Screen/detail_view.dart';

class HomeController extends GetxController {
  var productList = <ModelClass>[].obs;
  var filteredProductList = <ModelClass>[].obs;
  var isLoading = true.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  var selectedCategory = 'All'.obs;
  var categories = <String>[].obs;
  var categoryCounts = <String, int>{}.obs;
  var imageIndex = 0.obs;

  // ---- SORT / FILTER STATE ----
  var sortOption = 'featured'.obs;
  var filterMinPrice = 0.0.obs;
  var filterMaxPrice = 0.0.obs; // 0 = koi upper limit nahi
  var filterMinRating = 0.0.obs;
  var filterOnlyDiscounted = false.obs;

  static const Map<String, String> sortLabels = {
    'featured': 'Featured',
    'price_low': 'Price: Low to High',
    'price_high': 'Price: High to Low',
    'rating': 'Top Rated',
    'discount': 'Biggest Discount',
    'name': 'Name: A to Z',
  };

  // home screen promo banner/carousel
  var banners = <BannerModel>[].obs;
  var isBannersLoading = true.obs;

  // promo banner carousel ke dots track karne ke liye
  var bannerIndex = 0.obs;

  // track kis kis image ka precache ho chuka hai
  final Set<int> _precachedIndexes = {};

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    fetchBanners();
    _changeImage();
  }

  @override
  void onReady() {
    super.onReady();
    // context ab guaranteed available hai, yahan se precache shuru karein
    _precacheAllImages();
  }

  final List<String> shoppingImages = [
    'https://images.unsplash.com/photo-1441986300917-64674bd600d8',
    'https://images.unsplash.com/photo-1483985988355-763728e1935b',
    'https://images.unsplash.com/photo-1472851294608-062f824d29cc',
    'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da',
    'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d',
    'https://images.unsplash.com/photo-1519415943484-9fa1873496d4',
    'https://picsum.photos/id/1005/800/600',
    'https://picsum.photos/id/1011/800/600',
    'https://picsum.photos/id/1027/800/600',
    'https://picsum.photos/id/1035/800/600',
    'https://picsum.photos/id/1043/800/600',
    'https://picsum.photos/id/1050/800/600',
    'https://picsum.photos/id/1062/800/600',
    'https://picsum.photos/id/1074/800/600',
  ];

  void _changeImage() async {
    while (true) {
      await Future.delayed(const Duration(seconds: 7));
      imageIndex.value = (imageIndex.value + 1) % shoppingImages.length;
    }
  }

  Future<void> _precacheAllImages() async {
    final context = Get.context;
    if (context == null) return;

    for (int i = 0; i < shoppingImages.length; i++) {
      if (_precachedIndexes.contains(i)) continue;
      try {
        await precacheImage(NetworkImage(shoppingImages[i]), context);
        _precachedIndexes.add(i);
      } catch (e) {
        developer.log('Precache image error ($i): $e');
      }
    }
  }

  //copy to firebase
  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      isError.value = false;
      errorMessage.value = '';

      final querySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .get();

      productList.value = querySnapshot.docs
          .map((doc) => ModelClass.fromFirestore(doc))
          .toList();

      _extractCategories();
      filterByCategory('All');
    } catch (e) {
      isError.value = true;
      errorMessage.value = 'An error occurred: ${e.toString()}';
      developer.log('FetchProducts Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
  //end of copy to firebase

  // Firestore se active banners fetch karna, order field se sort
  Future<void> fetchBanners() async {
    try {
      isBannersLoading.value = true;
      final snapshot = await FirebaseFirestore.instance
          .collection('banners')
          .where('isActive', isEqualTo: true)
          .orderBy('order')
          .get();

      banners.value = snapshot.docs
          .map((doc) => BannerModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      developer.log('FetchBanners Error: $e');
    } finally {
      isBannersLoading.value = false;
    }
  }

  // banner tap hone par kahan navigate karna hai
  void handleBannerTap(BannerModel banner) {
    switch (banner.actionType) {
      case 'category':
        filterByCategory(banner.actionValue ?? 'All');
        break;
      case 'product':
        FirebaseFirestore.instance
            .collection('products')
            .doc(banner.actionValue)
            .get()
            .then((doc) {
          if (doc.exists) {
            goToProductDetail(ModelClass.fromFirestore(doc));
          }
        });
        break;
      case 'url':
      // agar external link kholni ho to url_launcher use karein
        break;
      default:
        break;
    }
  }

  void _extractCategories() {
    final uniqueCategories = <String>{};
    final counts = <String, int>{};

    for (var product in productList) {
      final category = product.category ?? 'Uncategorized';
      uniqueCategories.add(category);
      counts[category] = (counts[category] ?? 0) + 1;
    }

    // Sort categories alphabetically
    final sortedCategories = uniqueCategories.toList()..sort();
    categories.value = ['All', ...sortedCategories]; // 'All' at top

    // Add counts for 'All'
    categoryCounts.value = {'All': productList.length, ...counts};
  }

  // ============================================================
  // CATEGORY + FILTER + SORT
  // ============================================================

  // Sale price agar valid ho to wahi, warna normal price
  double _effectivePrice(ModelClass p) {
    final price = p.price ?? 0;
    final sale = p.discountPrice ?? 0;
    return (sale > 0 && price > 0 && sale < price) ? sale : price;
  }

  double _discountPercent(ModelClass p) {
    final price = p.price ?? 0;
    final sale = p.discountPrice ?? 0;
    if (sale > 0 && price > 0 && sale < price) {
      return (price - sale) / price * 100;
    }
    return 0;
  }

  // Filter slider ke max ke liye
  double get catalogMaxPrice {
    double max = 0;
    for (final p in productList) {
      final v = (p.price ?? 0).toDouble();
      if (v > max) max = v;
    }
    return max.ceilToDouble();
  }

  // Header banner ke liye: selected category ka sab se behtar (high rated)
  // product ki image. 'All' ke liye poore catalog mein se.
  // Obx ke andar call karne par productList change hone par bhi update hoga.
  String? categoryImage(String category) {
    final source = category == 'All'
        ? productList
        : productList.where((p) => p.category == category);

    String? bestImage;
    double bestRating = -1;

    for (final p in source) {
      final img = (p.image != null && p.image!.isNotEmpty)
          ? p.image!
          : (p.images.isNotEmpty ? p.images.first : '');
      if (img.isEmpty) continue;

      final rate = (p.rating?.rate ?? 0).toDouble();
      if (rate > bestRating) {
        bestRating = rate;
        bestImage = img;
      }
    }
    return bestImage;
  }

  bool get hasActiveFilters =>
      filterMinPrice.value > 0 ||
          filterMaxPrice.value > 0 ||
          filterMinRating.value > 0 ||
          filterOnlyDiscounted.value;

  //  Filter products by category
  void filterByCategory(String category) {
    selectedCategory.value = category;
    _applyAll();
  }

  void setSort(String option) {
    sortOption.value = option;
    _applyAll();
  }

  void applyFilters({
    required double minPrice,
    required double maxPrice,
    required double minRating,
    required bool onlyDiscounted,
  }) {
    filterMinPrice.value = minPrice;
    filterMaxPrice.value = maxPrice;
    filterMinRating.value = minRating;
    filterOnlyDiscounted.value = onlyDiscounted;
    _applyAll();
  }

  void resetFilters() {
    filterMinPrice.value = 0;
    filterMaxPrice.value = 0;
    filterMinRating.value = 0;
    filterOnlyDiscounted.value = false;
    _applyAll();
  }

  // Category -> filters -> sort, sab ek jagah
  void _applyAll() {
    Iterable<ModelClass> list = selectedCategory.value == 'All'
        ? productList
        : productList.where((p) => p.category == selectedCategory.value);

    list = list.where((p) {
      final price = _effectivePrice(p);
      if (price < filterMinPrice.value) return false;
      if (filterMaxPrice.value > 0 && price > filterMaxPrice.value) {
        return false;
      }
      if ((p.rating?.rate ?? 0) < filterMinRating.value) return false;
      if (filterOnlyDiscounted.value && _discountPercent(p) <= 0) {
        return false;
      }
      return true;
    });

    final result = list.toList();

    switch (sortOption.value) {
      case 'price_low':
        result.sort((a, b) => _effectivePrice(a).compareTo(_effectivePrice(b)));
        break;
      case 'price_high':
        result.sort((a, b) => _effectivePrice(b).compareTo(_effectivePrice(a)));
        break;
      case 'rating':
        result.sort(
              (a, b) => (b.rating?.rate ?? 0).compareTo(a.rating?.rate ?? 0),
        );
        break;
      case 'discount':
        result.sort(
              (a, b) => _discountPercent(b).compareTo(_discountPercent(a)),
        );
        break;
      case 'name':
        result.sort(
              (a, b) => (a.title ?? '').toLowerCase().compareTo(
            (b.title ?? '').toLowerCase(),
          ),
        );
        break;
      default: // featured = Firestore ka original order
        break;
    }

    filteredProductList.value = result;
  }

  //  Navigate to Product Detail
  void goToProductDetail(ModelClass product) {
    Get.to(
          () => const ProductDetailView(),
      arguments: product,
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 300),
    );
  }

  Future<void> refreshProducts() async {
    await fetchProducts();
  }

  // Title/query se space, hyphen, apostrophe, dot hata kar lowercase karta
  // hai, taake "tshirt", "t-shirt", "T Shirt" sab match ho jayein.
  String _normalize(String s) =>
      s.toLowerCase().replaceAll(RegExp(r"[\s\-'’.]"), '');

  //  Search Products (filter in current category)
  void searchProducts(String query) {
    if (query.isEmpty) {
      filterByCategory(selectedCategory.value);
    } else {
      final sourceList = selectedCategory.value == 'All'
          ? productList
          : productList
          .where((p) => p.category == selectedCategory.value)
          .toList();

      final normalizedQuery = _normalize(query);

      final filtered = sourceList.where((product) {
        final title = product.title ?? '';
        return _normalize(title).contains(normalizedQuery);
      }).toList();

      filteredProductList.value = filtered;
    }
  }

  //  Add to Cart
  void addToCart(Map<String, dynamic> productData) async {
    try {
      final response = await Functions.sendJson(
        url: 'https://fakestoreapi.com/carts',
        method: 'POST',
        jsonMap: {
          'userId': 1,
          'date': DateTime.now().toIso8601String(),
          'products': productData,
        },
      );

      if (response is Map<String, dynamic> && response['DocType'] == 'Error') {
        Get.snackbar(
          'Error',
          response['Message'] ?? 'Failed to add to cart',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade100,
          colorText: Colors.red.shade900,
        );
      } else {
        Get.snackbar(
          'Success! ',
          'Product added to cart!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade100,
          colorText: Colors.green.shade900,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to add to cart: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  //  Get icon for category
  IconData getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'men\'s clothing':
      case 'women\'s clothing':
        return Icons.checkroom;
      case 'jewelery':
        return Icons.diamond;
      case 'electronics':
        return Icons.electrical_services;
      default:
        return Icons.category;
    }
  }

  //  Get color for category
  Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'men\'s clothing':
        return Colors.blue;
      case 'women\'s clothing':
        return Colors.pink;
      case 'jewelery':
        return Colors.amber;
      case 'electronics':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}