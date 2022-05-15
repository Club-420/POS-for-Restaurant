final notifications = [];
const noOfTables = 20;

final Map<String, int> menus = {};
List tables = [];

//schema
// Map<String, Object?> orderSchema = {
//   'foodName': null as String,
//   'quantity': null as int,
//   'pricePerItem': null as double,
// };

// Map<String, Object?> schema = {
//   'name': null as String,
//   'isOccupied': false,
//   'hasCheckedOut': false,
//   'tableNo': null as int,
//   'orders': [],
//   'totalPrice': null as double,
// };
class OrderSchema {
  String foodName;
  double price;

  OrderSchema({required this.foodName, required this.price});
}

class TableSchema {
  final int index;

  TableSchema({required this.index});
  //otherdatas
  String? name;
  bool isOccupied = false;
  double totalPrice = 0.0;

  void clear() {
    name = null;
    isOccupied = false;
    totalPrice = 0.0;
  }
}

//now fill our tables with schema

