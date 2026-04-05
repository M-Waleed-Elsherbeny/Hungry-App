class ToppingsModel {
  final int id;
  final String name, image;

  ToppingsModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory ToppingsModel.fromJson(Map<String, dynamic> data) {
    return ToppingsModel(
      id: data["id"],
      name: data["name"] ?? "",
      image: data["image"] ?? "",
    );
  }
}




/*
    {
            "id": 1,
            "name": "Tomato",
            "image": "http://sonic-zdi0.onrender.com/storage/toppings/tomato.png"
        },
 */