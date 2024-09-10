import 'package:hive/hive.dart';
part 'bakeg.g.dart';

@HiveType(typeId: 2)
class Bakeg_Info {
  @HiveField(0)
  Map<String, String> info;
  Bakeg_Info({
    required this.info,
  });
}

@HiveType(typeId: 3)
class Bakeg_Good {
  @HiveField(0)
  String? date;
  @HiveField(1)
  List<Map<String, String>>? good_bakeg;
  Bakeg_Good({this.date, this.good_bakeg});
}

@HiveType(typeId: 4)
class Bakeg_Sold {
  @HiveField(0)
  String? date;
  @HiveField(1)
  List<Map<String, String>>? sold_bakeg;
  Bakeg_Sold({this.date, this.sold_bakeg});
}

@HiveType(typeId: 5)
class Bakeg_Write_Of {
  @HiveField(0)
  String? date;
  @HiveField(1)
  List<Map<String, String>>? write_of_bakeg;
  Bakeg_Write_Of({this.date, this.write_of_bakeg});
}
