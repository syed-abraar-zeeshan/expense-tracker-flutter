// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PasswordVisibility)
final passwordVisibilityProvider = PasswordVisibilityProvider._();

final class PasswordVisibilityProvider
    extends $NotifierProvider<PasswordVisibility, bool> {
  PasswordVisibilityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'passwordVisibilityProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$passwordVisibilityHash();

  @$internal
  @override
  PasswordVisibility create() => PasswordVisibility();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$passwordVisibilityHash() =>
    r'6ad2122ff2b5cd39d5b368940b55b83dea148d2b';

abstract class _$PasswordVisibility extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(ConfirmPasswordVisibility)
final confirmPasswordVisibilityProvider = ConfirmPasswordVisibilityProvider._();

final class ConfirmPasswordVisibilityProvider
    extends $NotifierProvider<ConfirmPasswordVisibility, bool> {
  ConfirmPasswordVisibilityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'confirmPasswordVisibilityProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$confirmPasswordVisibilityHash();

  @$internal
  @override
  ConfirmPasswordVisibility create() => ConfirmPasswordVisibility();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$confirmPasswordVisibilityHash() =>
    r'8faaf72f602d82a780837454320fb4b1cf81c144';

abstract class _$ConfirmPasswordVisibility extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
