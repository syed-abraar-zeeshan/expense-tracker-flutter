// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CurrencyController)
final currencyControllerProvider = CurrencyControllerProvider._();

final class CurrencyControllerProvider
    extends $NotifierProvider<CurrencyController, CurrencyState> {
  CurrencyControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currencyControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currencyControllerHash();

  @$internal
  @override
  CurrencyController create() => CurrencyController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CurrencyState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CurrencyState>(value),
    );
  }
}

String _$currencyControllerHash() =>
    r'da3e13ad6f5a18c5f9041215694db4d2d4cb3bbc';

abstract class _$CurrencyController extends $Notifier<CurrencyState> {
  CurrencyState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<CurrencyState, CurrencyState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CurrencyState, CurrencyState>,
              CurrencyState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
