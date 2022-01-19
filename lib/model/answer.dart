import 'dart:convert';

class Answer {
  int id = 0;
  int votedCount = 0;
  String text = "";
  String? image;

  Answer({
    required this.id,
    required this.votedCount,
    required this.text,
    this.image,
  });

  Answer copyWith({
    int? id,
    int? votedCount,
    String? text,
    String? image,
  }) {
    return Answer(
      id: id ?? this.id,
      votedCount: votedCount ?? this.votedCount,
      text: text ?? this.text,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'voted': votedCount,
      'text': text,
      'image': image,
    };
  }

  Map<String, dynamic> toMapForSend() {
    return {
      'text': text,
      'image': image,
    };
  }

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      id: map['id']?.toInt() ?? 0,
      votedCount: map['voted']?.toInt() ?? 0,
      text: map['text'] ?? '',
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Answer.fromJson(String source) => Answer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Answer(_id: $id, votedCount: $votedCount, text: $text, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Answer &&
        other.id == id &&
        other.votedCount == votedCount &&
        other.text == text &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^ votedCount.hashCode ^ text.hashCode ^ image.hashCode;
  }
}
