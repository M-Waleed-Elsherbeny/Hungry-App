import 'package:hungry_app/features/products/data/models/toppings_and_options_model.dart';

class UserCartData {
  final int itemId;
  final int productId;
  final String name;
  final String image;
  final int quantity;
  final String price;
  final String spicy;
  List<ToppingsAndOptionsModel> toppings;
  List<ToppingsAndOptionsModel> sideOptions;

  UserCartData({
    required this.itemId,
    required this.productId,
    required this.name,
    required this.image,
    required this.quantity,
    required this.price,
    required this.spicy,
    required this.toppings,
    required this.sideOptions,
  });

  factory UserCartData.fromJson(Map<String, dynamic> json) => UserCartData(
    itemId: json["item_id"],
    productId: json["product_id"],
    name: json["name"],
    image: json["image"],
    quantity: json["quantity"],
    price: json["price"],
    spicy: json["spicy"].toString(),
    toppings: List<ToppingsAndOptionsModel>.from(
      json["toppings"].map(
        (toppings) => ToppingsAndOptionsModel.fromJson(toppings),
      ),
    ),
    sideOptions: List<ToppingsAndOptionsModel>.from(
      json["side_options"].map(
        (options) => ToppingsAndOptionsModel.fromJson(options),
      ),
    ),
  );
}

class UserCartModel {
  final int id;
  final String totalPrice;
  final List<UserCartData> items;
  UserCartModel({
    required this.items,
    required this.id,
    required this.totalPrice,
  });

  factory UserCartModel.fromJson(Map<String, dynamic> json) => UserCartModel(
    id: json["id"],
    totalPrice: json["total_price"],
    items: List<UserCartData>.from(
      json["items"].map((x) => UserCartData.fromJson(x)),
    ),
  );
}
