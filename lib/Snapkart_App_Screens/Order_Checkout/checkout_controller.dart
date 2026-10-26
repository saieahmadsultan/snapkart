// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
//
// import '../../Utilities_Screens/App_Model/app_model.dart';
// import '../../Utilities_Screens/Notification_Helper/notification_helper.dart';
// import '../Cart_Screen/cart_controller.dart';
//
// class CheckoutController extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   // --- Buy Now (direct, bina cart ke) ---
//   var isBuyNow = false.obs;
//   ModelClass? buyNowProduct;
//   int buyNowQuantity = 1;
//   String? buyNowSize;
//   double buyNowPrice = 0.0;
//   double buyNowTotal = 0.0;
//
//   // --- Address ---
//   var savedAddresses = <Map<String, dynamic>>[].obs;
//   var selectedAddressIndex = 0.obs;
//   var isLoadingAddresses = true.obs;
//
//   // --- Payment ---
//   var selectedPayment = 'Cash on Delivery'.obs;
//   final List<Map<String, dynamic>> paymentMethods = [
//     {'name': 'Cash on Delivery', 'icon': '💵'},
//     {'name': 'Credit/Debit Card', 'icon': '💳'},
//     {'name': 'JazzCash / EasyPaisa', 'icon': '📱'},
//     {'name': 'Bank Transfer', 'icon': '🏦'},
//   ];
//
//   // --- Order ---
//   var isPlacingOrder = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchAddresses();
//
//     // NAYA - agar Product Detail se "Buy Now" ke zariye aaye hain
//     // to arguments se product/quantity/size/price/total nikal lein
//     final args = Get.arguments;
//
//     if (args != null && args is Map) {
//       final product = args['product'];
//
//       if (product is ModelClass) {
//         isBuyNow.value = true;
//         buyNowProduct = product;
//         buyNowQuantity = (args['quantity'] as int?) ?? 1;
//         buyNowSize = args['size'] as String?;
//         buyNowPrice = (args['price'] as num?)?.toDouble() ?? 0.0;
//         buyNowTotal =
//             (args['total'] as num?)?.toDouble() ??
//             (buyNowPrice * buyNowQuantity);
//       }
//     }
//   }
//
//   Future<void> fetchAddresses() async {
//     try {
//       isLoadingAddresses(true);
//       final uid = _auth.currentUser?.uid;
//       if (uid == null) return;
//
//       final snapshot = await _firestore
//           .collection('users')
//           .doc(uid)
//           .collection('addresses')
//           .get();
//
//       savedAddresses.value = snapshot.docs.map((doc) {
//         final data = doc.data();
//         data['addressId'] = doc.id;
//         return data;
//       }).toList();
//     } catch (e) {
//       Get.snackbar('Error', 'Addresses not load: $e');
//     } finally {
//       isLoadingAddresses(false);
//     }
//   }
//
//   void selectAddress(int index) {
//     selectedAddressIndex.value = index;
//   }
//
//   void selectPayment(String method) {
//     selectedPayment.value = method;
//   }
//
//   // NAYA - Buy Now flow mein screen par dikhane/order place karne
//   // ke liye items list (cart wale format jaisi hi)
//   List<Map<String, dynamic>> getOrderItems() {
//     if (isBuyNow.value && buyNowProduct != null) {
//       return [
//         {
//           'productId': buyNowProduct!.id,
//           'name': buyNowProduct!.title,
//           'image': buyNowProduct!.image,
//           'price': buyNowPrice,
//           'quantity': buyNowQuantity,
//           'size': buyNowSize,
//         },
//       ];
//     }
//
//     return CartController.instance.cartItems
//         .map((e) => Map<String, dynamic>.from(e))
//         .toList();
//   }
//
//   // NAYA - screen par dikhane wala total (Buy Now ya Cart, dono ke liye)
//   double get displayTotal {
//     return isBuyNow.value ? buyNowTotal : CartController.instance.totalPrice;
//   }
//
//   List<Map<String, dynamic>> _buildOrderItems(
//     List<Map<String, dynamic>> cartItems,
//   ) {
//     // Buy Now flow mein item cart se nahi aaya, is liye
//     // tier pricing dobara calculate karne ki zaroorat nahi -
//     // jo price/quantity pehle se diya gaya hai wahi use karo.
//     if (isBuyNow.value) {
//       return cartItems.map((item) {
//         final quantity = (item['quantity'] as int? ?? 1);
//         final unitPrice = (item['price'] as num? ?? 0).toDouble();
//         return {
//           ...item,
//           'unitPrice': unitPrice,
//           'basePrice': unitPrice,
//           'itemTotal': unitPrice * quantity,
//         };
//       }).toList();
//     }
//
//     final cartController = CartController.instance;
//     return cartItems.map((item) {
//       final quantity = (item['quantity'] as int? ?? 1);
//       final unitPrice = cartController.getUnitPrice(item); // tier price
//       final basePrice = (item['price'] as num? ?? 0).toDouble();
//       return {
//         ...item,
//         'unitPrice': unitPrice, // jo actually charge hui
//         'basePrice': basePrice, // original price (record ke liye)
//         'itemTotal': unitPrice * quantity,
//       };
//     }).toList();
//   }
//
//   // NAYA - total bhi khud calculate karo, caller ke total par depend mat karo
//   double _calculateTotal(List<Map<String, dynamic>> orderItems) {
//     return orderItems.fold(
//       0.0,
//       (sum, item) => sum + (item['itemTotal'] as num).toDouble(),
//     );
//   }
//
//   Future<void> placeOrder(
//     List<Map<String, dynamic>> cartItems,
//     double total,
//   ) async {
//     await fetchAddresses();
//     if (savedAddresses.isEmpty) {
//       Get.snackbar('Address', 'add address first');
//       return;
//     }
//
//     try {
//       isPlacingOrder(true);
//       final uid = _auth.currentUser?.uid;
//       if (uid == null) return;
//
//       final selectedAddr = savedAddresses[selectedAddressIndex.value];
//
//       // NAYA - tier-aware items aur sahi total
//       final orderItems = _buildOrderItems(cartItems);
//       final correctTotal = _calculateTotal(orderItems);
//
//       //  docRef se order ID milega
//       final docRef = await _firestore.collection('orders').add({
//         'userId': uid,
//         'items': orderItems, // CHANGE - discounted unitPrice/itemTotal ke saath
//         'totalAmount': correctTotal, // CHANGE - khud calculate kiya hua total
//         'address': selectedAddr,
//         'paymentMethod': selectedPayment.value,
//         'status': 'Pending',
//         'createdAt': FieldValue.serverTimestamp(),
//       });
//
//       //  Cart clear karo - sirf tab jab cart se order hua ho.
//       //  Buy Now flow mein item cart mein tha hi nahi.
//       if (!isBuyNow.value) {
//         CartController.instance.clearCart();
//       }
//
//       //  Order placed notification bhejo
//       await NotificationHelper.showOrderNotification(
//         title: 'Order Placed ',
//         body:
//             'Your order #${docRef.id.substring(0, 6)} has been placed successfully!',
//       );
//
//       //  Date format karo
//       final now = DateTime.now();
//       final formattedDate = '${now.day}/${now.month}/${now.year}';
//
//       //  Order success screen par jao arguments ke sath
//       Get.offAllNamed(
//         '/ordercheck',
//         arguments: {
//           'orderId': docRef.id,
//           'orderDate': formattedDate,
//           'paymentMethod': selectedPayment.value,
//           'totalAmount': correctTotal, // CHANGE
//         },
//       );
//     } catch (e) {
//       Get.snackbar('Error', 'Order not placed: $e');
//     } finally {
//       isPlacingOrder(false);
//     }
//   }
// }




// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
//
// import '../../Utilities_Screens/App_Model/app_model.dart';
// import '../../Utilities_Screens/Notification_Helper/notification_helper.dart';
// import '../Cart_Screen/cart_controller.dart';
//
// class CheckoutController extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   // --- Buy Now (direct, bina cart ke) ---
//   var isBuyNow = false.obs;
//   ModelClass? buyNowProduct;
//   int buyNowQuantity = 1;
//   String? buyNowSize;
//   String? buyNowColor; // NAYA
//   double buyNowPrice = 0.0;
//   double buyNowTotal = 0.0;
//
//   // --- Address ---
//   var savedAddresses = <Map<String, dynamic>>[].obs;
//   var selectedAddressIndex = 0.obs;
//   var isLoadingAddresses = true.obs;
//
//   // --- Payment ---
//   var selectedPayment = 'Cash on Delivery'.obs;
//   final List<Map<String, dynamic>> paymentMethods = [
//     {'name': 'Cash on Delivery', 'icon': '💵'},
//     {'name': 'Credit/Debit Card', 'icon': '💳'},
//     {'name': 'JazzCash / EasyPaisa', 'icon': '📱'},
//     {'name': 'Bank Transfer', 'icon': '🏦'},
//   ];
//
//   // --- Order ---
//   var isPlacingOrder = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchAddresses();
//
//     // NAYA - agar Product Detail se "Buy Now" ke zariye aaye hain
//     // to arguments se product/quantity/size/color/price/total nikal lein
//     final args = Get.arguments;
//
//     if (args != null && args is Map) {
//       final product = args['product'];
//
//       if (product is ModelClass) {
//         isBuyNow.value = true;
//         buyNowProduct = product;
//         buyNowQuantity = (args['quantity'] as int?) ?? 1;
//         buyNowSize = args['size'] as String?;
//         buyNowColor = args['color'] as String?; // NAYA
//         buyNowPrice = (args['price'] as num?)?.toDouble() ?? 0.0;
//         buyNowTotal =
//             (args['total'] as num?)?.toDouble() ??
//                 (buyNowPrice * buyNowQuantity);
//       }
//     }
//   }
//
//   Future<void> fetchAddresses() async {
//     try {
//       isLoadingAddresses(true);
//       final uid = _auth.currentUser?.uid;
//       if (uid == null) return;
//
//       final snapshot = await _firestore
//           .collection('users')
//           .doc(uid)
//           .collection('addresses')
//           .get();
//
//       savedAddresses.value = snapshot.docs.map((doc) {
//         final data = doc.data();
//         data['addressId'] = doc.id;
//         return data;
//       }).toList();
//     } catch (e) {
//       Get.snackbar('Error', 'Addresses not load: $e');
//     } finally {
//       isLoadingAddresses(false);
//     }
//   }
//
//   void selectAddress(int index) {
//     selectedAddressIndex.value = index;
//   }
//
//   void selectPayment(String method) {
//     selectedPayment.value = method;
//   }
//
//   // NAYA - Buy Now flow mein screen par dikhane/order place karne
//   // ke liye items list (cart wale format jaisi hi)
//   List<Map<String, dynamic>> getOrderItems() {
//     if (isBuyNow.value && buyNowProduct != null) {
//       return [
//         {
//           'productId': buyNowProduct!.id,
//           'name': buyNowProduct!.title,
//           'image': buyNowProduct!.image,
//           'price': buyNowPrice,
//           'quantity': buyNowQuantity,
//           'size': buyNowSize,
//           'color': buyNowColor, // NAYA
//         },
//       ];
//     }
//
//     return CartController.instance.cartItems
//         .map((e) => Map<String, dynamic>.from(e))
//         .toList();
//   }
//
//   // NAYA - screen par dikhane wala total (Buy Now ya Cart, dono ke liye)
//   double get displayTotal {
//     return isBuyNow.value ? buyNowTotal : CartController.instance.totalPrice;
//   }
//
//   List<Map<String, dynamic>> _buildOrderItems(
//       List<Map<String, dynamic>> cartItems,
//       ) {
//     // Buy Now flow mein item cart se nahi aaya, is liye
//     // tier pricing dobara calculate karne ki zaroorat nahi -
//     // jo price/quantity pehle se diya gaya hai wahi use karo.
//     if (isBuyNow.value) {
//       return cartItems.map((item) {
//         final quantity = (item['quantity'] as int? ?? 1);
//         final unitPrice = (item['price'] as num? ?? 0).toDouble();
//         return {
//           ...item,
//           'unitPrice': unitPrice,
//           'basePrice': unitPrice,
//           'itemTotal': unitPrice * quantity,
//         };
//       }).toList();
//     }
//
//     final cartController = CartController.instance;
//     return cartItems.map((item) {
//       final quantity = (item['quantity'] as int? ?? 1);
//       final unitPrice = cartController.getUnitPrice(item); // tier price
//       final basePrice = (item['price'] as num? ?? 0).toDouble();
//       return {
//         ...item,
//         'unitPrice': unitPrice, // jo actually charge hui
//         'basePrice': basePrice, // original price (record ke liye)
//         'itemTotal': unitPrice * quantity,
//       };
//     }).toList();
//   }
//
//   // NAYA - total bhi khud calculate karo, caller ke total par depend mat karo
//   double _calculateTotal(List<Map<String, dynamic>> orderItems) {
//     return orderItems.fold(
//       0.0,
//           (sum, item) => sum + (item['itemTotal'] as num).toDouble(),
//     );
//   }
//
//   Future<void> placeOrder(
//       List<Map<String, dynamic>> cartItems,
//       double total,
//       ) async {
//     await fetchAddresses();
//     if (savedAddresses.isEmpty) {
//       Get.snackbar('Address', 'add address first');
//       return;
//     }
//
//     try {
//       isPlacingOrder(true);
//       final uid = _auth.currentUser?.uid;
//       if (uid == null) return;
//
//       final selectedAddr = savedAddresses[selectedAddressIndex.value];
//
//       // NAYA - tier-aware items aur sahi total
//       final orderItems = _buildOrderItems(cartItems);
//       final correctTotal = _calculateTotal(orderItems);
//
//       //  docRef se order ID milega
//       final docRef = await _firestore.collection('orders').add({
//         'userId': uid,
//         'items': orderItems, // CHANGE - discounted unitPrice/itemTotal ke saath
//         'totalAmount': correctTotal, // CHANGE - khud calculate kiya hua total
//         'address': selectedAddr,
//         'paymentMethod': selectedPayment.value,
//         'status': 'Pending',
//         'createdAt': FieldValue.serverTimestamp(),
//       });
//
//       //  Cart clear karo - sirf tab jab cart se order hua ho.
//       //  Buy Now flow mein item cart mein tha hi nahi.
//       if (!isBuyNow.value) {
//         CartController.instance.clearCart();
//       }
//
//       //  Order placed notification bhejo
//       await NotificationHelper.showOrderNotification(
//         title: 'Order Placed ',
//         body:
//         'Your order #${docRef.id.substring(0, 6)} has been placed successfully!',
//       );
//
//       //  Date format karo
//       final now = DateTime.now();
//       final formattedDate = '${now.day}/${now.month}/${now.year}';
//
//       //  Order success screen par jao arguments ke sath
//       Get.offAllNamed(
//         '/ordercheck',
//         arguments: {
//           'orderId': docRef.id,
//           'orderDate': formattedDate,
//           'paymentMethod': selectedPayment.value,
//           'totalAmount': correctTotal, // CHANGE
//         },
//       );
//     } catch (e) {
//       Get.snackbar('Error', 'Order not placed: $e');
//     } finally {
//       isPlacingOrder(false);
//     }
//   }
// }





