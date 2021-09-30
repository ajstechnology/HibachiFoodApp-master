class APIRoute {
  static String _baseUrlOfServer = "https://hibachi1.ravinboss.co.in";

  static String _baseUrl = "https://hibachi1.ravinboss.co.in/public/api/";
  static String get baseUrl => _baseUrl;
  static String _loginURL = "login?";
  static String _registerURL = "register?";
  static String _verifyOTPURL = "verify-otp?";
  static String _reSendOTP = "send-otp?";
  static String _myOrder = "get-orders";
  static String _updateUserInfo = "update-user-profile?";
  static String _saveAddress = "save-address?";
  static String _deleteAddress = "delete-address?";
// check working
  static String _getSliderURLForHome = "get-restaurant-category-slides?";
  static String _getResturantSliderURLForHome = "get-restaurant-sliders?";

  static String _getNotifications = "get-user-notifications?";
  static String _getProductDetails = "get-single-item?";
  static String _getResturantItems = "get-restaurant-items";
  static String _getDeliveryResturant = "get-delivery-restaurants?";
  //
  static String _getAllResturantCategories = "get-all-restaurants-categories?";
  static String _getPromoSlider = "promo-slider";
  static String _getCoupons = "coupons";
  static String _searchProducts = "search-items?";
  static String _getAddresses = "get-addresses";
  static String _getApplyCoupon = "apply-coupon";
  static String _getPlaceOrder = "place-order";
  static String getChangeAvatar = "change-avatar";
  static String _getOrderStatus = "get-order-status";
  static String _getBlogList = "blog_list";
  static String _getRestaurantInfoById = "get-restaurant-info-by-id/";
  static String _getDriverDetails = "get-delivery-guy-location";
  static String _sendPasswordResetMail = "send-password-reset-mail?";
  static String _changeUserPassword = "change-user-password?";
  static String _saveCustomerToken = "save-customer-token";
  static String _getResturantCharges = "get-charges";
  static String _getUserInfo = "get-user-info";

  static String getBaseUrl() => _baseUrlOfServer;

  static String getLoginURL() => _baseUrl + _loginURL;
  static String getRegisterURL() => _baseUrl + _registerURL;
  static String getVerifyOTPURL() => _baseUrl + _verifyOTPURL;
  static String getReSendOTPURL() => _baseUrl + _reSendOTP;
  static String getMyOrdersURL() => _baseUrl + _myOrder;

  static String getUpdateUserInfoURL() => _baseUrl + _updateUserInfo;

  static String getSaveAddressURL() => _baseUrl + _saveAddress;
  static String getDeleteAddressURL() => _baseUrl + _deleteAddress;
  //
  static String getSliderURLForHomeURL() => _baseUrl + _getSliderURLForHome;
  //
  static String getNotificationsURL() => _baseUrl + _getNotifications;
  static String getDeliveryResturantDetailsURL() =>
      _baseUrl + _getDeliveryResturant;
  static String getProductDetailsURL() => _baseUrl + _getProductDetails;
  static String getResturantItemsURL() => _baseUrl + _getResturantItems;
  //
  static String getAllResturantCategories() =>
      _baseUrl + _getAllResturantCategories;
  static String getPromoSliderURL() => _baseUrl + _getPromoSlider;
  static String getCouponsURL() => _baseUrl + _getCoupons;
  static String searchProductsURL() => _baseUrl + _searchProducts;
  static String getAddressURL() => _baseUrl + _getAddresses;
  static String getApplyCouponURL() => _baseUrl + _getApplyCoupon;
  static String getPlaceOrderURL() => _baseUrl + _getPlaceOrder;
  static String getChangeAvatarURL() => _baseUrl + getChangeAvatar;
  static String getOrderStatusURL() => _baseUrl + _getOrderStatus;
  static String getResturantSliderURL() =>
      _baseUrl + _getResturantSliderURLForHome;
  static String getBlogListURL() => _baseUrl + _getBlogList;
  static String getRestaurantInfoByIdURL() => _baseUrl + _getRestaurantInfoById;
  static String getDriverDetailsURL() => _baseUrl + _getDriverDetails;
  static String getSendPasswordResetMail() => _baseUrl + _sendPasswordResetMail;
  static String getForgotPasswordVerify() => _baseUrl + _changeUserPassword;
  static String getSaveCustomerToken() => _baseUrl + _saveCustomerToken;
  static String getResturantChargesURL() => _baseUrl + _getResturantCharges;
  static String getUserInfo() => _baseUrl + _getUserInfo;
}
