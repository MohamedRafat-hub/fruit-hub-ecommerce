import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'database_service.dart';

class FireStoreService implements DatabaseService {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  @override
  Future<void> addData(
      {required String path,
      required Map<String, dynamic> data,
      String? uid}) async {
    if (uid != null) {
      await fireStore.collection(path).doc(uid).set(data);
    } else {
      await fireStore.collection(path).add(data);
    }
  }

  @override
  Future<dynamic> getData(
      {required String path,
      String? documentId,
      Map<String, dynamic>? query}) async {
    if (documentId != null) {
      var data = await fireStore.collection(path).doc(documentId).get();
      return data.data(); // map<String , dynamic>
    } else {
      Query<Map<String, dynamic>> data = fireStore.collection(path);
      if (query != null) {
        if (query['orderBy'] != null) {
          var orderByField = query['orderBy']; // sellingCount
          var descending = query['descending'];

          data = data.orderBy(orderByField, descending: descending);
        }
        if (query['limit'] != null) {
          var limit = query['limit'];
          data = data.limit(limit);
        }
      }
      var result = await data.get();
      return result.docs.map((e) => e.data()).toList();
    }
  }

  @override
  Future<bool> checkIfDataExist(
      {required String path, required String documentId}) async {
    var data = await fireStore.collection(path).doc(documentId).get();
    return data.exists;
  }

  @override
  Future<void> updateData({required String path, required String documentId, required Map<String, dynamic> data})async {
    await fireStore.collection(path).doc(documentId).update(data);
  }

  @override
  Future<void> deleteData({required String path, required String documentId})async {
    await fireStore.collection(path).doc(documentId).delete();
  }

  @override
  Future<int> getNextOrderNumber({required String path, required String doc})async {
    final counterRef = FirebaseFirestore.instance
        .collection(path)
        .doc(doc);

    int newOrderNumber = 0;

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(counterRef);

      newOrderNumber = (snapshot.data()?['lastOrderNumber'] ?? 1000) + 1;

      transaction.set(counterRef, {'lastOrderNumber': newOrderNumber});
    });

    return newOrderNumber;
  }



}
