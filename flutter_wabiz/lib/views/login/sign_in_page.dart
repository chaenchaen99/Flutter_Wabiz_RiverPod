import 'package:flutter/material.dart';
import 'package:flutter_wadiz_riverpod/theme.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SingInPage extends StatefulWidget {
  const SingInPage({super.key});

  @override
  State<SingInPage> createState() => _SingInPageState();
}

class _SingInPageState extends State<SingInPage> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "로그인",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: AppColors.wabizGray[900],
                ),
              ),
              const Gap(32),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: emailTextController,
                      decoration: const InputDecoration(
                        hintText: "이메일 입력",
                      ),
                    ),
                    const Gap(20),
                    TextFormField(
                      controller: emailTextController,
                      decoration: const InputDecoration(
                        hintText: "비밀번호 입력",
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(8),
              ButtonBar(
                //여러개의 버튼들을 수평배치하기 위해 사용하는 위젯
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "로그인 정보를 잊으셨나요?",
                      style: TextStyle(
                        color: AppColors.wabizGray[600],
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(24),
              GestureDetector(
                onTap: () async {},
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      "이메일로 로그인하기",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(24),
              Row(
                children: [
                  Text(
                    "아직 계정이 없나요?",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.wabizGray[900],
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      textStyle: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: () {
                      context.push("/sign-up");
                    },
                    child: const Text(
                      "회원가입",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
