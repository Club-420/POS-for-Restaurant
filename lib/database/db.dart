import 'package:cloud_firestore/cloud_firestore.dart';

class MenuDB {
  void addAllItems(List<Map<String, dynamic>> menuList) {
    final db = FirebaseFirestore.instance;

    for (final item in menuList) {
      db.collection('menu').add(item);
    }
  }
void addSingleItem(Map<String, dynamic> menuItem) {
    final db = FirebaseFirestore.instance;

    
      db.collection('menu').add(menuItem);

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
