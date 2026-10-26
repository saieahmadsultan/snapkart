// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class ModelClass {
//   String? id;
//   String? title;
//   double? price;
//   double? discountPrice;
//   String? description;
//   String? category;
//   String? image;
//   List<String> images;
//   int? stock;
//   Rating? rating;
//
//   List<PriceTier> priceTiers;
//
//   // Product sizes:
//   // S / M / L / XL ya 38 / 39 / 40
//   List<ProductSize> sizes;
//
//   ModelClass({
//     this.id,
//     this.title,
//     this.price,
//     this.discountPrice,
//     this.description,
//     this.category,
//     this.image,
//     this.images = const [],
//     this.stock,
//     this.rating,
//     this.priceTiers = const [],
//     this.sizes = const [],
//   });
//
//   factory ModelClass.fromFirestore(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;
//
//     return ModelClass(
//       id: doc.id,
//       title: data['title'] ?? 'No Title',
//
//       price: _toDouble(data['price']),
//
//       discountPrice: data['discountPrice'] != null
//           ? _toDouble(data['discountPrice'])
//           : null,
//
//       description: data['description'] ?? 'No description available',
//
//       category: data['category'] ?? 'Uncategorized',
//
//       image: data['image'] ?? '',
//
//       images: data['images'] != null ? List<String>.from(data['images']) : [],
//
//       stock: data['stock'] ?? 0,
//
//       rating: data['rating'] != null
//           ? Rating.fromJson(Map<String, dynamic>.from(data['rating']))
//           : Rating(rate: 0.0, count: 0),
//
//       priceTiers: data['priceTiers'] != null
//           ? (data['priceTiers'] as List)
//                 .map((t) => PriceTier.fromMap(Map<String, dynamic>.from(t)))
//                 .toList()
//           : [],
//
//       sizes: data['sizes'] != null
//           ? (data['sizes'] as List)
//                 .map((s) => ProductSize.fromMap(Map<String, dynamic>.from(s)))
//                 .toList()
//           : [],
//     );
//   }
//
//   static double _toDouble(dynamic value) {
//     if (value == null) return 0.0;
//
//     if (value is int) {
//       return value.toDouble();
//     }
//
//     if (value is double) {
//       return value;
//     }
//
//     if (value is num) {
//       return value.toDouble();
//     }
//
//     if (value is String) {
//       return double.tryParse(value) ?? 0.0;
//     }
//
//     return 0.0;
//   }
//
//   Map<String, dynamic> toFirestore() {
//     return {
//       'title': title,
//       'price': price,
//       'discountPrice': discountPrice,
//       'description': description,
//       'category': category,
//       'image': image,
//       'images': images,
//       'stock': stock,
//       'rating': rating?.toJson(),
//
//       'priceTiers': priceTiers.map((t) => t.toMap()).toList(),
//
//       'sizes': sizes.map((s) => s.toMap()).toList(),
//     };
//   }
//
//   factory ModelClass.fromJson(Map<String, dynamic> json) {
//     return ModelClass(
//       id: json['id']?.toString(),
//
//       title: json['title'],
//
//       price: _toDouble(json['price']),
//
//       discountPrice: json['discountPrice'] != null
//           ? _toDouble(json['discountPrice'])
//           : null,
//
//       description: json['description'],
//
//       category: json['category'],
//
//       image: json['image'],
//
//       images: json['images'] != null ? List<String>.from(json['images']) : [],
//
//       stock: json['stock'],
//
//       rating: json['rating'] != null
//           ? Rating.fromJson(Map<String, dynamic>.from(json['rating']))
//           : null,
//
//       priceTiers: json['priceTiers'] != null
//           ? (json['priceTiers'] as List)
//                 .map((t) => PriceTier.fromMap(Map<String, dynamic>.from(t)))
//                 .toList()
//           : [],
//
//       sizes: json['sizes'] != null
//           ? (json['sizes'] as List)
//                 .map((s) => ProductSize.fromMap(Map<String, dynamic>.from(s)))
//                 .toList()
//           : [],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'title': title,
//       'price': price,
//       'discountPrice': discountPrice,
//       'description': description,
//       'category': category,
//       'image': image,
//       'images': images,
//       'stock': stock,
//       'rating': rating?.toJson(),
//
//       'priceTiers': priceTiers.map((t) => t.toMap()).toList(),
//
//       'sizes': sizes.map((s) => s.toMap()).toList(),
//     };
//   }
// }
//
// // =====================================================
// // RATING
// // =====================================================
//
// class Rating {
//   double? rate;
//   int? count;
//
//   Rating({this.rate, this.count});
//
//   factory Rating.fromJson(Map<String, dynamic> json) {
//     return Rating(
//       rate: ModelClass._toDouble(json['rate']),
//       count: json['count'] ?? 0,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {'rate': rate, 'count': count};
//   }
// }
//
// // =====================================================
// // PRICE TIER
// // =====================================================
//
// class PriceTier {
//   int minQty;
//   double price;
//
//   PriceTier({required this.minQty, required this.price});
//
//   factory PriceTier.fromMap(Map<String, dynamic> map) {
//     return PriceTier(
//       minQty: map['minQty'] ?? 1,
//       price: ModelClass._toDouble(map['price']),
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {'minQty': minQty, 'price': price};
//   }
// }
//
// // =====================================================
// // PRODUCT SIZE
// // =====================================================
// //
// // Ab har size ka:
// // label
// // stock
// // price
// //
// // alag ho sakta hai.
// //
// // Example:
// // S  -> Rs 900  -> stock 10
// // M  -> Rs 950  -> stock 8
// // L  -> Rs 1000 -> stock 5
// //
//
// class ProductSize {
//   String label;
//   int stock;
//   double price;
//
//   ProductSize({required this.label, this.stock = 0, this.price = 0.0});
//
//   factory ProductSize.fromMap(Map<String, dynamic> map) {
//     return ProductSize(
//       label: map['label'] ?? '',
//       stock: map['stock'] ?? 0,
//       price: ModelClass._toDouble(map['price']),
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {'label': label, 'stock': stock, 'price': price};
//   }
// }
//
// // =====================================================
// // BANNER MODEL
// // =====================================================
//
// class BannerModel {
//   String? id;
//   String? imageUrl;
//   String? title;
//   String? discountText;
//   String actionType;
//   String? actionValue;
//   bool isActive;
//   int order;
//
//   BannerModel({
//     this.id,
//     this.imageUrl,
//     this.title,
//     this.discountText,
//     this.actionType = 'none',
//     this.actionValue,
//     this.isActive = true,
//     this.order = 0,
//   });
//
//   factory BannerModel.fromFirestore(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;
//
//     return BannerModel(
//       id: doc.id,
//       imageUrl: data['imageUrl'] ?? '',
//       title: data['title'] ?? '',
//       discountText: data['discountText'] ?? '',
//       actionType: data['actionType'] ?? 'none',
//       actionValue: data['actionValue'],
//       isActive: data['isActive'] ?? true,
//       order: data['order'] ?? 0,
//     );
//   }
//
//   Map<String, dynamic> toFirestore() {
//     return {
//       'imageUrl': imageUrl,
//       'title': title,
//       'discountText': discountText,
//       'actionType': actionType,
//       'actionValue': actionValue,
//       'isActive': isActive,
//       'order': order,
//     };
//   }
// }




