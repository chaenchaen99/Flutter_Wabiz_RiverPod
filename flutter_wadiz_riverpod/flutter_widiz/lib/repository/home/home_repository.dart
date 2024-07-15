import 'package:flutter_wadiz_riverpod/model/home/home_model.dart';
import 'package:flutter_wadiz_riverpod/service/home/home_api.dart';
import 'package:flutter_wadiz_riverpod/service/home/home_api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_repository.g.dart';

class HomeRepository {
  HomeApi homeApiService;

  HomeRepository(this.homeApiService);

  Future<HomeModel> getHomeProjects() async {
    final result = await homeApiService.getHomeProjects();
    return result;
  }
}

@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) {
  //service를 homerepository에서 주입할 수 있다.
  final service = ref.watch(homeApiServiceProvider);
  return HomeRepository(service);
}
