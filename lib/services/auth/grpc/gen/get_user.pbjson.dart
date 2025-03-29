//
//  Generated code. Do not modify.
//  source: get_user.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use getUserRequestMessageDescriptor instead')
const GetUserRequestMessage$json = {
  '1': 'GetUserRequestMessage',
  '2': [
    {'1': 'access_token', '3': 1, '4': 1, '5': 9, '10': 'accessToken'},
  ],
};

/// Descriptor for `GetUserRequestMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserRequestMessageDescriptor = $convert.base64Decode(
    'ChVHZXRVc2VyUmVxdWVzdE1lc3NhZ2USIQoMYWNjZXNzX3Rva2VuGAEgASgJUgthY2Nlc3NUb2'
    'tlbg==');

@$core.Deprecated('Use getUserResponseMessageDescriptor instead')
const GetUserResponseMessage$json = {
  '1': 'GetUserResponseMessage',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.authpb.User', '10': 'user'},
  ],
};

/// Descriptor for `GetUserResponseMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserResponseMessageDescriptor = $convert.base64Decode(
    'ChZHZXRVc2VyUmVzcG9uc2VNZXNzYWdlEiAKBHVzZXIYASABKAsyDC5hdXRocGIuVXNlclIEdX'
    'Nlcg==');

