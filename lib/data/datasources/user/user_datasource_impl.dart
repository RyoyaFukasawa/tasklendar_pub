// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:tasklendar/config/constraints/utils.dart';
import 'package:tasklendar/core/enums/auth_provider.dart';
import 'package:tasklendar/core/extension/auth_provider_extensiton.dart';
import 'package:tasklendar/data/datasources/user/user_datasource.dart';
import 'package:tasklendar/data/models/user_model.dart';

class UserDataSourceImpl implements UserDataSource {
  UserDataSourceImpl();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Getter //
  CollectionReference<Map<String, dynamic>> get _userCollection =>
      _firestore.collection('users');

  @override
  Future<void> createUser({
    required String id,
    required String email,
    required String status,
    required AuthProvider authProvider,
  }) async {
    try {
      await _userCollection.doc(id).set({
        'id': id,
        'email': email,
        'status': status,
        'authProvider': authProvider.toAuthProviderString(),
        'createdAt': now,
        'updatedAt': now,
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel?> fetchUserById(String id) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> res =
          await _userCollection.doc(id).get();

      if (res.data() == null) {
        return null;
      }

      final UserModel userModel = UserModel.fromJson(res.data()!);

      return userModel;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateUser({
    required String id,
    required String email,
    required String status,
    required AuthProvider authProvider,
  }) async {
    try {
      _userCollection.doc(id).update({
        'email': email,
        'status': status,
        'authProvider': authProvider.toAuthProviderString(),
        'updatedAt': now,
      });
    } catch (e) {
      rethrow;
    }
  }
}
