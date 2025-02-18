import 'package:finalproject/Utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Models/User.dart';
import '../Utils/ClientConfing.dart';
import '../Utils/db.dart';
import 'Homepagescreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.title});

  final String title;

  @override
  State<RegisterScreen> createState() => RegisterScreenPageState();
}



class RegisterScreenPageState extends State<RegisterScreen> {
  int _counter = 0;

  final _txtCity = TextEditingController();
  final _txtFirstName = TextEditingController();
  final _txtLastName = TextEditingController();
  final _txtPassword = TextEditingController();
  final _txtConfirmPassword = TextEditingController();


  Future insertUser(BuildContext context, User us) async {

    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //  String? getInfoDeviceSTR = prefs.getString("getInfoDeviceSTR");
    var url = "users/insertUser.php?firstName=" + us.FirstName + "&lastName=" + us.LastName;
    final response = await http.get(Uri.parse(serverPath + url));
    print(serverPath + url);
    setState(() { });
    Navigator.pop(context);
  }



  void insertUserFunc() {
    if (_txtFirstName.text != "") {
      User us = new User();
      us.FirstName = _txtFirstName.text;
      us.LastName = _txtLastName.text;
      us.City = _txtCity.text;
      us.Password = _txtPassword.text;
      us.ConfirmPassword = _txtConfirmPassword.text;
      insertUser(context ,us );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=> const Homepagescreen(title :" דף הבית ")),
      );
      /*
      var uti = new Utils();
      uti.showMyDialog(context, "success", "you registed successfully");
      _txtFirstName.text = "";
      _txtLastName.text = "";
      _txtCity.text = "";
      _txtPassword.text = "";
      _txtConfirmPassword.text = "";
       */
    } else {
      var uti = new Utils();
      uti.showMyDialog(context, "Required", "Please insert First name");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              ": שם פרטי",
              style: TextStyle(fontSize: 20),
            ),
            Container(
              width: 300,
              child: TextField(
                controller: _txtFirstName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'הזן שם פרטי - חובה',
                ),
              ),
            ),
            Text(
              ":שם משפחה",
              style: TextStyle(fontSize: 20),
            ),
            Container(
              width: 300,
              child: TextField(
                controller: _txtLastName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'הזן שם משפחה ',
                ),
              ),
            ),
            Text(
              ":עיר  ",
              style: TextStyle(fontSize: 20),
            ),
            Container(
              width: 300,
              child: TextField(
                controller: _txtCity,
//controller: _txtCity,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'הזן עיר',
                ),
              ),
            ),
            Text(
              ": סיסמה",
              style: TextStyle(fontSize: 20),
            ),
            Container(
              width: 300,
              child: TextField(
                controller: _txtPassword,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'הזן סיסמה',
                ),
              ),
            ),
            Text(
              ": אימות סיסמה",
              style: TextStyle(fontSize: 20),
            ),
            Container(
              width: 300,
              child: TextField(
                controller: _txtConfirmPassword,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'אימית סיסמה ',
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                insertUserFunc();
                /*
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> const HomePageScreen(title :" HomePage")),
                );
                 */
                //   content:Text(_txtCity.text+"_"+_txtEmail.text+"_"+_txtFullName.text+"_"+_txtPassword.text);
              },
              child: Text('הרשמה'),
            ),
          ],
        ),
      ),
    );
  }
}
