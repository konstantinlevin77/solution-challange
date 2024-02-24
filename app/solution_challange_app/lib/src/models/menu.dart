class Menu {
  String id;
  String name;
  String businessId;
  String businessName;

  // this map should have only two fields, name->string and isGlutenFree->bool
  Map ingredients;
  String price;
  String exampleImagePath;
  bool isGlutenFree;

  Menu(
      {required this.id,
      required this.name,
      required this.businessId,
      required this.businessName,
      required this.ingredients,
      required this.price,
      required this.exampleImagePath,
      required this.isGlutenFree});

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
        id: json["id"],
        name: json["name"],
        businessId: json["business_id"],
        businessName: json["business_name"],
        ingredients: json["ingredients"],
        price: json["price"],
        exampleImagePath: json["example_image_path"],
        isGlutenFree: json["is_gluten_free"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id":id,
      "name":name,
      "business_id":businessId,
      "ingredients":ingredients,
      "price":price,
      "example_image_path":exampleImagePath,
      "is_gluten_free":isGlutenFree
    };
  }

}
