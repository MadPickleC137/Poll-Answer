import 'package:hive/hive.dart';
import 'package:poll_answer/model/user.dart';

class UserDto extends TypeAdapter<User> {
  @override
  final typeId = 0;

  @override
  User read(BinaryReader reader) {
    return User()
      ..setUuid = reader.read()
      ..setToken = reader.read();
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer.write(obj.getUuid);
    writer.write(obj.getToken);
  }
}
