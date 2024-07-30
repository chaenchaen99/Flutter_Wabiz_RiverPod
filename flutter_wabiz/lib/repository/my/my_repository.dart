import 'package:flutter_wadiz_riverpod/model/project/project_model.dart';
import 'package:flutter_wadiz_riverpod/service/project/project_api.dart';
import 'package:flutter_wadiz_riverpod/service/project/project_api_service.dart';
import 'package:flutter_wadiz_riverpod/shared/model/response_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_repository.g.dart';

@riverpod
MyRepositoryImpl myRepository(MyRepositoryRef ref) {
  final projectService = ref.watch(projectApiServiceProvider);
  return MyRepositoryImpl(projectService);
}

abstract class MyRepository {
  //프로젝트 가져오기
  Future getProjectsByUserId(String userId);

  //프로젝트가 목록에 있을 때 프로젝트 열고 닫기
  Future updateProjectOpenState(String id, ProjectItemModel body);

  //프로젝트 삭제
  Future deleteProject(String id);
}

class MyRepositoryImpl implements MyRepository {
  ProjectApiClient projectService;

  MyRepositoryImpl(this.projectService);

  @override
  Future<ResponseModel> deleteProject(String id) async {
    final result = await projectService.deleteProject(id);
    return result;
  }

  @override
  Future getProjectsByUserId(String userId) async {
    final result = await projectService.getProjectByProjectId(userId);
    return result;
  }

  @override
  Future<ResponseModel> updateProjectOpenState(
      String id, ProjectItemModel body) async {
    final result = await projectService.updateProjectOpenState(id, body);
    return result;
  }
}
