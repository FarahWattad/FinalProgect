import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Models/User.dart';
import '../Utils/ClientConfing.dart';
import '../Utils/db.dart';
import 'Homepagescreen.dart';
import '../Utils/Utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.title});

  final String title;

  @override
  State<RegisterScreen> createState() => RegisterScreenPageState();
}

class RegisterScreenPageState extends State<RegisterScreen> {
  final _txtCity = TextEditingController();
  final _txtFirstName = TextEditingController();
  final _txtLastName = TextEditingController();
  final _txtPassword = TextEditingController();
  final _txtConfirmPassword = TextEditingController();
  final _txtEmail = TextEditingController();

  Future insertUser(BuildContext context, User us) async {
    try {
      var url = "users/insertUser.php?firstName=" +
          us.FirstName +
          "&lastName=" +
          us.LastName +
          "&city=" +
          us.City +
          "&email=" +
          us.Email +
          "&password=" +
          us.Password;

      final response = await http.get(Uri.parse(serverPath + url));
      if (response.statusCode == 200) {
        setState(() {});
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Homepagescreen(title: " דף הבית ")),
        );
      } else {
        var uti = Utils();
        uti.showMyDialog(context, "Error", "Failed to register user.");
      }
    } catch (e) {
      var uti = Utils();
      uti.showMyDialog(context, "Error", "An error occurred: $e");
    }
  }

  void insertUserFunc() {
    if (_txtFirstName.text != "" &&
        _txtLastName.text != "" &&
        _txtCity.text != "" &&
        _txtEmail.text != "" &&
        _txtPassword.text != "" &&
        _txtConfirmPassword.text != "") {
      if (_txtPassword.text == _txtConfirmPassword.text) {
        User us = User();
        us.FirstName = _txtFirstName.text;
        us.LastName = _txtLastName.text;
        us.City = _txtCity.text;
        us.Password = _txtPassword.text;
        us.ConfirmPassword = _txtConfirmPassword.text;
        us.Email = _txtEmail.text;

        insertUser(context, us);
      } else {
        var uti = Utils();
        uti.showMyDialog(context, "Error", "Passwords do not match");
      }
    } else {
      var uti = Utils();
      uti.showMyDialog(context, "Required", "Please fill in all fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange, // تغيير اللون هنا
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // تم حذف الكلمة هنا من الجزء البرتقالي
              SizedBox(height: 30),

              // Input Fields Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      ": שם פרטי",
                      style: TextStyle(fontSize: 20),
                    ),
                    Container(
                      width: double.infinity,
                      child: TextField(
                        controller: _txtFirstName,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'הזן שם פרטי - חובה',
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      ":שם משפחה",
                      style: TextStyle(fontSize: 20),
                    ),
                    Container(
                      width: double.infinity,
                      child: TextField(
                        controller: _txtLastName,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'הזן שם משפחה',
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      ":עיר",
                      style: TextStyle(fontSize: 20),
                    ),
                    Container(
                      width: double.infinity,
                      child: TextField(
                        controller: _txtCity,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'הזן עיר',
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      ": מייל או מספר טלפון",
                      style: TextStyle(fontSize: 20),
                    ),
                    Container(
                      width: double.infinity,
                      child: TextField(
                        controller: _txtEmail,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'מייל או מספר טלפון',
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      ": סיסמה",
                      style: TextStyle(fontSize: 20),
                    ),
                    Container(
                      width: double.infinity,
                      child: TextField(
                        controller: _txtPassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'הזן סיסמה',
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      ": אימות סיסמה",
                      style: TextStyle(fontSize: 20),
                    ),
                    Container(
                      width: double.infinity,
                      child: TextField(
                        controller: _txtConfirmPassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'אימית סיסמה',
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          insertUserFunc();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // اللون الأزرق هنا
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'הרשמה',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
