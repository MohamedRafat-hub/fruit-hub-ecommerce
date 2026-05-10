import 'package:dartz/dartz.dart';
import 'package:fruit_hub/core/errors/failure.dart';
import 'package:fruit_hub/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
      {required String name, required String email, required String password});

  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<Either<Failure,UserEntity>> loginWithGoogle();

  Future<Either<Failure,UserEntity>> loginWithFacebook();

  Future<void> addUserData({required UserEntity user});

 Future<bool> checkIfDataExist({required String path , required String documentId});

  Future<UserEntity> getUserData({required String uid});

  Future<Either<Failure , void>>sendPasswordResetEmail({required String email});

  Future<Either<Failure , void>>signOut();
}
