import 'dart:convert';
import 'package:finalproject/Models/Product.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/ClientConfing.dart';
import 'ProductDetailsScreen.dart';
import 'package:http/http.dart' as http;
class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({super.key, required this.title});

  final String title;

  @override
  State<ProductsListScreen> createState() => _ProductsListScreen();
}

class _ProductsListScreen extends State<ProductsListScreen> {
  Future getProducts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? lastCategoryID = prefs.getString('lastCategoryID');
    var url = "products/getProducts.php?categoryID=" + lastCategoryID.toString();
    final response = await http.get(Uri.parse(serverPath + url));
    List<Product> arr = [];

    for (Map<String, dynamic> i in json.decode(response.body)) {
      arr.add(Product.fromJson(i));
    }

    return arr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              widget.title,
              textDirection: TextDirection.rtl, // جعل النص من اليمين
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: getProducts(),
        builder: (context, projectSnap) {
          if (projectSnap.hasData) {
            if (projectSnap.data.length == 0) {
              return Center(
                child: Text(
                  'אין תוצאות',
                  style: TextStyle(fontSize: 23, color: Colors.black),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: const Text(
                        ' :רשימת המוצרים',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: projectSnap.data.length,
                        itemBuilder: (context, index) {
                          Product project = projectSnap.data[index];

                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            elevation: 4,
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(12),
                              onTap: () async {
                                final SharedPreferences prefs = await SharedPreferences.getInstance();
                                await prefs.setString('lastProductID', project.productID.toString());

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
                                project.productName ?? '',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                textDirection: TextDirection.rtl, // النص من اليمين
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Text(
                                  "${project.productPrice} ₪",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                  textDirection: TextDirection.rtl, // النص من اليمين
                                ),
                              ),
                              trailing: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  project.imageURL,
                                  width: 120,  // حجم الصورة أكبر لعرض أفضل
                                  height: 120, // حجم الصورة أكبر لعرض أفضل
                                  fit: BoxFit.contain,  // لعرض الصورة كاملة وواضحة
                                ),
                              ),
                              isThreeLine: false,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          } else if (projectSnap.hasError) {
            print(projectSnap.error);
            return Center(
              child: Text(
                'שגיאה, נסה שוב',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        },
      ),
    );
  }
}
