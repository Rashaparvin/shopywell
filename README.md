# ShopyWell

A eCommerce app built with Flutter, powered by Firebase, managed using BLoC state management, and integrated with Stripe for seamless payments.

# Features
 * User Authentication (Email/Password, Google Sign-In using Firebase)
 * Product Listing (Initially by a fake api) 
 * Wishlist & Add to Cart  (Stored in Firestore)
 * Stripe Payment Gateway Integration
 * Order Management using Firestore
 * Responsive UI 

 # Folder Structure
  📦 shopywell  
  ┣ 📂 lib  
  ┃ ┣ 📂 core             # Constants, themes, utilities  
  ┃ ┣ 📂 data             # Repositories, APIs  
  ┃ ┣ 📂 domain           # Models, BLoC (State Management)  
  ┃ ┣ 📂 presentation     # UI Screens & Widgets  
  ┃ ┣ 📜 main.dart        # Entry Point  

# Installation & Setup
  * Download the APK file from [provide link].
  * Install the APK on your Android device.
  * Open the app and start! 

# App Workflow 
  * Register or Log In
    * Sign up using email & password or Google account.
    * Once logged in, click "Get Started" to enter the app.

  * Explore Products 
    * Browse through a variety of products on the Home Screen.
    * Tap the ❤️ (Favorite Icon) to add items to your Wishlist.

  * Manage Your Cart 
    * Your wishlist items will also appear in the Cart Screen.
    * Click "Go to Cart" or "Buy Now" to move items to Checkout (removing them from Wishlist).

  * Checkout & Payment 
    * Review your cart and proceed to payment.
    * Update your profile details if needed. 
    * Complete the payment using Stripe (Use card number as '4242 4242 4242 4242' for test purpose) , and enjoy seamless shopping! 



