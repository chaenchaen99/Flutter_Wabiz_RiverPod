import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'project_model.g.dart';
part 'project_model.freezed.dart';

//freezed: flutter 앱에서 사용될 모델 클래스를 정의하는 패키지
//json 직렬화, 역직렬화를 위해 json_serializable 패키지를 함께 사용한다.
@freezed
class ProjectModel with _$ProjectModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ProjectModel({
    @Default([])
    List<ProjectItemModel> projects, //기본값을 []로 설정하기 위해서, null이 되는 것을 방지
  }) = _ProjectModel;

  factory ProjectModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectModelFromJson(json);
}

@freezed
class ProjectItemModel with _$ProjectItemModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ProjectItemModel({
    int? id,
    int? categoryId,
    int? projectTypeId,
    String? projectClass,
    String? userId,
    String? title,
    String? owner,
    int? price,
    String? thumbnail,
    String? count,
    String? deadline,
    String? description,
    int? waitlistCount,
    int? totalFundedCount,
    int? totalFunded,
    String? isOpen,
    String? category,
    String? type,
    @Default([]) List<int> image,
    @Default([]) List<int> projectImage,
  }) = _ProjectItemModel;

  factory ProjectItemModel.fromJson(Map<String, Object?> json) =>
      _$ProjectItemModelFromJson(json);
}
