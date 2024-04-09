// ignore_for_file: always_declare_return_types, type_annotate_public_apis, always_specify_types, lines_longer_than_80_chars, avoid_dynamic_calls

import "package:flutter/material.dart";
import "package:flutterinterviewproject/routes/Route.dart";
import "package:flutterinterviewproject/services/api_service.dart";
import "package:flutterinterviewproject/services/storage_service.dart";
import "package:get/get.dart";

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ApiServices _httpClient = ApiServices();

  var isObscure = true.obs;

  void togglePasswordVisibility() {
    isObscure.toggle();
  }

  loginApi() async {
     await _httpClient.postMethod("Login.php", <String, String>{
       "email": emailController.value.text.trim(),
       "password": passwordController.value.text.trim(),
     }, (map) async{

       final title = map["title"] ?? "";
       final message = map["message"] ?? "";

       Get.snackbar(
         "$title",
         "$message",
         backgroundColor: Colors.green,
         colorText: Colors.white,
         snackPosition: SnackPosition.BOTTOM,
       );

       await StorageServices().setData(map);
       await Get.offAllNamed(RouteName.productListScreen);
     }, (map) {
       final title = map["title"] ?? "";
       final message = map["message"] ?? "";

       Get.snackbar(
         "$title",
         "$message",
         backgroundColor: Colors.red,
         colorText: Colors.white,
         snackPosition: SnackPosition.BOTTOM,
       );
     });
  }


}
