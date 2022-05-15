final notifications = [];
const noOfTables = 20;

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
  String? foodName;
  int noOfItem = 0;
  double price = 0.0;
}

class TableSchema {
  final int index;

  TableSchema({required this.index});
  //otherdatas
  String? name;
  bool isOccupied = false;
  double totalPrice = 0.0;
  List foods = [];

  void clear() {
    name = null;
    isOccupied = false;
    totalPrice = 0.0;
  }
}

//now fill our tables with schema
final List<Map<String, double>> menu = [
  {
    'chicken': 150,
  },
  {
    'water': 25,
  },
  {
    'momo': 100,
  },
  {
    'ice cream': 30,
  },
  {
    'fruits': 190,
  },
  {
    'coffee': 100,
  },
  {
    'pakauda': 10,
  },
  {
    'fried rice': 35,
  },
  {
    'sel roti': 20,
  }
];
