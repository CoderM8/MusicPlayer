import 'dart:io';
import 'package:get/get.dart';
import 'package:musicplayer/Constants/dynamic_link.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../httpmodel/getuserupdate_model.dart';
import '../service/httpservice.dart';

class UserController extends GetxController {
  String? userName;
  String? userEmail;
  String? userImage;
  String? userId;
  String? phone;
  final RxBool isguest = false.obs;

  static const String appShareAndroid = 'https://play.google.com/store';
  static const String appShareIOS = 'https://www.apple.com/in/app-store/';

  @override
  Future<void> onInit() async {
    dynamicLink();
    super.onInit();
  }

  Future getuser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('user_id');
    isguest.value = prefs.getBool('guest') ?? false;
    if (userId != null) {
      await HttpService().getUserService(userId: userId).then((value) async {
        await prefs.setString('name', value.onlineMp3[0].name);
        await prefs.setString('email', value.onlineMp3[0].email);
        await prefs.setString('image', value.onlineMp3[0].userImage);
        await prefs.setString('phone', value.onlineMp3[0].phone);
        userName = prefs.getString('name');
        userEmail = prefs.getString('email');
        userImage = prefs.getString('image');
        phone = prefs.getString('phone');
        update();
      });
    }
  }

  String getAppShare() {
    if (Platform.isIOS) {
      return appShareIOS;
    } else {
      return appShareAndroid;
    }
  }

  Future<GetUserUpdateModel> getUpdataController({String? name, String? email, File? image, String? userid, String? phone}) async {
    return await HttpService().getUserUpdateService(userImage: image, userId: userid, email: email, name: name, phone: phone);
  }
}
