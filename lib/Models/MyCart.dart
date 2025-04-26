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



  // {"userID":"1","productID":"30","quantity":"0","productName":"\u05de\u05d6\u05d2\u05df \u05e0\u05d9\u05d9\u05d3 Tornado TO GO EU 16 12,000BTU - \"
  // "u05d2\u05d9\u05de\u05d5\u05e8 \u05dc\u05d1\u05df \u05d0\u05d7\u05e8\u05d9\u05d5\u05ea \u05e2\"\u05d9 \u05d4\u05d9\u05d1\u05d5\u05d0\u05df \u05d4\u05e8\u05e9\u05de\u05d9",""
  // "categoryID":"3","imageURL":"https:\/\/d2d22nphq0yz8t.cloudfront.net\/6cbcadef-96e0-49e9-b3bd-9921afe362db\/www.shekem-electric.co.il\/media\/catalog\/product\/t\/o\/to-go-16-1.png"}


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