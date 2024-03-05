class WorkOut {
  final int exerciseId;
  final String name;
  final String description;
  final int difficulty;
  final String exerciseImageUrl;

  WorkOut(this.exerciseId, this.name, this.description, this.difficulty,
      this.exerciseImageUrl);

  WorkOut.fromJson(Map<String, dynamic> json)
      : exerciseId = json['exerciseId'],
        name = json['name'],
        description = json['description'],
        difficulty = json['difficulty'],
        exerciseImageUrl = json['exerciseImageUrl'];

  Map<String, dynamic> toJson() => {
        'exerciseId': exerciseId,
        'name': name,
        'description': description,
        'difficulty': difficulty,
        'exerciseImageUrl': exerciseImageUrl
      };
}
