//
//  Generated code. Do not modify.
//  source: sign_in.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use signInRequestMessageDescriptor instead')
const SignInRequestMessage$json = {
  '1': 'SignInRequestMessage',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
    {'1': 'remember_me', '3': 3, '4': 1, '5': 8, '10': 'rememberMe'},
  ],
};

/// Descriptor for `SignInRequestMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signInRequestMessageDescriptor = $convert.base64Decode(
    'ChRTaWduSW5SZXF1ZXN0TWVzc2FnZRIUCgVlbWFpbBgBIAEoCVIFZW1haWwSGgoIcGFzc3dvcm'
    'QYAiABKAlSCHBhc3N3b3JkEh8KC3JlbWVtYmVyX21lGAMgASgIUgpyZW1lbWJlck1l');

@$core.Deprecated('Use signInResponseMessageDescriptor instead')
const SignInResponseMessage$json = {
  '1': 'SignInResponseMessage',
  '2': [
    {'1': 'provider', '3': 1, '4': 1, '5': 9, '10': 'provider'},
    {'1': 'access_token', '3': 2, '4': 1, '5': 9, '10': 'accessToken'},
    {'1': 'refresh_token', '3': 3, '4': 1, '5': 9, '10': 'refreshToken'},
    {'1': 'user', '3': 4, '4': 1, '5': 11, '6': '.authpb.User', '10': 'user'},
  ],
};

/// Descriptor for `SignInResponseMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signInResponseMessageDescriptor = $convert.base64Decode(
    'ChVTaWduSW5SZXNwb25zZU1lc3NhZ2USGgoIcHJvdmlkZXIYASABKAlSCHByb3ZpZGVyEiEKDG'
    'FjY2Vzc190b2tlbhgCIAEoCVILYWNjZXNzVG9rZW4SIwoNcmVmcmVzaF90b2tlbhgDIAEoCVIM'
    'cmVmcmVzaFRva2VuEiAKBHVzZXIYBCABKAsyDC5hdXRocGIuVXNlclIEdXNlcg==');

