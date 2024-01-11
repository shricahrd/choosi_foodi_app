

import '../../orders/model/group_order/safe_convert.dart';

class GetUserHomeModel {
  final Meta? meta;
  final Data? data;

  GetUserHomeModel({
     this.meta,
     this.data,
  });

  factory GetUserHomeModel.fromJson(Map<String, dynamic>? json) => GetUserHomeModel(
    meta: Meta.fromJson(asT<Map<String, dynamic>>(json, 'meta')),
    data: Data.fromJson(asT<Map<String, dynamic>>(json, 'data')),
  );

  Map<String, dynamic> toJson() => {
    'meta': meta?.toJson(),
    'data': data?.toJson(),
  };
}

class Meta {
  final String msg;
  final bool status;

  Meta({
    this.msg = "",
    this.status = false,
  });

  factory Meta.fromJson(Map<String, dynamic>? json) => Meta(
    msg: asT<String>(json, 'msg'),
    status: asT<bool>(json, 'status'),
  );

  Map<String, dynamic> toJson() => {
    'msg': msg,
    'status': status,
  };
}


class Data {
  final List<RestaurantsItem>? restaurants;
  final List<FeaturedFoodsItem>? featuredFoods;
  // final List<CategoriesItem>? categories;
  final List<BannerItem>? banner;
  final List<ReviewsItem>? reviews;
  final List<MenuItem>? menu;

  Data({
     this.restaurants,
     this.featuredFoods,
     // this.categories,
    this.banner,
     this.reviews,
     this.menu,
  });

  factory Data.fromJson(Map<String, dynamic>? json) => Data(
    restaurants: asT<List>(json, 'restaurants').map((e) => RestaurantsItem.fromJson(e)).toList(),
    featuredFoods: asT<List>(json, 'featuredFoods').map((e) => FeaturedFoodsItem.fromJson(e)).toList(),
    // categories: asT<List>(json, 'categories').map((e) => CategoriesItem.fromJson(e)).toList(),
    banner: asT<List>(json, 'banner').map((e) => BannerItem.fromJson(e)).toList(),
    reviews: asT<List>(json, 'testimonialsList').map((e) => ReviewsItem.fromJson(e)).toList(),
    menu: asT<List>(json, 'menu').map((e) => MenuItem.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    'restaurants': restaurants?.map((e) => e.toJson()),
    'featuredFoods': featuredFoods?.map((e) => e.toJson()),
    // 'categories': categories?.map((e) => e.toJson()),
    'banner': banner?.map((e) => e.toJson()),
    'testimonialsList': reviews?.map((e) => e.toJson()),
    'menu': menu?.map((e) => e.toJson()),
  };
}

class RestaurantsItem {
  final String id;
  final Timings timings;
  final String restaurantId;
  final List<String> restaurantImg;
  final int? deliveryTime;
  final double ratings;
  final String state;
  final String status;
  final List<dynamic> coordinates;
  final String restaurantName;
  final double distance;
  final List<RootCategoryItem> rootCategory;

  RestaurantsItem({
    this.id = "",
    required this.timings,
    this.restaurantId = "",
    required this.restaurantImg,
    this.deliveryTime = 0,
    this.ratings = 0.0,
    this.state = "",
    this.status = "",
    required this.coordinates,
    this.restaurantName = "",
    this.distance = 0.0,
    required this.rootCategory,
  });

