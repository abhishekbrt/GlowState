import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glowstate/features/auth/domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    String? displayName,
    String? photoUrl,
    required DateTime createdAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  const UserModel._();

  User toEntity() => User(
    id: id,
    email: email,
    displayName: displayName,
    photoUrl: photoUrl,
    createdAt: createdAt,
  );

  static UserModel fromEntity(User user) => UserModel(
    id: user.id,
    email: user.email,
    displayName: user.displayName,
    photoUrl: user.photoUrl,
    createdAt: user.createdAt,
  );
}
