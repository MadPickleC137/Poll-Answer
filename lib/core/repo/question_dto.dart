import 'package:hive_flutter/hive_flutter.dart';
import 'package:poll_answer/model/question.dart';

class QuestionDto extends TypeAdapter<Question> {
  @override
  final typeId = 4;

  @override
  Question read(BinaryReader reader) {
    return Question(
      id: reader.read(),
      categoryId: reader.read(),
      title: reader.read(),
      description: reader.read(),
      answerVariants: reader.read(),
      isPollCompleted: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Question obj) {
    writer.write(obj.id);
    writer.write(obj.categoryId);
    writer.write(obj.title);
    writer.write(obj.description);
    writer.write(obj.answerVariants);
    writer.write(obj.isPollCompleted);
  }
}
