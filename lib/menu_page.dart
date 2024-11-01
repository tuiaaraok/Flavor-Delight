import 'package:bakery/baked_page.dart';
import 'package:bakery/info_page.dart';
import 'package:bakery/recipes_page.dart';
import 'package:bakery/sold_baked_page.dart';
import 'package:bakery/write_of_bakeg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Text(
                      "Menu",
                      style: TextStyle(fontSize: 24.sp, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => const InfoPage(),
                          ),
                        );
                      },
                      child: Text(
                        "Help",
                        style: TextStyle(
                            fontSize: 24.sp, color: const Color(0xFF931E1E)),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(top: 59.h),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const RecipesPage(),
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
                        builder: (BuildContext context) => const BakedPage(),
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
                        builder: (BuildContext context) => const SoldBakedPage(),
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
                        builder: (BuildContext context) => const WriteOfBakeg(),
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
                      "Baked goods written off",
                      style: TextStyle(fontSize: 20.sp, color: Colors.white),
                    )),
                  ),
                ),
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                height: 195.h,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/menu_page.png"))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
