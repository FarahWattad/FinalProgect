import 'package:flutter/material.dart';

import 'Homepagescreen.dart';

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
              ": מייל או מספר טלפון",
              style: TextStyle(fontSize: 20),
            ),
            Container(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: ' מייל או מספר טלפון',
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'הזן סיסמה',
                ),
              ),
            ),
            Text(
              ": שם מלא ",
              style: TextStyle(fontSize: 20),
            ),
            Container(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'הזן שם מלא',
                ),
              ),
            ),
            Text(
              ": עיר ",
              style: TextStyle(fontSize: 20),
            ),
            Container(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'הזן את שם העיר',
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
                  MaterialPageRoute(
                      builder: (context) =>
                          const Homepagescreen(title: " HomePage")),
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
