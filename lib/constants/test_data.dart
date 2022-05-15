final notifications = [];
const noOfTables = 20;

List tables = [];

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
  List<Map<String, Object>> foods = [];

  @override
  String toString() {
    return 'index: $index, name: $name, foods: ${foods.toString()}';
  }

  double get getTotalPrice {
    double sum = 0.0;

    if (foods.isEmpty) {
      return sum;
    }

    for (final i in foods) {
      for (final j in menu) {
        if (i['name'] == j['name']) {
          double price = j['price'] as double;
          int no = i['noOfItem'] as int;

          sum = sum + price * no;
        }
      }
    }
    return sum;
  }

  void clear() {
    name = null;
    foods = [];
    isOccupied = false;
  }

  int contains(String food) {
    int index = -1;
    for (final item in foods) {
      index++;
      if (item['name'] == food) {
        return index;
      }
    }
    return -5;
  }

  int howMuch(String food) {
    int pos = contains(food);

    if (pos != -5) {
      return foods[pos]['noOfItem'] as int;
    } else {
      return 0;
    }
  }

  void add(String food, int quantity) {
    int pos = contains(food);
    if (pos != -5) {
      int prev = foods[pos]['noOfItem'] as int;
      foods[pos]['noOfItem'] = quantity + prev;
    } else {
      foods.add({
        'name': food,
        'noOfItem': quantity,
      });
    }
  }

  void addFoodList(List<Map<String, Object>> foodList) {
    for (final i in foodList) {
      add(i['name'] as String, i['noOfItem'] as int);
    }
  }

  void remove(String food, int quantity) {
    int pos = contains(food);
    if (pos != -5) {
      int prev = foods[pos]['noOfItem'] as int;
      if (prev > 1) {
        foods[pos]['noOfItem'] = prev - quantity;
      } else {
        foods.removeAt(pos);
      }
    }
  }
}

//now fill our tables with schema
final List<Map<String, Object>> menu = [
  {
    'name': 'chicken',
    'price': 150.0,
  },
  {
    'name': 'water',
    'price': 25.0,
  },
  {
    'name': 'momo',
    'price': 100.0,
  },
  {
    'name': 'ice cream',
    'price': 30.0,
  },
  {
    'name': 'fruits',
    'price': 190.0,
  },
  {
    'name': 'coffee',
    'price': 100.0,
  },
  {
    'name': 'pakauda',
    'price': 10.0,
  },
  {'name': 'fried rice', 'price': 35.0},
  {
    'name': 'sel roti',
    'price': 20.0,
  }
];
