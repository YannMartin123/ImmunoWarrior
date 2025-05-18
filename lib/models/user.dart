import 'package:hive/hive.dart';
import 'resources.dart';
import 'antibody.dart';
part 'user.g.dart';

@HiveType(typeId: 8)
class User {
  @HiveField(0)
  final String uid;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final Resources resources;

  @HiveField(3)
  final List<Antibody> antibodies;

  @HiveField(4)
  final Map<String, int> researchState;

  User({
    required this.uid,
    required this.username,
    required this.resources,
    required this.antibodies,
    required this.researchState,
  });

  // Convertir User en Map pour Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'resources': {
        'researchPoints': resources.researchPoints,
        'defensivePoints': resources.defensivePoints,
        'productionPoints': resources.productionPoints,
      },
      'antibodies': antibodies.map((antibody) => {
            'id': antibody.id,
            'name': antibody.name,
            'type': antibody.type,
            'strength': antibody.strength,
            'weaknesses': antibody.weaknesses,
            'resistances': antibody.resistances,
          }).toList(),
      'researchState': researchState,
    };
  }

  // Créer un User à partir d'un Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      resources: Resources(
        researchPoints: map['resources']['researchPoints'] ?? 0,
        defensivePoints: map['resources']['defensivePoints'] ?? 0,
        productionPoints: map['resources']['productionPoints'] ?? 0,
      ),
      antibodies: (map['antibodies'] as List<dynamic>?)
              ?.map((item) => Antibody(
                    id: item['id'] ?? '',
                    name: item['name'] ?? '',
                    type: item['type'] ?? '',
                    strength: item['strength'] ?? 0,
                    weaknesses: List<String>.from(item['weaknesses'] ?? []),
                    resistances: List<String>.from(item['resistances'] ?? []),
                  ))
              .toList() ??
          [],
      researchState: Map<String, int>.from(map['researchState'] ?? {}),
    );
  }
}