  factory RestaurantsItem.fromJson(Map<String, dynamic>? json) => RestaurantsItem(
    id: asT<String>(json, '_id'),
    timings: Timings.fromJson(asT<Map<String, dynamic>>(json, 'timings')),
    restaurantId: asT<String>(json, 'restaurantId'),
    restaurantImg: asT<List>(json, 'restaurantImg').map((e) => e.toString()).toList(),
    deliveryTime: asT<int>(json, 'deliveryTime'),
    ratings: asT<double>(json, 'ratings'),
    state: asT<String>(json, 'state'),
    status: asT<String>(json, 'status'),
    coordinates: asT<List>(json, 'coordinates').map((e) => double.tryParse(e.toString()) ?? 0.0).toList(),
    restaurantName: asT<String>(json, 'restaurantName'),
    distance: asT<double>(json, 'distance'),
    rootCategory: asT<List>(json, 'rootCategory').map((e) => RootCategoryItem.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'timings': timings.toJson(),
    'restaurantId': restaurantId,
    'restaurantImg': restaurantImg.map((e) => e),
    'deliveryTime': deliveryTime,
    'ratings': ratings,
    'state': state,
    'status': status,
    'coordinates': coordinates.map((e) => e),
    'restaurantName': restaurantName,
    'distance': distance,
    'rootCategory': rootCategory.map((e) => e.toJson()),
  };
}

class Timings {
  final String day;
  final String openingTime;
  final String closingTime;

  Timings({
    this.day = "",
    this.openingTime = "",
    this.closingTime = "",
  });

  factory Timings.fromJson(Map<String, dynamic>? json) => Timings(
    day: asT<String>(json, 'day'),
    openingTime: asT<String>(json, 'openingTime'),
    closingTime: asT<String>(json, 'closingTime'),
  );

  Map<String, dynamic> toJson() => {
    'day': day,
    'openingTime': openingTime,
    'closingTime': closingTime,
  };
}


class RootCategoryItem {
  final String categoryName;

  RootCategoryItem({
    this.categoryName = "",
  });

  factory RootCategoryItem.fromJson(Map<String, dynamic>? json) => RootCategoryItem(
    categoryName: asT<String>(json, 'categoryName'),
  );

  Map<String, dynamic> toJson() => {
    'categoryName': categoryName,
  };
}


class CategoriesItem {
  final String categoryId;
  final int commission;
  final String status;
  final String type;
  final bool isCompare;
  final bool isFeaturedWeb;
  final bool isCategoryWebNav;
  final bool isCategoryMobile;
  final bool isCategoryMobileNav;
  final String id;
  final String parentId;
  final String categoryName;
  final String categoryImg;
  final int createdAt;
  final int updatedAt;
  final int v;

  CategoriesItem({
    this.categoryId = "",
    this.commission = 0,
    this.status = "",
    this.type = "",
    this.isCompare = false,
    this.isFeaturedWeb = false,
    this.isCategoryWebNav = false,
    this.isCategoryMobile = false,
    this.isCategoryMobileNav = false,
    this.id = "",
    this.parentId = "",
    this.categoryName = "",
    this.categoryImg = "",
    this.createdAt = 0,
    this.updatedAt = 0,
    this.v = 0,
  });

  factory CategoriesItem.fromJson(Map<String, dynamic>? json) => CategoriesItem(
    categoryId: asT<String>(json, 'categoryId'),
    commission: asT<int>(json, 'commission'),
    status: asT<String>(json, 'status'),
    type: asT<String>(json, 'type'),
    isCompare: asT<bool>(json, 'isCompare'),
    isFeaturedWeb: asT<bool>(json, 'isFeaturedWeb'),
    isCategoryWebNav: asT<bool>(json, 'isCategoryWebNav'),
    isCategoryMobile: asT<bool>(json, 'isCategoryMobile'),
    isCategoryMobileNav: asT<bool>(json, 'isCategoryMobileNav'),
    id: asT<String>(json, '_id'),
    parentId: asT<String>(json, 'parentId'),
    categoryName: asT<String>(json, 'categoryName'),
    categoryImg: asT<String>(json, 'categoryImg'),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    v: asT<int>(json, '__v'),
  );

  Map<String, dynamic> toJson() => {
    'categoryId': categoryId,
    'commission': commission,
    'status': status,
    'type': type,
    'isCompare': isCompare,
    'isFeaturedWeb': isFeaturedWeb,
    'isCategoryWebNav': isCategoryWebNav,
    'isCategoryMobile': isCategoryMobile,
    'isCategoryMobileNav': isCategoryMobileNav,
    '_id': id,
    'parentId': parentId,
    'categoryName': categoryName,
    'categoryImg': categoryImg,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
  };
}


class BannerItem {
  final String bannerId;
  final String bannerFor;
  final String status;
  final bool isDefault;
  final String id;
  final String title;
  final String url;
  final String bannerImg;
  final int createdAt;
  final int updatedAt;

