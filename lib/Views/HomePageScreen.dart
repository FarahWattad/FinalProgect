import 'package:flutter/material.dart';

import 'EditProfile.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key, required this.title});

  final String title;

  @override
  State<HomePageScreen> createState() => HomePageScreenPageState();
}

class HomePageScreenPageState extends State<HomePageScreen> {


  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: ראשי',
      style: optionStyle,
    ),
    Text(
      'Index 1: חיפוש',
      style: optionStyle,
    ),
    Text(
      'Index 2: חיפוש',
      style: optionStyle,
    ),
    Text(
      'Index 2: הזמנות',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
            ListView(
              // This next line does the trick.
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(
                  width: 160,
                  color: Colors.red,
                ),
                Container(
                  width: 160,
                  color: Colors.blue,
                ),
                Container(
                  width: 160,
                  color: Colors.green,
                ),
                Container(
                  width: 160,
                  color: Colors.yellow,
                ),
                Container(
                  width: 160,
                  color: Colors.orange,
                ),
              ],
            ),
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

    bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
        icon: Icon(Icons.home),

        label: 'ראשי',
        ),
        BottomNavigationBarItem(
        icon: Icon(Icons.shopping_basket),
        label: 'הסל שלי',
        ),
        BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: 'חיפוש',
        ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sticky_note_2_outlined),
            label: ' הזמנות',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.black,

        onTap: _onItemTapped,
        ),
    );
  }
}
