import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezed_user_model.g.dart';
part 'freezed_user_model.freezed.dart';

//freezed에서는 데이터모델에 필요한 util들이 생성됨

@freezed
class FreezedUserModel with _$FreezedUserModel {
  const factory FreezedUserModel({
    int? id,
    String? name,
    String? username,
    String? email,
    Address? address,
  }) = _FreezedUserModel;

  factory FreezedUserModel.fromJson(Map<String, dynamic> json) =>
      _$FreezedUserModelFromJson(json);
}

@freezed
class Address with _$Address {
  const factory Address({
    String? street,
    String? zipcode,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}