  BannerItem({
    this.bannerId = "",
    this.bannerFor = "",
    this.status = "",
    this.isDefault = false,
    this.id = "",
    this.title = "",
    this.url = "",
    this.bannerImg = "",
    this.createdAt = 0,
    this.updatedAt = 0,
  });

  factory BannerItem.fromJson(Map<String, dynamic>? json) => BannerItem(
    bannerId: asT<String>(json, 'bannerId'),
    bannerFor: asT<String>(json, 'bannerFor'),
    status: asT<String>(json, 'status'),
    isDefault: asT<bool>(json, 'isDefault'),
    id: asT<String>(json, '_id'),
    title: asT<String>(json, 'title'),
    url: asT<String>(json, 'url'),
    bannerImg: asT<String>(json, 'bannerImg'),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
  );

  Map<String, dynamic> toJson() => {
    'bannerId': bannerId,
    'bannerFor': bannerFor,
    'status': status,
    'isDefault': isDefault,
    '_id': id,
    'title': title,
    'url': url,
    'bannerImg': bannerImg,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };
}


class ReviewsItem {
  final String reviewId;
  final double rating;
  final String status;
  final String id;
  final String restaurantId;
  final String restaurantName;
  final String userId;
  final String userName;
  final String review;
  final int createdAt;
  final int updatedAt;
  final int v;

  ReviewsItem({
    this.reviewId = "",
    this.rating = 0.0,
    this.status = "",
    this.id = "",
    this.restaurantId = "",
    this.restaurantName = "",
    this.userId = "",
    this.userName = "",
    this.review = "",
    this.createdAt = 0,
    this.updatedAt = 0,
    this.v = 0,
  });

  factory ReviewsItem.fromJson(Map<String, dynamic>? json) => ReviewsItem(
    reviewId: asT<String>(json, 'reviewId'),
    rating: asT<double>(json, 'rating'),
    status: asT<String>(json, 'status'),
    id: asT<String>(json, '_id'),
    restaurantId: asT<String>(json, 'restaurantId'),
    restaurantName: asT<String>(json, 'restaurantName'),
    userId: asT<String>(json, 'userId'),
    userName: asT<String>(json, 'userName'),
    review: asT<String>(json, 'review'),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    v: asT<int>(json, '__v'),
  );

  Map<String, dynamic> toJson() => {
    'reviewId': reviewId,
    'rating': rating,
    'status': status,
    '_id': id,
    'restaurantId': restaurantId,
    'restaurantName': restaurantName,
    'userId': userId,
    'userName': userName,
    'review': review,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
  };
}


class MenuItem {
  final String menuId;
  final bool isVegetarian;
  final List<String> menuImg;
  final String foodOffered;
  final String state;
  final String status;
  final String id;
  final String restaurantId;
  final String dishName;
  final String description;
  final int price;
  final String foodType;
  final String dishType;
  final String dishVisibilityStart;
  final String dishVisibilityEnd;
  final int createdAt;
  final int updatedAt;
  final String calories;
  final String carbs;
  final String fat;
  final String restaurantName;
  final String protein;
  final int totalSale;
  bool isBuyNow = false;
  bool isAddToCartEnable = false;

  MenuItem({
    this.menuId = "",
    this.isVegetarian = false,
    required this.menuImg,
    this.foodOffered = "",
    this.state = "",
    this.status = "",
    this.id = "",
    this.restaurantId = "",
    this.dishName = "",
    this.description = "",
    this.price = 0,
    this.foodType = "",
    this.dishType = "",
    this.dishVisibilityStart = "",
    this.dishVisibilityEnd = "",
    this.createdAt = 0,
    this.updatedAt = 0,
    this.calories = "",
    this.carbs = "",
    this.fat = "",
    this.restaurantName = "",
    this.protein = "",
    this.totalSale = 0,
    this.isBuyNow = false,
    this.isAddToCartEnable = false,
  });

