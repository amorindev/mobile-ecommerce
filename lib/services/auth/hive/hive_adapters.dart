import 'package:flu_go_jwt/services/auth/models/model.dart';
import 'package:hive_ce/hive.dart';
part 'hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<Session>(),
  AdapterSpec<User>(),
])
class HiveAuthAdapters {}
