class Order{
  Order({
    this.total="0",
    this.orderTime="",
    this.fullNameOrder="",
    this.Address="",
   this.orderID="0",
  });

  String total;
  String orderID;
  String orderTime;
  String fullNameOrder;
  String Address;

  // [{"orderID":"1","total":"2000","address":"zeemer","orderTime":"2024-11-30","fullNameOrder":""}]

  factory Order.fromJson(Map<String,dynamic> json)=>Order(
    total: json ["total"],
    orderTime: json["orderTime"],
    fullNameOrder: json["fullNameOrder"],
    Address: json["address"],
    orderID: json["orderID"],
  );
  Map<String,dynamic> toJson() => {
    "total": total,
    "orderTime": orderTime,
    "fullNameOrder": fullNameOrder,
    "Address": Address,
    "orderID": orderID,

  };
}