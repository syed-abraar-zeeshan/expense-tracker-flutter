// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ExpenseController)
final expenseControllerProvider = ExpenseControllerProvider._();

final class ExpenseControllerProvider
    extends $NotifierProvider<ExpenseController, ExpenseState> {
  ExpenseControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'expenseControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$expenseControllerHash();

  @$internal
  @override
  ExpenseController create() => ExpenseController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExpenseState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExpenseState>(value),
    );
  }
}

String _$expenseControllerHash() => r'dc36eb216ae86f3642a19424e09d2b8a4d37afe4';

abstract class _$ExpenseController extends $Notifier<ExpenseState> {
  ExpenseState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ExpenseState, ExpenseState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ExpenseState, ExpenseState>,
              ExpenseState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
