import 'dart:ffi';

class User {
  final Long memberId;
  final String name;
  final String email;
  final String socialId;
  final String profileImageUrl;
  final int age;
  final String gender;
  final int exerciseGoal;
  final bool isNewMember;

  User(
      this.memberId,
      this.name,
      this.email,
      this.socialId,
      this.profileImageUrl,
      this.age,
      this.gender,
      this.exerciseGoal,
      this.isNewMember);

  User.fromJson(Map<String, dynamic> json)
      : memberId = json['memberId'],
        name = json['name'],
        email = json['email'],
        socialId = json['socialId'],
        profileImageUrl = json['profileImageUrl'],
        age = json['age'],
        gender = json['gender'],
        exerciseGoal = json['exerciseGoal'],
        isNewMember = json['isNewMember'];

  Map<String, dynamic> toJson() => {
        'memberId': memberId,
        'name': name,
        'email': email,
        'socialId': socialId,
        'profileImageUrl': profileImageUrl,
        'age': age,
        'gender': gender,
        'exerciseGoal': exerciseGoal,
        'isNewMember': isNewMember,
      };
}
