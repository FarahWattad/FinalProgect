import 'dart:convert';
import 'package:finalproject/Models/Category.dart';
import 'package:finalproject/Views/ProductsListScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/ClientConfing.dart';
import 'EditProfile.dart';
import 'MyOrdersListScreen.dart';
import 'SearchScreen.dart';
import 'MyCartScreen.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class Homepagescreen extends StatefulWidget {
  const Homepagescreen({super.key, required this.title});

  final String title;

  @override
  State<Homepagescreen> createState() => _Homepagescreen();
}

class _Homepagescreen extends State<Homepagescreen> {
  int _counter = 0;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: ראשי',
      style: optionStyle,
    ),
    Text(
      'Index 1: הסל שלי',
      style: optionStyle,
    ),
    Text(
      'Index 2: חיפוש',
      style: optionStyle,
    ),
    Text(
      'Index 3: הזמנות',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (index == 1) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyCartScreen(
                title: "MyCartScreen",
              ),
            ));
      } else if (index == 2) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Searchs(
                title: "Searchs",
              ),
            ));
      } else if (index == 3) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Orders(
                title: "Orders",
              ),
            ));
      }
    });
  }

  Future getCategories() async {
    var url = "products/getCategories.php";
    final response = await http.get(Uri.parse(serverPath + url));
    print(serverPath + url);
    List<Category> arr = [];

    for (Map<String, dynamic> i in json.decode(response.body)) {
      arr.add(Category.fromJson(i));
    }

    return arr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Align(
          alignment: Alignment.centerRight, // جعل العنوان على اليمين
          child: Text(
            widget.title,
            textDirection: TextDirection.rtl,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue,
              Colors.white,
              Colors.orange,
            ],
          ),
        ),
        child: FutureBuilder(
          future: getCategories(),
          builder: (context, projectSnap) {
            if (projectSnap.hasData) {
              if (projectSnap.data.length == 0) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 2,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'אין תוצאות',
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.black,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        itemCount: projectSnap.data.length,
                        itemBuilder: (context, index) {
                          Category project = projectSnap.data[index];
                          return Card(
                            color: Colors.white.withOpacity(0.8),
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                            child: ListTile(
                              contentPadding: EdgeInsets.all(15),
                              onTap: () async {
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setString('lastCategoryID',
                                    project.categoryID.toString());

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductsListScreen(
                                      title: project.categoryName,
                                    ),
                                  ),
                                );
                              },
                              title: Row(
                                textDirection: TextDirection.rtl,
                                // النصوص من اليمين لليسار
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      project.categoryName ?? '',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: project.imageURC,
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            } else if (projectSnap.hasError) {
              return Center(
                child: Text(
                  'שגיאה, נסה שוב',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textDirection: TextDirection.rtl,
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
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
            label: 'הזמנות',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
