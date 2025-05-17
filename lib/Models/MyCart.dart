class MyCart {
  MyCart({
    required this.userID,
    required this.productID,
    required this.quantity,
    required this.productName,
    required this.categoryID,
    required this.imageURL,
    required this.productPrice,

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
         userID: json["userID"] ?? 0,
         productID: json["productID"],
         productPrice: json["productPrice"],
         quantity: json["quantity"],
         productName: json["productName"],
         categoryID: json["categoryID"],
         imageURL: json["imageURL"],

      );
  Map<String, dynamic> toJson() =>
      {
        "userID":userID  ,
        "productID":productID ,
        "quantity": quantity,
        "productPrice": productPrice,

        "productname": productName,
        "categoryID": categoryID,
        "imageURL": imageURL,

      };
}