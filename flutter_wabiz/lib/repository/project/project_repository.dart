import 'package:flutter_wadiz_riverpod/model/project/project_model.dart';
import 'package:flutter_wadiz_riverpod/model/project/reward_model.dart';
import 'package:flutter_wadiz_riverpod/service/project/project_api.dart';
import 'package:flutter_wadiz_riverpod/service/project/project_api_service.dart';
import 'package:flutter_wadiz_riverpod/shared/model/response_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'project_repository.g.dart';

class ProjectRepository {
  //서비스를 만들지 않았다면 해당 레포지토리에서 dio나 http 메서드 처리를 해주어야 한다.
  ProjectApiClient projectService;

  ProjectRepository(this.projectService);

  Future<ResponseModel?> createProject(ProjectItemModel body) async {
    final result = await projectService.createProject(body);
    return result;
  }

  Future<ResponseModel?> updateProjectOpenState(
      String id, ProjectItemModel body) async {
    final result = await projectService.updateProjectOpenState(id, body);
    return result;
  }

  Future<ResponseModel?> deleteProject(String id) async {
    final result = await projectService.deleteProject(id);
    return result;
  }

  Future<ResponseModel?> createProjectReward(
      String id, RewardItemModel body) async {
    final result = await projectService.createProjectReward(id, body);
    return result;
  }

  Future<ProjectModel> getProjectsByUserId(String userId) async {
    final result = await projectService.getProjectMyUserId(userId);
    return result;
  }

  Future<ProjectModel> getProjectByProjectId(String id) async {
    final result = await projectService.getProjectByProjectId(id);
    return result;
  }
}

@riverpod //@riverpod 어노테이션은 projectRepository 함수를 Riverpod의 Provider로 만들어준다.
//Provider는 의존성 주입을 쉽게 해주고, 상태를 관리할 수 있게 해준다.
ProjectRepository projectRepository(ProjectRepositoryRef ref) {
  //ref는 Provider의 레퍼런스로 다른 Provider를 참조하거나 관리할 수 있게 해준다.
  final service = ref.watch(projectApiServiceProvider);
  return ProjectRepository(service);
}
