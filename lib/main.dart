import 'dart:convert';
import 'dart:io';

import 'package:finalproject/Views/RegisterScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'Models/checkLoginModel.dart';
import 'Utils/ClientConfing.dart';
import 'Utils/Utils.dart';
import 'Views/Homepagescreen.dart';

void main() {
  runApp(const MyApp());
}

final _txtEmail = TextEditingController();
final _txtPassword = TextEditingController();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Farah'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  fillSavedPars() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _txtEmail.text = prefs.get("email").toString();
    _txtPassword.text = prefs.get("password").toString();
    if(_txtEmail.text != "" && _txtPassword.text != "")
    {
      checkLogin(context);
    }
  }




  Future checkLogin(BuildContext context) async {

    if(_txtPassword.text == "" || _txtEmail.text == "")
    {
      var uti = new Utils();
      uti.showMyDialog(context, "חובה", "בבקשה הזן האיימל שלך או הסיסמה");
    }
    else
    {
      //   SharedPreferences prefs = await SharedPreferences.getInstance();
      //  String? getInfoDeviceSTR = prefs.getString("getInfoDeviceSTR");
      var url = "login/checkLogin.php?Email=" + _txtEmail.text + "&Password=" +  _txtPassword.text;
      final response = await http.get(Uri.parse(serverPath + url));
      print(serverPath + url);
      // setState(() { });
      // Navigator.pop(context);
      if(checkLoginModel.fromJson(jsonDecode(response.body)).userID == 0)
      {
        // return ' אימיל ו/או הסיסמה שגויים';
        var uti = new Utils();
        uti.showMyDialog(context, "שגיאה", "אימיל ו/או הסיסמה שגויים");
      }
      else
      {
        // print("SharedPreferences 1");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userID', checkLoginModel.fromJson(jsonDecode(response.body)).userID!.toString());
        await prefs.setString('email', _txtEmail.text);
        await prefs.setString('password', _txtPassword.text);

        Navigator.push(
          context,
          MaterialPageRoute(builder:(context) => const Homepagescreen(title: "בית")),
        );
      }
    }
  }
  checkConction() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // print('connected to internet');// print(result);// return 1;
      }
    } on SocketException catch (_) {
      // print('not connected to internet');// print(result);
      var uti = new Utils();
      uti.showMyDialog(context, "אין אינטרנט",
          "האפליקציה דורשת חיבור לאינטרנט, נא להתחבר בבקשה");
      return;
    }
  }

  @override
  Widget build(BuildContext context) {

    checkConction();
    fillSavedPars();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Container(
            //   padding:
            //   EdgeInsets.all(50),
            //   child: Image.asset('Images/3shahtat.png'),
            // ),
            Text(
              " : מייל או מספר טלפון ",
              style: TextStyle(fontSize: 20),
            ),
            Container(
              width: 300,
              child: TextField(
                controller: _txtEmail,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'מייל או מספר טלפון',
                ),
              ),
            ),
            Text(
              ": סיסמה ",
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
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                checkLogin(context);

              },
              child: Text('כניסה'),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                //מעבר בין מסכים
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const RegisterScreen(title: "חשבון חדש")),
                );
              },
              child: Text('חשבון חדש'),
            ),

            TextButton(
              //اخر اشي عشان الدفع
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('מידע'),
                  content: Text(_txtEmail.text + "_" + _txtPassword.text),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'ביטול'),
                      child: const Text('ביטול'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'בסדר'),
                      child: const Text('בסדר'),
                    ),
                  ],
                ),
              ),

              child: const Text('נתונים'),
            ),
          ],
        ),
      ),
    );
  }
}
