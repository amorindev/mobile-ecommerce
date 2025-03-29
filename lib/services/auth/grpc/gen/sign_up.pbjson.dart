//
//  Generated code. Do not modify.
//  source: sign_up.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use signUpRequestMessageDescriptor instead')
const SignUpRequestMessage$json = {
  '1': 'SignUpRequestMessage',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
    {'1': 'comfirm_password', '3': 3, '4': 1, '5': 9, '10': 'comfirmPassword'},
  ],
};

/// Descriptor for `SignUpRequestMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signUpRequestMessageDescriptor = $convert.base64Decode(
    'ChRTaWduVXBSZXF1ZXN0TWVzc2FnZRIUCgVlbWFpbBgBIAEoCVIFZW1haWwSGgoIcGFzc3dvcm'
    'QYAiABKAlSCHBhc3N3b3JkEikKEGNvbWZpcm1fcGFzc3dvcmQYAyABKAlSD2NvbWZpcm1QYXNz'
    'd29yZA==');

@$core.Deprecated('Use signUpResponseMessageDescriptor instead')
const SignUpResponseMessage$json = {
  '1': 'SignUpResponseMessage',
  '2': [
    {'1': 'provider', '3': 1, '4': 1, '5': 9, '10': 'provider'},
    {'1': 'user', '3': 2, '4': 1, '5': 11, '6': '.authpb.User', '10': 'user'},
  ],
};

/// Descriptor for `SignUpResponseMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signUpResponseMessageDescriptor = $convert.base64Decode(
    'ChVTaWduVXBSZXNwb25zZU1lc3NhZ2USGgoIcHJvdmlkZXIYASABKAlSCHByb3ZpZGVyEiAKBH'
    'VzZXIYAiABKAsyDC5hdXRocGIuVXNlclIEdXNlcg==');

