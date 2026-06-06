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
    extends $NotifierProvider<CurrencyController, CurrencyInfo> {
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
  Override overrideWithValue(CurrencyInfo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CurrencyInfo>(value),
    );
  }
}

String _$currencyControllerHash() =>
    r'6af064fac3b2565477ffad6fc62750afe0c8c698';

abstract class _$CurrencyController extends $Notifier<CurrencyInfo> {
  CurrencyInfo build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<CurrencyInfo, CurrencyInfo>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CurrencyInfo, CurrencyInfo>,
              CurrencyInfo,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
