import 'dart:convert';
import 'package:finalproject/Models/Product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/ClientConfing.dart';
class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.title});

  final String title;
  @override
  State<ProductDetailsScreen> createState() => ProductPageState();
}

class ProductPageState extends State<ProductDetailsScreen> {
  final _txtUserName = TextEditingController();
  late Product _currProduct;

  Future<void> getDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? lastProductID = prefs.getString('lastProductID');

    var url = "products/getProductDetails.php?productID=$lastProductID";
    final response = await http.get(Uri.parse(serverPath + url));
    _currProduct = Product.fromJson(json.decode(response.body));
    setState(() {});
  }

  Future insertProductToCart(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID");
    var url = "carts/insertProductToCart.php?userID=" +
        userID! +
        "&productID=" +
        _currProduct.productID.toString();
    final response = await http.get(Uri.parse(serverPath + url));
    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Added to cart!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    getDetails();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "פרטי המוצר",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,  // الأزرق للـ AppBar
        elevation: 6,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,  // خلفية بيضاء
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(_currProduct.imageURL),
                ),
                const SizedBox(height: 40),
                Text(
                  _currProduct.productName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w300,
                    color: Colors.blue, // النص باللون الأزرق
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "מחיר :",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.orange, // النص باللون البرتقالي
                  ),
                  textAlign: TextAlign.right, // محاذاة النص من اليمين
                  textDirection: TextDirection.rtl, // اتجاه النص من اليمين لليسار
                ),
                Text(
                  _currProduct.productPrice.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.right, // محاذاة النص من اليمين
                  textDirection: TextDirection.rtl, // اتجاه النص من اليمين لليسار
                ),
                const SizedBox(height: 10),
                Divider(thickness: 1, color: Colors.grey.shade400),
                const SizedBox(height: 10),
                Text(
                  "אחריות :",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.orange, // النص باللون البرتقالي
                  ),
                  textAlign: TextAlign.right, // محاذاة النص من اليمين
                  textDirection: TextDirection.rtl, // اتجاه النص من اليمين لليسار
                ),
                Text(
                  _currProduct.warranty.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.right, // محاذاة النص من اليمين
                  textDirection: TextDirection.rtl, // اتجاه النص من اليمين لليسار
                ),
                const SizedBox(height: 20),
                // Add to Cart Button
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      insertProductToCart(context);
                    },
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text('הוסף לסל הקניות '),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange, // برتقالي
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
