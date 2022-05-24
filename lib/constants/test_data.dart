final notifications = ['Notifications'];
const noOfTables = 20;
List<String> Categories = [
  'Veg','Non-Veg','Drinks'
];
 String dropdownvalue = 'Veg';
List tables = [];
MenuSchema menu = MenuSchema();

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

  double getitemPrice({required String foodName}) {
    int index = contains(foodName);
    return menuItem[index]['price'] as double;
  }

  double getItemTotalPrice({required String foodName}) {
    double price = getitemPrice(foodName: foodName);
    double sum = price * howMuch(foodName);
    return sum;
  }

  double get getTotalPrice {
    double sum = 0.0;

    if (foods.isEmpty) {
      return sum;
    }

    for (final i in foods) {
      for (final j in menuItem) {
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

class MenuSchema {
  //this is temporary initialization
  final List<Map<String, Object>> menu = menuItem;
  List<String> category = [];

  @override
  String toString() {
    return '$menu';
  }

  void allCategory() {
    for (final item in menu) {
      if (!category.contains(item['category'] as String)) {
        category.add(item['category'] as String);
      }
    }
  }

  void addList(List<Map<String, Object>> menuList) {
    for (final item in menuList) {
      menu.add(item);
    }
  }

  void updateByIndex({required index, name = '', price = 0.0}) {
    if (name == null || name == '') {
    } else {
      menu[index]['name'] = name;
    }
    if (price > 0.0) {
      menu[index]['price'] = price;
    }
    return;
  }

  void clean() {
    menu.clear();
  }

  void updateByMap({required index, required Map<String, Object> map}) {
    updateByIndex(index: index, name: map['name'], price: map['price']);
  }
}

//now fill our tables with schema
final List<Map<String, Object>> menuItem = [
  {
    'name': 'Chicken',
    'price': 150.0,
    'category': 'non-veg',
  },
  {
    'name': 'Chicken MoMo',
    'price': 150.0,
    'category': 'non-veg',
  },
  {
    'name': 'Chicken Chewmin',
    'price': 150.0,
    'category': 'non-veg',
  },
  {
    'name': 'Chicken Thukpa',
    'price': 150.0,
    'category': 'non-veg',
  },
  {
    'name': 'Water',
    'category': 'Drinks',
    'price': 25.0,
  },
  {
    'name': 'aloo ko bhujiya tarkari ko jhol ra masu',
    'category': 'non-veg',
    'price': 100.0,
  },
  {
    'name': 'ice cream',
    'category': 'veg',
    'price': 30.0,
  },
  {
    'name': 'fruits',
    'category': 'veg',
    'price': 190.0,
  },
  {
    'name': 'coffee',
    'category': 'veg',
    'price': 100.0,
  },
  {
    'name': 'pakauda',
    'category': 'veg',
    'price': 10.0,
  },
  {
    'name': 'fried rice',
    'price': 35.0,
    'category': 'veg',
  },
  {
    'name': 'sel roti',
    'price': 20.0,
    'category': 'veg',
  }
];
