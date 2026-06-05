import 'package:expense_flow/features/categories/presentation/controllers/categories_state.dart';
import 'package:expense_flow/features/categories/presentation/providers/category_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'categories_controller.g.dart';

@riverpod
class CategoriesController extends _$CategoriesController {
  @override
  CategoriesState build() {
    return const CategoriesState();
  }

  Future<void> getCategories() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final categories = await ref
          .read(categoryRepositoryProvider)
          .getCategories();

      if (!ref.mounted) return;

      state = state.copyWith(isLoading: false, categories: categories);
    } catch (e) {
      if (!ref.mounted) return;

      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}
