import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruit_hub/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.name, required super.email, required super.uid , super.profileImage});

  factory UserModel.fromUserFirebase(User user) {
    return UserModel(
        name: user.displayName ?? '', email: user.email ?? '', uid: user.uid);
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        name: json['name'], email: json['email'], uid: json['uid'],
      profileImage: json['profileImage'],
    );
  }

  factory UserModel.fromUserEntity(UserEntity user) {
    return UserModel(name: user.name, email: user.email, uid: user.uid);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
      'profileImage':profileImage,
    };
  }
}
