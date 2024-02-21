class BusinessAccount {
  String id;
  String username;
  String email;
  String password;
  String name;
  String bio;
  String profilePicturePath;
  String instaProfileLink;
  double latitude;
  double longitude;
  DateTime createdAt;
  DateTime updatedAt;

  BusinessAccount({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.name,
    required this.bio,
    required this.profilePicturePath,
    required this.instaProfileLink,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BusinessAccount.fromJson(Map<String, dynamic> json) {
    return BusinessAccount(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        name: json["name"],
        bio: json["bio"],
        profilePicturePath: json["profile_picture_path"],
        instaProfileLink: json["insta_profile_link"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]));
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "email": email,
      "password": password,
      "name": name,
      "bio": bio,
      "profile_picture_path": profilePicturePath,
      "insta_profile_link": instaProfileLink,
      "latitude": latitude,
      "longitude": longitude,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}
