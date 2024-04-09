import "package:flutter/material.dart";
import "package:flutterinterviewproject/routes/Route.dart";
import "package:get/get.dart";
import "package:get_storage/get_storage.dart";

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "E-com",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: Routes.routes,
      initialRoute: Routes().initialRoute,
    );
  }
}
