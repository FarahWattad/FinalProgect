class Product{
  Product({
    this.productID=0,
    this.	productName="",
    this.productPrice=0,
    this.CreatedDateTime="",
    this.Warranty=0,
    this.categoryID=0,
  });

  int productID;
  String 	productName;
  int productPrice;
  String CreatedDateTime;
  int Warranty;
  int categoryID;

  factory Product.fromJson(Map<String,dynamic> json)=>Product(
    productID: json["productID"],
    productName: json["productName"],
    productPrice: json["productPrice"],
    CreatedDateTime: json["CreatedDateTime"],
    Warranty: json["Warranty"],
    categoryID: json["categoryID"],
  );


  Map<String,dynamic> toJson() => {
    "productID": productID,
    "productName": productName,
    "productPrice":productPrice,
    "CreatedDateTime":CreatedDateTime,
    "Warranty":Warranty,
    "categoryID":categoryID,

  };
}