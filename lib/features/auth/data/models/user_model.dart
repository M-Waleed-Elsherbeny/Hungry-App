class UserModel {
  final String name, email;
  final String? token, image, address, visa;

  UserModel({
    required this.name,
    required this.email,
    this.token,
    this.image,
    this.address,
    this.visa,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      token: json['token'] ?? "",
      image: json['image'] ?? "",
      address: json['address'] ?? "",
      visa: json['Visa'] ?? "",
    );
  }
}
