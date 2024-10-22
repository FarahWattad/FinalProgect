import 'package:flutter/material.dart';

import 'HomePageScreen.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key, required this.title});

  final String title;

  @override
  State<EditProfile> createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfile> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
              "Email Or Number Phone:",
              style: TextStyle(fontSize: 20),
            ),
            Container(
              width: 500,
              child :TextField(
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> const HomePageScreen(title :" HomePage")),
                );
              },
              child: Text('Save'),
            ),

          ],
        ),
      ),
    );
  }
}
