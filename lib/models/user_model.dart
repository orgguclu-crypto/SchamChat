class UserModel {
  final String id;
  final String username;
  final String email;
  final String? profileImage;
  final String language;
  final int vipLevel;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    this.profileImage,
    required this.language,
    required this.vipLevel,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      profileImage: json['profileImage'],
      language: json['language'] ?? 'tr',
      vipLevel: json['vipLevel'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'profileImage': profileImage,
      'language': language,
      'vipLevel': vipLevel,
    };
  }
}
