//
//  Generated code. Do not modify.
//  source: sign_up.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'user.pb.dart' as $5;

class SignUpRequestMessage extends $pb.GeneratedMessage {
  factory SignUpRequestMessage({
    $core.String? email,
    $core.String? password,
    $core.String? comfirmPassword,
  }) {
    final $result = create();
    if (email != null) {
      $result.email = email;
    }
    if (password != null) {
      $result.password = password;
    }
    if (comfirmPassword != null) {
      $result.comfirmPassword = comfirmPassword;
    }
    return $result;
  }
  SignUpRequestMessage._() : super();
  factory SignUpRequestMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SignUpRequestMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SignUpRequestMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'authpb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'email')
    ..aOS(2, _omitFieldNames ? '' : 'password')
    ..aOS(3, _omitFieldNames ? '' : 'comfirmPassword')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SignUpRequestMessage clone() => SignUpRequestMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SignUpRequestMessage copyWith(void Function(SignUpRequestMessage) updates) => super.copyWith((message) => updates(message as SignUpRequestMessage)) as SignUpRequestMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignUpRequestMessage create() => SignUpRequestMessage._();
  SignUpRequestMessage createEmptyInstance() => create();
  static $pb.PbList<SignUpRequestMessage> createRepeated() => $pb.PbList<SignUpRequestMessage>();
  @$core.pragma('dart2js:noInline')
  static SignUpRequestMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignUpRequestMessage>(create);
  static SignUpRequestMessage? _defaultInstance;

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
  $core.String get comfirmPassword => $_getSZ(2);
  @$pb.TagNumber(3)
  set comfirmPassword($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasComfirmPassword() => $_has(2);
  @$pb.TagNumber(3)
  void clearComfirmPassword() => clearField(3);
}

class SignUpResponseMessage extends $pb.GeneratedMessage {
  factory SignUpResponseMessage({
    $core.String? provider,
    $5.User? user,
  }) {
    final $result = create();
    if (provider != null) {
      $result.provider = provider;
    }
    if (user != null) {
      $result.user = user;
    }
    return $result;
  }
  SignUpResponseMessage._() : super();
  factory SignUpResponseMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SignUpResponseMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SignUpResponseMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'authpb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'provider')
    ..aOM<$5.User>(2, _omitFieldNames ? '' : 'user', subBuilder: $5.User.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SignUpResponseMessage clone() => SignUpResponseMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SignUpResponseMessage copyWith(void Function(SignUpResponseMessage) updates) => super.copyWith((message) => updates(message as SignUpResponseMessage)) as SignUpResponseMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignUpResponseMessage create() => SignUpResponseMessage._();
  SignUpResponseMessage createEmptyInstance() => create();
  static $pb.PbList<SignUpResponseMessage> createRepeated() => $pb.PbList<SignUpResponseMessage>();
  @$core.pragma('dart2js:noInline')
  static SignUpResponseMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignUpResponseMessage>(create);
  static SignUpResponseMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get provider => $_getSZ(0);
  @$pb.TagNumber(1)
  set provider($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProvider() => $_has(0);
  @$pb.TagNumber(1)
  void clearProvider() => clearField(1);

  /// tambien el proveedot?
  @$pb.TagNumber(2)
  $5.User get user => $_getN(1);
  @$pb.TagNumber(2)
  set user($5.User v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasUser() => $_has(1);
  @$pb.TagNumber(2)
  void clearUser() => clearField(2);
  @$pb.TagNumber(2)
  $5.User ensureUser() => $_ensure(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
