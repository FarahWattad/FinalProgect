class Order{
  Order({
    this.totalPrice="0",
    this.orderTime="",
    this.fullNameOrder="",
    this.Address="",
   this.orderID="0",
    this.orderDetails="",

  });
  String totalPrice;
  String orderID;
  String orderTime;
  String fullNameOrder;
  String Address;
  String orderDetails;

  factory Order.fromJson(Map<String,dynamic> json)=>Order(
    orderID: json["orderID"],
    totalPrice: json["totalPrice"],
    Address: json["address"],
    orderTime: json["orderTime"],
    // notes: json["notes"],
    fullNameOrder: json["fullNameOrder"],
    orderDetails: json["orderDetails"],
  );
  Map<String,dynamic> toJson() => {
    "totalPrice": totalPrice,
    "orderTime": orderTime,
    "fullNameOrder": fullNameOrder,
    "Address": Address,
    "orderDetails": orderDetails,

  };
}