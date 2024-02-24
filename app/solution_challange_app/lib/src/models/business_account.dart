class BusinessAccount {
  String id;
  String username;
  String email;
  String password;
  String name;
  String bio;
  String address;
  String profilePicturePath;
  String instaProfileLink;
  double latitude;
  double longitude;

  BusinessAccount({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.name,
    required this.bio,
    required this.address,
    required this.profilePicturePath,
    required this.instaProfileLink,
    required this.latitude,
    required this.longitude,
  });

  factory BusinessAccount.fromJson(Map<String, dynamic> json) {
    return BusinessAccount(
      id: json["id"],
      username: json["username"],
      email: json["email"],
      password: json["password"],
      name: json["name"],
      bio: json["bio"],
      address: json["address"],
      profilePicturePath: json["profile_picture_path"],
      instaProfileLink: json["insta_profile_link"],
      latitude: json["latitude"],
      longitude: json["longitude"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "email": email,
      "password": password,
      "name": name,
      "bio": bio,
      "address":address,
      "profile_picture_path": profilePicturePath,
      "insta_profile_link": instaProfileLink,
      "latitude": latitude,
      "longitude": longitude,
    };
  }
}
