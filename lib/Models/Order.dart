class Order{
  Order({
    this.	total=0,
    this.orderTime="",
    this.fullNameOrder="",
    this.Address="",
   this.orderID=0,
  });

  double total;
  int orderID;
  String orderTime;
  String fullNameOrder;
  String Address;

  factory Order.fromJson(Map<String,dynamic> json)=>Order(
    total: json ["total"],
    orderTime: json["orderTime"],
    fullNameOrder: json["fullNameOrder"],
    Address: json["Address"],
    orderID: json["orderID"],
  );
  Map<String,dynamic> toJson() => {
    "total": total,
    "orderTime": orderTime,
    "fullNameOrder":fullNameOrder,
    "Address":Address,
    "orderID":orderID,

  };
}