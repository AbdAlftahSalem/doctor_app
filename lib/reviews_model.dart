class ReviewsModel {
  String content, date, id, image, name, numberStar, pain;

  ReviewsModel({
    required this.content,
    required this.date,
    required this.id,
    required this.image,
    required this.name,
    required this.numberStar,
    required this.pain,
  });

  Map<String, dynamic> toMap() {
    return {
      'content': this.content,
      'date': this.date,
      'id': this.id,
      'image': this.image,
      'name': this.name,
      'numberStar': this.numberStar,
      'pain': this.pain,
    };
  }

  factory ReviewsModel.fromMap(Map<String, dynamic> map) {
    print(map["content"]);
    return ReviewsModel(
      content: map['content'] as String,
      date: map['date'] as String,
      id: map['id'] as String,
      image: map['image'] as String,
      name: map['name'] as String,
      numberStar: map['numberStar'] as String,
      pain: map['pain'] as String,
    );
  }
}
