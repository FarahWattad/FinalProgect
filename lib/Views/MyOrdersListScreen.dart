import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Models/Order.dart';
import '../Utils/ClientConfing.dart';
import 'OrderDetailsScreen.dart';

class Orders extends StatefulWidget {
  const Orders({super.key, required this.title});

  final String title;

  @override
  State<Orders> createState() => OrdersPageState();
}

class OrdersPageState extends State<Orders> {

  Future<List<Order>> getMyOrders() async {
    var url = "orders/getMyOrders.php";
    final response = await http.get(Uri.parse(serverPath + url));

    if (response.statusCode == 200) {
      List<Order> arr = [];
      List<dynamic> data = json.decode(response.body);

      for (var i in data) {
        arr.add(Order.fromJson(i));
      }

      return arr;
    } else {
      throw Exception('Failed to load orders');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white, // اللون الأبيض كخلفية
        appBar: AppBar(
          backgroundColor: Colors.blue, // اللون الأزرق في AppBar
          title: Text(
            "הזמנות",
            style: TextStyle(
              color: Colors.white, // النص باللون الأبيض
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: FutureBuilder<List<Order>>(
          future: getMyOrders(),
          builder: (context, projectSnap) {
            if (projectSnap.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.blue, // اللون الأزرق لمؤشر التحميل
                ),
              );
            } else if (projectSnap.hasError) {
              return Center(
                child: Text(
                  'שגיאה, נסה שוב',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.red, // النص باللون الأحمر للخطأ
                  ),
                ),
              );
            } else if (!projectSnap.hasData || projectSnap.data!.isEmpty) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'אין הזמנות',
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            } else {
              List<Order> orders = projectSnap.data!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        Order project = orders[index];

                        return Card(
                          color: Colors.orange.shade100, // اللون البرتقالي للبطاقة
                          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: ListTile(
                            onTap: () {


                              Navigator.push(
                                context,
                                MaterialPageRoute(builder:(context) => const OrderDetails(orderId: 12, items: [],)),
                              );
                            },
                            title: Text(
                              project.Address,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue, // النص باللون الأزرق
                              ),
                            ),
                            subtitle: Text(
                              "מספר הזמנה: ${project.orderID}\nתאריך הזמנה: ${project.orderTime}\nסה"
                                  "כ: ${project.total.toString()} שח\n${project.fullNameOrder}",
                              style: TextStyle(
                              fontSize: 16,
                              color: Colors.black, // النص باللون الأسود
                            ),
                          ),
                          isThreeLine: true,
                        ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}



