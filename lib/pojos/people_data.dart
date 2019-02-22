import 'dart:convert';

People peopleFromJson(String str) {
  final jsonData = json.decode(str);
  return People.fromMap(jsonData);
}

String peopleToJson(People data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class People {
  String name = '';
  String gender = '';
  String phone = '';
  String email = '';
  String age = '';

  People({this.name, this.gender, this.phone, this.email, this.age});

  factory People.fromMap(Map<String, dynamic> json) => People(
    name: json["name"],
    gender: json["gender"],
    phone: json["phone"],
    email: json["email"],
    age: json["age"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "gender": gender,
    "phone": phone,
    "email": email,
    "age":age,
  };

}
