import 'dart:convert';
import 'package:finalproject/Models/MyCart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/Product.dart';
import '../Utils/ClientConfing.dart';
import 'package:http/http.dart' as http;
import 'Payment.dart';
import 'ProductDetailsScreen.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key, required this.title});

  final String title;

  @override
  State<MyCartScreen> createState() => MyCartScreenState();
}

class MyCartScreenState extends State<MyCartScreen> {
  Future<List<Product>> getMyCart() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? userID = prefs.getString('userID');

      var url = "carts/getMyCart.php?userID=" + (userID ?? "1");
      final response = await http.get(Uri.parse(serverPath + url));
      List<Product> arr = [];
      final List<dynamic> jsonData = json.decode(response.body);
      for (Map<String, dynamic> i in jsonData) {
        Map<String, dynamic> completeJson = {
          "productID": i["productID"] ?? "",
          "productName": i["productName"] ?? "",
          "productPrice": 999,
          "CreatedDateTime": i["CreatedDateTime"] ?? "",
          "Warranty": i["Warranty"] ?? 0,
          "categoryID": i["categoryID"] ?? "",
          "imageURL": i["imageURL"] ?? "",
          "quantity": i["quantity"] ?? "1",
        };
        arr.add(Product.fromJson(completeJson));
      }
      return arr;
    } catch (e) {
      print("Error in getMyCart: $e");
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Blue color for the app bar
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Product>>(
        future: getMyCart(),
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
                  color: Colors.orange, // Orange loading indicator
                ));
          } else if (projectSnap.hasError) {
            return Center(
                child: Text('שגיאה, נסה שוב',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)));
          } else if (projectSnap.hasData) {
            final data = projectSnap.data!;
            if (data.isEmpty) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 2,
                child: Align(
                    alignment: Alignment.center,
                    child: Text('אין תוצאות',
                        style: TextStyle(fontSize: 23, color: Colors.black))),
              );
            } else {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        Product project = data[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          color: Colors.orange.shade50, // Light orange card
                          child: ListTile(
                            onTap: () async {
                              final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                              await prefs.setInt('lastProductID',
                                  project.productID as int);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailsScreen(
                                    title: project.productName,
                                  ),
                                ),
                              );
                            },
                            title: Text(
                              project.productName ?? 'מוצר ללא שם',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            subtitle: Text(
                              "${project.productPrice} שח",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            trailing: Image.network(
                              project.imageURL,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.image_not_supported);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          } else {
            return Center(child: Text('אין נתונים'));
          }
        },
      ),
      bottomNavigationBar: TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), // Blue button
        ),
        onPressed: () async {
          try {
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            final String? userName = prefs.getString('userName');

            List<Product> cartItems = await getMyCart();

            if (cartItems.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('עגלת הקניות ריקה')),
              );
              return;
            }

            double totalPrice = 0;
            for (var item in cartItems) {
              totalPrice += item.productPrice;
            }

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Payment(
                  userName: userName ?? 'אורח',
                  cartItems: cartItems,
                  totalPrice: totalPrice,
                ),
              ),
            );
          } catch (e) {
            print("Error in checkout button: $e");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('אירעה שגיאה, נסה שוב מאוחר יותר')),
            );
          }
        },
        child: Text('סיום הזמנה'),
      ),
    );
  }
}
