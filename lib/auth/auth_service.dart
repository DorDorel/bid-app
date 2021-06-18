import 'package:bid/db/database.dart';
import 'package:bid/models/user.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  Future<User?> get getCurrentUser async => _firebaseAuth.currentUser;
  Future<String> get getCurrentUserUID async => _firebaseAuth.currentUser!.uid;

  Future<String?> getCurrentUserTenantId() async {
    print(_firebaseAuth.currentUser!.tenantId);
    return _firebaseAuth.currentUser!.tenantId;
  }

  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return 'Signed In';
    } on FirebaseAuthException catch (e) {
      return e.message;
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
    // HttpsCallable setNewUserTenantId =
    //     FirebaseFunctions.instance.httpsCallable('setNewUserTenantId');
    // await setNewUserTenantId(user.toMap()).then((value) => print(value));
    await DatabaseSevice().addUserToUserCollection(user);
    await DatabaseSevice().addUserToCompanyUserList(user.tenantId, user);

    return userId;
  }

  // Future<bool> tenantIdValidation() async {
  //   // await DatabaseSevice().findUserinCompaniyCollectionbyUid(getCurrentUserUID, tenantId)
  //   final uid = await getCurrentUserUID;
  //   DatabaseSevice().getTenanetIdByUid(uid);
  //   return false;
  // }
}
