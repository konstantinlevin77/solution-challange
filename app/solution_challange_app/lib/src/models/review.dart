class Review {
  String id;
  String userId;
  String menuId;
  String businessId;
  String menuName;
  String businessName;
  int stars;
  String review;

  Review(
      {required this.id,
      required this.userId,
      required this.menuId,
      required this.businessId,
      required this.menuName,
      required this.businessName,
      required this.stars,
      required this.review});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
        id: json["id"],
        userId: json["user_id"],
        menuId: json["menu_id"],
        businessId: json["business_id"],
        stars: json["stars"],
        review: json["review"],
        menuName: json["menu_name"],
        businessName: json["business_name"]
        );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "menu_id": menuId,
      "business_id": businessId,
      "stars": stars,
      "review": review,
      "menu_name":menuName,
      "business_name":businessName
    };
  }
}
