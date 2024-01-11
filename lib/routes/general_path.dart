class GeneralPath {
  /*
  * Base Uri
  * */

  // static const BASE_URI = "http://choosifoodi.b2cinfohosting.in/test/api/user/";
  static const BASE_URI = "https://choosifoodi.b2cinfohosting.in/test/api/user/";

  static const BASE_URI_VENDOR = "http://choosifoodi.b2cinfohosting.in/test/api/vendor/";

  // static const BASE_URI_VENDOR = "http://choosifoodi.b2cinfohosting.in/test/api/admin/";

  /*
  * API Endpoints
  * */
  static const API_LOGIN = "login";
  static const API_SOCIAL_LOGIN = "social/login";
  static const API_FORGET_PASSWORD = "forget/otp";
  static const API_REGISTRATION = "registration";
  // static const API_RESET_PASSWORD = "reset-password";
  static const API_USER_PROFILE = "userProfile";
  static const API_VIEW_FOODI_GOAL = "view-foodi-goal";
  static const API_HOME = "home/all?";
  static const API_SEARCH = "home/search?";
  static const API_RESTAURANT = "home/restaurants?";
  static const API_USER_OTP_VERIFY = "forget/verify";
  static const API_RESET_PASSWORD = "forget/password";
  static const API_NEAR_RESTAURANT = "home/neerByRestaurants?";
  static const API_FOODIE_HIGHLIGHT = "home/foodiHighlights";
  static const API_RESTAURANT_DETAILS = "home/restaurantDetails/";
  static const API_PROFILE = "userProfile";
  static const API_UPDATE_PROFILE = "updateUserDetails";
  static const API_CHANGE_PWD = "changePassword";
  static const API_CONTACT_US = "contactus";
  static const API_CONTACT_INFO = "contact/info";
  static const API_GET_CART = "restaurant/cart/list";
  static const API_REMOVE_CART = "restaurant/cart/delete/";
  static const API_ADD_CART = "restaurant/cart/add";
  static const API_COUPON_APPLY = "restaurant/cart/coupon/apply";
  static const API_COUPON_REMOVE = "restaurant/cart/coupon/remove";
  static const API_REORDER = "restaurant/cart/reorder/";

  //ADDRESS
  static const API_GET_ADDRESS = "address/list";
  static const API_DETAILS_ADDRESS = "address/details/";
  static const API_UPDATE_ADDRESS = "address/update";
  static const API_DELETE_ADDRESS = "address/delete/";
  static const API_ADD_ADDRESS = "address/add";
  static const API_ADDRESS_DETAILS = "address/details/";
  static const API_DEFAULT_ADDRESS = "address/default/";
  static const API_STATE_LIST = "location/state/list?";
  static const API_COUNTRY_LIST = "location/country/list";
  static const API_CITY_LIST = "location/city/list?";
  static const  API_GET_ORDER = "restaurant/menu/order/list";
  static const API_VIEW_ORDER = "restaurant/menu/order/details/";
  static const API_SLOT_LIST = "restaurant/slot/list?";
  static const API_COUPON_LIST = "restaurant/coupon/list";

  static const API_CENCEL_ORDER = "restaurant/menu/order/cancel";
  static const API_FOOD_LOG_LIST = "restaurant/foodlog/list";
  static const API_FOOD_LOG_DETAILS = "restaurant/foodlog/details/";
  static const API_FOOD_LOG_UPDATE = "restaurant/foodlog/update";
  static const API_FOOD_LOG_MENU_DELETE = "restaurant/foodlog/delete/";
  static const API_FOOD_GOAL = "goal";
  static const API_REVIEW_LIST = "restaurant/review/list";
  static const API_ADD_REVIEW = "restaurant/review/add";
  static const API_REVIEW_DETAILS = "restaurant/review/details/";
  static const API_NORMAL_ORDER_ONLINE = "restaurant/menu/order/place";
  static const API_FOOD_FACT_LIST = "foodifact/list";
  static const API_FAQ_LIST = "faq/list";
  static const API_FAQ_DETAILS = "faq/details/";
  static const API_CART_INC = "restaurant/cart/increase";
  static const API_CART_DEC = "restaurant/cart/decrease";
  static const API_NOTIFICATION_LIST = "notification/list";
  static const API_NOTIFICATION_DETAILS = "notification/details/";
  static const API_ABOUT_US = "static/page/details/62a054c5b7350b22f846c7d5";

  static const API_PRIVACY_POLICY = "static/page/details/62a05517b7350b22f846c7dc";
  static const API_TERMS = "static/page/details/62a055c4b7350b22f846c7f8";

  //GROUP ORDER
  static const API_CREATE_GROUP = "restaurant/group/create";
  static const API_GROUP_LIST = "restaurant/group/list";
  static const API_GROUP_DETAILS = "restaurant/group/detail/";
  static const API_DELETE_GROUP = "restaurant/group/";
  static const API_GROUP_USER_LIST = "restaurant/group/user/list";
  static const API_GROUP_INVITE = "restaurant/group/invite";
  static const API_GROUP_JOIN = "restaurant/group/join/";
  static const API_GROUP_CART_ADD = "restaurant/group/cart/add";
  static const API_GROUP_CART_VIEW = "restaurant/group/cart/list/";
  static const API_GROUP_CART_REMOVE = "restaurant/group/cart/delete";
  static const API_GROUP_ORDER_LIST = "restaurant/group/order/list";
  static const API_GROUP_DETAILS_LIST = "restaurant/group/order/details2/";
  static const API_CANCEL_GROUP_ORDER = "restaurant/group/order/cancel";
  static const API_GROUP_CHECKOUT = "restaurant/group/order/place";

  static const API_INVOICE = "invoice?menuOrderId=";
  static const API_GROUP_INVOICE = "group/invoice?groupOrderId=";

  //*********************************************************
  // VENDOR
  // static const API_MOBILE_VERIFY = "mobile/verify";
  static const API_MOBILE_VERIFY = "mobile/exist";
  static const API_OTP_VERIFY = "otp/verify";
  static const API_VENDOR_REGISTER = "register";
  static const API_VENDOR_PROFILE = "profile";
  static const API_VENDOR_EDIT_PROFILE = "editProfile";
  static const API_REST_MENU = "restaurant/menu/list";
  static const API_REST_MENU_DETAILS = "restaurant/menu/details";
  static const API_REST_TREE = "restaurant/category/tree";
  static const API_REST_MENU_STATUS = "restaurant/menu/status";
  static const API_REST_UPDATE_MENU = "restaurant/menu/update";
  static const API_REST_ADD_MENU = "restaurant/menu/add";
  static const API_REST_ADD_RESTAURANTDETAILS = "addRestaurantDetails";

  static const API_REST_GET_NEW_SLOT = "restaurant/slot/new/list";
  static const API_REST_ADD_NEW_SLOT = "restaurant/slot/new/add";
  static const API_REST_SLOT_DETAILS = "restaurant/slot/new/details/";
  static const API_REST_NEW_UPDATE_SLOT = "restaurant/slot/new/update";
  static const API_REST_CHANGE_SLOT_STATUS = "restaurant/slot/new/status";
  static const API_REST_DASHBOARD = "restaurant/dashboard";
  static const API_REST_ORDER_STATUS = "restaurant/menu/order/status";
  static const API_REST_ADD_DELIVERY_CHARGE = "restaurant/delivery/charges/add";
  static const API_REST_GET_DELIVERY_CHARGE = "restaurant/delivery/charges/details";
  static const API_REST_LEDGER = "restaurant/ledger/details";
  static const API_REST_PAYMENT_LIST = "restaurant/payment/list";
  // static const API_REST_SALES_LIST = "restaurant/reports/sales-report";
  static const API_REST_SALES_LIST = "restaurant/menu/order/list?orderStatus=6";
  // static const API_REST_ANALYTICS = "restaurant/reports/top-users";
  static const API_REST_VENDOR_COUPON = "restaurant/coupon/list";
  static const API_REST_COUPON_DETAILS = "restaurant/coupon/details/";
  static const API_REST_COUPON_STATUS = "restaurant/coupon/status";
  static const API_REST_ADD_COUPON = "restaurant/coupon/add";
  static const API_REST_UPDATE_COUPON = "restaurant/coupon/update";

  static const API_REST_COMMISSION = "restaurant/dashboard/commission";

  static const API_REST_CATEGORY_LIST = "restaurant/category/list";
  // static const API_REST_CATEGORY_STATUS = "restaurant/category/status";
  static const API_REST_CATEGORY_DETAILS = "restaurant/category/details/";
  static const API_ADD_REST_CATEGORY = "restaurant/category/add";
  static const API_UPDATE_CATEGORY = "restaurant/category/update";

  static const API_REST_GROUP_ORDER_LIST = "restaurant/group/order/list";
    static const API_REST_GROUP_ORDER_DETAILS = "restaurant/group/order/details/";

    static const API_REST_GROUP_ORDER_STATUS = "restaurant/group/order/status";

  static const API_REST_GROUP_ORDER_SALES_LIST = "restaurant/group/order/list?orderStatus=6";
  static const API_REST_ANALYTICS = "restaurant/reports/most-sold-menu";


}
