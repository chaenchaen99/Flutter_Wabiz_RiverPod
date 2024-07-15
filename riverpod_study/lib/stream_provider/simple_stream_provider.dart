import 'package:flutter_riverpod/flutter_riverpod.dart';

//simpleStreamProvider라는 이름으로 StreamProvider를 만들었고,
//StreamProvider가 가지는 state값은 int형이다.
final simpleStreamProvider = StreamProvider<int>((ref) async* {
  for (var i = 0; i < 10; i++) {
    await Future.delayed(const Duration(seconds: 1));
    yield i;
  }
});
