class User{
  User({
    this.FirstName="",
    this.CreatedDateTime="",
    this.LastName="",
    this.City="",
    this.UserID="",
    this.Password="",
    this.Email="",
  this.ConfirmPassword="",
  });


  String FirstName;
  String LastName;
  String CreatedDateTime;
  String City;
  String UserID ;
  String Password;
  String ConfirmPassword;
  String Email;

  factory User.fromJson(Map<String,dynamic> json)=>User(
    FirstName: json["FirstName"],
    CreatedDateTime: json["CreatedDateTime"],
    LastName: json["LastName"],
    City: json["City"],
    UserID : json["UserID "],
    Password : json["Password "],
    ConfirmPassword : json["ConfirmPassword "],
  Email : json["Email "],

  );
  Map<String,dynamic> toJson() => {
    "FirstName": FirstName,
    "CreatedDateTime":CreatedDateTime,
    "LastName":LastName,
    "City":City,
    "UserID ":UserID ,
    "Password ":Password ,
    "ConfirmPassword ":ConfirmPassword ,
  "Email ":Email ,

  };
}