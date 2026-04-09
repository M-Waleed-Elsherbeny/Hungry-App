class ToppingsAndOptionsModel {
  final int id;
  final String name, image;

  ToppingsAndOptionsModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory ToppingsAndOptionsModel.fromJson(Map<String, dynamic> data) {
    return ToppingsAndOptionsModel(
      id: data["id"] ?? "",
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