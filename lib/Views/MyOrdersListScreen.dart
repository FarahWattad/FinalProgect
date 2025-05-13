import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/Order.dart';
import '../Utils/ClientConfing.dart';

class Orders extends StatefulWidget {
  const Orders({super.key, required this.title});
  final String title;

  @override
  State<Orders> createState() => OrdersPageState();
}

class OrdersPageState extends State<Orders> {
  Future<List<Order>> getMyOrders() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID") ?? "0";

    var url = "orders/getMyOrders.php?userID=" + userID;
    final response = await http.get(Uri.parse(serverPath + url));
    print(serverPath + url);

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

  void _showOrderDialog(Order order) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('פרטי הזמנה'),
        content: Text(
          "מספר הזמנה: ${order.orderID}\n"
              "סה\"כ: ${order.totalPrice} ש\"ח\n"
              "תאריך הזמנה: ${order.orderTime}\n"
              "שם מלא: ${order.fullNameOrder}\n"
              "כתובת: ${order.Address}\n"
              "פרטי הזמנה: ${order.orderDetails}",

        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'סגור'),
            child: const Text('סגור'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            "הזמנות",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: FutureBuilder<List<Order>>(
          future: getMyOrders(),
          builder: (context, projectSnap) {
            if (projectSnap.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(color: Colors.blue));
            } else if (projectSnap.hasError) {
              return Center(
                child: Text(
                  'שגיאה, נסה שוב',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red),
                ),
              );
            } else if (!projectSnap.hasData || projectSnap.data!.isEmpty) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Center(
                  child: Text(
                    'אין הזמנות',
                    style: TextStyle(fontSize: 50, color: Colors.black),
                  ),
                ),
              );
            } else {
              List<Order> orders = projectSnap.data!;
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  Order project = orders[index];
                  return Card(
                    color: Colors.orange.shade100,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: ListTile(
                      title: Text(
                        project.Address,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      subtitle: Text(
                        "מספר הזמנה: ${project.orderID}\n"
                            "תאריך הזמנה: ${project.orderTime}\n"
                            "סה\"כ: ${project.totalPrice} שח\n"
                            "${project.fullNameOrder}\n"
                           "פרטי ההזמנה: ${project.orderDetails}\n" ,

                          style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      isThreeLine: true,
                      trailing: TextButton(
                        onPressed: () => _showOrderDialog(project),
                        child: Text('הצג נתונים', style: TextStyle(color: Colors.blue)),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
