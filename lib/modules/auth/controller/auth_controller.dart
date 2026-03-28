import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../core/router/router.dart';
import '../../../core/router/routers_name.dart';
import '../../../core/services/local_services/shared_perf.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../core/widgets/show_snackbar.dart';
import '../models/user_model.dart';

import '../../../core/services/remote_services/firebase_init.dart';
import '../../../core/utils/auth_exceptions.dart';

class AuthController extends ChangeNotifier {
  register(UserModel user) async {
    loadingWithText();
    try {
      UserCredential credential =
          await getIt<FirebaseService>().auth.createUserWithEmailAndPassword(
                email: user.email,
                password: user.password,
              );
      if (credential.user != null) {
        createUser(user);
        NavigationManager.goToAndRemove(RouteName.login);
      }
    } on FirebaseAuthException catch (e) {
      NavigationManager.pop();
      showSnackBarCustom(text: AuthException.handleRegisterException(e));
    } on FirebaseException catch (e) {
      NavigationManager.pop();
      showSnackBarCustom(text: e.code);
    } catch (e) {
      NavigationManager.pop();
      showSnackBarCustom(text: 'Something went wrong');
    }
  }

  login({
    required String email,
    required String password,
  }) async {
    loadingWithText();
    try {
      UserCredential credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        // this is for update the user password inside firestore database after change it form forget password screen
        await updateUser(email, password);
        SharedPrefController().isLoggedIn(value: true);
        NavigationManager.goToAndRemove(RouteName.mainAppView);
        showSnackBarCustom(
          text: 'تم تسجيل الدخول بنجاح',
          backgroundColor: Colors.green,
        );
      }
    } on FirebaseAuthException catch (e) {
      NavigationManager.pop();
      showSnackBarCustom(text: AuthException.handleLoginException(e));
    } on FirebaseException catch (e) {
      NavigationManager.pop();
      showSnackBarCustom(text: e.code);
    } catch (e) {
      NavigationManager.pop();
      showSnackBarCustom(text: 'Something went wrong');
    }
  }

  createUser(UserModel user) {
    try {
      getIt<FirebaseService>().firestore.collection('users').add(user.toJson());
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  updateUser(String email, String password) async {
    try {
      final id = await getIt<FirebaseService>()
          .firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get()
          .then((value) => value.docs.first.id);

      await getIt<FirebaseService>()
          .firestore
          .collection('users')
          .doc(id)
          .update({'password': password}).then(
              (value) => saveUser(email: email, password: password));
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  sendEmailResetPassword({required String email}) async {
    loadingWithText();
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      NavigationManager.pushNamed(RouteName.checkEmail);
      showSnackBarCustom(
        text: 'تم ارسال الرابط بنجاح',
        backgroundColor: Colors.green,
      );
    } on FirebaseAuthException catch (e) {
      NavigationManager.pop();
      showSnackBarCustom(text: AuthException.handleResetPasswordException(e));
    } on FirebaseException catch (e) {
      NavigationManager.pop();
      showSnackBarCustom(text: e.code);
    } catch (e) {
      NavigationManager.pop();
      showSnackBarCustom(text: 'Something went wrong');
    }
  }

  saveUser({required String email, required String password}) async {
    await getIt<FirebaseService>()
        .firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .get()
        .then(
          (value) => SharedPrefController()
              .save(UserModel.fromSnapshot(value.docs.first)),
        )
        .onError((error, stackTrace) => print(error))
        .catchError((e) => print(e));
  }
}
