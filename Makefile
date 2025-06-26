gen:
	@protoc \
	--proto_path=files/protobuf/v1/auth \
	--dart_out=grpc:lib/services/auth/grpc/gen \
	files/protobuf/v1/auth/*.proto google/protobuf/timestamp.proto


.PHONY: Revisar
run:
	@echo "test"

.PHONY: cual de los gen usar
gen-ver:
	@protoc --proto_path=lib/services/auth/protobuf \
	--dart_out=grpc:lib/services/auth/protobuf/gen \
	lib/services/auth/protobuf/*.proto google/protobuf/timestamp.proto

hive: 
	@dart run build_runner build --delete-conflicting-outputs

.PHONY: generar icon con flutter_launcher_icons
.PHONY: si es la primera ves flutter clean && flutter pub get
.PHONY: de momento uno por uno
.PHONY: dart run flutter_launcher_icons -f flu_launcher_icons/ probar
app-icon:
	@dart run flutter_launcher_icons -f flu_launcher_icons/flutter_launcher_icons-dev.yml







