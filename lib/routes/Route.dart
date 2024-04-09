import "package:flutterinterviewproject/bindings/login_binding.dart";
import "package:flutterinterviewproject/bindings/product_detail_binding.dart";
import "package:flutterinterviewproject/bindings/product_list_binding.dart";
import "package:flutterinterviewproject/bindings/register_binding.dart";
import "package:flutterinterviewproject/screens/login_screen.dart";
import "package:flutterinterviewproject/screens/product_detail_screen.dart";
import "package:flutterinterviewproject/screens/product_list_screen.dart";
import "package:flutterinterviewproject/screens/register_screen.dart";
import "package:flutterinterviewproject/services/storage_service.dart";
import "package:get/get.dart";

class RouteName {
  static const String root = "/";
  static const String registerScreen = "/registerScreen";
  static const String productListScreen = "/productListScreen";
  static const String productDetailScreen = "/productDetailScreen";
}

List<String> get validRoutes {
  return <String>[
    RouteName.root,
    RouteName.registerScreen,
    RouteName.productListScreen,
    RouteName.productDetailScreen,
  ];
}

class Routes {
  static final List<GetPage> routes = <GetPage>[
    GetPage(
      page: () => const LoginScreen(),
      name: RouteName.root,
      binding: LoginBinding(),
    ),
    GetPage(
        page: () => const RegisterScreen(),
        name: RouteName.registerScreen,
        binding: RegisterBinding(),),
    GetPage(
        page: () => ProductListScreen(),
        name: RouteName.productListScreen,
        binding: ProductListBinding(),),
    GetPage(
        page: () => const ProductDetailScreen(),
        name: RouteName.productDetailScreen,
        binding: ProductDetailBinding(),),
  ];

  String get initialRoute {
    final userData = StorageServices().getData();
    if (userData.isNotEmpty) {
     // final String userToken = userData["data"]["user_token"];
      print("Userdate:: /*$userData*/");
      return RouteName.productListScreen;
    } else {
      print("MNodata:: /*$userData*/");
      return RouteName.root;
    }
  }
}
