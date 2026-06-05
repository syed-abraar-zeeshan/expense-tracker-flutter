import 'package:expense_flow/features/categories/domain/entities/category_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'categories_state.freezed.dart';

@freezed
abstract class CategoriesState with _$CategoriesState {
  const factory CategoriesState({
    @Default(false) bool isLoading,
    @Default([]) List<CategoryEntity> categories,
    String? errorMessage,
  }) = _CategoriesState;
}
