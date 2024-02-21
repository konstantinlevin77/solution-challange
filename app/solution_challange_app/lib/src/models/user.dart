class User {
  String id;
  String username;
  String email;
  String password;
  String firstName;
  String lastName;
  String bio;
  String profilePicturePath;
  String instaProfileLink;
  User(
      {required this.id,
      required this.username,
      required this.email,
      required this.password,
      required this.firstName,
      required this.lastName,
      required this.bio,
      required this.profilePicturePath,
      required this.instaProfileLink,});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json["id"] ?? "",
        username: json["username"] ?? "",
        email: json["email"] ?? "",
        password: json["password"] ?? "",
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? "",
        bio: json["bio"] ?? "",
        profilePicturePath: json["profile_picture_path"] ?? "",
        instaProfileLink: json["insta_profile_link"] ?? "",
        );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username':username,
      'email':email,
      'password':password,
      'first_name':firstName,
      'last_name':lastName,
      'bio':bio,
      'profile_picture_path':profilePicturePath,
      'insta_profile_link':instaProfileLink,
    };
  }
}
