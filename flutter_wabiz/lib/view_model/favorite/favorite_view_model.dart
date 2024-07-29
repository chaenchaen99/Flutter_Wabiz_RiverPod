import 'dart:convert';

import 'package:flutter_wadiz_riverpod/model/category/category_model.dart';
import 'package:flutter_wadiz_riverpod/repository/favorite/favorite_repository.dart';
import 'package:flutter_wadiz_riverpod/shared/enum/enum_shared_pref_key.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorite_view_model.g.dart';

@riverpod
class FavoriteViewModel extends _$FavoriteViewModel {
  @override
  CategoryModel build() {
    String? value = ref.read(favoriteRepositoryProvider).readValue(
          EnumSharedPrefKey.favoriteProject.value,
        );

    if (value?.isEmpty ?? true) {
      return const CategoryModel(projects: []);
    }
    return CategoryModel.fromJson(jsonDecode(value ?? ""));
  }

  addItem(CategoryItemModel value) {
    final oldState = state.projects;
    state = state.copyWith(projects: [...oldState, value]);
    ref.read(favoriteRepositoryProvider).saveValue(
          EnumSharedPrefKey.favoriteProject.value,
          jsonEncode(
            state.toJson(),
          ),
        );
  }

  removeItem(CategoryItemModel value) {
    final oldState = [...state.projects];
    oldState.removeWhere((element) => element.id == value.id);

    state = state.copyWith(projects: [...oldState]);
    ref.read(favoriteRepositoryProvider).saveValue(
          EnumSharedPrefKey.favoriteProject.value,
          jsonEncode(
            state.toJson(),
          ),
        );
  }
}
