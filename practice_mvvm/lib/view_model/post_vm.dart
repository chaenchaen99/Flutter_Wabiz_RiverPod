import 'package:dio/dio.dart';
import 'package:practice_mvvm/model/post_model.dart';
import 'package:practice_mvvm/service/post_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_vm.g.dart';
//1.

final postViewModelProvider = Provider((ref) {
  final service = ref.read(postServiceProvider);
  return PostViewModel(service);
});

class PostViewModel {
  PostServiceImpl? postServiceImpl;

  PostViewModel(this.postServiceImpl);

  Future<List<PostModel>?> getPosts() async {
    try {
      final posts = await postServiceImpl?.getPosts();
      return posts;
    } on DioException catch (e) {
      print(e.toString());
    }
    return null;
  }
}

//2.

final asyncPostNotifier =
    AsyncNotifierProvider<AsyncPostNotifier, List<PostModel>>(
        AsyncPostNotifier.new);

class AsyncPostNotifier extends AsyncNotifier<List<PostModel>> {
  //StateNotifier와 다른점 : AsyncNotifier는 build에서도 ref를 읽어올 수 있다.
  @override
  Future<List<PostModel>> build() async {
    final dio = ref.read(dioProvider);
    final response =
        await dio.get("https://jsonplaceholder.typicode.com/posts");
    if (response.statusCode == 200) {
      List<dynamic> jsonList = response.data;
      List<PostModel> posts =
          jsonList.map((json) => PostModel.fromJson(json)).toList();
      return posts;
    } else {
      return [];
    }
  }
}

//3.

final fetchPostsProvider = FutureProvider.autoDispose((ref) async {
  return ref.watch(postViewModelProvider).getPosts();
});

final fetchPostsProvider2 = FutureProvider.autoDispose((ref) async {
  @override
  Future<List<PostModel>> build() async {
    final dio = ref.read(dioProvider);
    final response =
        await dio.get("https://jsonplaceholder.typicode.com/posts");
    if (response.statusCode == 200) {
      List<dynamic> jsonList = response.data;
      List<PostModel> posts =
          jsonList.map((json) => PostModel.fromJson(json)).toList();
      return posts;
    } else {
      return [];
    }
  }
});

//4.
@riverpod
class AsyncPostsGenNotifier extends _$AsyncPostsGenNotifier {
  _fetchPosts() async {
    final dio = Dio();
    final response =
        await dio.get("https://jsonplaceholder.typicode.com/posts");
    if (response.statusCode == 200) {
      List<dynamic> jsonList = response.data;
      List<PostModel> posts =
          jsonList.map((json) => PostModel.fromJson(json)).toList();
      return posts;
    } else {
      return [];
    }
  }

  @override
  Future<List<PostModel>> build() async {
    return await _fetchPosts();
  }
}
