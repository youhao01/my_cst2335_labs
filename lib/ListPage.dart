import 'package:flutter/material.dart';

class ListItem {
  String name;
  String quantity;
  ListItem(this.name, this.quantity);
}

Widget ListPage() {
  return const _ListPageContent();
}

class _ListPageContent extends StatefulWidget {
  const _ListPageContent({super.key});

  @override
  State<_ListPageContent> createState() => _ListPageContentState();
}

class _ListPageContentState extends State<_ListPageContent> {
  final List<ListItem> _items = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  void _addItem() {
    if (_nameController.text.isNotEmpty && _quantityController.text.isNotEmpty) {
      setState(() {
        _items.add(ListItem(_nameController.text, _quantityController.text));
        _nameController.clear();
        _quantityController.clear();
      });
    }
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Delete Item"),
        content: const Text("Do you want to delete this item?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _items.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF4FC),
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: 'Type the item here',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _quantityController,
                    decoration: const InputDecoration(
                      hintText: 'Type the quantity here',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _addItem,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFDF4FC),
                  ),
                  child: const Text(
                    "Click here",
                    style: TextStyle(color: Colors.purple),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _items.isEmpty
                ? const Center(
              child: Text(
                "There are no items in the list",
                style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.grey),
              ),
            )
                : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () => _confirmDelete(index),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${index + 1}: ${_items[index].name}  quantity: ${_items[index].quantity}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
