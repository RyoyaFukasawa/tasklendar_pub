// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Project imports:
import 'package:tasklendar/core/enums/auth_provider.dart';
import 'package:tasklendar/core/extension/string_extension.dart';
import 'package:tasklendar/core/logs/log.dart';
import 'package:tasklendar/data/datasources/auth/auth_datasource.dart';
import 'package:tasklendar/data/datasources/user/user_datasource.dart';
import 'package:tasklendar/data/models/user_model.dart';
import 'package:tasklendar/domain/entities/user_entity.dart';
import 'package:tasklendar/domain/factory/user_factory.dart';
import 'package:tasklendar/domain/repository/auth_repository.dart';
import 'package:tasklendar/presentation/notifier/view_models/auth/sign_in_notifier.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthDataSource authDataSource,
    required UserDataSource userDataSource,
    required UserFactory userFactory,
  })  : _authDataSource = authDataSource,
        _userDataSource = userDataSource,
        _userFactory = userFactory;

  final AuthDataSource _authDataSource;
  final UserDataSource _userDataSource;
  final UserFactory _userFactory;

  @override
  Future<UserEntity?> fetchUser() async {
    try {
      final User? firebaseUser = await _authDataSource.fetchAuthUser();

      if (firebaseUser == null) {
        return null;
      }

      UserModel? userModel =
          await _userDataSource.fetchUserById(firebaseUser.uid);

      if (userModel == null) {
        await _userDataSource.createUser(
          id: firebaseUser.uid,
          email: '',
          status: 'guest',
          authProvider: AuthProvider.anonymous,
        );

        userModel = await _userDataSource.fetchUserById(firebaseUser.uid);
      }

      if (userModel == null) {
        return null;
      }

      final UserEntity user = await _userFactory.createUser(
        id: userModel.id,
        email: userModel.email,
        status: userModel.status,
        authProvider: userModel.authProvider.toAuthProvider(),
      );

      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> signInAnonymously() async {
    try {
      await _authDataSource.signInAnonymously();

      final UserEntity? user = await fetchUser();

      if (user == null) {
        throw Exception('User not found');
      }

      await _userDataSource.createUser(
        id: user.id,
        email: user.email,
        status: user.status,
        authProvider: user.authProvider,
      );

      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> mergeAnonymousAccount({
    required String email,
    required String password,
  }) async {
    try {
      final User? firebaseUser = await _authDataSource.fetchAuthUser();

      final AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );

      final UserCredential userCredential =
          await firebaseUser!.linkWithCredential(credential);

      return UserEntity(
        id: userCredential.user!.uid,
        email: userCredential.user!.email!,
        status: 'member',
        authProvider: AuthProvider.email,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> mergeAnonymousAccountWithGoogle() async {
    try {
      final User? firebaseUser = await _authDataSource.fetchAuthUser();

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // 新しいクレデンシャルを作成する
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final UserCredential userCredential =
          await firebaseUser!.linkWithCredential(credential);

      return UserEntity(
        id: userCredential.user!.uid,
        email: userCredential.user!.email!,
        status: 'member',
        authProvider: AuthProvider.google,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _authDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? firebaseUser = await _authDataSource.fetchAuthUser();

      if (firebaseUser == null) {
        throw Exception('User not found');
      }

      final UserModel? userModel =
          await _userDataSource.fetchUserById(firebaseUser.uid);

      if (userModel == null) {
        throw Exception('User not found');
      }

      return UserEntity(
        id: userModel.id,
        email: userModel.email,
        status: userModel.status,
        authProvider: AuthProvider.email,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    try {
      final User? firebaseUser = await _authDataSource.fetchAuthUser();

      await firebaseUser!.sendEmailVerification();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserEntity?> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // 新しいクレデンシャルを作成する
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final GoogleSignInAccount? user = await GoogleSignIn().signInSilently();
      final String? email = user?.email;

      final bool isUserExist =
          await _userDataSource.fetchUserByEmail(email!) != null;

      if (!isUserExist) {
        return null;
      }

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final User? firebaseUser = userCredential.user;

      if (firebaseUser == null) {
        return null;
      }

      final UserModel? userModel =
          await _userDataSource.fetchUserById(firebaseUser.uid);

      if (userModel == null) {
        return null;
      }

      return UserEntity(
        id: userModel.id,
        email: userModel.email,
        status: userModel.status,
        authProvider: AuthProvider.google,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> updateEmail({
    required String oldEmail,
    required String newEmail,
    required String password,
  }) async {
    try {
      final UserCredential credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: oldEmail,
        password: password,
      );

      //TODO
      // google sign inの場合は、credentialでエラーになる。
      // userEnityにどのproviderで会員登録しているかを登録しておく必要がある。
      // google sign in の場合はupdateEmailは実行しないようにする。

      await credential.user!.updateEmail(newEmail);

      return true;
    } catch (e) {
      Log.error(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _authDataSource.signOut();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteAccount({
    AuthCredential? credential,
  }) async {
    try {
      if (credential != null) {
        await _authDataSource.reAuthenticate(credential: credential);
      }

      final User? firebaseUser = await _authDataSource.fetchAuthUser();

      await _userDataSource.deleteUser(
        firebaseUser!.uid,
      );
      await _authDataSource.deleteAccount();
    } catch (e) {
      rethrow;
    }
  }
}
