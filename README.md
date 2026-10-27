# SnapKart 🛒 — Flutter E-Commerce App

A full-featured e-commerce mobile app built independently in Flutter with a Firebase backend, covering everything from authentication to checkout and order history. It supports English and Urdu (RTL) and has light and dark themes.

---

## ✨ Features

- 🔐 **Authentication** — Email/Password sign-up and login, Google Sign-In, Remember Me, Forgot Password (Firebase Auth)
- 🏠 **Home** — Search bar, promotional banner carousel (Mega Sale), category chips with dynamic banners, side navigation drawer
- 🔍 **Search, Sort & Filter** — Instant product search; sort by Featured, Price (Low to High / High to Low), Top Rated, Biggest Discount and Name (A to Z); filter by price range, minimum rating and discounted items
- 🕘 **Recently Viewed** — Quickly jump back to products you opened earlier
- 🛍️ **Product Details** — Image gallery with thumbnails, fullscreen view and share, ratings, stock status, description, colour and size variants, quantity selector, "You May Also Like" recommendations
- ⚡ **Add to Cart / Buy Now** — In-app "Added to Cart" feedback and a direct order confirmation dialog
- 🗂️ **Categories** — Browse all categories with item counts
- 🛒 **Cart** — Quantity controls, discount badges, order summary (items, discount, delivery, total)
- ❤️ **Wishlist** — Save items and move them to the cart
- 📦 **Multi-step Checkout** — Review → Address → Payment → Confirm, with an order confirmation screen
- 💳 **Four payment methods** — Cash on Delivery, Credit/Debit Card, JazzCash / EasyPaisa, Bank Transfer
- 📍 **Address management** — Add, edit and clear delivery addresses, with pick-on-map support
- 📋 **Order history** — Status filters (All, Processing, Shipped, ...), item thumbnails, totals, and live updates from Firestore
- 🔔 **Push & local notifications** via Firebase Cloud Messaging (FCM), with order and delivery notification toggles
- 🌐 **Bilingual UI** — English / Urdu with full RTL layout
- 🌗 **Light / Dark theme** — Persistent across sessions
- 👤 **Account management** — Edit profile (email change with verification), change password, delete account (password confirmation), logout
- ℹ️ **About Us** — App info, contact, social links and a complaint box

---

## 📱 Screenshots

### ☀️ Light Mode

### Onboarding & Authentication

| App Icon | Splash Screen | Login | Create Account |
|---|---|---|---|
| <img src="screenshots/light/01_onboarding_authentication_app_icon.jpeg" width="200" alt="App Icon" /> | <img src="screenshots/light/02_onboarding_authentication_splash_screen.jpeg" width="200" alt="Splash Screen" /> | <img src="screenshots/light/03_onboarding_authentication_login.jpeg" width="200" alt="Login" /> | <img src="screenshots/light/04_onboarding_authentication_create_account.jpeg" width="200" alt="Create Account" /> |

| Create Account (Form) |   |   |   |
|---|---|---|---|
| <img src="screenshots/light/05_onboarding_authentication_create_account_form.jpeg" width="200" alt="Create Account (Form)" /> |   |   |   |


### Home, Search, Sort & Filter

| Home | Home (Recently Viewed) | Category Banner | Side Drawer |
|---|---|---|---|
| <img src="screenshots/light/06_home_search_sort_filter_home.jpeg" width="200" alt="Home" /> | <img src="screenshots/light/07_home_search_sort_filter_home_recently_viewed.jpeg" width="200" alt="Home (Recently Viewed)" /> | <img src="screenshots/light/08_home_search_sort_filter_category_banner.jpeg" width="200" alt="Category Banner" /> | <img src="screenshots/light/09_home_search_sort_filter_side_drawer.jpeg" width="200" alt="Side Drawer" /> |

| Sort By | Filter | Search Results |   |
|---|---|---|---|
| <img src="screenshots/light/10_home_search_sort_filter_sort_by.jpeg" width="200" alt="Sort By" /> | <img src="screenshots/light/11_home_search_sort_filter_filter.jpeg" width="200" alt="Filter" /> | <img src="screenshots/light/12_home_search_sort_filter_search_results.jpeg" width="200" alt="Search Results" /> |   |


### Product Details

| Image Gallery | Details & Variants | You May Also Like | Added to Cart |
|---|---|---|---|
| <img src="screenshots/light/13_product_details_image_gallery.jpeg" width="200" alt="Image Gallery" /> | <img src="screenshots/light/14_product_details_details_variants.jpeg" width="200" alt="Details & Variants" /> | <img src="screenshots/light/15_product_details_you_may_also_like.jpeg" width="200" alt="You May Also Like" /> | <img src="screenshots/light/16_product_details_added_to_cart.jpeg" width="200" alt="Added to Cart" /> |

| Buy Now Confirmation |   |   |   |
|---|---|---|---|
| <img src="screenshots/light/17_product_details_buy_now_confirmation.jpeg" width="200" alt="Buy Now Confirmation" /> |   |   |   |


### Categories

