import 'package:hive/hive.dart';
import 'package:poll_answer/model/category.dart';

class CategoryDto extends TypeAdapter<Category> {
  @override
  final typeId = 1;

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
