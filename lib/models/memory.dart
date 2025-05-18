import 'package:hive/hive.dart';

part 'memory.g.dart';

@HiveType(typeId: 6)
class MemoireImmunitaire extends HiveObject {
  @HiveField(0)
  List<String> signaturesConnues;

  @HiveField(1)
  Map<String, double> bonusContrePathogenes; // ex: {"Virus": 0.2}

  @HiveField(2)
  int mutationsIgnorees;

  MemoireImmunitaire({
    required this.signaturesConnues,
    required this.bonusContrePathogenes,
    this.mutationsIgnorees = 0,
  });
}
