class User{
  User({
    this.id="",
    this.name="",
    this.phone="",
    this.note="",
    this.Address="",
    this.UserID=0,

  });

  String id;
  String name;
  String note;
  String phone;
  String Address;
  int UserID ;

  factory User.fromJson(Map<String,dynamic> json)=>User(
    id: json ["id"],
    name: json["name"],
    phone: json["phone"],
    note: json["note"],
    Address: json["Address"],
    UserID : json["UserID "],

  );
  Map<String,dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone":phone,
    "note":note,
    "Address":Address,
    "UserID ":UserID ,

  };
}