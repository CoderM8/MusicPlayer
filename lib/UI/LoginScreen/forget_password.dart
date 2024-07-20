import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:musicplayer/Constants/Custom_widget/textformfield.dart';
import 'package:musicplayer/Constants/Custom_widget/textwidget.dart';
import 'package:musicplayer/Constants/constant.dart';
import 'package:http/http.dart' as http;
import '../../Controller/login_controller.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final LoginController logincontroller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextWidget.regular('Forget Password', fontSize: 20.sp, fontWeight: FontWeight.bold),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Form(
          key: logincontroller.forgetformKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFieldWidget(
                borderRadius: 15.r,
                labelText: 'email'.tr,
                labelstyle: TextStyle(fontSize: 16.sp, fontFamily: "Poppins-Medium"),
                prefixIcon: const Icon(Icons.email),
                style: TextStyle(fontSize: 18.sp, fontFamily: "Poppins-Medium"),
                hintText: 'enteremail'.tr,
                keyboardType: TextInputType.emailAddress,
                controller: logincontroller.foremail,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'emailisnotempty'.tr;
                  }
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regex = RegExp(pattern);
                  if (!regex.hasMatch(value)) {
                    return 'entervalidemail'.tr;
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 20.h),
              Center(
                  child: InkWell(
                onTap: () async {
                  if (logincontroller.forgetformKey.currentState!.validate()) {
                    Map body = {
                      "data":
                          '{"method_name":"forgot_pass","package_name":"com.vinodflutter.musicPlayerDemo","user_email":"${logincontroller.foremail.text}"}'
                    };
                    final response = await http.post(Uri.parse(postApi), body: body);
                    if (response.statusCode == 200) {
                      final data = jsonDecode(response.body);
                      if (data['ONLINE_MP3'][0]['success'] == '1') {
                        snackbar(title: data['ONLINE_MP3'][0]['msg'], message: '');
                        logincontroller.useremail.clear();
                      } else {
                        snackbar(title: data['ONLINE_MP3'][0]['msg'], message: '');
                      }
                    }
                  }
                },
                child: Container(
                  height: 55.h,
                  width: 125.w,
                  decoration: BoxDecoration(
                    color: Get.theme.colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Center(
                    child: TextWidget.regular('Send', color: Colors.white, fontFamily: "Poppins-Medium"),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
