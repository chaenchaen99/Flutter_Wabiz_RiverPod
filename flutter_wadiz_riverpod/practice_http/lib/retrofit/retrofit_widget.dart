import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:practice_http/retrofit/post_api.dart';

class RetrofitWidget extends StatefulWidget {
  const RetrofitWidget({super.key});

  @override
  State<RetrofitWidget> createState() => _RetrofitWidgetState();
}

class _RetrofitWidgetState extends State<RetrofitWidget> {
  Dio dio = Dio();
  late PostApi postApi;
  String responseText = "";

  @override
  void initState() {
    super.initState();
    postApi = PostApi(dio);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            postApi.getPosts().then((value) {
              setState(() {
                responseText = value.data.toString();
              });
            });
          },
          child: const Text("retrofit get"),
        ),
        ElevatedButton(
          onPressed: () {
            postApi.postPosts({
              'title': "foo",
              'body': "bar",
              "userId": 1,
            }).then((value) {
              setState(() {
                print(value.response.statusCode);
                responseText = value.data.toString();
              });
            });
          },
          child: const Text("Retrofit Post"),
        ),
        ElevatedButton(
          onPressed: () {
            postApi.putPosts(
              "1",
              {
                'title': "foo",
                'body': "bar",
                "userId": 1,
              },
            ).then((value) {
              setState(() {
                print(value.response.statusCode);
                responseText = value.data.toString();
              });
            });
          },
          child: const Text("Retrofit Post"),
        ),
        ElevatedButton(
          onPressed: () {
            postApi.deletePost("1").then((value) {
              setState(() {
                print(value.response.statusCode);
                responseText = "삭제성공";
              });
            });
          },
          child: const Text("Retrofit Post"),
        ),
        Expanded(
            child: SingleChildScrollView(
          child: Text(responseText),
        ))
      ],
    );
  }
}
