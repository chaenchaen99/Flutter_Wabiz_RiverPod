import 'package:flutter_wadiz_riverpod/model/login/login_model.dart';
import 'package:flutter_wadiz_riverpod/repository/login/login_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_view_model.g.dart';
part 'login_view_model.freezed.dart';

@freezed
class LoginState with _$LoginState {
  factory LoginState({
    @Default(false) bool isLogin,
    int? userId,
    String? email,
    String? password,
    String? username,
  }) = _LoginState;

  factory LoginState.init() {
    return LoginState(
      isLogin: false,
      userId: 0,
      password: "",
      username: "",
    );
  }
}

@Riverpod(keepAlive: true)
class LoginViewModel extends _$LoginViewModel {
  @override
  LoginState build() {
    return LoginState.init();
  }

  Future<bool> signUp(LoginModel body) async {
    final result = await ref.watch(loginRepositoryProvider).signUp(
          body,
        );
    if (result.status == "ok") {
      return true;
    }
    return false;
  }

  Future<bool> checkEmail(LoginModel body) async {
    final result = await ref.watch(loginRepositoryProvider).checkEmail(
          body,
        );
    if (result.status == "ok") {
      return true;
    }
    return false;
  }
}
