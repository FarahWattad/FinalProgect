import 'package:flutter/material.dart';

import 'EditProfile.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key, required this.title});

  final String title;

  @override
  State<HomePageScreen> createState() => HomePageScreenPageState();
}

class HomePageScreenPageState extends State<HomePageScreen> {


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
            Text("home"),
            TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> const EditProfile(title :" EditProfile")),
                  );
                },
                child: Icon(Icons.account_circle)
            ),



          ],
        ),
      ),


    );
  }
}
