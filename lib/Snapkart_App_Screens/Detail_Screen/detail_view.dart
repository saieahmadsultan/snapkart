// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:snapkart/Utilities_Screens/App_Colors/app_colors.dart';
//
// import '../../Utilities_Screens/App_Model/app_model.dart';
// import 'detail_controller.dart';
//
// class ProductDetailView extends GetView<ProductDetailController> {
//   const ProductDetailView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Get.put(ProductDetailController());
//
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//
//         foregroundColor: Colors.black,
//
//         elevation: 0,
//
//         title: const Text(
//           'Product Details',
//           style: TextStyle(fontWeight: FontWeight.w600),
//         ),
//
//         actions: [
//           Obx(
//             () => IconButton(
//               onPressed: controller.toggleWishlist,
//
//               icon: Icon(
//                 controller.isWishlisted
//                     ? Icons.favorite
//                     : Icons.favorite_border,
//
//                 color: controller.isWishlisted ? Colors.red : Colors.black,
//               ),
//             ),
//           ),
//         ],
//       ),
//
//       body: Obx(() {
//         final product = controller.product.value;
//
//         if (product == null) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         return CustomScrollView(
//           slivers: [
//             SliverToBoxAdapter(
//               child: Column(
//                 children: [
//                   _imageSection(product),
//
//                   _productInfo(product),
//
//                   _sizeSection(product),
//
//                   _quantitySection(product),
//
//                   _descriptionSection(product),
//
//                   _relatedSection(),
//
//                   //const SizedBox(height: 5),
//                 ],
//               ),
//             ),
//           ],
//         );
//       }),
//
//       bottomNavigationBar: _bottomButtons(),
//     );
//   }
//
//   // =====================================================
//   // IMAGE SECTION
//   // =====================================================
//
//   Widget _imageSection(ModelClass product) {
//     return Container(
//       color: Colors.white,
//
//       child: Column(
//         children: [
//           SizedBox(
//             height: 330,
//
//             child: PageView.builder(
//               itemCount: controller.dummyImages.isEmpty
//                   ? 1
//                   : controller.dummyImages.length,
//
//               onPageChanged: controller.changeImage,
//
//               itemBuilder: (context, index) {
//                 final image = controller.dummyImages.isEmpty
//                     ? product.image
//                     : controller.dummyImages[index];
//
//                 if (image == null || image.isEmpty) {
//                   return const Center(
//                     child: Icon(
//                       Icons.image_not_supported,
//                       size: 80,
//                       color: Colors.grey,
//                     ),
//                   );
//                 }
//
//                 return Padding(
//                   padding: const EdgeInsets.all(20),
//
//                   child: Image.network(
//                     image,
//
//                     fit: BoxFit.contain,
//
//                     errorBuilder: (context, error, stackTrace) {
//                       return const Center(
//                         child: Icon(
//                           Icons.broken_image,
//                           size: 70,
//                           color: Colors.grey,
//                         ),
//                       );
//                     },
//
//                     loadingBuilder: (context, child, loadingProgress) {
//                       if (loadingProgress == null) {
//                         return child;
//                       }
//
//                       return const Center(child: CircularProgressIndicator());
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//
//           Obx(
//             () => Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//
//               children: List.generate(controller.dummyImages.length, (index) {
//                 final selected = controller.currentImageIndex.value == index;
//
//                 return AnimatedContainer(
//                   duration: const Duration(milliseconds: 200),
//
//                   margin: const EdgeInsets.symmetric(
//                     horizontal: 4,
//                     vertical: 10,
//                   ),
//
//                   height: 7,
//
//                   width: selected ? 22 : 7,
//
//                   decoration: BoxDecoration(
//                     color: selected
//                         ? const Color(0xFFE94560)
//                         : Colors.grey.shade400,
//
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 );
//               }),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // =====================================================
//   // PRODUCT INFO
//   // =====================================================
//
//   Widget _productInfo(ModelClass product) {
//     return Container(
//       width: double.infinity,
//
//       margin: const EdgeInsets.only(top: 8),
//
//       padding: const EdgeInsets.all(16),
//
//       color: Colors.white,
//
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//
//         children: [
//           Text(
//             product.title ?? 'No Title',
//
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//           ),
//
//           const SizedBox(height: 10),
//
//           // Rating
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
//
//                 decoration: BoxDecoration(
//                   color: AppColors.secondary,
//
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//
//                   children: [
//                     Text(
//                       '${product.rating?.rate?.toStringAsFixed(1) ?? '0.0'}',
//
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//
//                     const SizedBox(width: 3),
//
//                     const Icon(Icons.star, size: 13, color: Colors.white),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(width: 8),
//
//               Text(
//                 '${product.rating?.count ?? 0} Ratings',
//
//                 style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
//               ),
//             ],
//           ),
//
//           const SizedBox(height: 12),
//
//           // PRICE
//           Obx(() {
//             final currentPrice = controller.getUnitPrice();
//
//             final oldPrice = controller.oldPrice;
//
//             final discount = controller.discountPercentage;
//
//             return Row(
//               crossAxisAlignment: CrossAxisAlignment.end,
//
//               children: [
//                 Text(
//                   'Rs. ${currentPrice.toStringAsFixed(0)}',
//
//                   style: const TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.w700,
//                     color: Color(0xFFE94560),
//                   ),
//                 ),
//
//                 const SizedBox(width: 8),
//
//                 if (oldPrice > currentPrice)
//                   Text(
//                     'Rs. ${oldPrice.toStringAsFixed(0)}',
//
//                     style: TextStyle(
//                       fontSize: 13,
//                       color: Colors.grey.shade500,
//
//                       decoration: TextDecoration.lineThrough,
//                     ),
//                   ),
//
//                 const SizedBox(width: 7),
//
//                 if (discount > 0)
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 5,
//                       vertical: 2,
//                     ),
//
//                     decoration: BoxDecoration(
//                       color: Colors.red.shade50,
//
//                       borderRadius: BorderRadius.circular(3),
//                     ),
//
//                     child: Text(
//                       '$discount% OFF',
//
//                       style: TextStyle(
//                         fontSize: 11,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.red.shade700,
//                       ),
//                     ),
//                   ),
//               ],
//             );
//           }),
//
//           const SizedBox(height: 6),
//
//           Text(
//             'Inclusive of all taxes',
//
//             style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // =====================================================
//   // SIZE SECTION
//   // =====================================================
//
//   Widget _sizeSection(ModelClass product) {
//     if (product.sizes.isEmpty) {
//       return const SizedBox.shrink();
//     }
//
//     return Container(
//       width: double.infinity,
//
//       margin: const EdgeInsets.only(top: 8),
//
//       padding: const EdgeInsets.all(16),
//
//       color: Colors.white,
//
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//
//             children: [
//               const Text(
//                 'Select Size',
//
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//               ),
//
//               Obx(() {
//                 final size = controller.selectedSize.value;
//
//                 if (size == null) {
//                   return const SizedBox();
//                 }
//
//                 return Text(
//                   'Selected: ${size.label}',
//
//                   style: const TextStyle(
//                     fontSize: 12,
//                     color: Color(0xFFE94560),
//                     fontWeight: FontWeight.w600,
//                   ),
//                 );
//               }),
//             ],
//           ),
//
//           const SizedBox(height: 14),
//
//           Wrap(
//             spacing: 10,
//
//             runSpacing: 10,
//
//             children: product.sizes.map((size) {
//               return Obx(() {
//                 final isSelected = controller.selectedSize.value == size;
//
//                 final isOutOfStock = size.stock <= 0;
//
//                 return GestureDetector(
//                   onTap: isOutOfStock
//                       ? null
//                       : () => controller.selectSize(size),
//
//                   child: AnimatedContainer(
//                     duration: const Duration(milliseconds: 200),
//
//                     width: 82,
//
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 8,
//                       vertical: 10,
//                     ),
//
//                     decoration: BoxDecoration(
//                       color: isOutOfStock
//                           ? Colors.grey.shade100
//                           : isSelected
//                           ? const Color(0xFFFFF0F3)
//                           : Colors.white,
//
//                       border: Border.all(
//                         color: isOutOfStock
//                             ? Colors.grey.shade300
//                             : isSelected
//                             ? const Color(0xFFE94560)
//                             : Colors.grey.shade400,
//
//                         width: isSelected ? 2 : 1,
//                       ),
//
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//
//                     child: Column(
//                       children: [
//                         Text(
//                           size.label,
//
//                           style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w700,
//
//                             color: isOutOfStock
//                                 ? Colors.grey
//                                 : isSelected
//                                 ? const Color(0xFFE94560)
//                                 : Colors.black,
//                           ),
//                         ),
//
//                         const SizedBox(height: 4),
//
//                         // SMALL PRICE
//                         Text(
//                           size.price > 0
//                               ? 'Rs. ${size.price.toStringAsFixed(0)}'
//                               : 'Rs. ${controller.basePrice.toStringAsFixed(0)}',
//
//                           style: TextStyle(
//                             fontSize: 11,
//
//                             fontWeight: FontWeight.w500,
//
//                             color: isOutOfStock
//                                 ? Colors.grey
//                                 : Colors.grey.shade700,
//                           ),
//                         ),
//
//                         const SizedBox(height: 3),
//
//                         Text(
//                           isOutOfStock ? 'Out of stock' : '${size.stock} left',
//
//                           style: TextStyle(
//                             fontSize: 9,
//
//                             color: isOutOfStock
//                                 ? Colors.red
//                                 : Colors.green.shade700,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               });
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // =====================================================
//   // QUANTITY
//   // =====================================================
//
//   Widget _quantitySection(ModelClass product) {
//     return Container(
//       width: double.infinity,
//
//       margin: const EdgeInsets.only(top: 8),
//
//       padding: const EdgeInsets.all(16),
//
//       color: Colors.white,
//
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//
//         children: [
//           const Text(
//             'Quantity',
//
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//           ),
//
//           Obx(
//             () => Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey.shade300),
//
//                 borderRadius: BorderRadius.circular(7),
//               ),
//
//               child: Row(
//                 children: [
//                   IconButton(
//                     onPressed: controller.decreaseQuantity,
//
//                     icon: const Icon(Icons.remove, size: 18),
//                   ),
//
//                   Text(
//                     '${controller.quantity.value}',
//
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//
//                   IconButton(
//                     onPressed: controller.increaseQuantity,
//
//                     icon: const Icon(Icons.add, size: 18),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // =====================================================
//   // DESCRIPTION
//   // =====================================================
//
//   Widget _descriptionSection(ModelClass product) {
//     return Container(
//       width: double.infinity,
//
//       margin: const EdgeInsets.only(top: 8),
//
//       padding: const EdgeInsets.all(16),
//
//       color: Colors.white,
//
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//
//         children: [
//           const Text(
//             'Product Details',
//
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//           ),
//
//           const SizedBox(height: 10),
//
//           Text(
//             product.description ?? 'No description available.',
//
//             style: TextStyle(
//               fontSize: 14,
//               height: 1.5,
//               color: Colors.grey.shade700,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // =====================================================
//   // RELATED PRODUCTS
//   // =====================================================
//
//   Widget _relatedSection() {
//     return Obx(() {
//       if (controller.isRelatedLoading.value) {
//         return Container(
//           padding: const EdgeInsets.all(25),
//
//           child: const Center(child: CircularProgressIndicator()),
//         );
//       }
//
//       if (controller.relatedProducts.isEmpty) {
//         return const SizedBox.shrink();
//       }
//
//       return Container(
//         width: double.infinity,
//
//         margin: const EdgeInsets.only(top: 8),
//
//         padding: const EdgeInsets.all(16),
//
//         color: Colors.white,
//
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//
//           children: [
//             const Text(
//               'You May Also Like',
//
//               style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
//             ),
//
//             const SizedBox(height: 14),
//
//             SizedBox(
//               height: 232,
//
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//
//                 itemCount: controller.relatedProducts.length,
//
//                 itemBuilder: (context, index) {
//                   final item = controller.relatedProducts[index];
//
//                   return GestureDetector(
//                     onTap: () => controller.switchToRelatedProduct(item),
//
//                     child: Container(
//                       width: 150,
//
//                       margin: const EdgeInsets.only(right: 12),
//
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//
//                         border: Border.all(color: Colors.grey.shade200),
//
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//
//                         children: [
//                           ClipRRect(
//                             borderRadius: const BorderRadius.vertical(
//                               top: Radius.circular(10),
//                             ),
//
//                             child: SizedBox(
//                               height: 145,
//
//                               width: double.infinity,
//
//                               child: Image.network(
//                                 item.image ?? '',
//
//                                 fit: BoxFit.cover,
//
//                                 errorBuilder: (context, error, stackTrace) {
//                                   return const Icon(Icons.image, size: 50);
//                                 },
//                               ),
//                             ),
//                           ),
//
//                           Padding(
//                             padding: const EdgeInsets.all(9),
//
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//
//                               children: [
//                                 Text(
//                                   item.title ?? 'Product',
//
//                                   maxLines: 2,
//
//                                   overflow: TextOverflow.ellipsis,
//
//                                   style: const TextStyle(
//                                     fontSize: 13,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//
//                                 const SizedBox(height: 6),
//
//                                 Text(
//                                   'Rs. ${(item.discountPrice != null && item.discountPrice! > 0 ? item.discountPrice! : item.price ?? 0).toStringAsFixed(0)}',
//
//                                   style: const TextStyle(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w700,
//                                     color: Color(0xFFE94560),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }
//
//   // =====================================================
//   // BOTTOM BUTTONS
//   // =====================================================
//
//   Widget _bottomButtons() {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
//
//       decoration: BoxDecoration(
//         color: Colors.white,
//
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//
//             blurRadius: 10,
//
//             offset: const Offset(0, -2),
//           ),
//         ],
//       ),
//
//       child: SafeArea(
//         child: Row(
//           children: [
//             // -----------------------------------------
//             // CART
//             // -----------------------------------------
//             Expanded(
//               child: OutlinedButton(
//                 onPressed: controller.addToCart,
//
//                 style: OutlinedButton.styleFrom(
//                   minimumSize: const Size(0, 50),
//
//                   side: const BorderSide(color: Color(0xFFE94560)),
//
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//
//                 child: Obx(
//                   () => Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//
//                     children: [
//                       Icon(
//                         controller.isAddedToCart.value
//                             ? Icons.check
//                             : Icons.shopping_cart,
//
//                         color: AppColors.secondary,
//                       ),
//
//                       const SizedBox(width: 6),
//
//                       Text(
//                         controller.isAddedToCart.value
//                             ? 'Added'
//                             : 'Add to Cart',
//
//                         style: const TextStyle(
//                           color: AppColors.secondary,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//
//             const SizedBox(width: 10),
//
//             // -----------------------------------------
//             // BUY NOW
//             // -----------------------------------------
//             Expanded(
//               child: ElevatedButton(
//                 onPressed: controller.buyNow,
//
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: const Size(0, 50),
//
//                   backgroundColor: AppColors.secondary,
//
//                   foregroundColor: Colors.white,
//
//                   elevation: 0,
//
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//
//                 child: const Text(
//                   'Buy Now',
//
//                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../App_Routes/routes_view.dart';
// import '../../Utilities_Screens/App_Colors/app_colors.dart';
// import '../../Utilities_Screens/App_Colors/app_widgets.dart';
// import '../../Utilities_Screens/App_Model/app_model.dart';
// import '../Cart_Screen/cart_controller.dart';
// import 'detail_controller.dart';
//
// class ProductDetailView extends GetView<ProductDetailController> {
//   const ProductDetailView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Get.put(ProductDetailController());
//
//     return Scaffold(
//       backgroundColor: AppColors.background(context),
//       appBar: _appBar(context),
//       body: Obx(() {
//         final product = controller.product.value;
//
//         if (product == null) {
//           return const Center(
//             child: CircularProgressIndicator(color: AppColors.secondary),
//           );
//         }
//
//         return SingleChildScrollView(
//           padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               _ImageGallery(
//                 key: ValueKey(product.id),
//                 controller: controller,
//                 product: product,
//               ),
//               const SizedBox(height: 12),
//               _productInfo(context, product),
//               _sizeSection(context, product),
//               _quantitySection(context),
//               _descriptionSection(context, product),
//               _relatedSection(context),
//             ],
//           ),
//         );
//       }),
//       bottomNavigationBar: _bottomButtons(context),
//     );
//   }
//
//   // =====================================================
//   // APP BAR
//   // =====================================================
//
//   PreferredSizeWidget _appBar(BuildContext context) {
//     return AppBar(
//       elevation: 0,
//       scrolledUnderElevation: 0,
//       surfaceTintColor: Colors.transparent,
//       backgroundColor: AppColors.background(context),
//       foregroundColor: AppColors.textPrimary(context),
//       leading: IconButton(
//         icon: const Icon(Icons.arrow_back),
//         onPressed: () => Get.back(),
//       ),
//       titleSpacing: 0,
//       title: const SnapKartLogo(size: 24),
//       actions: [
//         Obx(() {
//           final liked = controller.isWishlisted;
//           return IconButton(
//             onPressed: controller.toggleWishlist,
//             icon: Icon(
//               liked ? Icons.favorite : Icons.favorite_border,
//               color: liked
//                   ? AppColors.secondary
//                   : AppColors.textPrimary(context),
//             ),
//           );
//         }),
//         Padding(
//           padding: const EdgeInsets.only(right: 8),
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               IconButton(
//                 icon: Icon(
//                   Icons.shopping_cart_outlined,
//                   color: AppColors.textPrimary(context),
//                 ),
//                 onPressed: () => Get.toNamed(AppRoutes.cart),
//               ),
//               Positioned(
//                 right: 4,
//                 top: 8,
//                 child: Obx(() {
//                   CartController.instance.cartItems.value;
//                   final count = CartController.instance.cartItemCount;
//
//                   if (count == 0) {
//                     return const SizedBox.shrink();
//                   }
//
//                   return Container(
//                     padding: const EdgeInsets.all(4),
//                     decoration: const BoxDecoration(
//                       color: AppColors.secondary,
//                       shape: BoxShape.circle,
//                     ),
//                     constraints: const BoxConstraints(
//                       minWidth: 18,
//                       minHeight: 18,
//                     ),
//                     child: Text(
//                       '$count',
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 10,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   );
//                 }),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   // =====================================================
//   // PRODUCT INFO
//   // =====================================================
//
//   Widget _productInfo(BuildContext context, ModelClass product) {
//     return AppCard(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Text(
//                   product.title ?? 'No Title',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w800,
//                     height: 1.2,
//                     color: AppColors.textPrimary(context),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               _stockPill(),
//             ],
//           ),
//
//           const SizedBox(height: 8),
//
//           // Rating
//           Row(
//             children: [
//               const Icon(Icons.star_rounded, size: 18, color: Colors.amber),
//               const SizedBox(width: 4),
//               Text(
//                 product.rating?.rate?.toStringAsFixed(1) ?? '0.0',
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w700,
//                   color: AppColors.textPrimary(context),
//                 ),
//               ),
//               const SizedBox(width: 4),
//               Text(
//                 '(${product.rating?.count ?? 0})',
//                 style: TextStyle(
//                   fontSize: 13,
//                   color: AppColors.textSecondary(context),
//                 ),
//               ),
//             ],
//           ),
//
//           const SizedBox(height: 12),
//
//           // Price
//           Obx(() {
//             final currentPrice = controller.getUnitPrice();
//             final oldPrice = controller.oldPrice;
//             final discount = controller.discountPercentage;
//
//             return Wrap(
//               crossAxisAlignment: WrapCrossAlignment.center,
//               spacing: 10,
//               runSpacing: 4,
//               children: [
//                 Text(
//                   'Rs. ${currentPrice.toStringAsFixed(0)}',
//                   style: const TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.w900,
//                     color: AppColors.secondary,
//                   ),
//                 ),
//                 if (oldPrice > currentPrice)
//                   Text(
//                     'Rs. ${oldPrice.toStringAsFixed(0)}',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey.shade500,
//                       decoration: TextDecoration.lineThrough,
//                     ),
//                   ),
//                 if (discount > 0)
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 10,
//                       vertical: 4,
//                     ),
//                     decoration: BoxDecoration(
//                       color: AppColors.orangeSoft(context),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       '$discount% OFF',
//                       style: const TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w800,
//                         color: AppColors.secondary,
//                       ),
//                     ),
//                   ),
//               ],
//             );
//           }),
//
//           const SizedBox(height: 6),
//
//           Text(
//             'Inclusive of all taxes',
//             style: TextStyle(
//               fontSize: 12,
//               color: AppColors.textSecondary(context),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _stockPill() {
//     return Obx(() {
//       final inStock = controller.selectedStock > 0;
//       final color = inStock ? AppColors.success : Colors.red.shade600;
//
//       return Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//         decoration: BoxDecoration(
//           color: color.withValues(alpha: 0.12),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               width: 7,
//               height: 7,
//               decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//             ),
//             const SizedBox(width: 5),
//             Text(
//               inStock ? 'In Stock' : 'Out of Stock',
//               style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w700,
//                 color: color,
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }
//
//   // =====================================================
//   // SIZE SECTION
//   // =====================================================
//
//   Widget _sizeSection(BuildContext context, ModelClass product) {
//     if (product.sizes.isEmpty) {
//       return const SizedBox.shrink();
//     }
//
//     return Padding(
//       padding: const EdgeInsets.only(top: 12),
//       child: AppCard(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Select Size',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w800,
//                     color: AppColors.textPrimary(context),
//                   ),
//                 ),
//                 Obx(() {
//                   final size = controller.selectedSize.value;
//
//                   if (size == null) {
//                     return const SizedBox();
//                   }
//
//                   return Text(
//                     'Selected: ${size.label}',
//                     style: const TextStyle(
//                       fontSize: 12,
//                       color: AppColors.secondary,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   );
//                 }),
//               ],
//             ),
//
//             const SizedBox(height: 14),
//
//             Wrap(
//               spacing: 10,
//               runSpacing: 10,
//               children: product.sizes.map((size) {
//                 return Obx(() {
//                   final isSelected = controller.selectedSize.value == size;
//                   final isOutOfStock = size.stock <= 0;
//
//                   return GestureDetector(
//                     onTap: isOutOfStock
//                         ? null
//                         : () => controller.selectSize(size),
//                     child: AnimatedContainer(
//                       duration: const Duration(milliseconds: 200),
//                       width: 78,
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 8,
//                         vertical: 10,
//                       ),
//                       decoration: BoxDecoration(
//                         color: isOutOfStock
//                             ? Colors.grey.withValues(alpha: 0.1)
//                             : isSelected
//                             ? AppColors.orangeSoft(context)
//                             : AppColors.cardBackground(context),
//                         border: Border.all(
//                           color: isOutOfStock
//                               ? Colors.grey.shade300
//                               : isSelected
//                               ? AppColors.secondary
//                               : Colors.grey.shade300,
//                           width: isSelected ? 2 : 1,
//                         ),
//                         borderRadius: BorderRadius.circular(14),
//                       ),
//                       child: Column(
//                         children: [
//                           Text(
//                             size.label,
//                             style: TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w800,
//                               color: isOutOfStock
//                                   ? Colors.grey
//                                   : isSelected
//                                   ? AppColors.secondary
//                                   : AppColors.textPrimary(context),
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             size.price > 0
//                                 ? 'Rs. ${size.price.toStringAsFixed(0)}'
//                                 : 'Rs. ${controller.basePrice.toStringAsFixed(0)}',
//                             style: TextStyle(
//                               fontSize: 11,
//                               color: isOutOfStock
//                                   ? Colors.grey
//                                   : AppColors.textSecondary(context),
//                             ),
//                           ),
//                           const SizedBox(height: 3),
//                           Text(
//                             isOutOfStock
//                                 ? 'Out of stock'
//                                 : '${size.stock} left',
//                             style: TextStyle(
//                               fontSize: 9,
//                               color: isOutOfStock
//                                   ? Colors.red
//                                   : AppColors.success,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 });
//               }).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // =====================================================
//   // QUANTITY
//   // =====================================================
//
//   Widget _quantitySection(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 12),
//       child: AppCard(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'Quantity',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w800,
//                 color: AppColors.textPrimary(context),
//               ),
//             ),
//             Obx(
//               () => Container(
//                 padding: const EdgeInsets.all(4),
//                 decoration: BoxDecoration(
//                   color: AppColors.textPrimary(context).withValues(alpha: 0.06),
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Row(
//                   children: [
//                     _qtyButton(
//                       context: context,
//                       icon: Icons.remove,
//                       onTap: controller.decreaseQuantity,
//                     ),
//                     SizedBox(
//                       width: 40,
//                       child: Text(
//                         '${controller.quantity.value}',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                           color: AppColors.textPrimary(context),
//                         ),
//                       ),
//                     ),
//                     _qtyButton(
//                       context: context,
//                       icon: Icons.add,
//                       onTap: controller.increaseQuantity,
//                       isPrimary: true,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _qtyButton({
//     required BuildContext context,
//     required IconData icon,
//     required VoidCallback onTap,
//     bool isPrimary = false,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 36,
//         height: 36,
//         decoration: BoxDecoration(
//           color: isPrimary ? AppColors.secondary : Colors.transparent,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Icon(
//           icon,
//           size: 20,
//           color: isPrimary ? Colors.white : AppColors.textPrimary(context),
//         ),
//       ),
//     );
//   }
//
//   // =====================================================
//   // DESCRIPTION
//   // =====================================================
//
//   Widget _descriptionSection(BuildContext context, ModelClass product) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 12),
//       child: AppCard(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Product Details',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w800,
//                 color: AppColors.textPrimary(context),
//               ),
//             ),
//             const SizedBox(height: 10),
//             _ExpandableText(
//               key: ValueKey('desc_${product.id}'),
//               text: product.description ?? 'No description available.',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // =====================================================
//   // RELATED PRODUCTS
//   // =====================================================
//
//   Widget _relatedSection(BuildContext context) {
//     return Obx(() {
//       if (controller.isRelatedLoading.value) {
//         return const Padding(
//           padding: EdgeInsets.all(25),
//           child: Center(
//             child: CircularProgressIndicator(color: AppColors.secondary),
//           ),
//         );
//       }
//
//       if (controller.relatedProducts.isEmpty) {
//         return const SizedBox.shrink();
//       }
//
//       return Padding(
//         padding: const EdgeInsets.only(top: 12),
//         child: AppCard(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'You May Also Like',
//                 style: TextStyle(
//                   fontSize: 17,
//                   fontWeight: FontWeight.w800,
//                   color: AppColors.textPrimary(context),
//                 ),
//               ),
//               const SizedBox(height: 14),
//               SizedBox(
//                 height: 230,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: controller.relatedProducts.length,
//                   itemBuilder: (context, index) {
//                     final item = controller.relatedProducts[index];
//
//                     final num shown =
//                         (item.discountPrice != null && item.discountPrice! > 0)
//                         ? item.discountPrice!
//                         : (item.price ?? 0);
//
//                     return GestureDetector(
//                       onTap: () => controller.switchToRelatedProduct(item),
//                       child: Container(
//                         width: 150,
//                         margin: const EdgeInsets.only(right: 12),
//                         decoration: BoxDecoration(
//                           color: AppColors.cardBackground(context),
//                           border: Border.all(color: Colors.grey.shade200),
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             ClipRRect(
//                               borderRadius: const BorderRadius.vertical(
//                                 top: Radius.circular(16),
//                               ),
//                               child: Container(
//                                 height: 140,
//                                 width: double.infinity,
//                                 color: Colors.white,
//                                 child: Image.network(
//                                   item.image ?? '',
//                                   fit: BoxFit.contain,
//                                   errorBuilder: (context, error, stackTrace) {
//                                     return const Icon(
//                                       Icons.image,
//                                       size: 50,
//                                       color: Colors.grey,
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(10),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     item.title ?? 'Product',
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(
//                                       fontSize: 13,
//                                       fontWeight: FontWeight.w600,
//                                       color: AppColors.textPrimary(context),
//                                     ),
//                                   ),
//                                   const SizedBox(height: 6),
//                                   Text(
//                                     'Rs. ${shown.toStringAsFixed(0)}',
//                                     style: const TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w900,
//                                       color: AppColors.secondary,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
//
//   // =====================================================
//   // BOTTOM BUTTONS
//   // =====================================================
//
//   Widget _bottomButtons(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
//       decoration: BoxDecoration(
//         color: AppColors.cardBackground(context),
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.08),
//             blurRadius: 12,
//             offset: const Offset(0, -4),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         top: false,
//         child: Row(
//           children: [
//             // ADD TO CART
//             Expanded(
//               child: GestureDetector(
//                 onTap: controller.addToCart,
//                 child: Obx(() {
//                   final added = controller.isAddedToCart.value;
//
//                   return Container(
//                     height: 54,
//                     decoration: BoxDecoration(
//                       color: AppColors.orangeSoft(context),
//                       borderRadius: BorderRadius.circular(16),
//                       border: Border.all(
//                         color: AppColors.secondary.withValues(alpha: 0.4),
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           added ? Icons.check : Icons.shopping_cart,
//                           color: AppColors.secondary,
//                           size: 22,
//                         ),
//                         const SizedBox(width: 8),
//                         Text(
//                           added ? 'Added' : 'Add to Cart',
//                           style: const TextStyle(
//                             color: AppColors.secondary,
//                             fontSize: 15,
//                             fontWeight: FontWeight.w800,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }),
//               ),
//             ),
//
//             const SizedBox(width: 12),
//
//             // BUY NOW
//             Expanded(
//               child: GradientButton(text: 'Buy Now', onTap: controller.buyNow),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // =====================================================
// // IMAGE GALLERY (main image + thumbnails + fullscreen)
// // =====================================================
//
// class _ImageGallery extends StatefulWidget {
//   final ProductDetailController controller;
//   final ModelClass product;
//
//   const _ImageGallery({
//     super.key,
//     required this.controller,
//     required this.product,
//   });
//
//   @override
//   State<_ImageGallery> createState() => _ImageGalleryState();
// }
//
// class _ImageGalleryState extends State<_ImageGallery> {
//   final PageController _page = PageController();
//
//   @override
//   void dispose() {
//     _page.dispose();
//     super.dispose();
//   }
//
//   List<String> get _images {
//     final list = widget.controller.dummyImages;
//     if (list.isNotEmpty) return list;
//
//     final single = widget.product.image;
//     return (single != null && single.isNotEmpty) ? [single] : [];
//   }
//
//   void _openFullScreen(List<String> images) {
//     Get.dialog(
//       Dialog(
//         backgroundColor: Colors.black,
//         insetPadding: EdgeInsets.zero,
//         shape: const RoundedRectangleBorder(),
//         child: SizedBox.expand(
//           child: Stack(
//             children: [
//               PageView.builder(
//                 controller: PageController(
//                   initialPage: widget.controller.currentImageIndex.value,
//                 ),
//                 itemCount: images.length,
//                 itemBuilder: (_, i) => InteractiveViewer(
//                   minScale: 1,
//                   maxScale: 4,
//                   child: Center(
//                     child: Image.network(images[i], fit: BoxFit.contain),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 40,
//                 right: 16,
//                 child: GestureDetector(
//                   onTap: () => Get.back(),
//                   child: const CircleAvatar(
//                     backgroundColor: Colors.white24,
//                     child: Icon(Icons.close, color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final images = _images;
//
//     return Column(
//       children: [
//         Container(
//           height: 340,
//           width: double.infinity,
//           clipBehavior: Clip.antiAlias,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(24),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withValues(alpha: 0.06),
//                 blurRadius: 12,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Stack(
//             children: [
//               Positioned.fill(
//                 child: images.isEmpty
//                     ? const Center(
//                         child: Icon(
//                           Icons.image_not_supported,
//                           size: 80,
//                           color: Colors.grey,
//                         ),
//                       )
//                     : PageView.builder(
//                         controller: _page,
//                         itemCount: images.length,
//                         onPageChanged: widget.controller.changeImage,
//                         itemBuilder: (context, index) {
//                           return Padding(
//                             padding: const EdgeInsets.all(18),
//                             child: Image.network(
//                               images[index],
//                               fit: BoxFit.contain,
//                               errorBuilder: (context, error, stackTrace) {
//                                 return const Center(
//                                   child: Icon(
//                                     Icons.broken_image,
//                                     size: 70,
//                                     color: Colors.grey,
//                                   ),
//                                 );
//                               },
//                               loadingBuilder: (context, child, progress) {
//                                 if (progress == null) return child;
//                                 return const Center(
//                                   child: CircularProgressIndicator(
//                                     color: AppColors.secondary,
//                                   ),
//                                 );
//                               },
//                             ),
//                           );
//                         },
//                       ),
//               ),
//
//               // DISCOUNT BADGE
//               Positioned(
//                 left: 12,
//                 top: 12,
//                 child: Obx(() {
//                   final d = widget.controller.discountPercentage;
//                   if (d <= 0) return const SizedBox.shrink();
//                   return DiscountBadge('-$d%');
//                 }),
//               ),
//
//               // FULLSCREEN BUTTON
//               if (images.isNotEmpty)
//                 Positioned(
//                   right: 12,
//                   bottom: 12,
//                   child: GestureDetector(
//                     onTap: () => _openFullScreen(images),
//                     child: Container(
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         shape: BoxShape.circle,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withValues(alpha: 0.12),
//                             blurRadius: 6,
//                           ),
//                         ],
//                       ),
//                       child: const Icon(
//                         Icons.fullscreen,
//                         size: 22,
//                         color: Colors.black87,
//                       ),
//                     ),
//                   ),
//                 ),
//
//               // DOTS
//               if (images.length > 1)
//                 Positioned(
//                   bottom: 16,
//                   left: 0,
//                   right: 0,
//                   child: Obx(() {
//                     final current = widget.controller.currentImageIndex.value;
//                     return Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: List.generate(images.length, (i) {
//                         final selected = current == i;
//                         return AnimatedContainer(
//                           duration: const Duration(milliseconds: 200),
//                           margin: const EdgeInsets.symmetric(horizontal: 3),
//                           height: 7,
//                           width: selected ? 20 : 7,
//                           decoration: BoxDecoration(
//                             color: selected
//                                 ? AppColors.secondary
//                                 : Colors.grey.shade400,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                         );
//                       }),
//                     );
//                   }),
//                 ),
//             ],
//           ),
//         ),
//
//         // THUMBNAILS
//         if (images.length > 1) ...[
//           const SizedBox(height: 10),
//           SizedBox(
//             height: 66,
//             child: Obx(() {
//               final current = widget.controller.currentImageIndex.value;
//
//               return ListView.separated(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: images.length,
//                 separatorBuilder: (_, __) => const SizedBox(width: 10),
//                 itemBuilder: (context, i) {
//                   final selected = current == i;
//
//                   return GestureDetector(
//                     onTap: () => _page.animateToPage(
//                       i,
//                       duration: const Duration(milliseconds: 300),
//                       curve: Curves.easeOut,
//                     ),
//                     child: AnimatedContainer(
//                       duration: const Duration(milliseconds: 200),
//                       width: 66,
//                       padding: const EdgeInsets.all(4),
//                       clipBehavior: Clip.antiAlias,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(14),
//                         border: Border.all(
//                           color: selected
//                               ? AppColors.secondary
//                               : Colors.grey.shade300,
//                           width: selected ? 2 : 1,
//                         ),
//                       ),
//                       child: Image.network(
//                         images[i],
//                         fit: BoxFit.contain,
//                         errorBuilder: (_, __, ___) =>
//                             const Icon(Icons.image, color: Colors.grey),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }),
//           ),
//         ],
//       ],
//     );
//   }
// }
//
// // =====================================================
// // EXPANDABLE DESCRIPTION ("Read More")
// // =====================================================
//
// class _ExpandableText extends StatefulWidget {
//   final String text;
//   const _ExpandableText({super.key, required this.text});
//
//   @override
//   State<_ExpandableText> createState() => _ExpandableTextState();
// }
//
// class _ExpandableTextState extends State<_ExpandableText> {
//   bool _expanded = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final isLong = widget.text.length > 120;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           widget.text,
//           maxLines: (_expanded || !isLong) ? null : 3,
//           overflow: TextOverflow.ellipsis,
//           style: TextStyle(
//             fontSize: 14,
//             height: 1.5,
//             color: AppColors.textSecondary(context),
//           ),
//         ),
//         if (isLong)
//           GestureDetector(
//             onTap: () => setState(() => _expanded = !_expanded),
//             child: Padding(
//               padding: const EdgeInsets.only(top: 6),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     _expanded ? 'Show Less' : 'Read More',
//                     style: const TextStyle(
//                       color: AppColors.secondary,
//                       fontSize: 13,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   Icon(
//                     _expanded
//                         ? Icons.keyboard_arrow_up
//                         : Icons.keyboard_arrow_down,
//                     color: AppColors.secondary,
//                     size: 18,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../App_Routes/routes_view.dart';
// import '../../Utilities_Screens/App_Colors/app_colors.dart';
// import '../../Utilities_Screens/App_Colors/app_widgets.dart';
// import '../../Utilities_Screens/App_Model/app_model.dart';
// import '../Cart_Screen/cart_controller.dart';
// import 'detail_controller.dart';
//
// class ProductDetailView extends GetView<ProductDetailController> {
//   const ProductDetailView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Get.put(ProductDetailController());
//
//     return Scaffold(
//       backgroundColor: AppColors.background(context),
//       appBar: _appBar(context),
//       body: Obx(() {
//         final product = controller.product.value;
//
//         if (product == null) {
//           return const Center(
//             child: CircularProgressIndicator(color: AppColors.secondary),
//           );
//         }
//
//         return SingleChildScrollView(
//           padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               _ImageGallery(
//                 key: ValueKey(product.id),
//                 controller: controller,
//                 product: product,
//               ),
//               const SizedBox(height: 12),
//               // Title, price, description, size, quantity: sab ek card mein
//               _productInfo(context, product),
//               _relatedSection(context),
//             ],
//           ),
//         );
//       }),
//       bottomNavigationBar: _bottomButtons(context),
//     );
//   }
//
//   // =====================================================
//   // APP BAR
//   // =====================================================
//
//   PreferredSizeWidget _appBar(BuildContext context) {
//     return AppBar(
//       elevation: 0,
//       scrolledUnderElevation: 0,
//       surfaceTintColor: Colors.transparent,
//       backgroundColor: AppColors.background(context),
//       foregroundColor: AppColors.textPrimary(context),
//       leading: IconButton(
//         icon: const Icon(Icons.arrow_back),
//         onPressed: () => Get.back(),
//       ),
//       titleSpacing: 0,
//       title: const SnapKartLogo(size: 24),
//       actions: [
//         Obx(() {
//           final liked = controller.isWishlisted;
//           return IconButton(
//             onPressed: controller.toggleWishlist,
//             icon: Icon(
//               liked ? Icons.favorite : Icons.favorite_border,
//               color: liked
//                   ? AppColors.secondary
//                   : AppColors.textPrimary(context),
//             ),
//           );
//         }),
//         Padding(
//           padding: const EdgeInsets.only(right: 8),
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               IconButton(
//                 icon: Icon(
//                   Icons.shopping_cart_outlined,
//                   color: AppColors.textPrimary(context),
//                 ),
//                 onPressed: () => Get.toNamed(AppRoutes.cart),
//               ),
//               Positioned(
//                 right: 4,
//                 top: 8,
//                 child: Obx(() {
//                   CartController.instance.cartItems.value;
//                   final count = CartController.instance.cartItemCount;
//
//                   if (count == 0) {
//                     return const SizedBox.shrink();
//                   }
//
//                   return Container(
//                     padding: const EdgeInsets.all(4),
//                     decoration: const BoxDecoration(
//                       color: AppColors.secondary,
//                       shape: BoxShape.circle,
//                     ),
//                     constraints: const BoxConstraints(
//                       minWidth: 18,
//                       minHeight: 18,
//                     ),
//                     child: Text(
//                       '$count',
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 10,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   );
//                 }),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   // =====================================================
//   // PRODUCT INFO (ek hi card: title, rating+stock, price,
//   // description, size, quantity)
//   // =====================================================
//
//   Widget _productInfo(BuildContext context, ModelClass product) {
//     return AppCard(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Title
//           Text(
//             product.title ?? 'No Title',
//             style: TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.w800,
//               height: 1.2,
//               color: AppColors.textPrimary(context),
//             ),
//           ),
//
//           const SizedBox(height: 8),
//
//           // Rating (left) + Stock pill (right)
//           Row(
//             children: [
//               const Icon(Icons.star_rounded, size: 20, color: Colors.amber),
//               const SizedBox(width: 4),
//               Text(
//                 product.rating?.rate?.toStringAsFixed(1) ?? '0.0',
//                 style: TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w800,
//                   color: AppColors.textPrimary(context),
//                 ),
//               ),
//               const SizedBox(width: 4),
//               Text(
//                 '(${product.rating?.count ?? 0})',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: AppColors.textSecondary(context),
//                 ),
//               ),
//               const Spacer(),
//               _stockPill(),
//             ],
//           ),
//
//           const SizedBox(height: 12),
//
//           // Price
//           Obx(() {
//             final currentPrice = controller.getUnitPrice();
//             final oldPrice = controller.oldPrice;
//             final discount = controller.discountPercentage;
//
//             return Wrap(
//               crossAxisAlignment: WrapCrossAlignment.center,
//               spacing: 12,
//               runSpacing: 4,
//               children: [
//                 Text(
//                   'Rs. ${currentPrice.toStringAsFixed(0)}',
//                   style: const TextStyle(
//                     fontSize: 30,
//                     fontWeight: FontWeight.w900,
//                     color: AppColors.secondary,
//                   ),
//                 ),
//                 if (oldPrice > currentPrice)
//                   Text(
//                     'Rs. ${oldPrice.toStringAsFixed(0)}',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey.shade500,
//                       decoration: TextDecoration.lineThrough,
//                     ),
//                   ),
//                 if (discount > 0)
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 12,
//                       vertical: 5,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.red.withValues(alpha: 0.12),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       '$discount% OFF',
//                       style: TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w800,
//                         color: Colors.red.shade600,
//                       ),
//                     ),
//                   ),
//               ],
//             );
//           }),
//
//           const SizedBox(height: 4),
//
//           Text(
//             'Inclusive of all taxes',
//             style: TextStyle(
//               fontSize: 13,
//               color: AppColors.textSecondary(context),
//             ),
//           ),
//
//           // Description + Read More
//           _divider(context),
//           _descriptionSection(context, product),
//
//           // Size
//           if (product.sizes.isNotEmpty) ...[
//             _divider(context),
//             _sizeSection(context, product),
//           ],
//
//           // Quantity
//           _divider(context),
//           _quantitySection(context),
//         ],
//       ),
//     );
//   }
//
//   Widget _divider(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 14),
//       child: Divider(
//         height: 1,
//         color: AppColors.textPrimary(context).withValues(alpha: 0.08),
//       ),
//     );
//   }
//
//   Widget _stockPill() {
//     return Obx(() {
//       final inStock = controller.selectedStock > 0;
//       final color = inStock ? AppColors.success : Colors.red.shade600;
//
//       return Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//         decoration: BoxDecoration(
//           color: color.withValues(alpha: 0.12),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               width: 8,
//               height: 8,
//               decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//             ),
//             const SizedBox(width: 6),
//             Text(
//               inStock ? 'In Stock' : 'Out of Stock',
//               style: TextStyle(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w700,
//                 color: color,
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }
//
//   // =====================================================
//   // DESCRIPTION
//   // =====================================================
//
//   Widget _descriptionSection(BuildContext context, ModelClass product) {
//     return _ExpandableText(
//       key: ValueKey('desc_${product.id}'),
//       text: product.description ?? 'No description available.',
//     );
//   }
//
//   // =====================================================
//   // SIZE SECTION
//   // =====================================================
//
//   Widget _sizeSection(BuildContext context, ModelClass product) {
//     if (product.sizes.isEmpty) {
//       return const SizedBox.shrink();
//     }
//
//     final sizes = product.sizes;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'Size',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w800,
//                 color: AppColors.textPrimary(context),
//               ),
//             ),
//             Obx(() {
//               final size = controller.selectedSize.value;
//
//               if (size == null) {
//                 return const SizedBox();
//               }
//
//               return Text(
//                 'Selected: ${size.label}',
//                 style: const TextStyle(
//                   fontSize: 13,
//                   color: AppColors.secondary,
//                   fontWeight: FontWeight.w700,
//                 ),
//               );
//             }),
//           ],
//         ),
//
//         const SizedBox(height: 12),
//
//         // 5 ya us se kam sizes: poori row mein barabar; zyada hon to wrap
//         if (sizes.length <= 5)
//           Row(
//             children: [
//               for (int i = 0; i < sizes.length; i++) ...[
//                 Expanded(child: _sizeChip(context, sizes[i])),
//                 if (i != sizes.length - 1) const SizedBox(width: 10),
//               ],
//             ],
//           )
//         else
//           Wrap(
//             spacing: 10,
//             runSpacing: 10,
//             children: sizes
//                 .map((s) => SizedBox(width: 64, child: _sizeChip(context, s)))
//                 .toList(),
//           ),
//       ],
//     );
//   }
//
//   Widget _sizeChip(BuildContext context, ProductSize size) {
//     return Obx(() {
//       final isSelected = controller.selectedSize.value == size;
//       final isOutOfStock = size.stock <= 0;
//
//       return GestureDetector(
//         onTap: isOutOfStock ? null : () => controller.selectSize(size),
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 200),
//           padding: const EdgeInsets.symmetric(vertical: 12),
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             color: isOutOfStock
//                 ? Colors.grey.withValues(alpha: 0.1)
//                 : isSelected
//                 ? AppColors.orangeSoft(context)
//                 : AppColors.cardBackground(context),
//             border: Border.all(
//               color: isOutOfStock
//                   ? Colors.grey.shade300
//                   : isSelected
//                   ? AppColors.secondary
//                   : Colors.grey.shade300,
//               width: isSelected ? 1.8 : 1,
//             ),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Text(
//             size.label,
//             style: TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.w700,
//               decoration: isOutOfStock ? TextDecoration.lineThrough : null,
//               color: isOutOfStock
//                   ? Colors.grey
//                   : isSelected
//                   ? AppColors.secondary
//                   : AppColors.textPrimary(context),
//             ),
//           ),
//         ),
//       );
//     });
//   }
//
//   // =====================================================
//   // QUANTITY
//   // =====================================================
//
//   Widget _quantitySection(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           'Quantity',
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w800,
//             color: AppColors.textPrimary(context),
//           ),
//         ),
//         Obx(
//           () => Container(
//             padding: const EdgeInsets.all(4),
//             decoration: BoxDecoration(
//               color: AppColors.textPrimary(context).withValues(alpha: 0.06),
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Row(
//               children: [
//                 _qtyButton(
//                   context: context,
//                   icon: Icons.remove,
//                   onTap: controller.decreaseQuantity,
//                 ),
//                 SizedBox(
//                   width: 44,
//                   child: Text(
//                     '${controller.quantity.value}',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                       color: AppColors.textPrimary(context),
//                     ),
//                   ),
//                 ),
//                 _qtyButton(
//                   context: context,
//                   icon: Icons.add,
//                   onTap: controller.increaseQuantity,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _qtyButton({
//     required BuildContext context,
//     required IconData icon,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 36,
//         height: 36,
//         color: Colors.transparent,
//         child: Icon(icon, size: 20, color: AppColors.textPrimary(context)),
//       ),
//     );
//   }
//
//   // =====================================================
//   // RELATED PRODUCTS
//   // =====================================================
//
//   Widget _relatedSection(BuildContext context) {
//     return Obx(() {
//       if (controller.isRelatedLoading.value) {
//         return const Padding(
//           padding: EdgeInsets.all(25),
//           child: Center(
//             child: CircularProgressIndicator(color: AppColors.secondary),
//           ),
//         );
//       }
//
//       if (controller.relatedProducts.isEmpty) {
//         return const SizedBox.shrink();
//       }
//
//       return Padding(
//         padding: const EdgeInsets.only(top: 12),
//         child: AppCard(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'You May Also Like',
//                 style: TextStyle(
//                   fontSize: 17,
//                   fontWeight: FontWeight.w800,
//                   color: AppColors.textPrimary(context),
//                 ),
//               ),
//               const SizedBox(height: 14),
//               SizedBox(
//                 height: 230,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: controller.relatedProducts.length,
//                   itemBuilder: (context, index) {
//                     final item = controller.relatedProducts[index];
//
//                     final num shown =
//                         (item.discountPrice != null && item.discountPrice! > 0)
//                         ? item.discountPrice!
//                         : (item.price ?? 0);
//
//                     return GestureDetector(
//                       onTap: () => controller.switchToRelatedProduct(item),
//                       child: Container(
//                         width: 150,
//                         margin: const EdgeInsets.only(right: 12),
//                         decoration: BoxDecoration(
//                           color: AppColors.cardBackground(context),
//                           border: Border.all(color: Colors.grey.shade200),
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             ClipRRect(
//                               borderRadius: const BorderRadius.vertical(
//                                 top: Radius.circular(16),
//                               ),
//                               child: Container(
//                                 height: 140,
//                                 width: double.infinity,
//                                 color: Colors.white,
//                                 child: Image.network(
//                                   item.image ?? '',
//                                   fit: BoxFit.contain,
//                                   errorBuilder: (context, error, stackTrace) {
//                                     return const Icon(
//                                       Icons.image,
//                                       size: 50,
//                                       color: Colors.grey,
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(10),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     item.title ?? 'Product',
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(
//                                       fontSize: 13,
//                                       fontWeight: FontWeight.w600,
//                                       color: AppColors.textPrimary(context),
//                                     ),
//                                   ),
//                                   const SizedBox(height: 6),
//                                   Text(
//                                     'Rs. ${shown.toStringAsFixed(0)}',
//                                     style: const TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w900,
//                                       color: AppColors.secondary,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
//
//   // =====================================================
//   // BOTTOM BUTTONS
//   // =====================================================
//
//   Widget _bottomButtons(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
//       decoration: BoxDecoration(
//         color: AppColors.cardBackground(context),
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.08),
//             blurRadius: 12,
//             offset: const Offset(0, -4),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         top: false,
//         child: Row(
//           children: [
//             // ADD TO CART
//             Expanded(
//               child: GestureDetector(
//                 onTap: controller.addToCart,
//                 child: Obx(() {
//                   final added = controller.isAddedToCart.value;
//
//                   return Container(
//                     height: 54,
//                     decoration: BoxDecoration(
//                       color: AppColors.orangeSoft(context),
//                       borderRadius: BorderRadius.circular(16),
//                       border: Border.all(
//                         color: AppColors.secondary.withValues(alpha: 0.4),
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           added ? Icons.check : Icons.shopping_cart,
//                           color: AppColors.secondary,
//                           size: 22,
//                         ),
//                         const SizedBox(width: 8),
//                         Text(
//                           added ? 'Added' : 'Add to Cart',
//                           style: const TextStyle(
//                             color: AppColors.secondary,
//                             fontSize: 15,
//                             fontWeight: FontWeight.w800,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }),
//               ),
//             ),
//
//             const SizedBox(width: 12),
//
//             // BUY NOW
//             Expanded(
//               child: GradientButton(text: 'Buy Now', onTap: controller.buyNow),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // =====================================================
// // IMAGE GALLERY (main image + thumbnails + fullscreen)
// // =====================================================
//
// class _ImageGallery extends StatefulWidget {
//   final ProductDetailController controller;
//   final ModelClass product;
//
//   const _ImageGallery({
//     super.key,
//     required this.controller,
//     required this.product,
//   });
//
//   @override
//   State<_ImageGallery> createState() => _ImageGalleryState();
// }
//
// class _ImageGalleryState extends State<_ImageGallery> {
//   final PageController _page = PageController();
//
//   @override
//   void dispose() {
//     _page.dispose();
//     super.dispose();
//   }
//
//   List<String> get _images {
//     final list = widget.controller.dummyImages;
//     if (list.isNotEmpty) return list;
//
//     final single = widget.product.image;
//     return (single != null && single.isNotEmpty) ? [single] : [];
//   }
//
//   void _openFullScreen(List<String> images) {
//     Get.dialog(
//       Dialog(
//         backgroundColor: Colors.black,
//         insetPadding: EdgeInsets.zero,
//         shape: const RoundedRectangleBorder(),
//         child: SizedBox.expand(
//           child: Stack(
//             children: [
//               PageView.builder(
//                 controller: PageController(
//                   initialPage: widget.controller.currentImageIndex.value,
//                 ),
//                 itemCount: images.length,
//                 itemBuilder: (_, i) => InteractiveViewer(
//                   minScale: 1,
//                   maxScale: 4,
//                   child: Center(
//                     child: Image.network(images[i], fit: BoxFit.contain),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 40,
//                 right: 16,
//                 child: GestureDetector(
//                   onTap: () => Get.back(),
//                   child: const CircleAvatar(
//                     backgroundColor: Colors.white24,
//                     child: Icon(Icons.close, color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _circleButton({
//     required IconData icon,
//     required VoidCallback onTap,
//     Color color = Colors.black87,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 44,
//         height: 44,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           shape: BoxShape.circle,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withValues(alpha: 0.12),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Icon(icon, size: 22, color: color),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final images = _images;
//
//     return Column(
//       children: [
//         Container(
//           height: 340,
//           width: double.infinity,
//           clipBehavior: Clip.antiAlias,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(24),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withValues(alpha: 0.06),
//                 blurRadius: 12,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Stack(
//             children: [
//               Positioned.fill(
//                 child: images.isEmpty
//                     ? const Center(
//                         child: Icon(
//                           Icons.image_not_supported,
//                           size: 80,
//                           color: Colors.grey,
//                         ),
//                       )
//                     : PageView.builder(
//                         controller: _page,
//                         itemCount: images.length,
//                         onPageChanged: widget.controller.changeImage,
//                         itemBuilder: (context, index) {
//                           return Padding(
//                             padding: const EdgeInsets.all(18),
//                             child: Image.network(
//                               images[index],
//                               fit: BoxFit.contain,
//                               errorBuilder: (context, error, stackTrace) {
//                                 return const Center(
//                                   child: Icon(
//                                     Icons.broken_image,
//                                     size: 70,
//                                     color: Colors.grey,
//                                   ),
//                                 );
//                               },
//                               loadingBuilder: (context, child, progress) {
//                                 if (progress == null) return child;
//                                 return const Center(
//                                   child: CircularProgressIndicator(
//                                     color: AppColors.secondary,
//                                   ),
//                                 );
//                               },
//                             ),
//                           );
//                         },
//                       ),
//               ),
//
//               // DISCOUNT BADGE
//               Positioned(
//                 left: 12,
//                 top: 12,
//                 child: Obx(() {
//                   final d = widget.controller.discountPercentage;
//                   if (d <= 0) return const SizedBox.shrink();
//                   return DiscountBadge('-$d%');
//                 }),
//               ),
//
//               // HEART + SHARE (top right)
//               Positioned(
//                 right: 12,
//                 top: 12,
//                 child: Column(
//                   children: [
//                     Obx(() {
//                       final liked = widget.controller.isWishlisted;
//                       return _circleButton(
//                         icon: liked ? Icons.favorite : Icons.favorite_border,
//                         color: liked ? AppColors.secondary : Colors.black87,
//                         onTap: widget.controller.toggleWishlist,
//                       );
//                     }),
//                     const SizedBox(height: 10),
//                     _circleButton(
//                       icon: Icons.share_outlined,
//                       onTap: () {
//                         // TODO: share_plus package add karke yahan share karwayein
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//
//               // FULLSCREEN BUTTON
//               if (images.isNotEmpty)
//                 Positioned(
//                   right: 12,
//                   bottom: 12,
//                   child: _circleButton(
//                     icon: Icons.fullscreen,
//                     onTap: () => _openFullScreen(images),
//                   ),
//                 ),
//
//               // DOTS
//               if (images.length > 1)
//                 Positioned(
//                   bottom: 16,
//                   left: 0,
//                   right: 0,
//                   child: Obx(() {
//                     final current = widget.controller.currentImageIndex.value;
//                     return Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: List.generate(images.length, (i) {
//                         final selected = current == i;
//                         return AnimatedContainer(
//                           duration: const Duration(milliseconds: 200),
//                           margin: const EdgeInsets.symmetric(horizontal: 3),
//                           height: 7,
//                           width: selected ? 20 : 7,
//                           decoration: BoxDecoration(
//                             color: selected
//                                 ? AppColors.secondary
//                                 : Colors.grey.shade400,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                         );
//                       }),
//                     );
//                   }),
//                 ),
//             ],
//           ),
//         ),
//
//         // THUMBNAILS (4 barabar, poori width par)
//         if (images.length > 1) ...[
//           const SizedBox(height: 10),
//           SizedBox(
//             height: 76,
//             child: LayoutBuilder(
//               builder: (context, constraints) {
//                 final itemWidth = (constraints.maxWidth - 30) / 4;
//
//                 return Obx(() {
//                   final current = widget.controller.currentImageIndex.value;
//
//                   return ListView.separated(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: images.length,
//                     separatorBuilder: (_, __) => const SizedBox(width: 10),
//                     itemBuilder: (context, i) {
//                       final selected = current == i;
//
//                       return GestureDetector(
//                         onTap: () => _page.animateToPage(
//                           i,
//                           duration: const Duration(milliseconds: 300),
//                           curve: Curves.easeOut,
//                         ),
//                         child: AnimatedContainer(
//                           duration: const Duration(milliseconds: 200),
//                           width: itemWidth,
//                           clipBehavior: Clip.antiAlias,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(14),
//                             border: Border.all(
//                               color: selected
//                                   ? AppColors.secondary
//                                   : Colors.transparent,
//                               width: 2,
//                             ),
//                           ),
//                           child: Image.network(
//                             images[i],
//                             fit: BoxFit.cover,
//                             errorBuilder: (_, __, ___) =>
//                                 const Icon(Icons.image, color: Colors.grey),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 });
//               },
//             ),
//           ),
//         ],
//       ],
//     );
//   }
// }
//
// // =====================================================
// // EXPANDABLE DESCRIPTION ("Read More")
// // =====================================================
//
// class _ExpandableText extends StatefulWidget {
//   final String text;
//   const _ExpandableText({super.key, required this.text});
//
//   @override
//   State<_ExpandableText> createState() => _ExpandableTextState();
// }
//
// class _ExpandableTextState extends State<_ExpandableText> {
//   bool _expanded = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final isLong = widget.text.length > 120;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           widget.text,
//           maxLines: (_expanded || !isLong) ? null : 3,
//           overflow: TextOverflow.ellipsis,
//           style: TextStyle(
//             fontSize: 14,
//             height: 1.5,
//             color: AppColors.textSecondary(context),
//           ),
//         ),
//         if (isLong)
//           GestureDetector(
//             onTap: () => setState(() => _expanded = !_expanded),
//             child: Padding(
//               padding: const EdgeInsets.only(top: 6),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     _expanded ? 'Show Less' : 'Read More',
//                     style: const TextStyle(
//                       color: AppColors.secondary,
//                       fontSize: 13,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   Icon(
//                     _expanded
//                         ? Icons.keyboard_arrow_up
//                         : Icons.keyboard_arrow_down,
//                     color: AppColors.secondary,
//                     size: 18,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../App_Routes/routes_view.dart';
import '../../Utilities_Screens/App_Colors/app_colors.dart';
import '../../Utilities_Screens/App_Colors/app_widgets.dart';
import '../../Utilities_Screens/App_Model/app_model.dart';
import '../Cart_Screen/cart_controller.dart';
import 'detail_controller.dart';

class ProductDetailView extends GetView<ProductDetailController> {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProductDetailController());

    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: _appBar(context),
      body: Obx(() {
        final product = controller.product.value;

        if (product == null) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.secondary),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _ImageGallery(
                key: ValueKey(product.id),
                controller: controller,
                product: product,
              ),
              const SizedBox(height: 12),
              // Title, price, description, size, quantity: sab ek card mein
              _productInfo(context, product),
              _relatedSection(context),
            ],
          ),
        );
      }),
      bottomNavigationBar: _bottomButtons(context),
    );
  }

  // =====================================================
  // APP BAR
  // =====================================================

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
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
      title: const SnapKartLogo(size: 24),
      actions: [
        Obx(() {
          final liked = controller.isWishlisted;
          return IconButton(
            onPressed: controller.toggleWishlist,
            icon: Icon(
              liked ? Icons.favorite : Icons.favorite_border,
              color: liked
                  ? AppColors.secondary
                  : AppColors.textPrimary(context),
            ),
          );
        }),
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: AppColors.textPrimary(context),
                ),
                onPressed: () => Get.toNamed(AppRoutes.cart),
              ),
              Positioned(
                right: 4,
                top: 8,
                child: Obx(() {
                  CartController.instance.cartItems.value;
                  final count = CartController.instance.cartItemCount;

                  if (count == 0) {
                    return const SizedBox.shrink();
                  }

                  return Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.secondary,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      '$count',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // =====================================================
  // PRODUCT INFO (ek hi card: title, rating+stock, price,
  // description, size, quantity)
  // =====================================================

  Widget _productInfo(BuildContext context, ModelClass product) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            product.title ?? 'No Title',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 1.2,
              color: AppColors.textPrimary(context),
            ),
          ),

          const SizedBox(height: 8),

          // Rating (left) + Stock pill (right)
          Row(
            children: [
              const Icon(Icons.star_rounded, size: 20, color: Colors.amber),
              const SizedBox(width: 4),
              Text(
                product.rating?.rate?.toStringAsFixed(1) ?? '0.0',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary(context),
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '(${product.rating?.count ?? 0})',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary(context),
                ),
              ),
              const Spacer(),
              _stockPill(),
            ],
          ),

          const SizedBox(height: 12),

          // Price
          Obx(() {
            final currentPrice = controller.getUnitPrice();
            final oldPrice = controller.oldPrice;
            final discount = controller.discountPercentage;

            return Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 12,
              runSpacing: 4,
              children: [
                Text(
                  'Rs. ${currentPrice.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: AppColors.secondary,
                  ),
                ),
                if (oldPrice > currentPrice)
                  Text(
                    'Rs. ${oldPrice.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                if (discount > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '$discount% OFF',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: Colors.red.shade600,
                      ),
                    ),
                  ),
              ],
            );
          }),

          const SizedBox(height: 4),

          Text(
            'Inclusive of all taxes',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary(context),
            ),
          ),

          // Description + Read More
          _divider(context),
          _descriptionSection(context, product),

          // Color
          if (product.colors.isNotEmpty) ...[
            _divider(context),
            _colorSection(context, product),
          ],

          // Size
          if (product.sizes.isNotEmpty) ...[
            SizedBox(height: product.colors.isNotEmpty ? 16 : 0),
            if (product.colors.isEmpty) _divider(context),
            _sizeSection(context, product),
          ],

          // Quantity
          const SizedBox(height: 16),
          _quantitySection(context),
        ],
      ),
    );
  }

  Widget _divider(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Divider(
        height: 1,
        color: AppColors.textPrimary(context).withValues(alpha: 0.08),
      ),
    );
  }

  Widget _stockPill() {
    return Obx(() {
      final inStock = controller.selectedStock > 0;
      final color = inStock ? AppColors.success : Colors.red.shade600;

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
            Text(
              inStock ? 'In Stock' : 'Out of Stock',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
      );
    });
  }

  // =====================================================
  // DESCRIPTION
  // =====================================================

  Widget _descriptionSection(BuildContext context, ModelClass product) {
    return _ExpandableText(
      key: ValueKey('desc_${product.id}'),
      text: product.description ?? 'No description available.',
    );
  }

  // =====================================================
  // COLOR SECTION
  // =====================================================

  Widget _colorSection(BuildContext context, ModelClass product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Color',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary(context),
              ),
            ),
            Obx(
              () => Text(
                controller.selectedColor.value?.name ?? '',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary(context),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 14,
          runSpacing: 10,
          children: product.colors
              .map((c) => _colorSwatch(context, c))
              .toList(),
        ),
      ],
    );
  }

  Widget _colorSwatch(BuildContext context, ProductColor color) {
    return Obx(() {
      final selected = controller.selectedColor.value == color;

      return GestureDetector(
        onTap: () => controller.selectColor(color),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 46,
          height: 46,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: selected ? AppColors.secondary : Colors.grey.shade300,
              width: selected ? 2 : 1,
            ),
          ),
          child: ClipOval(child: _swatchFill(color)),
        ),
      );
    });
  }

  // hex2 ho to aadha-aadha (jaise Grey & Black), warna ek rang
  Widget _swatchFill(ProductColor color) {
    final first = _parseHex(color.hex);
    final hex2 = color.hex2;

    if (hex2 == null || hex2.isEmpty) {
      return Container(color: first);
    }

    return Row(
      children: [
        Expanded(child: Container(color: first)),
        Expanded(child: Container(color: _parseHex(hex2))),
      ],
    );
  }

  Color _parseHex(String hex) {
    var h = hex.replaceAll('#', '').trim();
    if (h.length == 6) h = 'FF$h';
    final value = int.tryParse(h, radix: 16);
    return Color(value ?? 0xFFBDBDBD);
  }

  // =====================================================
  // SIZE SECTION
  // =====================================================

  Widget _sizeSection(BuildContext context, ModelClass product) {
    if (product.sizes.isEmpty) {
      return const SizedBox.shrink();
    }

    final sizes = product.sizes;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Size',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary(context),
              ),
            ),
            Obx(() {
              final size = controller.selectedSize.value;

              if (size == null) {
                return const SizedBox();
              }

              return Text(
                'Selected: ${size.label}',
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w700,
                ),
              );
            }),
          ],
        ),

        const SizedBox(height: 12),

        // 5 ya us se kam sizes: poori row mein barabar; zyada hon to wrap
        if (sizes.length <= 5)
          Row(
            children: [
              for (int i = 0; i < sizes.length; i++) ...[
                Expanded(child: _sizeChip(context, sizes[i])),
                if (i != sizes.length - 1) const SizedBox(width: 10),
              ],
            ],
          )
        else
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: sizes
                .map((s) => SizedBox(width: 64, child: _sizeChip(context, s)))
                .toList(),
          ),
      ],
    );
  }

  Widget _sizeChip(BuildContext context, ProductSize size) {
    return Obx(() {
      final isSelected = controller.selectedSize.value == size;
      final isOutOfStock = size.stock <= 0;

      return GestureDetector(
        onTap: isOutOfStock ? null : () => controller.selectSize(size),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isOutOfStock
                ? Colors.grey.withValues(alpha: 0.1)
                : isSelected
                ? AppColors.orangeSoft(context)
                : AppColors.cardBackground(context),
            border: Border.all(
              color: isOutOfStock
                  ? Colors.grey.shade300
                  : isSelected
                  ? AppColors.secondary
                  : Colors.grey.shade300,
              width: isSelected ? 1.8 : 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            size.label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              decoration: isOutOfStock ? TextDecoration.lineThrough : null,
              color: isOutOfStock
                  ? Colors.grey
                  : isSelected
                  ? AppColors.secondary
                  : AppColors.textPrimary(context),
            ),
          ),
        ),
      );
    });
  }

  // =====================================================
  // QUANTITY
  // =====================================================

  Widget _quantitySection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Quantity',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary(context),
          ),
        ),
        Obx(
          () => Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.textPrimary(context).withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                _qtyButton(
                  context: context,
                  icon: Icons.remove,
                  onTap: controller.decreaseQuantity,
                ),
                SizedBox(
                  width: 44,
                  child: Text(
                    '${controller.quantity.value}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.textPrimary(context),
                    ),
                  ),
                ),
                _qtyButton(
                  context: context,
                  icon: Icons.add,
                  onTap: controller.increaseQuantity,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _qtyButton({
    required BuildContext context,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        color: Colors.transparent,
        child: Icon(icon, size: 20, color: AppColors.textPrimary(context)),
      ),
    );
  }

  // =====================================================
  // RELATED PRODUCTS
  // =====================================================

  Widget _relatedSection(BuildContext context) {
    return Obx(() {
      if (controller.isRelatedLoading.value) {
        return const Padding(
          padding: EdgeInsets.all(25),
          child: Center(
            child: CircularProgressIndicator(color: AppColors.secondary),
          ),
        );
      }

      if (controller.relatedProducts.isEmpty) {
        return const SizedBox.shrink();
      }

      return Padding(
        padding: const EdgeInsets.only(top: 12),
        child: AppCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'You May Also Like',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary(context),
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 230,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.relatedProducts.length,
                  itemBuilder: (context, index) {
                    final item = controller.relatedProducts[index];

                    final num shown =
                        (item.discountPrice != null && item.discountPrice! > 0)
                        ? item.discountPrice!
                        : (item.price ?? 0);

                    return GestureDetector(
                      onTap: () => controller.switchToRelatedProduct(item),
                      child: Container(
                        width: 150,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground(context),
                          border: Border.all(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                              child: Container(
                                height: 140,
                                width: double.infinity,
                                color: Colors.white,
                                child: Image.network(
                                  item.image ?? '',
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.image,
                                      size: 50,
                                      color: Colors.grey,
                                    );
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title ?? 'Product',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary(context),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Rs. ${shown.toStringAsFixed(0)}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900,
                                      color: AppColors.secondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  // =====================================================
  // BOTTOM BUTTONS
  // =====================================================

  Widget _bottomButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground(context),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // ADD TO CART
            Expanded(
              child: GestureDetector(
                onTap: controller.addToCart,
                child: Obx(() {
                  final added = controller.isAddedToCart.value;

                  return Container(
                    height: 54,
                    decoration: BoxDecoration(
                      color: AppColors.orangeSoft(context),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.secondary.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          added ? Icons.check : Icons.shopping_cart,
                          color: AppColors.secondary,
                          size: 22,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          added ? 'Added' : 'Add to Cart',
                          style: const TextStyle(
                            color: AppColors.secondary,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(width: 12),

            // BUY NOW
            Expanded(
              child: GradientButton(text: 'Buy Now', onTap: controller.buyNow),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// IMAGE GALLERY (main image + thumbnails + fullscreen)
// =====================================================

class _ImageGallery extends StatefulWidget {
  final ProductDetailController controller;
  final ModelClass product;

  const _ImageGallery({
    super.key,
    required this.controller,
    required this.product,
  });

  @override
  State<_ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<_ImageGallery> {
  final PageController _page = PageController();

  @override
  void dispose() {
    _page.dispose();
    super.dispose();
  }

  List<String> get _images {
    final list = widget.controller.dummyImages;
    if (list.isNotEmpty) return list;

    final single = widget.product.image;
    return (single != null && single.isNotEmpty) ? [single] : [];
  }

  void _openFullScreen(List<String> images) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.black,
        insetPadding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(),
        child: SizedBox.expand(
          child: Stack(
            children: [
              PageView.builder(
                controller: PageController(
                  initialPage: widget.controller.currentImageIndex.value,
                ),
                itemCount: images.length,
                itemBuilder: (_, i) => InteractiveViewer(
                  minScale: 1,
                  maxScale: 4,
                  child: Center(
                    child: Image.network(images[i], fit: BoxFit.contain),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                right: 16,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: const CircleAvatar(
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.close, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _circleButton({
    required IconData icon,
    required VoidCallback onTap,
    Color color = Colors.black87,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 22, color: color),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final images = _images;

    return Column(
      children: [
        Container(
          height: 340,
          width: double.infinity,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: images.isEmpty
                    ? const Center(
                        child: Icon(
                          Icons.image_not_supported,
                          size: 80,
                          color: Colors.grey,
                        ),
                      )
                    : PageView.builder(
                        controller: _page,
                        itemCount: images.length,
                        onPageChanged: widget.controller.changeImage,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(18),
                            child: Image.network(
                              images[index],
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Icon(
                                    Icons.broken_image,
                                    size: 70,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                              loadingBuilder: (context, child, progress) {
                                if (progress == null) return child;
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.secondary,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
              ),

              // DISCOUNT BADGE
              Positioned(
                left: 12,
                top: 12,
                child: Obx(() {
                  final d = widget.controller.discountPercentage;
                  if (d <= 0) return const SizedBox.shrink();
                  return DiscountBadge('-$d%');
                }),
              ),

              // HEART + SHARE (top right)
              Positioned(
                right: 12,
                top: 12,
                child: Column(
                  children: [
                    Obx(() {
                      final liked = widget.controller.isWishlisted;
                      return _circleButton(
                        icon: liked ? Icons.favorite : Icons.favorite_border,
                        color: liked ? AppColors.secondary : Colors.black87,
                        onTap: widget.controller.toggleWishlist,
                      );
                    }),
                    const SizedBox(height: 10),
                    _circleButton(
                      icon: Icons.share_outlined,
                      onTap: () {
                        // TODO: share_plus package add karke yahan share karwayein
                      },
                    ),
                  ],
                ),
              ),

              // FULLSCREEN BUTTON
              if (images.isNotEmpty)
                Positioned(
                  right: 12,
                  bottom: 12,
                  child: _circleButton(
                    icon: Icons.fullscreen,
                    onTap: () => _openFullScreen(images),
                  ),
                ),

              // DOTS
              if (images.length > 1)
                Positioned(
                  bottom: 16,
                  left: 0,
                  right: 0,
                  child: Obx(() {
                    final current = widget.controller.currentImageIndex.value;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(images.length, (i) {
                        final selected = current == i;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          height: 7,
                          width: selected ? 20 : 7,
                          decoration: BoxDecoration(
                            color: selected
                                ? AppColors.secondary
                                : Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        );
                      }),
                    );
                  }),
                ),
            ],
          ),
        ),

        // THUMBNAILS (4 barabar, poori width par)
        if (images.length > 1) ...[
          const SizedBox(height: 10),
          SizedBox(
            height: 76,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final itemWidth = (constraints.maxWidth - 30) / 4;

                return Obx(() {
                  final current = widget.controller.currentImageIndex.value;

                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, i) {
                      final selected = current == i;

                      return GestureDetector(
                        onTap: () => _page.animateToPage(
                          i,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        ),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: itemWidth,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: selected
                                  ? AppColors.secondary
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Image.network(
                            images[i],
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.image, color: Colors.grey),
                          ),
                        ),
                      );
                    },
                  );
                });
              },
            ),
          ),
        ],
      ],
    );
  }
}

// =====================================================
// EXPANDABLE DESCRIPTION ("Read More")
// =====================================================

class _ExpandableText extends StatefulWidget {
  final String text;
  const _ExpandableText({super.key, required this.text});

  @override
  State<_ExpandableText> createState() => _ExpandableTextState();
}

// class _ExpandableTextState extends State<_ExpandableText> {
//   bool _expanded = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final isLong = widget.text.length > 120;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           widget.text,
//           maxLines: (_expanded || !isLong) ? null : 3,
//           overflow: TextOverflow.ellipsis,
//           style: TextStyle(
//             fontSize: 14,
//             height: 1.5,
//             color: AppColors.textSecondary(context),
//           ),
//         ),
//         if (isLong)
//           GestureDetector(
//             onTap: () => setState(() => _expanded = !_expanded),
//             child: Padding(
//               padding: const EdgeInsets.only(top: 6),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     _expanded ? 'Show Less' : 'Read More',
//                     style: const TextStyle(
//                       color: AppColors.secondary,
//                       fontSize: 13,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   Icon(
//                     _expanded
//                         ? Icons.keyboard_arrow_up
//                         : Icons.keyboard_arrow_down,
//                     color: AppColors.secondary,
//                     size: 18,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }

class _ExpandableTextState extends State<_ExpandableText> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: 14,
      height: 1.5,
      color: AppColors.textSecondary(context),
    );
    final isLong = widget.text.length > 120;
    final showFull = _expanded || !isLong;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          alignment: Alignment.topCenter,
          child: showFull
              ? Text(widget.text, style: style) // poora text
              : Text(
                  widget.text,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: style,
                ),
        ),
        if (isLong)
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _expanded ? 'Show Less' : 'Read More',
                    style: const TextStyle(
                      color: AppColors.secondary,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Icon(
                    _expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.secondary,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
