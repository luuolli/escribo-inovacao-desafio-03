import 'dart:convert';

class People {
  late final int id;
  late final String name;
  late final String height;
  late final String mass;
  late final String hairColor;
  late final String skinColor;
  late final String eyeColor;
  late final String birthYear;
  late final String gender;
  late final String url;

  People({
    required this.name,
    required this.height,
    required this.mass,
    required this.hairColor,
    required this.skinColor,
    required this.eyeColor,
    required this.birthYear,
    required this.gender,
    required this.url,
  }) {
    id = getIdFromUrl();
  }

  int getIdFromUrl() {
    var regexp = RegExp(r'people/(\d+)/');
    return int.parse(regexp.allMatches(url).first.group(1)!);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'height': height,
      'mass': mass,
      'hairColor': hairColor,
      'skinColor': skinColor,
      'eyeColor': eyeColor,
      'birthYear': birthYear,
      'gender': gender,
      'url': url,
    };
  }

  factory People.fromMap(Map<String, dynamic> map) {
    return People(
      name: map['name'],
      height: map['height'],
      mass: map['mass'],
      hairColor: map['hair_color'],
      skinColor: map['skin_color'],
      eyeColor: map['eye_color'],
      birthYear: map['birth_year'],
      gender: map['gender'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory People.fromJson(String source) => People.fromMap(json.decode(source));

  @override
  String toString() {
    return '''
      Person(
        name: $name, 
        height: $height, 
        mass: $mass, 
        hairColor: $hairColor, 
        skinColor: $skinColor, 
        eyeColor: $eyeColor, 
        birthYear: $birthYear, 
        gender: $gender, 
        url: $url
      )
    ''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is People &&
        other.name == name &&
        other.height == height &&
        other.mass == mass &&
        other.hairColor == hairColor &&
        other.skinColor == skinColor &&
        other.eyeColor == eyeColor &&
        other.birthYear == birthYear &&
        other.gender == gender &&
        other.url == url &&
        other.id == id;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        height.hashCode ^
        mass.hashCode ^
        hairColor.hashCode ^
        skinColor.hashCode ^
        eyeColor.hashCode ^
        birthYear.hashCode ^
        gender.hashCode ^
        url.hashCode ^
        id.hashCode;
  }
}
