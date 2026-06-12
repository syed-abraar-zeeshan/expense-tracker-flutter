// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ResetPasswordVisibility)
final resetPasswordVisibilityProvider = ResetPasswordVisibilityProvider._();

final class ResetPasswordVisibilityProvider
    extends $NotifierProvider<ResetPasswordVisibility, bool> {
  ResetPasswordVisibilityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resetPasswordVisibilityProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resetPasswordVisibilityHash();

  @$internal
  @override
  ResetPasswordVisibility create() => ResetPasswordVisibility();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$resetPasswordVisibilityHash() =>
    r'b881f2114034334f9a5aeac020bf9e20e795a46d';

abstract class _$ResetPasswordVisibility extends $Notifier<bool> {
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

@ProviderFor(ResetConfirmPasswordVisibility)
final resetConfirmPasswordVisibilityProvider =
    ResetConfirmPasswordVisibilityProvider._();

final class ResetConfirmPasswordVisibilityProvider
    extends $NotifierProvider<ResetConfirmPasswordVisibility, bool> {
  ResetConfirmPasswordVisibilityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resetConfirmPasswordVisibilityProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resetConfirmPasswordVisibilityHash();

  @$internal
  @override
  ResetConfirmPasswordVisibility create() => ResetConfirmPasswordVisibility();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$resetConfirmPasswordVisibilityHash() =>
    r'9512a266025226ac20a37a742cee79c04d7dc193';

abstract class _$ResetConfirmPasswordVisibility extends $Notifier<bool> {
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
