import 'package:flutter_wadiz_riverpod/repository/my/my_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_view_model.g.dart';
part 'my_view_model.freezed.dart';

@freezed
class MyPageState with _$MyPageState {
  factory MyPageState({bool? loginState}) = _MyPageState;
}

@riverpod
class MyPageViewModel extends _$MyPageViewModel {
  @override
  MyPageState build() {
    return MyPageState(loginState: false);
  }

  fetchUserProjects() async {}

  updateProject(String id) async {
    await ref.watch(myRepositoryProvider).updateProjectOpenState(id);
  }

  deleteProject(String id) async {
    await ref.watch(myRepositoryProvider).deleteProject(id);
  }
}
