// Project imports:
import 'package:tasklendar/core/enums/user_status.dart';

class UserModel {
  UserModel({
    required this.id,
    required this.email,
    required this.status,
    required this.authProvider,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String email;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String status;
  final String authProvider;

  // factory UserModel.fromUser(User user, UserStatus status) => UserModel(
  //       id: user.uid,
  //       email: user.email!,
  //       createdAt: DateTime.now(),
  //       updatedAt: DateTime.now(),
  //       status: userStatus(status),
  //     );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        email: json['email'],
        status: json['status'],
        authProvider: json['authProvider'],
        createdAt: DateTime.parse(json["createdAt"].toDate().toString()),
        updatedAt: DateTime.parse(json["updatedAt"].toDate().toString()),
      );

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, createdAt: $createdAt, updatedAt: $updatedAt,)';
  }

  static String userStatus(UserStatus status) {
    switch (status) {
      case UserStatus.guest:
        return 'guest';
      case UserStatus.member:
        return 'member';
      case UserStatus.subscribed:
        return 'subscribed';
      default:
        return 'guest';
    }
  }
}
