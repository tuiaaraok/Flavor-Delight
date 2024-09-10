import 'package:bakery/baked_page.dart';
import 'package:bakery/data/bakeg.dart';
import 'package:bakery/data/boxes.dart';
import 'package:bakery/info_page.dart';
import 'package:bakery/recipes_page.dart';
import 'package:bakery/sold_baked_page.dart';
import 'package:bakery/write_of_bakeg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

class MenuPage extends StatefulWidget {
  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(
            "Menu",
            style: TextStyle(fontSize: 24.sp, color: Colors.white),
          ),
        ),
        leadingWidth: 200.w,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => InfoPage(),
                  ),
                );
              },
              child: Text(
                "Help",
                style: TextStyle(fontSize: 24.sp, color: Color(0xFF931E1E)),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Spacer(),
            Padding(
              padding: EdgeInsets.only(top: 59.h),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => RecipesPage(),
                    ),
                  );
                },
                child: Container(
                  width: 290.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.r),
                      ),
                      color: Color(0xFF931E1E)),
                  child: Center(
                      child: Text(
                    "Recipes",
                    style: TextStyle(fontSize: 20.sp, color: Colors.white),
                  )),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 59.h),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => BakedPage(),
                    ),
                  );
                },
                child: Container(
                  width: 290.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.r),
                      ),
                      color: const Color(0xFF931E1E)),
                  child: Center(
                      child: Text(
                    "Baked goods",
                    style: TextStyle(fontSize: 20.sp, color: Colors.white),
                  )),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 59.h),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => SoldBakedPage(),
                    ),
                  );
                },
                child: Container(
                  width: 290.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.r),
                      ),
                      color: Color(0xFF931E1E)),
                  child: Center(
                      child: Text(
                    "Sold baked goods",
                    style: TextStyle(fontSize: 20.sp, color: Colors.white),
                  )),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 59.h),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => WriteOfBakeg(),
                    ),
                  );
                },
                child: Container(
                  width: 290.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.r),
                      ),
                      color: Color(0xFF931E1E)),
                  child: Center(
                      child: Text(
                    "Baked goods written off",
                    style: TextStyle(fontSize: 20.sp, color: Colors.white),
                  )),
                ),
              ),
            ),
            Spacer(),
            Container(
              width: double.infinity,
              height: 195.h,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/menu_page.png"))),
            )
          ],
        ),
      ),
    );
  }
}