  factory MenuItem.fromJson(Map<String, dynamic>? json) => MenuItem(
    menuId: asT<String>(json, 'menuId'),
    isVegetarian: asT<bool>(json, 'isVegetarian'),
    menuImg: asT<List>(json, 'menuImg').map((e) => e.toString()).toList(),
    foodOffered: asT<String>(json, 'foodOffered'),
    state: asT<String>(json, 'state'),
    status: asT<String>(json, 'status'),
    id: asT<String>(json, '_id'),
    restaurantId: asT<String>(json, 'restaurantId'),
    dishName: asT<String>(json, 'dishName'),
    description: asT<String>(json, 'description'),
    price: asT<int>(json, 'price'),
    foodType: asT<String>(json, 'foodType'),
    dishType: asT<String>(json, 'dishType'),
    dishVisibilityStart: asT<String>(json, 'dishVisibilityStart'),
    dishVisibilityEnd: asT<String>(json, 'dishVisibilityEnd'),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    calories: asT<String>(json, 'calories'),
    carbs: asT<String>(json, 'carbs'),
    fat: asT<String>(json, 'fat'),
    restaurantName: asT<String>(json, 'restaurantName'),
    protein: asT<String>(json, 'protein'),
    totalSale: asT<int>(json, 'totalSale'),
    isBuyNow: asT<bool>(json, 'isBuyNow'),
    isAddToCartEnable: asT<bool>(json, 'isAddToCartEnable'),
  );

  set setBuyNow(bool? isChecked){
    this.isBuyNow = isChecked!;
    print("In Model isBuyNow   $isBuyNow");
  }

  set setAddToCartEnable(bool? isChecked){
    this.isAddToCartEnable = isChecked!;
    print("In Model _isAddToCartEnable   $isAddToCartEnable");
  }

  Map<String, dynamic> toJson() => {
    'menuId': menuId,
    'isVegetarian': isVegetarian,
    'menuImg': menuImg.map((e) => e),
    'foodOffered': foodOffered,
    'state': state,
    'status': status,
    '_id': id,
    'restaurantId': restaurantId,
    'dishName': dishName,
    'description': description,
    'price': price,
    'foodType': foodType,
    'dishType': dishType,
    'dishVisibilityStart': dishVisibilityStart,
    'dishVisibilityEnd': dishVisibilityEnd,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'calories': calories,
    'carbs': carbs,
    'fat': fat,
    'restaurantName': restaurantName,
    'protein': protein,
    'totalSale': totalSale,
  };
}

class FeaturedFoodsItem {
  final String menuId;
  final bool isVegetarian;
  final List<String> menuImg;
  final String restaurantId;
  final String dishName;
  final int createdAt;
  final int updatedAt;
  final String id;

  FeaturedFoodsItem({
    this.menuId = "",
    this.isVegetarian = false,
    required this.menuImg,
    this.restaurantId = "",
    this.dishName = "",
    this.createdAt = 0,
    this.updatedAt = 0,
    this.id = "",
  });

  factory FeaturedFoodsItem.fromJson(Map<String, dynamic>? json) => FeaturedFoodsItem(
    menuId: asT<String>(json, 'menuId'),
    isVegetarian: asT<bool>(json, 'isVegetarian'),
    menuImg: asT<List>(json, 'menuImg').map((e) => e.toString()).toList(),
    restaurantId: asT<String>(json, 'restaurantId'),
    dishName: asT<String>(json, 'dishName'),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    id: asT<String>(json, 'id'),
  );

  Map<String, dynamic> toJson() => {
    'menuId': menuId,
    'isVegetarian': isVegetarian,
    'menuImg': menuImg.map((e) => e).toList(),
    'restaurantId': restaurantId,
    'dishName': dishName,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'id': id,
  };
}