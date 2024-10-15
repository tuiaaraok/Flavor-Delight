import 'package:bakery/baked_page.dart';
import 'package:bakery/data/bakeg.dart';
import 'package:bakery/data/boxes.dart';
import 'package:bakery/data/recipes.dart';
import 'package:bakery/info_page.dart';
import 'package:bakery/menu_page.dart';
import 'package:bakery/recipes_page.dart';
import 'package:bakery/sold_baked_page.dart';
import 'package:bakery/write_of_bakeg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(BakegInfoAdapter());
  Hive.registerAdapter(BakegGoodAdapter());
  Hive.registerAdapter(BakegSoldAdapter());
  Hive.registerAdapter(BakegWriteOfAdapter());
  Hive.registerAdapter(RecipesAdapter());
  await Hive.openBox<Bakeg_Good>(HiveBoxes.bakeg_good);
  await Hive.openBox<Bakeg_Sold>(HiveBoxes.bakeg_sold);
  await Hive.openBox<Bakeg_Info>(HiveBoxes.bakeg_info);
  await Hive.openBox<Bakeg_Write_Of>(HiveBoxes.bakeg_write_of);
  await Hive.openBox<Recipes>(HiveBoxes.recipes);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(400, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFF6C6D33),
            appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
          ),
          home: MenuPage(),
        );
      },
    );
  }
}
