import 'package:flutter/material.dart';

class Homepagescreenscreen extends StatefulWidget {
  const Homepagescreenscreen({super.key, required this.title});

  final String title;

  @override
  State<Homepagescreenscreen> createState() => HomepagescreenscreenPageState();
}

class HomepagescreenscreenPageState extends State<Homepagescreenscreen> {


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
          ],
        ),
      ),
    );
  }
}
