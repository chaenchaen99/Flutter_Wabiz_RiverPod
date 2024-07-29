import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_wadiz_riverpod/model/category/category_model.dart';
import 'package:flutter_wadiz_riverpod/model/project/project_model.dart';
import 'package:flutter_wadiz_riverpod/theme.dart';
import 'package:flutter_wadiz_riverpod/view_model/favorite/favorite_view_model.dart';
import 'package:flutter_wadiz_riverpod/view_model/project/project_view_model.dart';
import 'package:flutter_wadiz_riverpod/views/project/detail/project_detail_widget.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ProjectDetailPage extends StatefulWidget {
  final String project;

  const ProjectDetailPage({
    super.key,
    required this.project,
  });

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  late ProjectItemModel projectItemModel;
  ValueNotifier<bool> isMore = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    projectItemModel = ProjectItemModel.fromJson(json.decode(
      widget.project,
    ));
  }

  @override
  void dispose() {
    isMore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.go("/home");
            },
            icon: SvgPicture.asset(
              "assets/icons/home_outlined.svg",
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
      body: Consumer(builder: (context, ref, child) {
        final project = ref.watch(
          projectDetailViewModelProvider(
            projectItemModel.id.toString(),
          ),
        );
        return project.when(
          data: (data) {
            return Column(
              children: [
                Container(
                  height: 240,
                  decoration: BoxDecoration(
                    color: Colors.grey[300]!,
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        projectItemModel.thumbnail ?? "",
                      ),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(.2),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                ),
                const Divider(
                  color: AppColors.newBg,
                  height: 32,
                ),
                Expanded(
                  child: ValueListenableBuilder(
                      valueListenable: isMore,
                      builder: (context, value, child) {
                        return Stack(
                          children: [
                            Positioned.fill(
                              //Stack위젯의 전체영역을 채우는 위젯 생성
                              child: SingleChildScrollView(
                                physics: !value
                                    ? const NeverScrollableScrollPhysics() //스크롤 불가능
                                    : const BouncingScrollPhysics(), // 스크롤 가능
                                child: ProjectDetailWidget(data: data),
                              ),
                            ),
                            if (!value)
                              Positioned(
                                left: 16,
                                right: 16,
                                bottom: 0,
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                          Colors.white,
                                          Colors.white,
                                          Colors.white,
                                          Colors.white.withOpacity(.7),
                                          Colors.white.withOpacity(.1),
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter),
                                  ),
                                ),
                              ),
                            if (!value)
                              Positioned(
                                  left: 16,
                                  right: 16,
                                  bottom: 16,
                                  child: GestureDetector(
                                    onTap: () => isMore.value = true,
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "스토리 더보기",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                          Gap(12),
                                          Icon(
                                            Icons.keyboard_arrow_down,
                                            color: AppColors.primary,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                          ],
                        );
                      }),
                ),
              ],
            );
          },
          error: (error, stackTrace) {
            return const Center(
              child: Text("Error"),
            );
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      }),
      bottomNavigationBar: _BottomAppBar(
        projectItemModel: projectItemModel,
      ),
    );
  }
}

class _BottomAppBar extends ConsumerWidget {
  final ProjectItemModel projectItemModel;
  const _BottomAppBar({super.key, required this.projectItemModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoriteViewModelProvider);
    final current = favorites.projects
        .where((element) => element.id == projectItemModel.id)
        .toList();

    return BottomAppBar(
      height: 84,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      padding: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey[200]!,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 4,
        ),
        child: Row(
          children: [
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    if (current.isNotEmpty) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("안내"),
                              content: const Text("구독을 취소할까요?"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      ref
                                          .read(favoriteViewModelProvider
                                              .notifier)
                                          .removeItem(
                                            CategoryItemModel(
                                              id: projectItemModel.id,
                                            ),
                                          );
                                      Navigator.pop(context);
                                    },
                                    child: const Text("네")),
                              ],
                            );
                          });
                      return;
                    }
                    ref.read(favoriteViewModelProvider.notifier).addItem(
                          CategoryItemModel(
                            id: projectItemModel.id,
                            thumbnail: projectItemModel.thumbnail,
                            description: projectItemModel.description,
                            title: projectItemModel.title,
                            owner: projectItemModel.owner,
                            totalFunded: projectItemModel.totalFunded,
                            totalFundedCount: projectItemModel.totalFundedCount,
                          ),
                        );
                  },
                  icon: Icon(
                    current.isNotEmpty ? Icons.favorite : Icons.favorite_border,
                    color: current.isNotEmpty ? Colors.red : Colors.black,
                  ),
                ),
                const Text("1만+"),
              ],
            ),
            const Gap(12),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 50,
                child: const Center(
                  child: Text(
                    "펀딩하기",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
