import 'package:flutter/material.dart';

class Searchs extends StatefulWidget {
  const Searchs({super.key, required this.title});

  final String title;

  State<Searchs> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<Searchs> {
  TextEditingController _searchController = TextEditingController();
  List<String> products = [];
  List<String> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    filteredProducts = products;
  }

  void _filterProduct(String query) {
    setState(() {
      filteredProducts = products
          .where((product) => product.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _navigateToScreen(String title) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CategoryScreen(title: title)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(":חיפוש מוצר"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _searchController,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: "...לחפש מוצר",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _filterProduct,
            ),
            SizedBox(height: 20),
            Text("קטגוריות", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () => _navigateToScreen("מזגנים עיליים"),
                    child: Text("מזגנים עיליים")),
                SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () => _navigateToScreen("מזגני מיני מרכזי"),
                    child: Text("מזגני מיני מרכזי")),
                SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () => _navigateToScreen("מזגנים ניידים"),
                    child: Text("מזגנים ניידים")),
              ],
            ),
            SizedBox(height: 20),
            Text("מותגים", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: () => _navigateToScreen("FAMILY"), child: Text("FAMILY")),
                SizedBox(height: 10),
                ElevatedButton(onPressed: () => _navigateToScreen("TORNADO"), child: Text("TORNADO")),
                SizedBox(height: 10),
                ElevatedButton(onPressed: () => _navigateToScreen("TADIRAN"), child: Text("TADIRAN")),
                SizedBox(height: 10),
                ElevatedButton(onPressed: () => _navigateToScreen("ELECTRA"), child: Text("ELECTRA")),
                SizedBox(height: 10),
                ElevatedButton(onPressed: () => _navigateToScreen("ELCO"), child: Text("ELCO")),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(filteredProducts[index], textAlign: TextAlign.right),
                    leading: Icon(Icons.shopping_cart),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryScreen extends StatelessWidget {
  final String title;
  const CategoryScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text(
          "$title דף תוכן",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
