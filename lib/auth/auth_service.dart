import 'package:bid/db/database.dart';
import 'package:bid/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  Future<User?> get getCurrentUser async => _firebaseAuth.currentUser;
  Future<String> get getCurrentUserUID async => _firebaseAuth.currentUser!.uid;
  Future<String?> get getCurrentUserName async =>
      _firebaseAuth.currentUser!.displayName;

  Future<String?> getCurrentUserTenantId() async {
    print(_firebaseAuth.currentUser!.tenantId);
    return _firebaseAuth.currentUser!.tenantId;
  }

  Future<bool> signIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (err) {
      print(err.message);
      return false;
    }
  }

  Future signOut() async {
    try {
      await _firebaseAuth.signOut();
      print('sign out');
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> createUser({required CustomUser user}) async {
    final newUser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email, password: user.password);
    final userId = newUser.user!.uid;
    user.uid = userId;

    await DatabaseService().addUserToUserCollection(user: user);
    await DatabaseService()
        .addUserToCompanyUserList(cid: user.tenantId, user: user);

    return userId;
  }

  static Future<void> sendResetPasswordMail({required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  static Future<void> blockUser({required String email}) async {
    //await _firebaseAuth.
  }
}
