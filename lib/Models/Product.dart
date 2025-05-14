class Product{
  Product({
    this.productID="",
    this.productName="",
    this.productPrice=0,
    this.CreatedDateTime="",
    this.Warranty=0,
    this.categoryID="",
    this.imageURL="",
  });
  String productID;
  String productName;
  int productPrice;
  String CreatedDateTime;
  int Warranty;
  String categoryID;
  String imageURL;
  factory Product.fromJson(Map<String,dynamic> json)=>Product(
    productID: json["productID"],
    productName: json["productName"],
    productPrice: json["productPrice"],
   CreatedDateTime: json["CreatedDateTime"],
   Warranty: json["Warranty"],
    categoryID: json["categoryID"],
    imageURL: json["imageURL"],
  );
  Map<String,dynamic> toJson() => {
    "productID": productID,
    "productName": productName,
    "productPrice":productPrice,
    "CreatedDateTime":CreatedDateTime,
    "Warranty":Warranty,
    "categoryID":categoryID,
    "imageURL":imageURL,
  };

}