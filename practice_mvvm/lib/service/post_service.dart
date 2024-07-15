//방법 3 가지 존재
//service --> repository --> view model
//service --> view model *해당 클래스는 이 방법으로 구현*
//repository --> view model

import 'package:dio/dio.dart';
import 'package:practice_mvvm/model/post_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// final postRepositoryProvider = Provider((ref) {
//   return PostRepositoryImpl(ref.read(postServiceProvider));
// });

// service --> repository
final postServiceProvider = Provider((ref) {
  final dio = ref.read(dioProvider);
  return PostServiceImpl(dio);
}); //이렇게 하면 어디서든 ref를 통해 PostService에 접근할 수있음

final dioProvider = Provider((ref) {
  return Dio();
});

// abstract class PostRepository {
//   Future<List<PostModel>?> getPosts();
// }

// class PostRepositoryImpl extends PostRepository {
//   PostServiceImpl postServiceImpl;

//   PostRepositoryImpl(this.postServiceImpl);

//   @override
//   Future<List<PostModel>?> getPosts() async {
//     return await postServiceImpl.getPosts();
//   }
// }

abstract class PostService {
  Future<List<PostModel>?> getPosts();
}

class PostServiceImpl extends PostService {
  Dio dio;

  PostServiceImpl(this.dio);

  @override
  Future<List<PostModel>?> getPosts() async {
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