| Categories |   |   |   |
|---|---|---|---|
| <img src="screenshots/light/18_categories_categories.jpeg" width="200" alt="Categories" /> |   |   |   |


### Cart & Wishlist

| My Cart | My Wishlist | Wishlist (Tab) |   |
|---|---|---|---|
| <img src="screenshots/light/19_cart_wishlist_my_cart.jpeg" width="200" alt="My Cart" /> | <img src="screenshots/light/20_cart_wishlist_my_wishlist.jpeg" width="200" alt="My Wishlist" /> | <img src="screenshots/light/21_cart_wishlist_wishlist_tab.jpeg" width="200" alt="Wishlist (Tab)" /> |   |


### Checkout

| Checkout (Review) | Order Summary | Payment Step | Address & Payment |
|---|---|---|---|
| <img src="screenshots/light/22_checkout_checkout_review.jpeg" width="200" alt="Checkout (Review)" /> | <img src="screenshots/light/23_checkout_order_summary.jpeg" width="200" alt="Order Summary" /> | <img src="screenshots/light/24_checkout_payment_step.jpeg" width="200" alt="Payment Step" /> | <img src="screenshots/light/25_checkout_address_payment.jpeg" width="200" alt="Address & Payment" /> |

| Payment Methods | Address Edit | Address Edit (Pick on Map) | Order Placed |
|---|---|---|---|
| <img src="screenshots/light/26_checkout_payment_methods.jpeg" width="200" alt="Payment Methods" /> | <img src="screenshots/light/27_checkout_address_edit.jpeg" width="200" alt="Address Edit" /> | <img src="screenshots/light/28_checkout_address_edit_pick_on_map.jpeg" width="200" alt="Address Edit (Pick on Map)" /> | <img src="screenshots/light/29_checkout_order_placed.jpeg" width="200" alt="Order Placed" /> |


### Order History

| All Orders | Orders (Tab) | Status Filter |   |
|---|---|---|---|
| <img src="screenshots/light/30_order_history_all_orders.jpeg" width="200" alt="All Orders" /> | <img src="screenshots/light/31_order_history_orders_tab.jpeg" width="200" alt="Orders (Tab)" /> | <img src="screenshots/light/32_order_history_status_filter.jpeg" width="200" alt="Status Filter" /> |   |


### Settings, Profile & About

| Settings | Account Options | Change Password | Delete Account |
|---|---|---|---|
| <img src="screenshots/light/33_settings_profile_about_settings.jpeg" width="200" alt="Settings" /> | <img src="screenshots/light/34_settings_profile_about_account_options.jpeg" width="200" alt="Account Options" /> | <img src="screenshots/light/35_settings_profile_about_change_password.jpeg" width="200" alt="Change Password" /> | <img src="screenshots/light/36_settings_profile_about_delete_account.jpeg" width="200" alt="Delete Account" /> |

| User Information | Urdu (RTL) | About Us | Complaint Box |
|---|---|---|---|
| <img src="screenshots/light/37_settings_profile_about_user_information.jpeg" width="200" alt="User Information" /> | <img src="screenshots/light/38_settings_profile_about_urdu_rtl.jpeg" width="200" alt="Urdu (RTL)" /> | <img src="screenshots/light/39_settings_profile_about_about_us.jpeg" width="200" alt="About Us" /> | <img src="screenshots/light/40_settings_profile_about_complaint_box.jpeg" width="200" alt="Complaint Box" /> |


---

### 🌙 Dark Mode

### Home, Search, Sort & Filter

| Home | Category Banner | Side Drawer | Sort By |
|---|---|---|---|
| <img src="screenshots/dark/01_home_search_sort_filter_home.jpeg" width="200" alt="Home" /> | <img src="screenshots/dark/02_home_search_sort_filter_category_banner.jpeg" width="200" alt="Category Banner" /> | <img src="screenshots/dark/03_home_search_sort_filter_side_drawer.jpeg" width="200" alt="Side Drawer" /> | <img src="screenshots/dark/04_home_search_sort_filter_sort_by.jpeg" width="200" alt="Sort By" /> |

| Filter | Search Results |   |   |
|---|---|---|---|
| <img src="screenshots/dark/05_home_search_sort_filter_filter.jpeg" width="200" alt="Filter" /> | <img src="screenshots/dark/06_home_search_sort_filter_search_results.jpeg" width="200" alt="Search Results" /> |   |   |


### Product Details

| Image Gallery | Details & Variants | You May Also Like | Added to Cart |
|---|---|---|---|
| <img src="screenshots/dark/07_product_details_image_gallery.jpeg" width="200" alt="Image Gallery" /> | <img src="screenshots/dark/08_product_details_details_variants.jpeg" width="200" alt="Details & Variants" /> | <img src="screenshots/dark/09_product_details_you_may_also_like.jpeg" width="200" alt="You May Also Like" /> | <img src="screenshots/dark/10_product_details_added_to_cart.jpeg" width="200" alt="Added to Cart" /> |

| Buy Now Confirmation |   |   |   |
|---|---|---|---|
| <img src="screenshots/dark/11_product_details_buy_now_confirmation.jpeg" width="200" alt="Buy Now Confirmation" /> |   |   |   |


