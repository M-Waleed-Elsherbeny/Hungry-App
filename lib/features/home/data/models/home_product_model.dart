class HomeProductModel {
  final int id;
  final String name, description, image, rating, price;

  HomeProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.rating,
    required this.price,
  });

  factory HomeProductModel.fromJson(Map<String, dynamic> data) {
    return HomeProductModel(
      id: data["id"],
      name: data["name"] ?? "",
      description: data["description"] ?? "",
      image: data["image"] ?? "",
      rating: data["rating"] ?? "",
      price: data["price"] ?? "",
    );
  }
}




/*
    {
        "id": 1,
        "name": "Cheeseburger Wendys Burger",
        "description": "Enjoy our delicious Hamburger Veggie Burger, made with a savory blend of fresh vegetables and herbs, topped with crisp lettuce, juicy tomatoes, and tangy pickles, all served on a soft, toasted bun. ",
        "image": "http://sonic-zdi0.onrender.com/storage/products/cheeseburger.jpg",
        "rating": "4.9",
        "price": "140.00"
    },
 */