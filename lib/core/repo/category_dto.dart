import 'package:hive/hive.dart';
import 'package:poll_answer/model/category.dart';
import 'package:poll_answer/model/user.dart';

class CategoryDto extends TypeAdapter<Category> {
  @override
  final typeId = 0;

  @override
  Category read(BinaryReader reader) {
    return Category(id: reader.read(), name: reader.read());
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    writer.write(obj.id);
    writer.write(obj.name);
  }
}
