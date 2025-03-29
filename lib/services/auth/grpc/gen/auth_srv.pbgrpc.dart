//
//  Generated code. Do not modify.
//  source: auth_srv.proto
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

import 'sign_in.pb.dart' as $0;
import 'sign_up.pb.dart' as $1;

export 'auth_srv.pb.dart';

@$pb.GrpcServiceName('authpb.AuthService')
class AuthServiceClient extends $grpc.Client {
  static final _$signIn = $grpc.ClientMethod<$0.SignInRequestMessage, $0.SignInResponseMessage>(
      '/authpb.AuthService/SignIn',
      ($0.SignInRequestMessage value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SignInResponseMessage.fromBuffer(value));
  static final _$signUp = $grpc.ClientMethod<$1.SignUpRequestMessage, $1.SignUpResponseMessage>(
      '/authpb.AuthService/SignUp',
      ($1.SignUpRequestMessage value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.SignUpResponseMessage.fromBuffer(value));

  AuthServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.SignInResponseMessage> signIn($0.SignInRequestMessage request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$signIn, request, options: options);
  }

  $grpc.ResponseFuture<$1.SignUpResponseMessage> signUp($1.SignUpRequestMessage request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$signUp, request, options: options);
  }
}

@$pb.GrpcServiceName('authpb.AuthService')
abstract class AuthServiceBase extends $grpc.Service {
  $core.String get $name => 'authpb.AuthService';

  AuthServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.SignInRequestMessage, $0.SignInResponseMessage>(
        'SignIn',
        signIn_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SignInRequestMessage.fromBuffer(value),
        ($0.SignInResponseMessage value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SignUpRequestMessage, $1.SignUpResponseMessage>(
        'SignUp',
        signUp_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.SignUpRequestMessage.fromBuffer(value),
        ($1.SignUpResponseMessage value) => value.writeToBuffer()));
  }

  $async.Future<$0.SignInResponseMessage> signIn_Pre($grpc.ServiceCall call, $async.Future<$0.SignInRequestMessage> request) async {
    return signIn(call, await request);
  }

  $async.Future<$1.SignUpResponseMessage> signUp_Pre($grpc.ServiceCall call, $async.Future<$1.SignUpRequestMessage> request) async {
    return signUp(call, await request);
  }

  $async.Future<$0.SignInResponseMessage> signIn($grpc.ServiceCall call, $0.SignInRequestMessage request);
  $async.Future<$1.SignUpResponseMessage> signUp($grpc.ServiceCall call, $1.SignUpRequestMessage request);
}
