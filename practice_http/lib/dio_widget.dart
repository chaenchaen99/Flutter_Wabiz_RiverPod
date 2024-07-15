import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:practice_http/main.dart';

class DioWidget extends StatefulWidget {
  const DioWidget({super.key});

  @override
  State<DioWidget> createState() => _DioWidgetState();
}

class _DioWidgetState extends State<DioWidget> {
  String responseText = "";
  Dio dio = Dio(
    BaseOptions(
      headers: {
        "content-type": "application/json; charset=UTF-8",
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            dio.get(api).then((value) {
              setState(() {
                responseText =
                    value.data.toString(); //http와 달리 dio는 자동으로 decode해줌
              });
            });
          },
          child: const Text("Dio get"),
        ),
        TextButton(
          onPressed: () {
            dio.post(
              api,
              data: {
                "title": "foo",
                "body": 'bar',
                "userId": 1,
              },
            ).then((response) {
              print(response.statusCode);
              if (response.statusCode == 201) {
                setState(() {
                  responseText = response.data.toString();
                });
              }
            });
          },
          child: const Text("Dio post"),
        ),
        TextButton(
          onPressed: () {
            dio.putUri(
              Uri.parse("$api/1"),
              data: {
                "title": "foo",
                "body": 'bar',
                "userId": 1,
              },
            ).then((value) {
              setState(() {
                responseText = value.data.toString();
              });
            });
          },
          child: const Text("Dio put"),
        ),
        TextButton(
          onPressed: () {
            try {
              dio.delete("$api/1/123");
            } on DioException catch (error) {
              //예외처리: dio 예외처리는 try catch 사용한다.
              print(error.toString());
            }
          },
          child: const Text("Dio delete"),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Text(responseText),
          ),
        ),
      ],
    );
  }
}