import 'package:cloud_firestore/cloud_firestore.dart';

class ModelClass {
  String? id;
  String? title;
  double? price;
  double? discountPrice;
  String? description;
  String? category;
  String? image;
  List<String> images;
  int? stock;
  Rating? rating;

  List<PriceTier> priceTiers;

  // Product sizes:
  // S / M / L / XL ya 38 / 39 / 40
  List<ProductSize> sizes;

  // NAYA - Product colors (gol swatches)
  List<ProductColor> colors;

  ModelClass({
    this.id,
    this.title,
    this.price,
    this.discountPrice,
    this.description,
    this.category,
    this.image,
    this.images = const [],
    this.stock,
    this.rating,
    this.priceTiers = const [],
    this.sizes = const [],
    this.colors = const [],
  });

  factory ModelClass.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return ModelClass(
      id: doc.id,
      title: data['title'] ?? 'No Title',

      price: _toDouble(data['price']),

      discountPrice: data['discountPrice'] != null
          ? _toDouble(data['discountPrice'])
          : null,

      description: data['description'] ?? 'No description available',

      category: data['category'] ?? 'Uncategorized',

      image: data['image'] ?? '',

      images: data['images'] != null ? List<String>.from(data['images']) : [],

      stock: data['stock'] ?? 0,

      rating: data['rating'] != null
          ? Rating.fromJson(Map<String, dynamic>.from(data['rating']))
          : Rating(rate: 0.0, count: 0),

      priceTiers: data['priceTiers'] != null
          ? (data['priceTiers'] as List)
          .map((t) => PriceTier.fromMap(Map<String, dynamic>.from(t)))
          .toList()
          : [],

      sizes: data['sizes'] != null
          ? (data['sizes'] as List)
          .map((s) => ProductSize.fromMap(Map<String, dynamic>.from(s)))
          .toList()
          : [],

      // NAYA
      colors: data['colors'] != null
          ? (data['colors'] as List)
          .map((c) => ProductColor.fromMap(Map<String, dynamic>.from(c)))
          .toList()
          : [],
    );
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;

    if (value is int) {
      return value.toDouble();
    }

    if (value is double) {
      return value;
    }

