class Category{
  Category({
    this.categoryID="",
    this.categoryName="",
    this.imageURC="",
  });

  String 	categoryID;
  String categoryName;
  String imageURC;
  factory Category.fromJson(Map<String,dynamic> json)=>Category(
    categoryID: json["categoryID"],
    categoryName: json["categoryName"],
    imageURC: json["imageURC"],

  );
  Map<String,dynamic> toJson() => {
    "categoryID": 	categoryID,
    "categoryName": categoryName,
    "imageURC":imageURC,
  };
}