class Category{
  Category({
    this.	categoryID=0,
    this.categoryName="",
    this.imageURC="",
  });

  int 	categoryID;
  String categoryName;
  String imageURC;
  factory Category.fromJson(Map<String,dynamic> json)=>Category(
    categoryID: json ["categoryID"],
    categoryName: json["categoryName"],
    imageURC: json["imageURC"],

  );
  Map<String,dynamic> toJson() => {
    "categoryID": 	categoryID,
    "categoryName": categoryName,
    "imageURC":imageURC,
  };
}