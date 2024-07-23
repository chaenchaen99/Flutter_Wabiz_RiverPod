import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_wadiz_riverpod/theme.dart';
import 'package:flutter_wadiz_riverpod/view_model/login/login_view_model.dart';
import 'package:flutter_wadiz_riverpod/view_model/my/my_view_model.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("마이페이지"),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: AppColors.wabizGray[900],
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final myPageState = ref.watch(myPageViewModelProvider);
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 470,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Consumer(builder: (context, ref, child) {
                        if (myPageState.loginState ?? false) {
                          return Row(
                            children: [
                              const CircleAvatar(
                                radius: 24,
                                backgroundColor: Color.fromARGB(255, 4, 4, 4),
                              ),
                              const Gap(8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${myPageState.loginModel?.email}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const Gap(4),
                                    Text(
                                      "${myPageState.loginModel?.username}님 안녕하세요.",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            content: const Text("로그아웃 할까요?"),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("취소"),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  ref
                                                      .read(
                                                          loginViewModelProvider
                                                              .notifier)
                                                      .signOut();
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("확인"),
                                              ),
                                            ],
                                          ));
                                },
                                icon: const Icon(
                                  Icons.logout,
                                ),
                              ),
                            ],
                          );
                        }
                        return Row(
                          children: [
                            const CircleAvatar(
                              radius: 24,
                              backgroundColor: Color.fromARGB(255, 4, 4, 4),
                            ),
                            const Gap(8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    context.push("/sign-in");
                                  },
                                  child: const Row(
                                    children: [
                                      Text("로그인하기"),
                                      Icon(
                                        Icons.keyboard_arrow_right,
                                      )
                                    ],
                                  ),
                                ),
                                const Gap(6),
                                const Text(
                                  "로그인 후 다양한 프로젝트에 참여해보세요",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: AppColors.wabizGray[200],
                            child: SvgPicture.asset(
                              "assets/icons/featured_seasonal_and_gifts.svg",
                              width: 28,
                              height: 28,
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          const Gap(20),
                          const Text(
                            "새로운 도전을\n시작해보세요",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                          const Gap(20),
                          const Text(
                            "개인 후원부터 제품, 콘텐츠, 서비스 출시, 성장까지 함께할게요.",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          if (!(myPageState.loginState ?? true)) {
                            showDialog(
                              context: context,
                              builder: (context) => const AlertDialog(
                                content: Text(
                                  "로그인이 필요한 서비스입니다.",
                                ),
                              ),
                            );
                            return;
                          }
                          context.push(
                            "/add",
                          );
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              "프로젝트 만들기",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
