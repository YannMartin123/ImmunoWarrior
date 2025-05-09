import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:immunowarriors/models/antibody.dart';
import 'package:immunowarriors/models/resources.dart';
import 'package:immunowarriors/models/user.dart';
import 'package:immunowarriors/models/viral_base.dart';
import 'package:path/path.dart' as path;

void main() {
  setUpAll(() async {
    // Initialiser Hive une seule fois pour tous les tests
    final tempDir = Directory.systemTemp.createTempSync();
    final hivePath = path.join(tempDir.path, 'hive_test');
    Hive.init(hivePath);

    // Enregistrer les adaptateurs une seule fois
    Hive.registerAdapter(AntibodyAdapter());
    Hive.registerAdapter(ViralBaseAdapter());
    Hive.registerAdapter(ResourcesAdapter());
    Hive.registerAdapter(UserAdapter());
  });

  setUp(() async {
    // Ouvrir une box propre pour chaque test
    await Hive.openBox('testBox');
  });

  test('Antibody serialization', () async {
    final box = Hive.box('testBox');
    final antibody = Antibody(
      id: '1',
      name: 'Anticorps A',
      type: 'Virus',
      strength: 100,
      weaknesses: ['Bactérie'],
      resistances: ['Champignon'],
    );
    await box.put('antibody', antibody);
    final retrieved = box.get('antibody') as Antibody;
    expect(retrieved.name, 'Anticorps A');
    expect(retrieved.type, 'Virus');
  });

  test('User serialization', () async {
    final box = Hive.box('testBox');
    final resources = Resources(
      researchPoints: 100,
      defensivePoints: 200,
      productionPoints: 300,
    );
    final user = User(
      uid: '123',
      username: 'TestUser',
      resources: resources,
      antibodies: [
        Antibody(
          id: '1',
          name: 'Anticorps A',
          type: 'Virus',
          strength: 100,
          weaknesses: ['Bactérie'],
          resistances: ['Champignon'],
        ),
      ],
      researchState: {'antibody1': 1},
    );
    await box.put('user', user);
    final retrieved = box.get('user') as User;
    expect(retrieved.username, 'TestUser');
    expect(retrieved.resources.researchPoints, 100);
  });

  tearDown(() async {
    // Fermer la box après chaque test
    await Hive.box('testBox').close();
  });

  tearDownAll(() async {
    // Nettoyer Hive et supprimer le répertoire temporaire
    await Hive.close();
    
  });
}