import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../Utilities_Screens/App_Model/app_model.dart';
import '../../Utilities_Screens/Notification_Helper/notification_helper.dart';
import '../Cart_Screen/cart_controller.dart';

class CheckoutController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // --- Buy Now (direct, bina cart ke) ---
  var isBuyNow = false.obs;
  ModelClass? buyNowProduct;
  int buyNowQuantity = 1;
  String? buyNowSize;
  String? buyNowColor; // NAYA
  double buyNowPrice = 0.0;
  double buyNowTotal = 0.0;

  // --- Address ---
  var savedAddresses = <Map<String, dynamic>>[].obs;
  var selectedAddressIndex = 0.obs;
  var isLoadingAddresses = true.obs;
  var isAddressSelected = false.obs; // NAYA - user ne khud address chuna/add kiya ya nahi

  // --- Payment ---
  var selectedPayment = ''.obs; // CHANGE - by default koi payment method selected nahi
  var isPaymentSelected = false.obs; // NAYA - user ne khud payment chuna ya nahi
  final List<Map<String, dynamic>> paymentMethods = [
    {'name': 'Cash on Delivery', 'icon': '💵'},
    {'name': 'Credit/Debit Card', 'icon': '💳'},
    {'name': 'JazzCash / EasyPaisa', 'icon': '📱'},
    {'name': 'Bank Transfer', 'icon': '🏦'},
  ];

  // --- Order ---
  var isPlacingOrder = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAddresses();

    // NAYA - agar Product Detail se "Buy Now" ke zariye aaye hain
    // to arguments se product/quantity/size/color/price/total nikal lein
    final args = Get.arguments;

    if (args != null && args is Map) {
      final product = args['product'];

      if (product is ModelClass) {
        isBuyNow.value = true;
        buyNowProduct = product;
        buyNowQuantity = (args['quantity'] as int?) ?? 1;
        buyNowSize = args['size'] as String?;
        buyNowColor = args['color'] as String?; // NAYA
        buyNowPrice = (args['price'] as num?)?.toDouble() ?? 0.0;
        buyNowTotal =
            (args['total'] as num?)?.toDouble() ??
                (buyNowPrice * buyNowQuantity);
      }
    }
  }

  Future<void> fetchAddresses() async {
    try {
      isLoadingAddresses(true);
      final uid = _auth.currentUser?.uid;
      if (uid == null) return;

      final snapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('addresses')
          .get();

      savedAddresses.value = snapshot.docs.map((doc) {
        final data = doc.data();
        data['addressId'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      Get.snackbar('Error', 'Addresses not load: $e');
    } finally {
      isLoadingAddresses(false);
    }
  }

  void selectAddress(int index) {
    selectedAddressIndex.value = index;
    isAddressSelected.value = true; // NAYA - stepper mein Address orange ho
  }

  // NAYA - address add/edit screen kholo; wapas aane par agar address
  // maujood hai to Address step complete maan lo
  Future<void> openAddressScreen([Map<String, dynamic>? addr]) async {
    await Get.toNamed('/address', arguments: addr);
    await fetchAddresses();
    if (savedAddresses.isNotEmpty) {
      isAddressSelected.value = true;
    }
  }

  void selectPayment(String method) {
    selectedPayment.value = method;
    isPaymentSelected.value = true; // NAYA - stepper mein Payment orange ho
  }

  // NAYA - Buy Now flow mein screen par dikhane/order place karne
  // ke liye items list (cart wale format jaisi hi)
  List<Map<String, dynamic>> getOrderItems() {
    if (isBuyNow.value && buyNowProduct != null) {
      return [
        {
          'productId': buyNowProduct!.id,
          'name': buyNowProduct!.title,
          'image': buyNowProduct!.image,
          'price': buyNowPrice,
          'quantity': buyNowQuantity,
          'size': buyNowSize,
          'color': buyNowColor, // NAYA
        },
      ];
    }

    return CartController.instance.cartItems
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  // NAYA - screen par dikhane wala total (Buy Now ya Cart, dono ke liye)
  double get displayTotal {
    return isBuyNow.value ? buyNowTotal : CartController.instance.totalPrice;
  }

  List<Map<String, dynamic>> _buildOrderItems(
      List<Map<String, dynamic>> cartItems,
      ) {
    // Buy Now flow mein item cart se nahi aaya, is liye
    // tier pricing dobara calculate karne ki zaroorat nahi -
    // jo price/quantity pehle se diya gaya hai wahi use karo.
    if (isBuyNow.value) {
      return cartItems.map((item) {
        final quantity = (item['quantity'] as int? ?? 1);
        final unitPrice = (item['price'] as num? ?? 0).toDouble();
        return {
          ...item,
          'unitPrice': unitPrice,
          'basePrice': unitPrice,
          'itemTotal': unitPrice * quantity,
        };
      }).toList();
    }

    final cartController = CartController.instance;
    return cartItems.map((item) {
      final quantity = (item['quantity'] as int? ?? 1);
      final unitPrice = cartController.getUnitPrice(item); // tier price
      final basePrice = (item['price'] as num? ?? 0).toDouble();
      return {
        ...item,
        'unitPrice': unitPrice, // jo actually charge hui
        'basePrice': basePrice, // original price (record ke liye)
        'itemTotal': unitPrice * quantity,
      };
    }).toList();
  }

  // NAYA - total bhi khud calculate karo, caller ke total par depend mat karo
  double _calculateTotal(List<Map<String, dynamic>> orderItems) {
    return orderItems.fold(
      0.0,
          (sum, item) => sum + (item['itemTotal'] as num).toDouble(),
    );
  }

  Future<void> placeOrder(
      List<Map<String, dynamic>> cartItems,
      double total,
      ) async {
    await fetchAddresses();
    if (savedAddresses.isEmpty) {
      Get.snackbar('Address', 'add address first');
      return;
    }

    // NAYA - payment method select kiye bina order place nahi hoga
    if (selectedPayment.value.isEmpty) {
      Get.snackbar('Payment', 'Please select a payment method first');
      return;
    }

    try {
      isPlacingOrder(true);
      final uid = _auth.currentUser?.uid;
      if (uid == null) return;

      final selectedAddr = savedAddresses[selectedAddressIndex.value];

      // NAYA - tier-aware items aur sahi total
      final orderItems = _buildOrderItems(cartItems);
      final correctTotal = _calculateTotal(orderItems);

      //  docRef se order ID milega
      final docRef = await _firestore.collection('orders').add({
        'userId': uid,
        'items': orderItems, // CHANGE - discounted unitPrice/itemTotal ke saath
        'totalAmount': correctTotal, // CHANGE - khud calculate kiya hua total
        'address': selectedAddr,
        'paymentMethod': selectedPayment.value,
        'status': 'Pending',
        'createdAt': FieldValue.serverTimestamp(),
      });

      //  Cart clear karo - sirf tab jab cart se order hua ho.
      //  Buy Now flow mein item cart mein tha hi nahi.
      if (!isBuyNow.value) {
        CartController.instance.clearCart();
      }

      //  Order placed notification bhejo
      await NotificationHelper.showOrderNotification(
        title: 'Order Placed ',
        body:
        'Your order #${docRef.id.substring(0, 6)} has been placed successfully!',
      );

      //  Date format karo
      final now = DateTime.now();
      final formattedDate = '${now.day}/${now.month}/${now.year}';

      //  Order success screen par jao arguments ke sath
      Get.offAllNamed(
        '/ordercheck',
        arguments: {
          'orderId': docRef.id,
          'orderDate': formattedDate,
          'paymentMethod': selectedPayment.value,
          'totalAmount': correctTotal, // CHANGE
        },
      );
    } catch (e) {
      Get.snackbar('Error', 'Order not placed: $e');
    } finally {
      isPlacingOrder(false);
    }
  }
}