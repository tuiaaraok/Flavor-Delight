import 'package:hive/hive.dart';
part 'bakeg.g.dart';

@HiveType(typeId: 2)
// ignore: camel_case_types
class Bakeg_Info {
  @HiveField(0)
  Map<String, String> info;
  Bakeg_Info({
    required this.info,
  });
}

@HiveType(typeId: 3)
// ignore: camel_case_types
class Bakeg_Good {
  @HiveField(0)
  String? date;
  @HiveField(1)
  List<Map<String, String>>? goodBakeg;
  Bakeg_Good({this.date, this.goodBakeg});
}

@HiveType(typeId: 4)
// ignore: camel_case_types
class Bakeg_Sold {
  @HiveField(0)
  String? date;
  @HiveField(1)
  List<Map<String, String>>? soldBakeg;
  Bakeg_Sold({this.date, this.soldBakeg});
}

@HiveType(typeId: 5)
// ignore: camel_case_types
class Bakeg_Write_Of {
  @HiveField(0)
  String? date;
  @HiveField(1)
  List<Map<String, String>>? writeOfBakeg;
  Bakeg_Write_Of({this.date, this.writeOfBakeg});
}
