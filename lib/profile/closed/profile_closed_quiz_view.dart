import 'package:flutter/cupertino.dart';
import 'package:poll_answer/model/question.dart';

class ProfileClosedQuizView extends StatelessWidget {
  List<Question> closedQuests = List.empty();
  ProfileClosedQuizView({required this.closedQuests});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Closed questions"),
      ),
    );
  }
}
