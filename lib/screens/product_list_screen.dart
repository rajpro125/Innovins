import "package:flutter/material.dart";
import "package:flutterinterviewproject/controllers/product_list_controller.dart";
import "package:flutterinterviewproject/routes/Route.dart";
import "package:flutterinterviewproject/services/storage_service.dart";
import "package:get/get.dart";
import "package:velocity_x/velocity_x.dart";

class ProductListScreen extends StatelessWidget {
  final ProductListController controller = Get.put(ProductListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.deepPurple.shade50,
        title: "Product List".text.base.make(),
        actions: [
          IconButton(
            icon: const Icon(Icons.power_settings_new),
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  title: const Text("Confirm Logout"),
                  content: const Text("Are you sure you want to logout?"),
                  actions: [
                    TextButton(
                      onPressed: Get.back,
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        StorageServices().clearDataAndCloseApp();
                      },
                      child: const Text("Logout"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          return controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : controller.productList.isEmpty
                  ? Image.asset("assets/image/empty.png").centered()
              : ListView.builder(
                      itemCount: controller.productList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final product = controller.productList[index];
                        return Card(
                          child: ListTile(
                            tileColor: Colors.grey[200],
                            title: Column(crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text('ID: ${product.id ?? "N/a"}'),
                                Text('Product Name: ${product.name  ?? "N/a"}'),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('MOQ: ${product.moq ?? "N/a"}'),
                                Text('Price:  ₹${product.price ?? "N/a"}'),
                                Text('Discounted Price: ₹${product.discountedPrice ?? "N/a"}'),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () async {
                                    await Get.toNamed(
                                        RouteName.productDetailScreen,
                                        arguments: <String, dynamic>{
                                          "id": product.id ?? "",
                                          "name": product.name ?? "",
                                          "moq": product.moq ?? "",
                                          "price": product.price ?? "",
                                          "discounted_price":
                                              product.discountedPrice ?? "",
                                        },);
                                    await controller.productListApi();
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    Get.dialog(
                                      AlertDialog(
                                        title: const Text("Confirm Delete"),
                                        content: const Text("Are you sure you want to delete the product?"),
                                        actions: [
                                          TextButton(
                                            onPressed: Get.back,
                                            child: const Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              Get.back();
                                              await controller.productDeleteApi(product.id ?? "");
                                            },
                                            child: const Text("Delete"),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ).px8();
                      },
                    );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Get.toNamed(RouteName.productDetailScreen);
          await controller.productListApi();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
