import 'package:hive/hive.dart';

part 'recipes.g.dart';

@HiveType(typeId: 1)
class Recipes {
  @HiveField(0)
  final String date;
  @HiveField(1)
  final String note;
  Recipes({required this.date, required this.note});
}
