class MyCart {
  MyCart({
    this.userID = "",
    this.productID = "",
    this.quantity = "",
    this.productName = "",
    this.categoryID = "",
    this.imageURL = "",
    this.productPrice = "",

  });
  String userID;
  String productID;
  String quantity;
  String productName;
  String categoryID;
  String imageURL;
  String productPrice;
  factory MyCart.fromJson(Map<String, dynamic> json)=>
      MyCart(
        // userID: json["userID"],
        // productID: json["productID"],
        // quantity: json["quantity"],
        // productName: json["productName"],
        // categoryID: json["categoryID"],
        // imageURL: json["imageURL"],

      );
  Map<String, dynamic> toJson() =>
      {
        "userID":userID  ,
        "productID":productID ,
        "quantity": quantity,
        "productname": productName,
        "categoryID": categoryID,
        "imageURL": imageURL,

      };
}