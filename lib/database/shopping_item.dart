import 'package:floor/floor.dart';

@entity
class ShoppingItem {
  @primaryKey
  final int id;

  final String item;
  final String quantity;

  ShoppingItem(this.id, this.item, this.quantity);

  static int ID = 1; // 自增 ID 用于插入新项目
}