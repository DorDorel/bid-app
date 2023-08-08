import 'dart:developer';

import 'package:bid/data/models/user.dart';
import 'package:bid/data/networking/user_data_db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class AuthenticationRepository {
  Stream<User?> get authStateChanges;
  User? get getCurrentUser;
  Future<bool> signIn({required String email, required String password});
  Future signOut();
  Future<String> createUser({required CustomUser user});
  Future<void> sendResetPasswordMail({required String email});
  Future<void> blockUser({required String email});
}

@immutable
class AuthenticationRepositoryImpl with AuthenticationRepository {
  static String get getCurrentUserUID => FirebaseAuth.instance.currentUser!.uid;

  static String? get getCurrentUserName =>
      FirebaseAuth.instance.currentUser!.displayName;

  @override
  Stream<User?> get authStateChanges =>
      FirebaseAuth.instance.authStateChanges();

  @override
  User? get getCurrentUser => FirebaseAuth.instance.currentUser;

  @override
  Future<bool> signIn({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (exp) {
      print(exp.message);
      return false;
    }
  }

  @override
  Future signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await FirebaseFirestore.instance.terminate();
      await FirebaseFirestore.instance.clearPersistence();

      log('sign out');
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Future<String> createUser({
    required CustomUser user,
  }) async {
    try {
      final newUser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: user.email, password: user.password);
      final userId = newUser.user!.uid;
      user.uid = userId;
      await UserDataService().addUserToUserCollection(
        user: user,
      );
      await UserDataService()
          .addUserToCompanyUserList(cid: user.tenantId, user: user);

      return userId;
    } on FirebaseAuthException catch (exp) {
      print(exp.toString());
      return '';
    }
  }

  @override
  Future<void> sendResetPasswordMail({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
    } on FirebaseAuthException catch (exp) {
      print(
        exp.toString(),
      );
    }
  }

  @override
  Future<void> blockUser({
    required String email,
  }) async {
    //await _firebaseAuth.
  }
}
