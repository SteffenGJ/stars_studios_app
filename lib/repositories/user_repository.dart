import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stars_studios/repositories/repository.dart';

class UserRepository implements Repository<Map<String, dynamic>> {
  final db = FirebaseFirestore.instance.collection("users");

  @override
  Future<Map<String, dynamic>> fetch(String user) async {
    Map<String, dynamic>? returnUser;
    await db.doc(user).get().then((event) {
      returnUser = event.data();
    });
    return returnUser ?? {};
  }

  @override
  Future<void> create(String id, Map<String, dynamic> data) async {
    await db.doc(id).set(data);
  }

  @override
  Future<void> update(String id, Map<String, dynamic> data) async {
    await db.doc(id).update(data);
  }

  @override
  Future<void> delete(Map<String, dynamic> data) async {
    //TODO: Implement
  }
}
