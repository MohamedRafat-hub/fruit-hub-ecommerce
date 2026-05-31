import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruit_hub/core/errors/exceptions.dart';
import 'package:fruit_hub/core/errors/failure.dart';
import 'package:fruit_hub/core/helper_functions/handle_auth_exception.dart';
import 'package:fruit_hub/core/services/database_service.dart';
import 'package:fruit_hub/core/services/firebase_auth_service.dart';
import 'package:fruit_hub/core/utils/backend_endpoint.dart';
import 'package:fruit_hub/features/auth/data/models/user_model.dart';
import 'package:fruit_hub/features/auth/domain/entities/user_entity.dart';
import 'package:fruit_hub/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  final DatabaseService databaseService;

  AuthRepoImpl(
      {required this.firebaseAuthService, required this.databaseService});

  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
      {required String name,
      required String email,
      required String password}) async {
    User? user;
    try {
      log('name is $name');
      user = await firebaseAuthService.createUserWithEmailAndPassword(
          name: name, email: email, password: password);
      UserEntity userEntity = UserModel.fromUserFirebase(user);
      userEntity.name = name;
      await addUserData(user: userEntity);
      return right(userEntity);
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.errorMessage));
    } catch (e) {
      if (user != null) {
        await firebaseAuthService.deleteUser();
      }
      return left(ServerFailure(
          'An unknown error occurred. , Please try again later.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      User user = await firebaseAuthService.signInWithEmailAndPassword(
          email: email, password: password);

      UserEntity userEntity = await getUserData(uid: user.uid);
      log('name is ${userEntity.name}');
      return right(userEntity);
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.toString()));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loginWithGoogle() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithGoogle();
      if(user == null)
        {
          return left(ServerFailure('Google sign-in was cancelled by the user.'));
        }
      bool exist = await checkIfDataExist(
          path: BackendEndpoint.getUserData, documentId: user.uid);
      late UserEntity userEntity;
      if (exist) {
        userEntity = await getUserData(uid: user.uid);
      } else {
        userEntity =  UserModel.fromUserFirebase(user);
        await addUserData(user: userEntity);
      }
      log(user.displayName!);

      return right(userEntity);
    } on Exception catch (e) {
      if (user != null) {
        await firebaseAuthService.deleteUser();
      }
      log('google login error ${e.toString()}}');
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loginWithFacebook() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithFacebook();
      if(user == null)
      {
        return left(ServerFailure('Facebook sign-in was cancelled by the user.'));
      }
      bool exist = await checkIfDataExist(
          path: BackendEndpoint.getUserData, documentId: user.uid);
      late UserEntity userEntity;
      if(exist)
        {
          userEntity = await getUserData(uid: user.uid);
        }
      else
        {
          userEntity = UserModel.fromUserFirebase(user);
          addUserData(user: userEntity);
        }
      return right(userEntity);
    } on Exception catch (e) {
      if (user != null) {
        await firebaseAuthService.deleteUser();
      }
      log('facebook login error ${e.toString()}');
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<void> addUserData({required UserEntity user}) async {
    await databaseService.addData(
        path: BackendEndpoint.addUserData, data: UserModel.fromUserEntity(user).toMap(), uid: user.uid);
  }

  @override
  Future<UserEntity> getUserData({required String uid}) async {
    Map<String, dynamic> userData = await databaseService.getData(
        path: BackendEndpoint.getUserData, documentId: uid);

    return UserModel.fromJson(userData);
  }

  @override
  Future<bool> checkIfDataExist(
      {required String path, required String documentId}) {
    return databaseService.checkIfDataExist(path: path, documentId: documentId);
  }

  @override
  Future<Either<Failure, void>> sendPasswordResetEmail({required String email})async {
    try {
      await firebaseAuthService.sendPasswordResetEmail(email: email.trim());
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(ServerFailure(handleAuthException(e)));
    }
  }

  @override
  Future<Either<Failure, void>> signOut()async {
    try {
      await firebaseAuthService.signOut();
      return right(null);
    }catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateUserProfileImage({
    required String uid,
    required String imageUrl,
  }) async {
    try {
      await databaseService.updateData(
        path: BackendEndpoint.getUserData,
        documentId: uid,
        data: {'profileImage': imageUrl},
      );
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updatePassword({required String password, required String newPassword})async {
    try {
      final  email = FirebaseAuth.instance.currentUser!.email!;
      await firebaseAuthService.reAuthenticate(email: email, password: password);
      await firebaseAuthService.updatePassword(newPassword: newPassword);
      return right(null);
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.errorMessage));
    }catch(e){
      return left(ServerFailure('حدث خطأ غير معروف، يرجى المحاولة مرة أخرى لاحقاً.'));
    }
  }
}
