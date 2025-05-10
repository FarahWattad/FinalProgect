import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/Product.dart';
import '../Utils/ClientConfing.dart';
import 'package:http/http.dart' as http;

class Payment extends StatefulWidget {
  final String userName;
  final List<Product> cartItems;
  final double totalPrice;

  const Payment({
    Key? key,
    required this.userName,
    required this.cartItems,
    required this.totalPrice,
  }) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final TextEditingController notesController = TextEditingController();
  late List<Product> _cartItems;
  double _totalPrice = 0.0;

  String _firstName = "";
  String _lastName = "";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _cartItems = List.from(widget.cartItems);
    _totalPrice = widget.totalPrice;
    getMyDetails();
  }

  Future insertOrder(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userID = prefs.getString("userID") ?? "0";
      var url = "orders/insertOrder.php?userID=" + userID +
          "&totalPrice=" + _totalPrice.toStringAsFixed(2) +
          "&notes=" + Uri.encodeComponent(notesController.text);
      final response = await http.get(Uri.parse(serverPath + url));
      print(serverPath + url);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('הזמנה בוצעה בהצלחה!')),
      );

      Navigator.pop(context);
      Navigator.pop(context);
    } catch (e) {
      print("Error in insertOrder: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('אירעה שגיאה בביצוע ההזמנה')),
      );
    }
  }

  Future getMyDetails() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        _firstName = prefs.getString("FirstName") ?? "";
        _lastName = prefs.getString("LastName") ?? "";
        _isLoading = false;
      });
    } catch (e) {
      print("Error in getMyDetails: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _removeProduct(int index) {
    Product removed = _cartItems[index];
    setState(() {
      _totalPrice -= removed.productPrice ?? 0.0;
      _cartItems.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('המוצר "${removed.productName}" הוסר מהעגלה'),
        action: SnackBarAction(
          label: 'בטל',
          onPressed: () {
            setState(() {
              _cartItems.insert(index, removed);
              _totalPrice += removed.productPrice ?? 0.0;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xFFF5F5F5),
        appBar: AppBar(
          backgroundColor: Colors.orange.shade700,
          title: Text(
            "פרטי ההזמנה",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Text(
                      'שם הלקוח: $_firstName $_lastName',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'פרטי מוצרים:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.orange.shade800,
                      ),
                    ),
                    SizedBox(height: 10),
                    ..._cartItems.asMap().entries.map(
                          (entry) {
                        int index = entry.key;
                        Product item = entry.value;
                        return Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${item.productPrice?.toStringAsFixed(2) ?? '0'} ש"ח',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green.shade800,
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    item.productName ?? '',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87,
                                    ),
                                    textAlign: TextAlign.right,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () => _removeProduct(index),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ).toList(),
                    Divider(thickness: 2),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'סה"כ לתשלום: ${_totalPrice.toStringAsFixed(2)} ש"ח',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade800,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'הערות (מיקום, זמן אספקה...)',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: notesController,
                      decoration: InputDecoration(
                        hintText: 'כתוב כאן...',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      maxLines: 3,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    print('הוזן הערות: ${notesController.text}');
                    insertOrder(context);
                  },
                  child: Text(
                    "אישור הזמנה",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}