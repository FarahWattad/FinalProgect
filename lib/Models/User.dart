class User{
  User({
    this.FirstName="",
    this.CreatedDateTime="",
    this.LastName="",
    this.City="",
    this.UserID=0,

  });


  String FirstName;
  String LastName;
  String CreatedDateTime;
  String City;
  int UserID ;

  factory User.fromJson(Map<String,dynamic> json)=>User(
    FirstName: json["FirstName"],
    CreatedDateTime: json["CreatedDateTime"],
    LastName: json["LastName"],
    City: json["City"],
    UserID : json["UserID "],

  );
  Map<String,dynamic> toJson() => {
    "FirstName": FirstName,
    "CreatedDateTime":CreatedDateTime,
    "LastName":LastName,
    "City":City,
    "UserID ":UserID ,

  };
}