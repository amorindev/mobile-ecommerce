//
//  Generated code. Do not modify.
//  source: user_srv.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'get_user.pb.dart' as $2;

export 'user_srv.pb.dart';

@$pb.GrpcServiceName('authpb.UserService')
class UserServiceClient extends $grpc.Client {
  static final _$getUser = $grpc.ClientMethod<$2.GetUserRequestMessage, $2.GetUserResponseMessage>(
      '/authpb.UserService/GetUser',
      ($2.GetUserRequestMessage value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.GetUserResponseMessage.fromBuffer(value));

  UserServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$2.GetUserResponseMessage> getUser($2.GetUserRequestMessage request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUser, request, options: options);
  }
}

@$pb.GrpcServiceName('authpb.UserService')
abstract class UserServiceBase extends $grpc.Service {
  $core.String get $name => 'authpb.UserService';

  UserServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.GetUserRequestMessage, $2.GetUserResponseMessage>(
        'GetUser',
        getUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.GetUserRequestMessage.fromBuffer(value),
        ($2.GetUserResponseMessage value) => value.writeToBuffer()));
  }

  $async.Future<$2.GetUserResponseMessage> getUser_Pre($grpc.ServiceCall call, $async.Future<$2.GetUserRequestMessage> request) async {
    return getUser(call, await request);
  }

  $async.Future<$2.GetUserResponseMessage> getUser($grpc.ServiceCall call, $2.GetUserRequestMessage request);
}
