//
//  Generated code. Do not modify.
//  source: sign_in.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'user.pb.dart' as $5;

class SignInRequestMessage extends $pb.GeneratedMessage {
  factory SignInRequestMessage({
    $core.String? email,
    $core.String? password,
    $core.bool? rememberMe,
  }) {
    final $result = create();
    if (email != null) {
      $result.email = email;
    }
    if (password != null) {
      $result.password = password;
    }
    if (rememberMe != null) {
      $result.rememberMe = rememberMe;
    }
    return $result;
  }
  SignInRequestMessage._() : super();
  factory SignInRequestMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SignInRequestMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SignInRequestMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'authpb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'email')
    ..aOS(2, _omitFieldNames ? '' : 'password')
    ..aOB(3, _omitFieldNames ? '' : 'rememberMe')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SignInRequestMessage clone() => SignInRequestMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SignInRequestMessage copyWith(void Function(SignInRequestMessage) updates) => super.copyWith((message) => updates(message as SignInRequestMessage)) as SignInRequestMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignInRequestMessage create() => SignInRequestMessage._();
  SignInRequestMessage createEmptyInstance() => create();
  static $pb.PbList<SignInRequestMessage> createRepeated() => $pb.PbList<SignInRequestMessage>();
  @$core.pragma('dart2js:noInline')
  static SignInRequestMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignInRequestMessage>(create);
  static SignInRequestMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get password => $_getSZ(1);
  @$pb.TagNumber(2)
  set password($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearPassword() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get rememberMe => $_getBF(2);
  @$pb.TagNumber(3)
  set rememberMe($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRememberMe() => $_has(2);
  @$pb.TagNumber(3)
  void clearRememberMe() => clearField(3);
}

class SignInResponseMessage extends $pb.GeneratedMessage {
  factory SignInResponseMessage({
    $core.String? provider,
    $core.String? accessToken,
    $core.String? refreshToken,
    $5.User? user,
  }) {
    final $result = create();
    if (provider != null) {
      $result.provider = provider;
    }
    if (accessToken != null) {
      $result.accessToken = accessToken;
    }
    if (refreshToken != null) {
      $result.refreshToken = refreshToken;
    }
    if (user != null) {
      $result.user = user;
    }
    return $result;
  }
  SignInResponseMessage._() : super();
  factory SignInResponseMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SignInResponseMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SignInResponseMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'authpb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'provider')
    ..aOS(2, _omitFieldNames ? '' : 'accessToken')
    ..aOS(3, _omitFieldNames ? '' : 'refreshToken')
    ..aOM<$5.User>(4, _omitFieldNames ? '' : 'user', subBuilder: $5.User.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SignInResponseMessage clone() => SignInResponseMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SignInResponseMessage copyWith(void Function(SignInResponseMessage) updates) => super.copyWith((message) => updates(message as SignInResponseMessage)) as SignInResponseMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignInResponseMessage create() => SignInResponseMessage._();
  SignInResponseMessage createEmptyInstance() => create();
  static $pb.PbList<SignInResponseMessage> createRepeated() => $pb.PbList<SignInResponseMessage>();
  @$core.pragma('dart2js:noInline')
  static SignInResponseMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignInResponseMessage>(create);
  static SignInResponseMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get provider => $_getSZ(0);
  @$pb.TagNumber(1)
  set provider($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProvider() => $_has(0);
  @$pb.TagNumber(1)
  void clearProvider() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get accessToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set accessToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccessToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccessToken() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get refreshToken => $_getSZ(2);
  @$pb.TagNumber(3)
  set refreshToken($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRefreshToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearRefreshToken() => clearField(3);

  @$pb.TagNumber(4)
  $5.User get user => $_getN(3);
  @$pb.TagNumber(4)
  set user($5.User v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasUser() => $_has(3);
  @$pb.TagNumber(4)
  void clearUser() => clearField(4);
  @$pb.TagNumber(4)
  $5.User ensureUser() => $_ensure(3);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
