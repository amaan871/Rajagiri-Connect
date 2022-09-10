class Teacher {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? phone;
  String? branch;
  String? division;
  String? photoUrl;
  String? skill;

  Teacher(
      {this.uid,
      this.email,
      this.firstName,
      this.secondName,
      this.phone,
      this.branch,
      this.division,
      this.photoUrl,
      this.skill});

  factory Teacher.fromMap(map) {
    return Teacher(
        uid: map['uid'],
        email: map['email'],
        firstName: map['firstName'],
        secondName: map['secondName'],
        phone: map['phone'],
        branch: map['branch'],
        division: map['division'],
        photoUrl: map['photoUrl'],
        skill: map['skill']);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'phone': phone,
      'branch': branch,
      'division': division,
      'photoUrl': photoUrl,
      'skill': skill,
    };
  }
}
