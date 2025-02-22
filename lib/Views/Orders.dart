import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key, required this.title});

  final String title;

  @override
  State<Orders> createState() => OrdersPageState();
}

class OrdersPageState extends State<Orders> {
  final List<Map<String, dynamic>> orders = [
    {"id": 1, "total": 150.0, "date": "2025-02-08"},
    {"id": 2, "total": 230.5, "date": "2025-02-07"},
    {"id": 3, "total": 99.99, "date": "2025-02-06"},
  ];

  int? selectedOrderId;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(selectedOrderId == null
              ? widget.title
              : "תאריך ההזמנה: $selectedOrderId"),
          leading: selectedOrderId != null
              ? IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                selectedOrderId = null;
              });
            },
          )
              : null,
        ),
        body: selectedOrderId == null
            ? ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5, // إضافة ظل للمستطيلات لجعلها أوضح
              child: Padding(
                padding: EdgeInsets.all(20), // تكبير الحجم الداخلي للمستطيل
                child: ListTile(
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 15), // توسيع حجم الـ ListTile
                  title: Text(
                    "המזנה : ${order['id']}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "תאריך: ${order['date']}",
                    style: TextStyle(fontSize: 18),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "₪${order['total']}",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderDetails(orderId: order['id']),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          textStyle: TextStyle(fontSize: 16),
                        ),
                        child: Text("הצגת פרטים"),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        )
            : Center(
          child: Text(
            "תוכן ההזמנה: $selectedOrderId",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class OrderDetails extends StatelessWidget {
  final int orderId;

  const OrderDetails({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تفاصيل الطلبية رقم $orderId"),
      ),
      body: Center(
        child: Text(
          "هنا تفاصيل الطلبية رقم $orderId",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
