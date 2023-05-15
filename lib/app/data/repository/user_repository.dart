import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  UserRepository({
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore;

  final FirebaseFirestore _firebaseFirestore;

  CollectionReference get _collectionReference =>
      _firebaseFirestore.collection('users');

  Future<void> addUser({
    required String id,
    required String email,
    required createdAt,
    required updatedAt,
  }) async {
    try {
      await _collectionReference.doc(id).set({
        'id': id,
        'email': email,
        'created_at': createdAt,
        'updated_at': updatedAt,
      });
    } catch (e) {
      print('addUser failed: $e');
      rethrow;
    }
  }

  Future<void> updateUser({
    required String id,
    required String email,
    required createdAt,
    required updatedAt,
  }) async {
    try {
      await _collectionReference.doc(id).update({
        'id': id,
        'email': email,
        'created_at': createdAt,
        'updated_at': updatedAt,
      });
    } catch (e) {
      print('updateUser failed: $e');
      rethrow;
    }
  }

  Future<void> deleteUser({required String id}) async {
    try {
      await _collectionReference.doc(id).delete();
    } catch (e) {
      print('deleteUser failed: $e');
      rethrow;
    }
  }

  Future<DocumentSnapshot> getUser({required String id}) async {
    try {
      return await _collectionReference.doc(id).get();
    } catch (e) {
      print('getUser failed: $e');
      rethrow;
    }
  }
}
