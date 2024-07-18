import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_repository.g.dart';

@riverpod
MyRepositoryImpl myRepository(MyRepositoryRef ref) {
  return MyRepositoryImpl();
}

abstract class MyRepository {
  //프로젝트 가져오기
  Future getProjectsByUserId(String userId);

  //프로젝트가 목록에 있을 때 프로젝트 열고 닫기
  Future updateProjectOpenState(String id);

  //프로젝트 삭제
  Future deleteProject(String id);
}

class MyRepositoryImpl implements MyRepository {
  @override
  Future deleteProject(String id) {
    // TODO: implement deleteProject
    throw UnimplementedError();
  }

  @override
  Future getProjectsByUserId(String userId) {
    // TODO: implement getProjectsByUserId
    throw UnimplementedError();
  }

  @override
  Future updateProjectOpenState(String id) {
    // TODO: implement updateProjectOpenState
    throw UnimplementedError();
  }
}
