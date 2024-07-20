import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:musicplayer/Constants/Language/language_model.dart';
import 'package:provider/provider.dart';
import '../../Constants/Custom_widget/textwidget.dart';
import '../../Constants/Language/language_constant.dart';
import '../../Constants/constant.dart';

class LanguageScreen extends StatelessWidget {
  LanguageScreen({Key? key}) : super(key: key);

  final RxInt selectedindex = 0.obs;

  @override
  Widget build(BuildContext context) {
    final localization = Provider.of<LocalizationController>(context, listen: false);

    Get.locale!.languageCode;
    selectedindex.value = Language.languageList.indexWhere((element) => element.languageCode == Get.locale!.languageCode);
    print('lan---${Get.locale!.languageCode}');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextWidget.regular('language'.tr, fontFamily: "Poppins-Bold", fontSize: 20.sp),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
        child: SizedBox(
          height: 300.h,
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: Language.languageList.length,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 10.h,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return Obx(() {
                selectedindex.value;
                return ListTile(
                  onTap: () async {
                    // Get.updateLocale(Locale(Language.languageList[index].languageCode, Language.languageList[index].countryCode));
                    await localization.setLocale(Language.languageList[index].languageCode);
                    Get.updateLocale(Locale(Language.languageList[index].languageCode, Language.languageList[index].countryCode));
                    selectedindex.value = index;
                    userLanguage();

                    // changeLanguage(Language.languageList[index].languageCode);
                    final snackBar = SnackBar(
                      duration: const Duration(seconds: 1),
                      content: Row(
                        children: [
                          TextWidget.regular(Language.languageList[index].name,
                              fontSize: 20.sp, fontFamily: "Poppins-Regular", color: Get.theme.colorScheme.primary),
                          SizedBox(width: 8.w),
                          TextWidget.regular("languagesetsuccessfully".tr,
                              fontFamily: "Poppins-Medium", color: Get.theme.colorScheme.primary, fontSize: 15.sp),
                        ],
                      ),
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.all(15.0),
                      dismissDirection: DismissDirection.startToEnd,
                      backgroundColor: shimmerGreen,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    // Language.languageList[index].id = selectedindex.value;
                    // selectedindex.value = index;
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  leading: TextWidget.regular(Language.languageList[index].flag, fontSize: 25.sp),
                  title: TextWidget.regular(Language.languageList[index].name,
                      fontSize: 20.sp, textAlign: TextAlign.start, fontFamily: "Poppins-Regular"),
                  trailing: selectedindex.value == index
                      ? SvgPicture.asset(
                          'assets/icons/done.svg',
                          height: 30.w,
                          width: 30.w,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : null,
                );
              });
            },
          ),
        ),
      ),
    );
  }
}
