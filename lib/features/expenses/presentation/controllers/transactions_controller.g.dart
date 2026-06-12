// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TransactionsController)
final transactionsControllerProvider = TransactionsControllerProvider._();

final class TransactionsControllerProvider
    extends
        $AsyncNotifierProvider<
          TransactionsController,
          List<TransactionEntity>
        > {
  TransactionsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'transactionsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$transactionsControllerHash();

  @$internal
  @override
  TransactionsController create() => TransactionsController();
}

String _$transactionsControllerHash() =>
    r'e710ca822700209f34b3f20f00111124f8828b37';

abstract class _$TransactionsController
    extends $AsyncNotifier<List<TransactionEntity>> {
  FutureOr<List<TransactionEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<TransactionEntity>>,
              List<TransactionEntity>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<TransactionEntity>>,
                List<TransactionEntity>
              >,
              AsyncValue<List<TransactionEntity>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
