class User{
  User({
    this.FirstName="",
    this.CreatedDateTime="",
    this.LastName="",
    this.Password="",
    this.UserID=0,

  });


  String FirstName;
  String LastName;
  String CreatedDateTime;
  String Password;
  int UserID ;

  factory User.fromJson(Map<String,dynamic> json)=>User(
    FirstName: json["FirstName"],
    CreatedDateTime: json["CreatedDateTime"],
    LastName: json["LastName"],
    Password: json["Password"],
    UserID : json["UserID "],

  );
  Map<String,dynamic> toJson() => {
    "FirstName": FirstName,
    "CreatedDateTime":CreatedDateTime,
    "LastName":LastName,
    "Password":Password,
    "UserID ":UserID ,

  };
}