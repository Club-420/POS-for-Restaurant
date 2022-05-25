import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pos/auth/firebase_auth_provider.dart';

Map<String, dynamic> tableModel = {
  'index': 0,
  'name': '',
  'isOccupied': false,
  'foods': [{}],
};

class TableDB {
  Future<void> updateSingleTable(
      {required int index, required Map<String, dynamic> tableData}) async {
    final db = FirebaseFirestore.instance;
    await db.collection('tables').doc('table $index').set(tableData);
  }

  Future<void> addSingleItem(
      {required int index, required String foodName, required int no}) async {
    final db = FirebaseFirestore.instance;

    Map<String, dynamic> foods = await getSingleTable(index: index);
    // foods['foods']['name'] = foodName;
    // foods['foods']['noOfItems'] = foodName;

    await db
        .collection('tables')
        .doc('table $index')
        .update({'foods': foods['foods']});
  }

  void updateStatusOfTable({required int index, required bool status}) {
    final db = FirebaseFirestore.instance;
    db.collection('tables').doc('table $index').update({'isOccupied': status});
  }

  Future<void> cleanSingleTable({required int index}) async {
    await updateSingleTable(index: index, tableData: {
      'index': index,
      'name': '',
      'isOccupied': false,
      'foods': [{}],
    });
  }

  Future<Map<String, dynamic>> getSingleTable({required int index}) async {
    final db = FirebaseFirestore.instance;
    Map<String, dynamic>? singleTable;
    await db.collection('tables').doc('table $index').get().then((event) {
      singleTable = event.data();
    });

    return singleTable!;
  }

  void addAllTables() {
    final db = FirebaseFirestore.instance;

    //for now we have twenty tables
    for (int i = 0; i < 20; i++) {
      tableModel['index'] = i;
      db.collection('tables').doc('table $i').set({
        'index': i,
        'name': '',
        'isOccupied': false,
        'foods': [{}],
      });
    }
  }

  Future<List<Map<String, dynamic>>> getAllTables() async {
    final db = FirebaseFirestore.instance;
    final List<Map<String, dynamic>> tempList = [];
    await db.collection('tables').get().then((data) {
      for (final doc in data.docs) {
        tempList.add(doc.data());
      }
    });
    return tempList;
  }

  //to update name in database
  Future<void> updateCustomerName(
      {required int index, required String customerName}) async {
    final db = FirebaseFirestore.instance;
    db
        .collection('tables')
        .doc('table $index')
        .update({'name': customerName, 'isOccupied': true});
  }
}

//Menu database
class MenuDB {
  void addAllItems(List<Map<String, dynamic>> menuList) {
    final db = FirebaseFirestore.instance;

    for (final item in menuList) {
      db.collection('menu').add(item);
    }
  }

  void addSingleItem(Map<String, dynamic> menuItem) {
    final db = FirebaseFirestore.instance;
    String docName = menuItem['name'];
    db.collection('menu').doc(docName).set(menuItem);
  }

  void deleteSingleItem({required String name}) {
    final db = FirebaseFirestore.instance;
    db.collection('menu').doc(name).delete();
  }

  void updateSingleItem(
      {required String oldName, required Map<String, dynamic> updatedFood}) {
    deleteSingleItem(name: oldName);
    addSingleItem(updatedFood);
  }

  Future<List<Map<String, dynamic>>> getAllItems() async {
    final db = FirebaseFirestore.instance;
    final List<Map<String, dynamic>> tempList = [];
    await db.collection('menu').get().then((data) {
      for (final doc in data.docs) {
        tempList.add(doc.data());
      }
    });
    return tempList;
  }
}
