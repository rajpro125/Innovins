// ignore_for_file: always_specify_types, avoid_dynamic_calls

import "package:flutter/material.dart";
import "package:flutterinterviewproject/models/model.dart";
import "package:flutterinterviewproject/models/product_list_model.dart";
import "package:flutterinterviewproject/services/api_service.dart";
import "package:flutterinterviewproject/services/storage_service.dart";
import "package:get/get.dart";

class ProductListController extends GetxController {
  final ApiServices _httpClient = ApiServices();
  RxList<ProductList> productList = <ProductList>[].obs;
  RxBool isLoading = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await productListApi();
  }

  Future<void> productListApi() async {
    isLoading.value = true;
    final Data? userData = StorageServices().getUserData().data;
    final String userToken = userData?.userToken ?? "";


    await _httpClient.postMethod(
      "productList.php",
      <String, String>{"user_login_token": userToken},
          (response) {
        final List<dynamic> productListJson = response;
        productList.assignAll(
          productListJson.map((json) => ProductList.fromJson(json)).toList(),
        );
        isLoading.value = false;
      },
          (error) {
        final title = error["title"] ?? "";
        final message = error["message"] ?? "";
        isLoading.value = false;
        Get.snackbar(
          "$title",
          "$message",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }

  productDeleteApi(String Id) async{
    await ApiServices().postMethod("deleteProduct.php", <String, String>{
      "user_login_token": StorageServices().getUserData().data?.userToken ?? "",
      "id": Id,
    } , (map) async{

      final title = map["title"] ?? "";
      final message = map["message"] ?? "";

      await Future.delayed(Duration(seconds: 1));
      await productListApi();

      Get.snackbar(
        "$title",
        "$message",
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
      );

    }, (map) {
      final title = map["title"] ?? "";
      final message = map["message"] ?? "";

      Get.snackbar(
        "$title",
        "$message",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    } );
  }
}
