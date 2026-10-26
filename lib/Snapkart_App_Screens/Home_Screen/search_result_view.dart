import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utilities_Screens/App_Colors/app_colors.dart';
import '../../Utilities_Screens/App_Colors/app_widgets.dart';
import '../../Utilities_Screens/App_Model/app_model.dart';
import '../../Utilities_Screens/Currency_Service/currency_service.dart';
import '../Cart_Screen/cart_controller.dart';
import '../Home_Screen/home_controller.dart';
import '../Wishlist_Screen/wishlist_controller.dart';

class SearchResultsView extends StatefulWidget {
  const SearchResultsView({super.key});

  @override
  State<SearchResultsView> createState() => _SearchResultsViewState();
}

class _SearchResultsViewState extends State<SearchResultsView> {
  late TextEditingController _searchCtrl;
  late String _query;
  final HomeController controller = Get.find<HomeController>();

  String _normalize(String s) =>
      s.toLowerCase().replaceAll(RegExp(r"[\s\-'’.]"), '');

  @override
  void initState() {
    super.initState();
    _query = Get.arguments as String? ?? '';
    _searchCtrl = TextEditingController(text: _query);
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    setState(() {
      _query = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final normalizedQuery = _normalize(_query);

    final results = controller.productList.where((product) {
      final title = product.title ?? '';
      return _normalize(title).contains(normalizedQuery);
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: _appBar(context),
      body: results.isEmpty
          ? _emptyState(context)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // RESULT COUNT
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                  child: Text(
                    _query.trim().isEmpty
                        ? '${results.length} products'
                        : '${results.length} results for "${_query.trim()}"',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary(context),
                    ),
                  ),
                ),

                // GRID
                Expanded(
                  child: GridView.builder(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.68,
                        ),
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      return _productCard(context, results[index]);
                    },
                  ),
                ),
              ],
            ),
    );
  }

  // ============================================================
  // APP BAR (back + search field)
  // ============================================================

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      backgroundColor: AppColors.background(context),
      foregroundColor: AppColors.textPrimary(context),
      toolbarHeight: 64,
      titleSpacing: 0,
      title: Container(
        height: 46,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: AppColors.cardBackground(context),
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
          controller: _searchCtrl,
          autofocus: false,
          textInputAction: TextInputAction.search,
          onChanged: _onSearchChanged,
          cursorColor: AppColors.secondary,
          style: TextStyle(fontSize: 14, color: AppColors.textPrimary(context)),
          decoration: InputDecoration(
            isDense: true,
            hintText: 'type_product_name'.tr,
            hintStyle: TextStyle(color: AppColors.textSecondary(context)),
            filled: false,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 13),
            prefixIcon: const Icon(
              Icons.search,
              size: 22,
              color: AppColors.secondary,
            ),
            suffixIcon: _searchCtrl.text.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.close,
                      size: 18,
                      color: AppColors.textSecondary(context),
                    ),
                    onPressed: () {
                      _searchCtrl.clear();
                      _onSearchChanged('');
                    },
                  )
                : null,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // EMPTY STATE
  // ============================================================

  Widget _emptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: AppColors.orangeSoft(context),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.search_off,
                size: 64,
                color: AppColors.secondary,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'no_products_found'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary(context),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'try_different_category'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary(context)),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // PRODUCT CARD (Home jaisa)
  // ============================================================

  Widget _productCard(BuildContext context, ModelClass product) {
    final double oldPrice = product.price ?? 0;
    final double salePrice = product.discountPrice ?? 0;

    final bool hasDiscount =
        salePrice > 0 && oldPrice > 0 && salePrice < oldPrice;

    final int discountPercent = hasDiscount
        ? (((oldPrice - salePrice) / oldPrice) * 100).round()
        : 0;

    final double shownPrice = hasDiscount ? salePrice : oldPrice;

    final String imageUrl = (product.image != null && product.image!.isNotEmpty)
        ? product.image!
        : (product.images.isNotEmpty ? product.images.first : '');

    return GestureDetector(
      onTap: () => controller.goToProductDetail(product),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBackground(context),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.07),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(18),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(6),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => Center(
                            child: Icon(
                              Icons.broken_image,
                              size: 45,
                              color: Colors.grey.shade300,
                            ),
                          ),
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.secondary,
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    // DISCOUNT BADGE (teal)
                    if (hasDiscount)
                      Positioned(
                        left: 8,
                        top: 8,
                        child: DiscountBadge('-$discountPercent%'),
                      ),

                    // HEART
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Obx(() {
                        final liked = WishlistController.instance.isWishlisted(
                          product.id,
                        );

                        return GestureDetector(
                          onTap: () => WishlistController.instance
                              .toggleWishlist(product),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: Icon(
                              liked
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              size: 18,
                              color: liked
                                  ? AppColors.secondary
                                  : Colors.grey.shade600,
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),

            // INFO
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      height: 1.25,
                      color: AppColors.textPrimary(context),
                    ),
                  ),

                  const SizedBox(height: 5),

                  // RATING
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                      const SizedBox(width: 3),
                      Text(
                        product.rating?.rate?.toStringAsFixed(1) ?? '0.0',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary(context),
                        ),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '(${product.rating?.count ?? 0})',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // PRICE + CART
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: ValueListenableBuilder<String>(
                          valueListenable: CurrencyService.instance.symbol,
                          builder: (context, currency, _) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '$currency ${shownPrice.toStringAsFixed(0)}',
                                    style: const TextStyle(
                                      color: AppColors.secondary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                if (hasDiscount)
                                  Text(
                                    '$currency ${oldPrice.toStringAsFixed(0)}',
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 10,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 6),
                      _cartButton(product, hasDiscount),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cartButton(ModelClass product, bool hasDiscount) {
    return GestureDetector(
      onTap: () {
        CartController.instance.addToCart({
          'productId': product.id,
          'title': product.title,
          'price': hasDiscount ? product.discountPrice : product.price,
          'quantity': 1,
          'image': product.image,
        });

        Get.snackbar(
          '🛒 ${'added_exclaim'.tr}',
          'added_to_cart'.trParams({'product': product.title ?? ''}),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.success.withValues(alpha: 0.15),
          colorText: AppColors.primaryDark,
          duration: const Duration(seconds: 1),
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
        );
      },
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.secondary.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Icon(
          Icons.shopping_cart_outlined,
          size: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}
