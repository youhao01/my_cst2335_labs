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

  ShoppingItem? selectedItem; //  Week9: 当前选中的 item

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

  ///  Week8 原始风格列表页面
  Widget listPage() {
    return Column(
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
                onTap: () {
                  setState(() {
                    selectedItem = shoppingList[index]; //  Tap 事件
                  });
                },
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
    );
  }

  ///  Week9: 详情页面（简洁风格 + 手机上方居中）
  Widget detailsPage() {
    if (selectedItem == null) {
      return Center(child: Text("No item selected"));
    } else {
      var size = MediaQuery.of(context).size;
      var width = size.width;
      var height = size.height;
      bool isTablet = (width > height) && (width > 720);

      return isTablet
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 平板左对齐
        children: detailsContent(MainAxisAlignment.start),
      )
          : Align(
        alignment: Alignment.topCenter, //  手机上方居中
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: detailsContent(MainAxisAlignment.center),
        ),
      );
    }
  }

  ///  公共详情内容（保持 Week8 原始风格）
  List<Widget> detailsContent(MainAxisAlignment buttonAlign) {
    return [
      Text("Item: ${selectedItem!.item}", style: TextStyle(fontSize: 20)),
      SizedBox(height: 10),
      Text("Quantity: ${selectedItem!.quantity}", style: TextStyle(fontSize: 18)),
      SizedBox(height: 10),
      Text("Database ID: ${selectedItem!.id}", style: TextStyle(fontSize: 18)),
      SizedBox(height: 20),
      Row(
        mainAxisAlignment: buttonAlign,
        children: [
          ElevatedButton(
            onPressed: () async {
              await itemDao.deleteItem(selectedItem!);
              setState(() {
                shoppingList.remove(selectedItem);
                selectedItem = null;
              });
            },
            child: Text("Delete"),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              setState(() {
                selectedItem = null;
              });
            },
            child: Text("Close"),
          ),
        ],
      ),
    ];
  }

  ///  响应式布局（加整体 Padding + 横屏右侧留空隙）
  Widget reactiveLayout(double width, double height) {
    Widget content;
    if ((width > height) && (width > 720)) {
      content = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 1, child: listPage()),
          SizedBox(width: 20), //  列表与详情页之间留空隙
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0), //  详情页自身增加左边距
              child: detailsPage(),
            ),
          ),
        ],
      );
    } else {
      content = selectedItem == null ? listPage() : detailsPage();
    }

    return Padding(
      padding: const EdgeInsets.all(16.0), //  整体页面边距
      child: content,
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;

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
      body: reactiveLayout(width, height),
    );
  }
}
