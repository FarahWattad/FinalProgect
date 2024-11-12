import 'package:finalproject/Utils/Utils.dart';
import 'package:flutter/material.dart';

import '../Utils/db.dart';
import 'HomePageScreen.dart';

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key, required this.title});

  final String title;

  @override
  State<Registerscreen> createState() => RegisterscreenPageState();
}

class RegisterscreenPageState extends State<Registerscreen> {
  int _counter = 0;

  final _txtEmail= TextEditingController();
  final _txtPassword= TextEditingController();
  final _txtCity= TextEditingController();
  final _txtName= TextEditingController();



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
              "Email Or Number Phone:",
              style: TextStyle(fontSize: 20),
            ),
            Container(
              width: 500,
              child :TextField(
                controller: _txtEmail,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Email Or Phone',
                ),
              ),
            ),
            Text(
              "Password :",
              style: TextStyle(fontSize: 20),
            ),
            Container(
              width: 500,
              child : TextField(
                controller: _txtPassword,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Password',
                ),
              ),
            ),
            Text(
              "Full Name:",
              style: TextStyle(fontSize: 20),
            ),
            Container(
              width: 500,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Full Name',
                ),
              ),
            ),
            Text(
              "City :",
              style: TextStyle(fontSize: 20),
            ),
            Container(
              width: 500,
              child :TextField(

                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter City',
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                var Uti2=new Utils();
                Uti2.showMyDialog(context, _txtEmail.text, _txtPassword.text);
                insertUser("aa", 'ss' , 'dd');
                /*
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> const HomePageScreen(title :" HomePage")),
                );
                 */
                content:Text(_txtCity.text+"_"+_txtEmail.text+"_"+_txtName.text+"_"+_txtPassword.text);
              },
              child: Text('Register'),
            ),

          ],
        ),
      ),
    );
  }
}
