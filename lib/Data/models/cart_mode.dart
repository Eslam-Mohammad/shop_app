class CartMode {


  CartMode.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? status;
  dynamic message;
  Data? data;



}

class Data {


  Data.fromJson(dynamic json) {
    if (json['cart_items'] != null) {
      cartItems = [];
      json['cart_items'].forEach((v) {
        cartItems?.add(CartItems.fromJson(v));
      });
    }
    subTotal = json['sub_total'];
    total = json['total'];
  }
  List<CartItems>? cartItems;
  num? subTotal;
  num? total;



}

class CartItems {


  CartItems.fromJson(dynamic json) {
    id = json['id'];
    quantity = json['quantity'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }
  int? id;
  int? quantity;
  Product? product;



}

class Product {


  Product.fromJson(dynamic json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
  int? id;
  num? price;
  num? oldPrice;
  num? discount;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool? inFavorites;
  bool? inCart;



}