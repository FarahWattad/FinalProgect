import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'Models/checkLoginModel.dart';
import 'Utils/ClientConfing.dart';
import 'Utils/Utils.dart';
import 'Views/Homepagescreen.dart';
import 'Views/RegisterScreen.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Colors.blue,
          secondary: Colors.deepOrange,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'קוראייר'),
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
  @override
  void initState() {
    super.initState();
    checkConnection();
    fillSavedPars();
  }

  fillSavedPars() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _txtEmail.text = prefs.getString("email") ?? '';
    _txtPassword.text = prefs.getString("password") ?? '';

    if (_txtEmail.text.isNotEmpty && _txtPassword.text.isNotEmpty) {
      checkLogin(context);
    }
  }

  Future checkLogin(BuildContext context) async {
    if (_txtEmail.text.isEmpty || _txtPassword.text.isEmpty) {
      var uti = Utils();
      uti.showMyDialog(context, "חובה", "בבקשה הזן האיימל שלך או הסיסמה");
    } else {
      var url = "login/checkLogin.php?Email=${_txtEmail.text}&Password=${_txtPassword.text}";
      final response = await http.get(Uri.parse(serverPath + url));

      if (checkLoginModel.fromJson(jsonDecode(response.body)).userID == 0) {
        var uti = Utils();
        uti.showMyDialog(context, "שגיאה", "אימיל ו/או הסיסמה שגויים");
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userID', checkLoginModel.fromJson(jsonDecode(response.body)).userID!.toString());
        await prefs.setString('email', _txtEmail.text);
        await prefs.setString('password', _txtPassword.text);
        await prefs.setString('FirstName', checkLoginModel.fromJson(jsonDecode(response.body)).FirstName!.toString());
        await prefs.setString('LastName', checkLoginModel.fromJson(jsonDecode(response.body)).LastName!.toString());

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Homepagescreen(title: "בית")),
        );
      }
    }
  }

  checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isEmpty || result[0].rawAddress.isEmpty) {
        throw SocketException('No internet');
      }
    } on SocketException catch (_) {
      var uti = Utils();
      uti.showMyDialog(context, "אין אינטרנט", "האפליקציה דורשת חיבור לאינטרנט, נא להתחבר בבקשה");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 5,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.account_circle, size: 100, color: Colors.blue),
                    const SizedBox(height: 20),
                    Text(
                      "כניסה לחשבון",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange.shade700,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: _txtEmail,
                      textAlign: TextAlign.right, // الكتابة من اليمين لليسار
                      decoration: InputDecoration(
                        labelText: 'מייל או מספר טלפון', // العبارات بالعبرية من اليمين لليسار
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _txtPassword,
                      obscureText: true,
                      textAlign: TextAlign.right, // الكتابة من اليمين لليسار
                      decoration: InputDecoration(
                        labelText: 'סיסמה', // العبارات بالعبرية من اليمين لليسار
                        prefixIcon: const Icon(Icons.lock),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          checkLogin(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text(
                          'כניסה', // العبارات بالعبرية من اليمين لليسار
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(title: "חשבון חדש"), // العبارات بالعبرية من اليمين لليسار
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.deepOrange),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text(
                          'יצירת חשבון חדש', // العبارات بالعبرية من اليمين لليسار
                          style: TextStyle(color: Colors.deepOrange.shade700, fontSize: 16),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('מידע'),
                            content: Text("${_txtEmail.text}_${_txtPassword.text}"),
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
                        );
                      },
                      child: const Text('הצג נתונים', style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
