import 'package:hive_flutter/hive_flutter.dart';
import 'package:poll_answer/model/answer.dart';

class QuestionDto extends TypeAdapter<Answer> {
  @override
  final typeId = 3;

  @override
  Answer read(BinaryReader reader) {
    return Answer(
      id: reader.read(),
      votedCount: reader.read(),
      text: reader.read(),
      image: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Answer obj) {
    writer.write(obj.id);
    writer.write(obj.votedCount);
    writer.write(obj.text);
    writer.write(obj.image);
  }
}
