class User {
  String id;
  String username;
  String email;
  String password;
  String firstName;
  String lastName;
  int age;
  String gender;
  String bio;
  String profilePicturePath;
  String instaProfileLink;
  DateTime createdAt;
  DateTime updatedAt;

  User(
      {required this.id,
      required this.username,
      required this.email,
      required this.password,
      required this.firstName,
      required this.lastName,
      required this.age,
      required this.gender,
      required this.bio,
      required this.profilePicturePath,
      required this.instaProfileLink,
      required this.createdAt,
      required this.updatedAt});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json["id"] ?? "",
        username: json["username"] ?? "",
        email: json["email"] ?? "",
        password: json["password"] ?? "",
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? "",
        age: json["age"] ?? 0,
        gender: json["gender"] ?? "",
        bio: json["bio"] ?? "",
        profilePicturePath: json["profile_picture_path"] ?? "",
        instaProfileLink: json["insta_profile_link"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]) );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username':username,
      'email':email,
      'password':password,
      'first_name':firstName,
      'last_name':lastName,
      'age':age,
      'gender':gender,
      'bio':bio,
      'profile_picture_path':profilePicturePath,
      'insta_profile_link':instaProfileLink,
      'created_at':createdAt,
      'updated_at':updatedAt
    };
  }
}
