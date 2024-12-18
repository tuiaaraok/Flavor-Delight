import 'package:bakery/data/boxes.dart';
import 'package:bakery/data/recipes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({
    super.key,
  });

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  TextEditingController tipController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode(); // FocusNode для первого TextField
  final FocusNode _nodeText2 = FocusNode(); // FocusNode для второго TextField

  bool addrecept = false;
  int currentIndex = -1;

  _updateFormCompletion() {
    bool isFilled =
        tipController.text.isNotEmpty && notesController.text.isNotEmpty;

    return isFilled;
  }

  @override
  void initState() {
    super.initState();
    tipController.addListener(_updateFormCompletion);
    notesController.addListener(_updateFormCompletion);
  }

  @override
  void dispose() {
    _nodeText1.dispose();
    _nodeText2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: Hive.box<Recipes>(HiveBoxes.recipes).listenable(),
          builder: (context, Box<Recipes> box, _) {
            return KeyboardActions(
              config: KeyboardActionsConfig(nextFocus: false, actions: [
                KeyboardActionsItem(
                  focusNode: _nodeText1,
                ),
                KeyboardActionsItem(
                  focusNode: _nodeText2,
                  onTapAction: () {},
                ),
              ]),
              child: SafeArea(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Recipes",
                                    style: TextStyle(
                                        fontSize: 24.sp, color: Colors.white),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (!addrecept) {
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: CircleAvatar(
                                      radius: 27.r,
                                      backgroundColor: addrecept
                                          ? const Color(0xFF931E1E)
                                              .withValues(alpha: 0.5)
                                          : const Color(0xFF931E1E),
                                      child: Icon(
                                        IconsaxPlusLinear.house_2,
                                        size: 27.h,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                          for (int i = box.values.length - 1; i >= 0; i--) ...[
                            Padding(
                              padding: EdgeInsets.only(right: 20.w, top: 10.h),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: currentIndex != -1 ? 330.w : 300.w,
                                child: currentIndex != i
                                    ? InkWell(
                                        onTap: () {
                                          currentIndex = i;

                                          setState(() {});
                                        },
                                        child: Container(
                                          height: 40.h,
                                          decoration: BoxDecoration(
                                              color: const Color(0xFF84853F),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12.r))),
                                          child: Center(
                                            child: Text(
                                              box.getAt(i)!.date,
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                            color: const Color(0xFF931E1E),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.r))),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.h, horizontal: 20.w),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 55.h,
                                                width: 300.w,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              12.r)),
                                                  color: const Color(0xFFD9D9D9)
                                                      .withValues(alpha: 0.25),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.w),
                                                  child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        box.getAt(i)!.date,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 18.sp),
                                                      )),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.h),
                                                child: Container(
                                                  height: 180.h,
                                                  width: 300.w,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12.r)),
                                                    color:
                                                        const Color(0xFFD9D9D9)
                                                            .withValues(
                                                                alpha: 0.25),
                                                  ),
                                                  child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10.w),
                                                      child: Text(
                                                        box.getAt(i)!.note,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 16.sp),
                                                      )),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 20.h),
                                                child: InkWell(
                                                  onTap: () {
                                                    currentIndex = -1;

                                                    _nodeText1.unfocus();
                                                    _nodeText2.unfocus();
                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                    width: 120.w,
                                                    height: 40.h,
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFF84853F),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20.r)),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Back",
                                                        style: TextStyle(
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          ],
                          addrecept
                              ? const SizedBox.shrink()
                              : Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  child: SizedBox(
                                    width: double.maxFinite,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: 350.w,
                                          child: Text(
                                              "Add new sold baked goods ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.sp)),
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            addrecept = true;

                                            setState(() {});
                                          },
                                          child: CircleAvatar(
                                            radius: 45.r,
                                            backgroundColor:
                                                const Color(0xFF931E1E),
                                            child: Center(
                                              child: Icon(
                                                Icons.add,
                                                size: 36.h,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    addrecept
                        ? SizedBox(
                            width: double.infinity,
                            height: 840.h,
                            child: Center(
                              child: Container(
                                height: 370.h,
                                width: 330.w,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF931E1E),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12.r))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.h, horizontal: 20.w),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 55.h,
                                        width: 300.w,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.r)),
                                          // ignore: use_full_hex_values_for_flutter_colors
                                          color: const Color(0xffdd9d9d9)
                                              .withValues(alpha: 0.25),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w),
                                          child: Center(
                                            child: TextField(
                                              controller: tipController,
                                              focusNode:
                                                  _nodeText1, // Использование первого FocusNode
                                              decoration: InputDecoration(
                                                  border: InputBorder
                                                      .none, // Убираем обводку
                                                  focusedBorder: InputBorder
                                                      .none, // Убираем обводку при фокусе
                                                  hintText: 'Name of recipe',
                                                  hintStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white
                                                          .withValues(
                                                              alpha: 0.25),
                                                      fontSize: 18.sp)),
                                              keyboardType: TextInputType.text,
                                              cursorColor: Colors.transparent,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.sp),
                                              onChanged: (text) {
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.h),
                                        child: Container(
                                          height: 180.h,
                                          width: 300.w,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.r)),
                                            color: const Color(0xFFD9D9D9)
                                                .withValues(alpha: 0.25),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w),
                                            child: TextField(
                                              minLines: 1,
                                              maxLines:
                                                  null, // Позволяет полю расширяться по мере добавления строк
                                              controller: notesController,
                                              focusNode:
                                                  _nodeText2, // Использование второго FocusNode
                                              textInputAction:
                                                  TextInputAction.newline,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  hintText: 'Description',
                                                  hintStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white
                                                          .withValues(
                                                              alpha: 0.25),
                                                      fontSize: 18.sp)),
                                              cursorColor:
                                                  const Color(0xFF6C6D33),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.sp),
                                              onChanged: (text) {
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 20.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                addrecept = false;
                                                _nodeText1.unfocus();
                                                _nodeText2.unfocus();
                                                setState(() {});
                                              },
                                              child: Container(
                                                width: 120.w,
                                                height: 40.h,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF84853F),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              20.r)),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Back",
                                                    style: TextStyle(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                addrecept = false;
                                                box.add(Recipes(
                                                    date: tipController.text,
                                                    note:
                                                        notesController.text));
                                                tipController.text = "";
                                                notesController.text = "";
                                                _nodeText1.unfocus();
                                                _nodeText2.unfocus();
                                                setState(() {});
                                              },
                                              child: Container(
                                                width: 120.w,
                                                height: 40.h,
                                                decoration: BoxDecoration(
                                                  color: _updateFormCompletion()
                                                      ? const Color(0xFF84853F)
                                                      : const Color.fromARGB(
                                                          255, 48, 49, 5),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              20.r)),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Create",
                                                    style: TextStyle(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink()
                  ],
                ),
              ),
            );
          }),
    );
  }
}