    if (value is num) {
      return value.toDouble();
    }

    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    }

    return 0.0;
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'price': price,
      'discountPrice': discountPrice,
      'description': description,
      'category': category,
      'image': image,
      'images': images,
      'stock': stock,
      'rating': rating?.toJson(),

      'priceTiers': priceTiers.map((t) => t.toMap()).toList(),

      'sizes': sizes.map((s) => s.toMap()).toList(),

      // NAYA
      'colors': colors.map((c) => c.toMap()).toList(),
    };
  }

  factory ModelClass.fromJson(Map<String, dynamic> json) {
    return ModelClass(
      id: json['id']?.toString(),

      title: json['title'],

      price: _toDouble(json['price']),

      discountPrice: json['discountPrice'] != null
          ? _toDouble(json['discountPrice'])
          : null,

      description: json['description'],

      category: json['category'],

      image: json['image'],

      images: json['images'] != null ? List<String>.from(json['images']) : [],

      stock: json['stock'],

      rating: json['rating'] != null
          ? Rating.fromJson(Map<String, dynamic>.from(json['rating']))
          : null,

      priceTiers: json['priceTiers'] != null
          ? (json['priceTiers'] as List)
          .map((t) => PriceTier.fromMap(Map<String, dynamic>.from(t)))
          .toList()
          : [],

      sizes: json['sizes'] != null
          ? (json['sizes'] as List)
          .map((s) => ProductSize.fromMap(Map<String, dynamic>.from(s)))
          .toList()
          : [],

      // NAYA
      colors: json['colors'] != null
          ? (json['colors'] as List)
          .map((c) => ProductColor.fromMap(Map<String, dynamic>.from(c)))
          .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'discountPrice': discountPrice,
      'description': description,
      'category': category,
      'image': image,
      'images': images,
      'stock': stock,
      'rating': rating?.toJson(),

      'priceTiers': priceTiers.map((t) => t.toMap()).toList(),

      'sizes': sizes.map((s) => s.toMap()).toList(),

      // NAYA
      'colors': colors.map((c) => c.toMap()).toList(),
    };
  }
}

// =====================================================
// RATING
// =====================================================

class Rating {
  double? rate;
  int? count;

  Rating({this.rate, this.count});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: ModelClass._toDouble(json['rate']),
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'rate': rate, 'count': count};
  }
}

// =====================================================
// PRICE TIER
// =====================================================

class PriceTier {
  int minQty;
  double price;

  PriceTier({required this.minQty, required this.price});

  factory PriceTier.fromMap(Map<String, dynamic> map) {
    return PriceTier(
      minQty: map['minQty'] ?? 1,
      price: ModelClass._toDouble(map['price']),
    );
  }

  Map<String, dynamic> toMap() {
    return {'minQty': minQty, 'price': price};
  }
}

// =====================================================
// PRODUCT SIZE
// =====================================================
//
// Ab har size ka:
// label
// stock
// price
//
// alag ho sakta hai.
//
// Example:
// S  -> Rs 900  -> stock 10
// M  -> Rs 950  -> stock 8
// L  -> Rs 1000 -> stock 5
//

class ProductSize {
  String label;
  int stock;
  double price;

  ProductSize({required this.label, this.stock = 0, this.price = 0.0});

  factory ProductSize.fromMap(Map<String, dynamic> map) {
    return ProductSize(
      label: map['label'] ?? '',
      stock: map['stock'] ?? 0,
      price: ModelClass._toDouble(map['price']),
    );
  }

  Map<String, dynamic> toMap() {
    return {'label': label, 'stock': stock, 'price': price};
  }
}

// =====================================================
// PRODUCT COLOR (NAYA)
// =====================================================
//
// name : "Grey & Black"
// hex  : "#E0E0E0"   (pehla rang)
// hex2 : "#212121"   (optional - do rang wala aadha-aadha swatch)
//
// Firestore mein products ke andar:
// colors: [
//   { name: "Grey & Black", hex: "#E0E0E0", hex2: "#212121" },
//   { name: "White",        hex: "#FFFFFF" },
//   { name: "Navy",         hex: "#1B365D" },
// ]
//

class ProductColor {
  String name;
  String hex;
  String? hex2;

  ProductColor({required this.name, required this.hex, this.hex2});

  factory ProductColor.fromMap(Map<String, dynamic> map) {
    return ProductColor(
      name: map['name'] ?? '',
      hex: map['hex'] ?? '#BDBDBD',
      hex2: map['hex2'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'hex': hex, 'hex2': hex2};
  }
}

// =====================================================
// BANNER MODEL
// =====================================================

class BannerModel {
  String? id;
  String? imageUrl;
  String? title;
  String? discountText;
  String actionType;
  String? actionValue;
  bool isActive;
  int order;

  BannerModel({
    this.id,
    this.imageUrl,
    this.title,
    this.discountText,
    this.actionType = 'none',
    this.actionValue,
    this.isActive = true,
    this.order = 0,
  });

  factory BannerModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return BannerModel(
      id: doc.id,
      imageUrl: data['imageUrl'] ?? '',
      title: data['title'] ?? '',
      discountText: data['discountText'] ?? '',
      actionType: data['actionType'] ?? 'none',
      actionValue: data['actionValue'],
      isActive: data['isActive'] ?? true,
      order: data['order'] ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'imageUrl': imageUrl,
      'title': title,
      'discountText': discountText,
      'actionType': actionType,
      'actionValue': actionValue,
      'isActive': isActive,
      'order': order,
    };
  }
}