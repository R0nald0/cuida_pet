import 'dart:convert';

class ConfirmationLoginModel {
 final String accessToken;
 final String refreshToken;
  ConfirmationLoginModel({
    required this.accessToken,
    required this.refreshToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }

  factory ConfirmationLoginModel.fromMap(Map<String, dynamic> map) {
    return ConfirmationLoginModel(
      accessToken: map['access_token'] ?? '',
      refreshToken: map['refresh_token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ConfirmationLoginModel.fromJson(String source) => ConfirmationLoginModel.fromMap(json.decode(source));
}
