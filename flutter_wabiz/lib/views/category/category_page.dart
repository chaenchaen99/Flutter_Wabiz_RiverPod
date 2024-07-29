import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_wadiz_riverpod/repository/favorite/favorite_repository.dart';
import 'package:flutter_wadiz_riverpod/theme.dart';
import 'package:flutter_wadiz_riverpod/view_model/category/category_view_model.dart';
import 'package:flutter_wadiz_riverpod/view_model/favorite/favorite_view_model.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class CategoryPage extends ConsumerStatefulWidget {
  final String categoryId;
  const CategoryPage({super.key, required this.categoryId});

  @override
  ConsumerState<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends ConsumerState<CategoryPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(categoryViewModelProvider.notifier)
          .fetchProjects(widget.categoryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("카테고리"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/icons/home_outlined.svg",
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          //최상위 프로젝트
          SizedBox(
            height: 204,
            child: Consumer(builder: (context, ref, child) {
              final datas =
                  ref.watch(fetchCategoryProjectsProvider(widget.categoryId));
              return datas.when(
                data: (data) {
                  final titleProject =
                      data.projects[Random().nextInt(data.projects.length) - 1];
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            titleProject.thumbnail ?? ""),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(.2),
                          BlendMode.darken,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${titleProject.title}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Gap(12),
                        Text(
                          "${titleProject.description}",
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Gap(16),
                        Container(
                          height: 4,
                          width: 120,
                          decoration: const BoxDecoration(color: Colors.white),
                        ),
                      ],
                    ),
                  );
                },
                error: (error, stackTrace) {
                  return Center(
                    child: Text(error.toString()),
                  );
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            }),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(6, 16, 8, 0),
            height: 110,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Consumer(builder: (context, ref, child) {
              final types = ref.watch(fetchTypeTabsProvider);
              return types.when(data: (data) {
                return Consumer(builder: (context, ref, child) {
                  final vm = ref.watch(categoryViewModelProvider);
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final tab = data[index];
                        return GestureDetector(
                          onTap: () {
                            ref
                                .read(categoryViewModelProvider.notifier)
                                .updateType(tab);

                            //데이터 가져오는 것 추가
                            ref
                                .read(categoryViewModelProvider.notifier)
                                .fetchProjects(widget.categoryId);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 32,
                            ),
                            child: IntrinsicWidth(
                              child: Column(
                                children: [
                                  const Gap(8),
                                  SvgPicture.asset(
                                    tab.imagePath ?? "",
                                    width: 32,
                                    height: 32,
                                  ),
                                  const Gap(12),
                                  Text(
                                    "${tab.type}",
                                    style: TextStyle(
                                      fontWeight:
                                          vm.selectedType?.type == tab.type
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                    ),
                                  ),
                                  const Gap(12),
                                  Container(
                                    height: 6,
                                    color: vm.selectedType?.type == tab.type
                                        ? Colors.black
                                        : Colors.transparent,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                });
              }, error: (error, trace) {
                return Center(
                  child: Text(error.toString()),
                );
              }, loading: () {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              });
            }),
          ),
          const Divider(
            height: 0,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Consumer(builder: (context, ref, child) {
                final projects =
                    ref.watch(categoryViewModelProvider).projectState;
                return projects.when(data: (data) {
                  if (data.isEmpty) {
                    return const Center(
                      child: Text("등록된 데이터가 없습니다."),
                    );
                  }
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          children: [
                            Consumer(builder: (context, ref, child) {
                              final filter = ref
                                  .watch(categoryViewModelProvider)
                                  .projectFilter;
                              return DropdownButton(
                                value: filter,
                                items: EnumCategoryProjectType.values.map((e) {
                                  return DropdownMenuItem(
                                    value: e,
                                    onTap: () {
                                      ref
                                          .read(categoryViewModelProvider
                                              .notifier)
                                          .updateProjectFilter(e);
                                    },
                                    child: Text(e.value),
                                  );
                                }).toList(),
                                onChanged: (value) {},
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                ),
                                underline: const SizedBox.shrink(),
                              );
                            }),
                            const Gap(24),
                            DropdownButton(
                              items: const [
                                DropdownMenuItem(
                                  child: Text("추천순"),
                                ),
                              ],
                              onChanged: (value) {},
                              underline: const SizedBox.shrink(),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final project = data[index];
                            return InkWell(
                              onTap: () {
                                context.push(
                                  "/detail",
                                  extra: json.encode(
                                    project.toJson(),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 24,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 120,
                                      width: 164,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.blue,
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                              project.thumbnail ?? "",
                                            ),
                                            fit: BoxFit.cover,
                                            colorFilter: ColorFilter.mode(
                                                Colors.black.withOpacity(.2),
                                                BlendMode.darken)),
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            right: 2,
                                            top: 2,
                                            child: Consumer(
                                                builder: (context, ref, child) {
                                              final favorites = ref.watch(
                                                  favoriteViewModelProvider);

                                              final current = favorites.projects
                                                  .where((element) =>
                                                      element.id == project.id)
                                                  .toList();

                                              return IconButton(
                                                onPressed: () {
                                                  if (current.isNotEmpty) {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            content: const Text(
                                                                "구독을 취소할까요?"),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  ref
                                                                      .read(favoriteViewModelProvider
                                                                          .notifier)
                                                                      .removeItem(
                                                                          project);
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child:
                                                                    const Text(
                                                                        "네"),
                                                              )
                                                            ],
                                                          );
                                                        });
                                                    return;
                                                  }
                                                  ref
                                                      .read(
                                                          favoriteViewModelProvider
                                                              .notifier)
                                                      .addItem(project);
                                                },
                                                icon: Icon(
                                                  current.isNotEmpty
                                                      ? Icons.favorite
                                                      : Icons.favorite_border,
                                                ),
                                                color: current.isNotEmpty
                                                    ? Colors.red
                                                    : Colors.white,
                                              );
                                            }),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Gap(16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${project.title}",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const Gap(8),
                                          Text(
                                            "${project.owner}",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color:
                                                    AppColors.wabizGray[500]),
                                          ),
                                          const Gap(8),
                                          Text(
                                            "${NumberFormat("###,###,###").format(project.totalFundedCount)}명 참여",
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: AppColors.primary),
                                          ),
                                          const Gap(8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6, vertical: 4),
                                            decoration: const BoxDecoration(
                                                color: AppColors.bg),
                                            child: Text(
                                              switch (
                                                  project.totalFunded ?? 0) {
                                                >= 100000000 && > 10000000 =>
                                                  "${NumberFormat.currency(
                                                    locale: "ko_KR",
                                                    symbol: "",
                                                  ).format((project.totalFunded ?? 0) ~/ 100000000)}억 원+",
                                                >= 10000000 && > 10000 =>
                                                  "${NumberFormat.currency(
                                                    locale: "ko_KR",
                                                    symbol: "",
                                                  ).format((project.totalFunded ?? 0) ~/ 10000000)}천만 원+",
                                                > 10000 =>
                                                  "${NumberFormat.currency(
                                                    locale: "ko_KR",
                                                    symbol: "",
                                                  ).format((project.totalFunded ?? 0) ~/ 10000)}만 원+",
                                                _ => "",
                                              },
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }, error: (error, trace) {
                  return Center(
                    child: Text(
                      error.toString(),
                    ),
                  );
                }, loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                });
              }),
            ),
          ),
        ],
      ),
    );
  }
}
