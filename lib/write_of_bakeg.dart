import 'package:flutter/material.dart';
import 'package:bakery/data/bakeg.dart';
import 'package:bakery/data/boxes.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class WriteOfBakeg extends StatefulWidget {
  const WriteOfBakeg({super.key});

  @override
  State<WriteOfBakeg> createState() => _WriteOfBakegState();
}

class _WriteOfBakegState extends State<WriteOfBakeg> {
  bool _areAllFieldsFilled() {
    for (var controller in countControllers) {
      if (controller.text.isEmpty) return false;
    }

    return date.text.isNotEmpty; // Check date field as well
  }

  List<String?> selectedValues = [];
  TextEditingController date = TextEditingController();
  List<TextEditingController> countControllers = [];
  List<String> nameSol = [];

  List<FocusNode> focusNodes1 = [];
  List<CardHelper> cards = [];
  int currentIndex = -1;
  bool addbakeg = false;
  bool opencard = false;
  bool imit = false;
  Set<String> name = {};

  @override
  void dispose() {
    for (var controller in countControllers) {
      controller.dispose();
    }

    for (var focusNode in focusNodes1) {
      focusNode.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable:
              Hive.box<Bakeg_Write_Of>(HiveBoxes.bakegWriteOf).listenable(),
          builder: (context, Box<Bakeg_Write_Of> box, _) {
            if (!imit) {
              name.clear();
              Box<Bakeg_Info> infoBox =
                  Hive.box<Bakeg_Info>(HiveBoxes.bakegInfo);
              if (infoBox.isNotEmpty) {
                infoBox.values.last.info.forEach((key, value) {
                  name.add("$value $key");
                });

                cards = List.generate(name.length,
                    (index) => CardHelper(id: index, items: name.toList()));
                imit = true;
              }
            }
            nameSol.clear();
            for (int i = 0; i < box.values.length; i++) {
              int j = 0;
              String text = "";
              for (var action in box.getAt(i)!.writeOfBakeg!) {
                if (j == box.getAt(i)!.writeOfBakeg!.length - 1) {
                  text += ("${action["count"]!}-${action["name"]!}");
                } else {
                  text += ("${action["count"]!}-${action["name"]!}, ");
                }

                j++;
              }
              nameSol.add(text);
            }

            return Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: SingleChildScrollView(
                    physics: addbakeg
                        ? const NeverScrollableScrollPhysics()
                        : const ScrollPhysics(),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 70.h, bottom: 20.h),
                          child: SizedBox(
                            width: 380.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Baked goods written off",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 24.sp)),
                                GestureDetector(
                                  onTap: () {
                                    if (!addbakeg) {
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: CircleAvatar(
                                    radius: 27.r,
                                    backgroundColor: addbakeg
                                        ? const Color(0xFF931E1E)
                                            .withOpacity(0.5)
                                        : const Color(0xFF931E1E),
                                    child: Icon(
                                      IconsaxPlusLinear.house_2,
                                      size: 27.h,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        for (int i = box.values.length - 1; i >= 0; i--) ...[
                          GestureDetector(
                            onTap: () {
                              currentIndex = i;
                              setState(() {});
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: Container(
                                width: 300.w,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF931E1E),
                                    border: currentIndex == i
                                        ? Border.all(
                                            color: const Color(0xFF84853F),
                                            width: 2.w)
                                        : null,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12.r))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 2.h, horizontal: 10.w),
                                      child: Text(
                                        box.getAt(i)!.date.toString(),
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            color: const Color(0xFF6C6D33)),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 2.h, horizontal: 10.w),
                                      child: Text(
                                        nameSol[i],
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: SizedBox(
                            width: double.maxFinite,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 350.w,
                                  child: Text("Add new sold baked goods ",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.sp)),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                InkWell(
                                  onTap: () {
                                    if (cards.isNotEmpty) {
                                      addbakeg = true;
                                    } else {
                                      showAlertDialog(context);
                                    }
                                    setState(() {});
                                  },
                                  child: CircleAvatar(
                                    radius: 45.r,
                                    backgroundColor: const Color(0xFF931E1E),
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
                        box.length == 0
                            ? Padding(
                                padding: EdgeInsets.symmetric(vertical: 80.h),
                                child: Column(
                                  children: [
                                    Text(
                                      "Empty",
                                      style: TextStyle(
                                          color: const Color(0xFF931E1E),
                                          fontSize: 24.sp),
                                    ),
                                    Text(
                                      textAlign: TextAlign.center,
                                      "You don't have any Baked goods written off.",
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 20.sp),
                                    ),
                                    Container(
                                      height: 200.h,
                                      width: 200.h,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/empty.png"))),
                                    )
                                  ],
                                ),
                              )
                            : const SizedBox.shrink()
                      ],
                    ),
                  ),
                ),
                addbakeg
                    ? KeyboardActions(
                        config: KeyboardActionsConfig(
                          keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
                          nextFocus:
                              true, // Это позволит переключаться на следующее поле
                          actions: [
                            for (int i = 0; i < focusNodes1.length; i++)
                              KeyboardActionsItem(
                                focusNode: focusNodes1[i],
                                displayDoneButton:
                                    true, // Показываем кнопку "Done" для всех полей
                              ),
                          ],
                        ),
                        child: Container(
                          width: double.infinity,
                          color: Colors.transparent.withOpacity(0.3),
                          child: Center(
                            child: SafeArea(
                              child: Container(
                                width: 310.w,
                                height: 500.h,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF84853F),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.r))),
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.w, vertical: 10.h),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Date",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24.sp)),
                                            InkWell(
                                              onTap: () {
                                                countControllers.clear();
                                                date.clear();
                                                selectedValues.clear();
                                                addbakeg = false;
                                                setState(() {});
                                              },
                                              child: CircleAvatar(
                                                radius: 15.r,
                                                backgroundColor:
                                                    const Color(0xFFD9D9D9),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.clear,
                                                    size: 20.h,
                                                    color:
                                                        const Color(0xFF931E1E),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.h),
                                            child: Container(
                                              height: 40.h,
                                              width: 130.w,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12.r)),
                                                color: const Color(0xFFD9D9D9),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w),
                                                child: Center(
                                                  child: TextField(
                                                    textAlign: TextAlign.center,
                                                    controller: date,
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        hintText: 'XX.XX.XXXX',
                                                        hintStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: const Color(
                                                                    0xFF6C6D33)
                                                                .withOpacity(
                                                                    0.5),
                                                            fontSize: 18.sp)),
                                                    keyboardType:
                                                        TextInputType.datetime,
                                                    cursorColor:
                                                        Colors.transparent,
                                                    style: TextStyle(
                                                        color: const Color(
                                                            0xFF6C6D33),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18.sp),
                                                    onChanged: (text) {
                                                      setState(() {});
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.h),
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              "Quantity of baked goods",
                                              style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.5),
                                                  fontSize: 20.sp),
                                            ),
                                          ),
                                        ),
                                        for (int i = 0;
                                            i < selectedValues.length &&
                                                i < cards.length;
                                            i++)
                                          Column(
                                            children: [
                                              CardWidget(
                                                items: cards[i].items,
                                                selectedItemCallback:
                                                    (selectedValue) {
                                                  if (i <
                                                          selectedValues
                                                              .length &&
                                                      i < cards.length) {
                                                    selectedValues[i] =
                                                        selectedValue;
                                                  }
                                                  for (int j = 0;
                                                      j < cards.length;
                                                      j++) {
                                                    if (i == j) continue;
                                                    cards[j]
                                                        .items
                                                        .remove(selectedValue);
                                                  }
                                                  setState(() {});
                                                },
                                              ),
                                              if (selectedValues[i] !=
                                                  null) ...[
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.w,
                                                      vertical: 10.h),
                                                  child: SizedBox(
                                                    width: 250.w,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          height: 40.h,
                                                          width: 60.w,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        12.r)),
                                                            color: const Color(
                                                                0xFFD9D9D9),
                                                          ),
                                                          child: Center(
                                                            child: TextField(
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              controller: countControllers[
                                                                  i] = countControllers
                                                                          .length >
                                                                      i
                                                                  ? countControllers[
                                                                      i]
                                                                  : TextEditingController(),
                                                              focusNode: focusNodes1[
                                                                  i] = focusNodes1
                                                                          .length >
                                                                      i
                                                                  ? focusNodes1[
                                                                      i]
                                                                  : FocusNode(),
                                                              decoration:
                                                                  InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                focusedBorder:
                                                                    InputBorder
                                                                        .none,
                                                                hintText: '0',
                                                                hintStyle:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: const Color(
                                                                          0xFF6C6D33)
                                                                      .withOpacity(
                                                                          0.5),
                                                                  fontSize:
                                                                      18.sp,
                                                                ),
                                                              ),
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              cursorColor: Colors
                                                                  .transparent,
                                                              style: TextStyle(
                                                                color: const Color(
                                                                    0xFF6C6D33),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18.sp,
                                                              ),
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {});
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 20.w,
                                                        ),
                                                        Container(
                                                            height: 40.h,
                                                            width: 170.w,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(12
                                                                            .r)),
                                                                color: const Color(
                                                                    0xFFD9D9D9)),
                                                            child: Center(
                                                              child: Text(
                                                                selectedValues[
                                                                        i]!
                                                                    .split(
                                                                        ' ')[1],
                                                                style: TextStyle(
                                                                    color: const Color(
                                                                        0xFF6C6D33),
                                                                    fontSize:
                                                                        16.sp),
                                                              ),
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.h),
                                          child: SizedBox(
                                            height: 100.h,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  child: SizedBox(
                                                    width: 80.w,
                                                    height: 30.h,
                                                    child: InkWell(
                                                      onTap: () {
                                                        focusNodes1
                                                            .add(FocusNode());
                                                        selectedValues
                                                            .add(null);
                                                        countControllers.add(
                                                            TextEditingController());

                                                        setState(
                                                            () {}); // Refresh state after adding fields
                                                      },
                                                      child: CircleAvatar(
                                                        radius: 15.r,
                                                        backgroundColor:
                                                            const Color(
                                                                0xFF6C6D33),
                                                        child: Center(
                                                          child: Icon(
                                                            Icons.add,
                                                            size: 20.h,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Column(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          addbakeg = false;
                                                          selectedValues
                                                              .clear();
                                                          countControllers
                                                              .clear();
                                                          date.clear();
                                                          setState(() {});
                                                        },
                                                        child: SizedBox(
                                                          width: 145.w,
                                                          height: 40.h,
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        12.5.w),
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: const Color(
                                                                      0xFF931E1E),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20.r))),
                                                              child: Center(
                                                                  child: Text(
                                                                "Back",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16.sp),
                                                              )),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 10.h),
                                                        child: SizedBox(
                                                          width: 145.w,
                                                          height: 40.h,
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        12.5.w),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                if (_areAllFieldsFilled()) {
                                                                  Box<Bakeg_Info>
                                                                      infoBox =
                                                                      Hive.box<
                                                                              Bakeg_Info>(
                                                                          HiveBoxes
                                                                              .bakegInfo);
                                                                  List<Map<String, String>>
                                                                      newElem =
                                                                      [];
                                                                  Map<String,
                                                                          String>
                                                                      info =
                                                                      infoBox
                                                                          .getAt(
                                                                              0)!
                                                                          .info;
                                                                  for (int i =
                                                                          0;
                                                                      i <
                                                                          selectedValues
                                                                              .length;
                                                                      i++) {
                                                                    newElem
                                                                        .add({
                                                                      "name": selectedValues[
                                                                              i]!
                                                                          .split(
                                                                              ' ')[1],
                                                                      "count":
                                                                          countControllers[i]
                                                                              .text
                                                                    });
                                                                    List<String>
                                                                        parts =
                                                                        selectedValues[i]!
                                                                            .split(" ");
                                                                    String output = parts
                                                                        .sublist(
                                                                            1)
                                                                        .join(
                                                                            " ");
                                                                    if (int.parse(selectedValues[i]!.split(' ')[0]) -
                                                                            int.parse(countControllers[i].text) ==
                                                                        0) {
                                                                      info.remove(
                                                                          output);
                                                                    } else {
                                                                      info[
                                                                          output] = (int.parse(selectedValues[i]!.split(' ')[0]) -
                                                                              int.parse(countControllers[i].text))
                                                                          .toString();
                                                                    }
                                                                  }
                                                                  box.add(Bakeg_Write_Of(
                                                                      date: date
                                                                          .text,
                                                                      writeOfBakeg:
                                                                          newElem));
                                                                  infoBox.putAt(
                                                                      0,
                                                                      Bakeg_Info(
                                                                          info:
                                                                              info));
                                                                  addbakeg =
                                                                      false;
                                                                  imit = false;
                                                                  countControllers
                                                                      .clear();
                                                                  date.clear();
                                                                  selectedValues
                                                                      .clear();
                                                                  setState(
                                                                      () {});
                                                                }
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: _areAllFieldsFilled()
                                                                      ? const Color(
                                                                          0xFF931E1E)
                                                                      : const Color(
                                                                              0xFF931E1E)
                                                                          .withOpacity(
                                                                              0.5),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20.r)),
                                                                ),
                                                                child: Center(
                                                                    child: Text(
                                                                  "Create",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          16.sp),
                                                                )),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ))
                    : currentIndex != -1
                        ? Container(
                            width: double.infinity,
                            height: 840.h,
                            color: Colors.transparent.withOpacity(0.3),
                            child: Center(
                              child: Container(
                                width: 290.w,
                                height: 360.h,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF6C6D33),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.r))),
                                child: SingleChildScrollView(
                                    child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 10.h),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Date",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 24.sp)),
                                          InkWell(
                                            onTap: () {
                                              currentIndex = -1;
                                              setState(() {});
                                            },
                                            child: CircleAvatar(
                                              radius: 15.r,
                                              backgroundColor:
                                                  const Color(0xFFD9D9D9),
                                              child: Center(
                                                child: Icon(
                                                  Icons.clear,
                                                  size: 20.h,
                                                  color:
                                                      const Color(0xFF931E1E),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.h),
                                          child: Container(
                                            height: 55.h,
                                            width: 200.w,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12.r)),
                                                color: const Color(0xFFD9D9D9)
                                                    .withOpacity(0.25),
                                                border: Border.all(
                                                    color:
                                                        const Color(0xFF6C6D33),
                                                    width: 2.w)),
                                            child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w),
                                                child: Center(
                                                  child: Text(
                                                      box
                                                          .getAt(currentIndex)!
                                                          .date
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: const Color(
                                                              0xFFCFCFCF),
                                                          fontSize: 18.sp)),
                                                )),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.h),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            "Quantity of baked goods",
                                            style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                                fontSize: 20.sp),
                                          ),
                                        ),
                                      ),
                                      for (int i = 0;
                                          i <
                                              box
                                                  .getAt(currentIndex)!
                                                  .writeOfBakeg!
                                                  .length;
                                          i++) ...[
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 80.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12.r)),
                                                    color:
                                                        const Color(0xFFD9D9D9)
                                                            .withOpacity(0.25),
                                                    border: Border.all(
                                                        color: const Color(
                                                            0xFF6C6D33),
                                                        width: 2.w)),
                                                child: Center(
                                                    child: Text(
                                                  box
                                                      .getAt(currentIndex)!
                                                      .writeOfBakeg![i]["count"]
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: const Color(
                                                          0xFFCFCFCF),
                                                      fontSize: 18.sp),
                                                )),
                                              ),
                                              Container(
                                                width: 145.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12.r)),
                                                    color:
                                                        const Color(0xFFD9D9D9)
                                                            .withOpacity(0.25),
                                                    border: Border.all(
                                                        color: const Color(
                                                            0xFF6C6D33),
                                                        width: 2.w)),
                                                child: Center(
                                                    child: Text(
                                                        box
                                                            .getAt(
                                                                currentIndex)!
                                                            .writeOfBakeg![i]
                                                                ["name"]
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: const Color(
                                                                0xFFCFCFCF),
                                                            fontSize: 18.sp))),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.h),
                                          child: SizedBox(
                                            child: InkWell(
                                              onTap: () {
                                                currentIndex = -1;
                                                setState(() {});
                                              },
                                              child: SizedBox(
                                                width: 145.w,
                                                height: 40.h,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 12.5.w),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xFF931E1E),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20.r))),
                                                    child: Center(
                                                        child: Text(
                                                      "Back",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16.sp),
                                                    )),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                              ),
                            ),
                          )
                        : const SizedBox.shrink()
              ],
            );
          }),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("You haven't baked any pastries"),
      content: Text("Go to the baking screen and enter the items you see."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class CardWidget extends StatefulWidget {
  final List<String> items;

  final Function(String?) selectedItemCallback;
  const CardWidget({
    super.key,
    required this.items,
    required this.selectedItemCallback,
  });

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: const Color(0xFF6C6D33),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DropdownButtonHideUnderline(
                  child: DropdownButton2(
                isExpanded: true,
                hint: const Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'Select a Key',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                items: widget.items
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Center(
                            child: Container(
                              width: 247.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                  color: const Color(0xFF6C6D33),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.r))),
                              child: Center(
                                child: Text(
                                  item,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: const Color(0xFFD9D9D9).withOpacity(0.25),
                  ),
                  offset: Offset(0, -10.h),
                  scrollbarTheme: ScrollbarThemeData(
                    radius: const Radius.circular(40),
                    thickness: WidgetStateProperty.all(6),
                    thumbVisibility: WidgetStateProperty.all(true),
                  ),
                ),
                value: selectedValue,
                onChanged: (value) {
                  widget.selectedItemCallback(value); // Call the callback
                  setState(() {
                    selectedValue = value as String; // Save the value locally
                  });
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class CardHelper {
  final int id;
  final List<String> items;
  final String? selectedItem;

  CardHelper({
    required this.id,
    required this.items,
    this.selectedItem,
  });
}
