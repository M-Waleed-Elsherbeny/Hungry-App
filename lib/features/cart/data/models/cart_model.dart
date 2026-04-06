class CartModel {
  final int productId;
  final int quantity;
  final double spicy;
  final List<int> toppings;
  final List<int> sideOptions;

  CartModel({
    required this.productId,
    required this.quantity,
    required this.spicy,
    required this.toppings,
    required this.sideOptions,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product_id': productId,
      'quantity': quantity,
      'spicy': spicy,
      'toppings': toppings,
      'side_options': sideOptions,
    };
  }
}

class CartItemsModel {
  final List<CartModel> items;

  CartItemsModel({required this.items});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'items': items.map((x) => x.toMap()).toList()};
  }
}

/*{                                                                                                   
      "product_id": 1,
      "quantity": 2,
      "spicy"   : 0.1,
      "toppings": [ 1,2,3 ],
      "side_options": [ 1,2,3 ]
    }, 
    */
