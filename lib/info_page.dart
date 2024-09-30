import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:launch_review/launch_review.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Row(children: [
                  Text(
                    "Help ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  Icon(
                    IconsaxPlusLinear.candle_2,
                    color: Colors.white,
                    size: 24.h,
                  )
                ]),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Container(
                    width: 300.h,
                    height: 300.h,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: AssetImage("assets/info.png"))),
                  )),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () async {
                          String? encodeQueryParameters(
                              Map<String, String> params) {
                            return params.entries
                                .map((MapEntry<String, String> e) =>
                                    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                .join('&');
                          }

                          // ···
                          final Uri emailLaunchUri = Uri(
                            scheme: 'mailto',
                            path: 'TravisJohnson9902@outlook.com',
                            query: encodeQueryParameters(<String, String>{
                              '': '',
                            }),
                          );
                          try {
                            if (await canLaunchUrl(emailLaunchUri)) {
                              await launchUrl(emailLaunchUri);
                            } else {
                              throw Exception(
                                  "Could not launch $emailLaunchUri");
                            }
                          } catch (e) {
                            print(
                                'Error launching email client: $e'); // Log the error
                          }
                        },
                        child: Container(
                          width: 310.w,
                          height: 55.h,
                          decoration: BoxDecoration(
                              color: Color(0xFF931E1E),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.r))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 10.w,
                              ),
                              Icon(
                                IconsaxPlusLinear.sms,
                                size: 32.h,
                                color: Colors.white,
                              ),
                              SizedBox(
                                  width:
                                      8), // Добавьте немного пространства между иконкой и текстом
                              Expanded(
                                child: Text(
                                  "Contact us",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.sp),
                                  textAlign:
                                      TextAlign.center, // Центрируем текст
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 21.h,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () async {
                          final Uri _url = Uri.parse('https://flutter.dev');
                          if (!await launchUrl(_url)) {
                            throw Exception('Could not launch $_url');
                          }
                        },
                        child: Container(
                          width: 310.w,
                          height: 55.h,
                          decoration: BoxDecoration(
                              color: Color(0xFF931E1E),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.r))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 10.w,
                              ),
                              Icon(
                                IconsaxPlusLinear.security_safe,
                                size: 32.h,
                                color: Colors.white,
                              ),
                              SizedBox(
                                  width:
                                      8), // Добавьте немного пространства между иконкой и текстом
                              Expanded(
                                child: Text(
                                  "Privacy policy",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.sp),
                                  textAlign:
                                      TextAlign.center, // Центрируем текст
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 21.h,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () async {
                          LaunchReview.launch(
                              androidAppId: "app.openauthenticator",
                              iOSAppId: "585027354");
                        },
                        child: Container(
                          width: 310.w,
                          height: 55.h,
                          decoration: BoxDecoration(
                              color: Color(0xFF931E1E),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.r))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 10.w,
                              ),
                              Icon(
                                IconsaxPlusLinear.global_search,
                                size: 32.h,
                                color: Colors.white,
                              ),
                              SizedBox(
                                  width:
                                      8), // Добавьте немного пространства между иконкой и текстом
                              Expanded(
                                child: Text(
                                  "Rate us",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.sp),
                                  textAlign:
                                      TextAlign.center, // Центрируем текст
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 21.h,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 38.h),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    radius: 36.r,
                    backgroundColor: Color(0xFF931E1E),
                    child: Center(
                      child: Icon(
                        IconsaxPlusLinear.house_2,
                        size: 36.h,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
