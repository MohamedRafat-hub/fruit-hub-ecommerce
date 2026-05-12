import 'package:fruit_hub/features/auth/domain/entities/user_entity.dart';

abstract class DatabaseService {
  Future<void> addData(
      {required String path,
      required Map<String, dynamic> data,
      String? uid}); // General method

  Future<dynamic> getData(
      {required String path, String? documentId, Map<String, dynamic>? query});

  Future<bool> checkIfDataExist(
      {required String path, required String documentId});

  Future<void> upfateData(
      {required String path,
      required String documentId,
      required Map<String, dynamic> data});
}
