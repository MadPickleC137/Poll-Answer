import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:poll_answer/model/answer.dart';

class Question {
  int id = 0;
  int? categoryId;
  String? title;
  String? description;
  List<Answer>? answerVariants;
  bool isPollCompleted = false;

  Question({
    required this.id,
    this.categoryId,
    this.title,
    this.description,
    this.answerVariants,
    required this.isPollCompleted,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryId': categoryId,
      'title': title,
      'description': description,
      'answerVariants': answerVariants?.map((x) => x.toMap()).toList(),
      'isPollCompleted': isPollCompleted,
    };
  }

  Map<String, dynamic> toMapForSend() {
    return {
      'categoryId': categoryId,
      'title': title,
      'description': description,
      'answers': answerVariants?.map((x) => x.toMapForSend()).toList(),
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id']?.toInt() ?? 0,
      categoryId: map['categoryId']?.toInt(),
      title: map['title'],
      description: map['description'],
      answerVariants: map['answerVariants'] != null
          ? List<Answer>.from(
              map['answerVariants']?.map((x) => Answer.fromMap(x)))
          : null,
      isPollCompleted: map['isPollCompleted'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  String toJsonForSend() => json.encode(toMapForSend());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));

  Question copyWith({
    int? id,
    int? categoryId,
    String? title,
    String? description,
    List<Answer>? answerVariants,
    bool? isPollCompleted,
  }) {
    return Question(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      description: description ?? this.description,
      answerVariants: answerVariants ?? this.answerVariants,
      isPollCompleted: isPollCompleted ?? this.isPollCompleted,
    );
  }

  @override
  String toString() {
    return 'Question(id: $id, categoryId: $categoryId, title: $title, description: $description, answerVariants: $answerVariants, isPollCompleted: $isPollCompleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Question &&
        other.id == id &&
        other.categoryId == categoryId &&
        other.title == title &&
        other.description == description &&
        listEquals(other.answerVariants, answerVariants) &&
        other.isPollCompleted == isPollCompleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        categoryId.hashCode ^
        title.hashCode ^
        description.hashCode ^
        answerVariants.hashCode ^
        isPollCompleted.hashCode;
  }
}
