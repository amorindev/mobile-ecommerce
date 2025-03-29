//
//  Generated code. Do not modify.
//  source: get_user.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'user.pb.dart' as $5;

class GetUserRequestMessage extends $pb.GeneratedMessage {
  factory GetUserRequestMessage({
    $core.String? accessToken,
  }) {
    final $result = create();
    if (accessToken != null) {
      $result.accessToken = accessToken;
    }
    return $result;
  }
  GetUserRequestMessage._() : super();
  factory GetUserRequestMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserRequestMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserRequestMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'authpb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accessToken')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserRequestMessage clone() => GetUserRequestMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserRequestMessage copyWith(void Function(GetUserRequestMessage) updates) => super.copyWith((message) => updates(message as GetUserRequestMessage)) as GetUserRequestMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserRequestMessage create() => GetUserRequestMessage._();
  GetUserRequestMessage createEmptyInstance() => create();
  static $pb.PbList<GetUserRequestMessage> createRepeated() => $pb.PbList<GetUserRequestMessage>();
  @$core.pragma('dart2js:noInline')
  static GetUserRequestMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserRequestMessage>(create);
  static GetUserRequestMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accessToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set accessToken($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccessToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccessToken() => clearField(1);
}

class GetUserResponseMessage extends $pb.GeneratedMessage {
  factory GetUserResponseMessage({
    $5.User? user,
  }) {
    final $result = create();
    if (user != null) {
      $result.user = user;
    }
    return $result;
  }
  GetUserResponseMessage._() : super();
  factory GetUserResponseMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserResponseMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserResponseMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'authpb'), createEmptyInstance: create)
    ..aOM<$5.User>(1, _omitFieldNames ? '' : 'user', subBuilder: $5.User.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserResponseMessage clone() => GetUserResponseMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserResponseMessage copyWith(void Function(GetUserResponseMessage) updates) => super.copyWith((message) => updates(message as GetUserResponseMessage)) as GetUserResponseMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserResponseMessage create() => GetUserResponseMessage._();
  GetUserResponseMessage createEmptyInstance() => create();
  static $pb.PbList<GetUserResponseMessage> createRepeated() => $pb.PbList<GetUserResponseMessage>();
  @$core.pragma('dart2js:noInline')
  static GetUserResponseMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserResponseMessage>(create);
  static GetUserResponseMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $5.User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user($5.User v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => clearField(1);
  @$pb.TagNumber(1)
  $5.User ensureUser() => $_ensure(0);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