### Categories

| Categories |   |   |   |
|---|---|---|---|
| <img src="screenshots/dark/12_categories_categories.jpeg" width="200" alt="Categories" /> |   |   |   |


### Cart & Wishlist

| My Cart | Order Summary | My Wishlist | Wishlist (Tab) |
|---|---|---|---|
| <img src="screenshots/dark/13_cart_wishlist_my_cart.jpeg" width="200" alt="My Cart" /> | <img src="screenshots/dark/14_cart_wishlist_order_summary.jpeg" width="200" alt="Order Summary" /> | <img src="screenshots/dark/15_cart_wishlist_my_wishlist.jpeg" width="200" alt="My Wishlist" /> | <img src="screenshots/dark/16_cart_wishlist_wishlist_tab.jpeg" width="200" alt="Wishlist (Tab)" /> |


### Checkout

| Checkout (Review) | Address & Payment | Payment Methods | Address Edit |
|---|---|---|---|
| <img src="screenshots/dark/17_checkout_checkout_review.jpeg" width="200" alt="Checkout (Review)" /> | <img src="screenshots/dark/18_checkout_address_payment.jpeg" width="200" alt="Address & Payment" /> | <img src="screenshots/dark/19_checkout_payment_methods.jpeg" width="200" alt="Payment Methods" /> | <img src="screenshots/dark/20_checkout_address_edit.jpeg" width="200" alt="Address Edit" /> |

| Address Edit (Pick on Map) | Order Placed |   |   |
|---|---|---|---|
| <img src="screenshots/dark/21_checkout_address_edit_pick_on_map.jpeg" width="200" alt="Address Edit (Pick on Map)" /> | <img src="screenshots/dark/22_checkout_order_placed.jpeg" width="200" alt="Order Placed" /> |   |   |


### Order History

| Latest Orders | All Orders | Status Filter |   |
|---|---|---|---|
| <img src="screenshots/dark/23_order_history_latest_orders.jpeg" width="200" alt="Latest Orders" /> | <img src="screenshots/dark/24_order_history_all_orders.jpeg" width="200" alt="All Orders" /> | <img src="screenshots/dark/25_order_history_status_filter.jpeg" width="200" alt="Status Filter" /> |   |


### Settings, Profile & About

| Settings | Dark Mode & Account | Profile Tab | Change Password |
|---|---|---|---|
| <img src="screenshots/dark/26_settings_profile_about_settings.jpeg" width="200" alt="Settings" /> | <img src="screenshots/dark/27_settings_profile_about_dark_mode_account.jpeg" width="200" alt="Dark Mode & Account" /> | <img src="screenshots/dark/28_settings_profile_about_profile_tab.jpeg" width="200" alt="Profile Tab" /> | <img src="screenshots/dark/29_settings_profile_about_change_password.jpeg" width="200" alt="Change Password" /> |

| Delete Account | User Information | Urdu (RTL) | About Us |
|---|---|---|---|
| <img src="screenshots/dark/30_settings_profile_about_delete_account.jpeg" width="200" alt="Delete Account" /> | <img src="screenshots/dark/31_settings_profile_about_user_information.jpeg" width="200" alt="User Information" /> | <img src="screenshots/dark/32_settings_profile_about_urdu_rtl.jpeg" width="200" alt="Urdu (RTL)" /> | <img src="screenshots/dark/33_settings_profile_about_about_us.jpeg" width="200" alt="About Us" /> |

| Complaint Box |   |   |   |
|---|---|---|---|
| <img src="screenshots/dark/34_settings_profile_about_complaint_box.jpeg" width="200" alt="Complaint Box" /> |   |   |   |


---

## 🛠️ Tech Stack

| Category | Technology |
|---|---|
| Framework | Flutter, Dart |
| State Management | GetX (reactive UI with Obx, DI, routing) |
| Backend | Firebase (Firestore, Auth, FCM) |
| Local Storage | SharedPreferences |
| Media | Cloudinary |

---

## 🏗️ Architecture Highlights

- Clean, reusable GetX controllers shared across 16+ screens
- Real-time Firestore listeners for order updates and admin-side inventory sync (see companion [SnapKart Admin Panel](https://github.com/saieahmadsultan/snapkart-admin-panel))
- One-time custom migration script to move the product catalog from a public REST API into Firestore
- Firebase Security Rules configured for role-based data access
- Full English/Urdu localization with RTL support

---

## 🚀 Getting Started

```bash
# Clone the repo
git clone https://github.com/saieahmadsultan/snapkart.git
cd snapkart

# Install dependencies
flutter pub get

# Run the app
flutter run
```

> Note: You'll need to connect your own Firebase project (Auth, Firestore, FCM enabled) and add your `google-services.json` / `GoogleService-Info.plist` before running.

---

## 👤 Author

**Saie Ahmad Sultan**
Flutter Mobile App Developer
📧 ahmadsultaniswl@gmail.com
🔗 [LinkedIn](https://www.linkedin.com/in/saieahmadsultan)
🐙 [GitHub](https://github.com/saieahmadsultan)
