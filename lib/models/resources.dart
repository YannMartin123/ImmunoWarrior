import 'package:hive/hive.dart';
part 'resources.g.dart';

@HiveType(typeId: 7)
class Resources {
  @HiveField(0)
  final int researchPoints;

  @HiveField(1)
  final int defensivePoints;

  @HiveField(2)
  final int productionPoints;

  Resources({
    required this.researchPoints,
    required this.defensivePoints,
    required this.productionPoints,
  });
}