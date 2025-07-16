import 'package:flutter/material.dart';
import 'database/app_database.dart';
import 'database/shopping_item.dart';
import 'database/shopping_item_dao.dart';

void main() {
  runApp(MaterialApp(
    home: ShoppingListPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class ShoppingListPage extends StatefulWidget {
  @override
  _ShoppingListPageState createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  final TextEditingController itemController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  List<ShoppingItem> shoppingList = [];
  late AppDatabase database;
  late ShoppingItemDao itemDao;

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  Future<void> initDatabase() async {
    database = await $FloorAppDatabase.databaseBuilder('shopping_list.db').build();
    itemDao = database.shoppingItemDao;

    final items = await itemDao.findAllItems();
    setState(() {
      shoppingList = items;
    });

    if (items.isNotEmpty) {
      final maxId = items.map((e) => e.id).reduce((a, b) => a > b ? a : b);
      ShoppingItem.ID = maxId + 1;
    }
  }

  void addItem() async {
    String item = itemController.text.trim();
    String quantity = quantityController.text.trim();
    if (item.isNotEmpty && quantity.isNotEmpty) {
      final newItem = ShoppingItem(ShoppingItem.ID++, item, quantity);
      await itemDao.insertItem(newItem);
      setState(() {
        shoppingList.add(newItem);
      });
      itemController.clear();
      quantityController.clear();
    }
  }

  void confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Delete Item'),
        content: Text('Do you want to delete "${shoppingList[index].item}"?'),
        actions: [
          TextButton(
            onPressed: () async {
              await itemDao.deleteItem(shoppingList[index]);
              setState(() {
                shoppingList.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('No'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[100],
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Flutter Demo Home Page',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: itemController,
                    decoration: InputDecoration(
                      hintText: 'Type the item here',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: quantityController,
                    decoration: InputDecoration(
                      hintText: 'Type the quantity here',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: addItem,
                  child: Text('Click here'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: shoppingList.isEmpty
                  ? Center(child: Text('There are no items in the list'))
                  : ListView.builder(
                itemCount: shoppingList.length,
                itemBuilder: (context, index) {
                  final item = shoppingList[index];
                  return GestureDetector(
                    onLongPress: () => confirmDelete(index),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Center(
                        child: Text(
                          '${index + 1}: ${item.item}  quantity: ${item.quantity}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
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