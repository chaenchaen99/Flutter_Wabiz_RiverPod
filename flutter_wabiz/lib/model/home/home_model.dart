import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'home_model.g.dart';
part 'home_model.freezed.dart';

//freezed: flutter 앱에서 사용될 모델 클래스를 정의하는 패키지
//json 직렬화, 역직렬화를 위해 json_serializable 패키지를 함께 사용한다.
@freezed
class HomeModel with _$HomeModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory HomeModel({
    String? status,
    int? totalCount,
    @Default([])
    List<HomeItemModel> projects, //기본값을 []로 설정하기 위해서, null이 되는 것을 방지
  }) = _HomeModel;

  factory HomeModel.fromJson(Map<String, dynamic> json) =>
      _$HomeModelFromJson(json);
}

@freezed
class HomeItemModel with _$HomeItemModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory HomeItemModel({
    int? id,
    int? categoryId,
    int? projectTypeId,
    String? userId,
    String? title,
    String? owner,
    int? price,
    String? thumbnail,
    String? deadline,
    String? description,
    int? waitlistCount,
    int? totalFundedCount,
    int? totalFunded,
    String? isOpen,
    String? category,
    String? type,
  }) = _HomeItemModel;

  factory HomeItemModel.fromJson(Map<String, Object?> json) =>
      _$HomeItemModelFromJson(json);
}
