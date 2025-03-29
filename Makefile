gen:
	@protoc \
	--proto_path=files/protobuf/v1/auth \
	--dart_out=grpc:lib/services/auth/grpc/gen \
	files/protobuf/v1/auth/*.proto google/protobuf/timestamp.proto


.PHONY: Revisar
run:
	@echo "test"

gen:
	@protoc --proto_path=lib/services/auth/protobuf \
	--dart_out=grpc:lib/services/auth/protobuf/gen \
	lib/services/auth/protobuf/*.proto google/protobuf/timestamp.proto

hive: 
	@dart run build_runner build --delete-conflicting-outputs