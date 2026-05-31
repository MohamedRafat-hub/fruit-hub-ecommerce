import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fruit_hub/core/errors/exceptions.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  Future<void> deleteUser() async {
    await FirebaseAuth.instance.currentUser?.delete();
  }

  Future<User> createUserWithEmailAndPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw CustomExceptions('الرقم السري ضعيف جدا.');
      } else if (e.code == 'email-already-in-use') {
        throw CustomExceptions('هذا البريد الإلكتروني مستخدم بالفعل.');
      } else if (e.code == 'network-request-failed') {
        throw CustomExceptions('تأكد من اتصالك بالإنترنت وحاول مرة أخرى.');
      } else {
        throw CustomExceptions('لم يتم إنشاء الحساب. يرجى المحاولة مرة أخرى.');
      }
    } catch (e) {
      throw CustomExceptions('لم يتم إنشاء الحساب. يرجى المحاولة مرة أخرى.');
    }
  }

  Future<User> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log('???????????????????????????login error ${e.code}');
      if (e.code == 'user-not-found') {
        throw CustomExceptions('البريد الإلكتروني غير موجود.');
      } else if (e.code == 'wrong-password') {
        throw CustomExceptions('الرقم السري غير صحيح.');
      } else if (e.code == 'network-request-failed') {
        throw CustomExceptions('تأكد من اتصالك بالإنترنت وحاول مرة أخرى.');
      } else {
        throw CustomExceptions(
            'لم يتم تسجيل الدخول. برجاء التأكد من صحة البريد الالكتروني والرقم السري');
      }
    } catch (e) {
      log('????????? login catch ${e.toString()}');
      throw CustomExceptions('لم يتم تسجيل الدخول. يرجى المحاولة مرة أخرى.');
    }
  }

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn().signIn(); // Trigger the authentication flow

    if(googleUser == null) {
      // The user canceled the sign-in
      return null;
    }
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return (await (FirebaseAuth.instance.signInWithCredential(credential)))
        .user!;
  }

  Future<User?> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token

    if(loginResult.status == LoginStatus.cancelled)
      {
        // The user canceled the sign-in
        return null;
      }

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    // Once signed in, return the UserCredential
    return (await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential))
        .user!;
  }

  bool isLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

  Future<void> sendPasswordResetEmail({required String email}) {
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }

  Future<void> reAuthenticate(
      {required String email, required String password}) async {
    try {
      final credential =
          EmailAuthProvider.credential(email: email, password: password);
      await FirebaseAuth.instance.currentUser!
          .reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        throw CustomExceptions('كلمة المرور الحالية غير صحيحة.');
      } else if (e.code == 'network-request-failed') {
        throw CustomExceptions('تأكد من اتصالك بالإنترنت وحاول مرة أخرى.');
      } else {
        throw CustomExceptions('حدث خطأ، يرجى المحاولة مرة أخرى.');
      }
    }
  }


  Future<void>updatePassword({required String newPassword})async{
    try {
      FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw CustomExceptions('كلمة المرور الجديدة ضعيفة جداً.');
      } else if (e.code == 'network-request-failed') {
        throw CustomExceptions('تأكد من اتصالك بالإنترنت وحاول مرة أخرى.');
      } else {
        throw CustomExceptions('حدث خطأ، يرجى المحاولة مرة أخرى.');
      }
    }
  }
}
