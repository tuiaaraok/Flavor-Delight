import 'package:bakery/data/bakeg.dart';
import 'package:bakery/data/boxes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class BakedPage extends StatefulWidget {
  const BakedPage({super.key});

  @override
  State<StatefulWidget> createState() => _BakedPageState();
}

class _BakedPageState extends State<BakedPage> {
  bool addbakeg = false;
  bool opencard = false;
  TextEditingController date = TextEditingController();
  int currentIndex = -1;

  List<TextEditingController> countProductControllers = [];
  List<TextEditingController> productNameControllers = [];
  List<FocusNode> focusNodes1 = [];
  List<FocusNode> focusNodes2 = [];
  List<String> name = [];

  bool _areAllFieldsFilled() {
    for (var controller in productNameControllers) {
      if (controller.text.isEmpty) return false;
    }
    for (var controller in countProductControllers) {
      if (controller.text.isEmpty) return false;
    }
    return date.text.isNotEmpty; // Check date field as well
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<Bakeg_Good>(HiveBoxes.bakegGood).listenable(),
        builder: (context, Box<Bakeg_Good> box, _) {
          name.clear();
          for (int i = 0; i < box.values.length; i++) {
            int j = 0;
            String text = "";
            for (var action in box.getAt(i)!.goodBakeg!) {
              if (j == box.getAt(i)!.goodBakeg!.length - 1) {
                text += ("${action["count"]!}-${action["name"]!}");
              } else {
                text += ("${action["count"]!}-${action["name"]!}, ");
              }

              j++;
            }
            name.add(text);
          }

          return Scaffold(
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 70.h, bottom: 20.h),
                        child: SizedBox(
                          width: 380.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Baked goods",
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
                                      ? const Color(0xFF931E1E).withOpacity(0.5)
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
                                  color: const Color(0xFF84853F),
                                  border: currentIndex == i
                                      ? Border.all(
                                          color: const Color(0xFF931E1E),
                                          width: 2.w)
                                      : null,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.r))),
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
                                          color: const Color(0xFF931E1E)),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 2.h, horizontal: 10.w),
                                    child: Text(
                                      name[i],
                                      style: TextStyle(
                                          fontSize: 18.sp, color: Colors.white),
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
                                child: Text("Add new baked goods",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.sp)),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              InkWell(
                                onTap: () {
                                  addbakeg = true;
                                  countProductControllers
                                      .add(TextEditingController());
                                  productNameControllers
                                      .add(TextEditingController());
                                  focusNodes1.add(FocusNode());
                                  focusNodes2.add(FocusNode());

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
                              box.length == 0
                                  ? SizedBox(
                                      height: 500.h,
                                      child: Center(
                                        child: SizedBox(
                                          height: 100.h,
                                          child: Column(
                                            children: [
                                              Text(
                                                "Empty",
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xFF931E1E),
                                                    fontSize: 24.sp),
                                              ),
                                              Text(
                                                textAlign: TextAlign.center,
                                                "You don't have any Sold baked goods.",
                                                style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.5),
                                                    fontSize: 20.sp),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink()
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                addbakeg
                    ? KeyboardActions(
                        config: KeyboardActionsConfig(
                          keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
                          nextFocus: true,
                          actions: [
                            for (int i = 0; i < focusNodes1.length; i++)
                              KeyboardActionsItem(
                                focusNode: focusNodes1[i],
                                displayDoneButton: true,
                              ),
                            for (int i = 0; i < focusNodes2.length; i++)
                              KeyboardActionsItem(
                                focusNode: focusNodes2[i],
                                displayDoneButton: true,
                              ),
                          ],
                        ),
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.8,
                          color: Colors.transparent.withOpacity(0.3),
                          child: Center(
                            child: Container(
                              width: 290.w,
                              height: 360.h,
                              decoration: BoxDecoration(
                                  color: const Color(0xFF931E1E),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.r))),
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
                                            addbakeg = false;
                                            countProductControllers.clear();
                                            productNameControllers.clear();
                                            date.clear();

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
                                                color: const Color(0xFF931E1E),
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
                                              child: TextField(
                                                controller: date,
                                                textAlign: TextAlign.center,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    hintText: 'XX.XX.XXXX',
                                                    hintStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white
                                                            .withOpacity(0.25),
                                                        fontSize: 18.sp)),
                                                keyboardType:
                                                    TextInputType.datetime,
                                                cursorColor: Colors.transparent,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.sp),
                                                onChanged: (text) {
                                                  setState(
                                                      () {}); // Call setState here
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.h),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          "Quantity of baked goods",
                                          style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                              fontSize: 20.sp),
                                        ),
                                      ),
                                    ),
                                    for (int i = 0;
                                        i < productNameControllers.length;
                                        i++) ...[
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 40.h,
                                              width: 80.w,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              12.r)),
                                                  color: const Color(0xFFD9D9D9)
                                                      .withOpacity(0.25),
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xFF6C6D33),
                                                      width: 2.w)),
                                              child: TextField(
                                                textAlign: TextAlign.center,
                                                controller: countProductControllers[
                                                    i] = countProductControllers
                                                            .length >
                                                        i
                                                    ? countProductControllers[i]
                                                    : TextEditingController(),
                                                focusNode: focusNodes1[i] =
                                                    focusNodes1.length > i
                                                        ? focusNodes1[i]
                                                        : FocusNode(),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  hintText: '0',
                                                  hintStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white
                                                        .withOpacity(0.5),
                                                    fontSize: 18.sp,
                                                  ),
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                                cursorColor: Colors.transparent,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.sp,
                                                ),
                                                onChanged: (text) {
                                                  setState(
                                                      () {}); // Call setState here
                                                },
                                              ),
                                            ),
                                            Container(
                                              height: 40.h,
                                              width: 145.w,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              12.r)),
                                                  color: const Color(0xFFD9D9D9)
                                                      .withOpacity(0.25),
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xFF6C6D33),
                                                      width: 2.w)),
                                              child: Center(
                                                child: TextField(
                                                  textAlign: TextAlign.center,
                                                  maxLines: 1,
                                                  controller: productNameControllers[
                                                      i] = productNameControllers
                                                              .length >
                                                          i
                                                      ? productNameControllers[
                                                          i]
                                                      : TextEditingController(),
                                                  focusNode: focusNodes2[i] =
                                                      focusNodes2.length > i
                                                          ? focusNodes2[i]
                                                          : FocusNode(),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    hintText: "Product",
                                                    hintStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white
                                                          .withOpacity(0.5),
                                                      fontSize: 18.sp,
                                                    ),
                                                  ),
                                                  cursorColor:
                                                      const Color(0xFF6C6D33),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.sp,
                                                  ),
                                                  onChanged: (text) {
                                                    setState(
                                                        () {}); // Call setState here
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.h),
                                      child: SizedBox(
                                        height: 100.h,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                              alignment: Alignment.topCenter,
                                              child: SizedBox(
                                                width: 80.w,
                                                height: 30.h,
                                                child: InkWell(
                                                  onTap: () {
                                                    countProductControllers.add(
                                                        TextEditingController());
                                                    productNameControllers.add(
                                                        TextEditingController());
                                                    focusNodes1
                                                        .add(FocusNode());
                                                    focusNodes2
                                                        .add(FocusNode());
                                                    setState(
                                                        () {}); // Refresh state after adding fields
                                                  },
                                                  child: CircleAvatar(
                                                    radius: 15.r,
                                                    backgroundColor:
                                                        const Color(0xFF6C6D33),
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
                                              alignment: Alignment.bottomCenter,
                                              child: Column(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      countProductControllers
                                                          .clear();
                                                      productNameControllers
                                                          .clear();
                                                      date.clear();
                                                      addbakeg = false;
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
                                                                  0xFF84853F),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
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
                                                    padding: EdgeInsets.only(
                                                        top: 10.h),
                                                    child: SizedBox(
                                                      width: 145.w,
                                                      height: 40.h,
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    12.5.w),
                                                        child: GestureDetector(
                                                          onTap:
                                                              _areAllFieldsFilled()
                                                                  ? () {
                                                                      List<Map<String, String>>
                                                                          newElem =
                                                                          [];
                                                                      Map<String,
                                                                              String>
                                                                          info =
                                                                          {};
                                                                      Box<Bakeg_Info>
                                                                          infoBox =
                                                                          Hive.box<Bakeg_Info>(
                                                                              HiveBoxes.bakegInfo);

                                                                      if (infoBox
                                                                          .isEmpty) {
                                                                        for (int i =
                                                                                0;
                                                                            i < productNameControllers.length;
                                                                            i++) {
                                                                          info[productNameControllers[i].text] =
                                                                              countProductControllers[i].text;
                                                                          newElem
                                                                              .add({
                                                                            "name":
                                                                                productNameControllers[i].text,
                                                                            "count":
                                                                                countProductControllers[i].text
                                                                          });
                                                                        }

                                                                        infoBox.add(Bakeg_Info(
                                                                            info:
                                                                                info));
                                                                      } else {
                                                                        info.addAll(infoBox
                                                                            .getAt(0)!
                                                                            .info);
                                                                        for (int i =
                                                                                0;
                                                                            i < productNameControllers.length;
                                                                            i++) {
                                                                          if (info
                                                                              .containsKey(productNameControllers[i].text)) {
                                                                            info[productNameControllers[i].text] =
                                                                                (int.parse(countProductControllers[i].text) + int.parse(info[productNameControllers[i].text]!)).toString();
                                                                          } else {
                                                                            info[productNameControllers[i].text] =
                                                                                countProductControllers[i].text;
                                                                          }
                                                                          newElem
                                                                              .add({
                                                                            "name":
                                                                                productNameControllers[i].text,
                                                                            "count":
                                                                                countProductControllers[i].text
                                                                          });
                                                                        }
                                                                        infoBox.putAt(
                                                                            0,
                                                                            Bakeg_Info(info: info));
                                                                      }

                                                                      box.add(Bakeg_Good(
                                                                          date: date
                                                                              .text,
                                                                          goodBakeg:
                                                                              newElem));
                                                                      countProductControllers
                                                                          .clear();
                                                                      productNameControllers
                                                                          .clear();
                                                                      date.clear();
                                                                      addbakeg =
                                                                          false;

                                                                      setState(
                                                                          () {});
                                                                    }
                                                                  : null,
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: _areAllFieldsFilled()
                                                                  ? const Color(
                                                                      0xFF84853F)
                                                                  : Colors.red,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
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
                              )),
                            ),
                          ),
                        ),
                      )
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
                                    color: const Color(0xFF931E1E),
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
                                      for (int i = box
                                                  .getAt(currentIndex)!
                                                  .goodBakeg!
                                                  .length -
                                              1;
                                          i >= 0;
                                          i--) ...[
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
                                                      .goodBakeg![i]["count"]
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
                                                            .goodBakeg![i]
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
                                                            0xFF84853F),
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
            ),
          );
        });
  }
}

class YourWidget extends StatelessWidget {
  final bool opencard;
  final List<String> name;
  final int currentIndex;

  const YourWidget(
      {super.key,
      required this.opencard,
      required this.name,
      required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    List<String> items = name[currentIndex]
        .replaceAll(', ', ' ') // Убираем запятые, чтобы использовать split
        .split(' '); // Разделяем строку по пробелам

    return opencard
        ? Container(
            width: double.infinity,
            height: 840.h,
            color: Colors.transparent.withOpacity(0.3),
            child: Center(
              child: Container(
                width: 290.w,
                height: 500.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF931E1E),
                  borderRadius: BorderRadius.all(Radius.circular(20.r)),
                ),
                child: Wrap(
                  children: items.map((item) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 5.h,
                          horizontal: 10.w), // Отступ между контейнерами
                      padding: EdgeInsets.all(10.r), // Внутренний отступ
                      color: Colors.white, // Цвет контейнера
                      child: Text(
                        item,
                        style: TextStyle(fontSize: 20.sp), // Размер текста
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
