import 'dart:convert';

class UserModel {
  final String email;
  final String registerType;
  final String imageAvatar;
    UserModel({
    required this.email,
    required this.registerType,
    required this.imageAvatar
  });


  UserModel.empty() :
  email ='' ,
  imageAvatar ='',
  registerType= '',
  super();

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'registerType': registerType,
      'imageAvatar': imageAvatar,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      registerType: map['registerType'] ?? '',
      imageAvatar: map['imageAvatar'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
  UserModel copyWith({
    String? email,
    String? registerType,
    String? imageAvatar    
  }) {
    return UserModel(
          email: email ?? this.email,
      registerType: registerType ?? this.registerType,
      imageAvatar: imageAvatar ?? this.imageAvatar
    );
  }
}
