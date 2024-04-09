import "package:flutter/material.dart";
import "package:flutterinterviewproject/common/app_text_form_field.dart";
import "package:flutterinterviewproject/controllers/product_detail_controller.dart";
import "package:get/get.dart";
import "package:velocity_x/velocity_x.dart";

class ProductDetailScreen extends GetView<ProductDetailController> {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: 30,),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.deepPurple.shade50,
        title: controller.Id == "" ? "Add Product".text.base.make() : "Update Product".text.base.make(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                AppTextFormField(
                  controller: controller.nameController,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.next,
                  validator: (String? value) {
                    return (GetUtils.isNullOrBlank(value) ?? true)
                        ? "required"
                        : null;
                  },
                  enabled: true,
                  labelText: "Product Name",
                  hintText: "Enter Product Name",
                ),
                AppTextFormField(
                  controller: controller.moqController,
                  keyboardType: TextInputType.phone,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.next,
                  validator: (String? value) {
                    return (GetUtils.isNullOrBlank(value) ?? true)
                        ? "required"
                        : null;
                  },
                  enabled: true,
                  labelText: "Model Of Quantity",
                  hintText: "Enter Model Of Quantity",
                ),
                AppTextFormField(
                  controller: controller.priceController,
                  keyboardType: TextInputType.phone,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.next,
                  validator: (String? value) {
                    return (GetUtils.isNullOrBlank(value) ?? true)
                        ? "required"
                        : null;
                  },
                  enabled: true,
                  labelText: "Price",
                  hintText: "Enter Price",
                  suffixIcon: const SizedBox(),
                ),
                AppTextFormField(
                  controller: controller.discountedController,
                  keyboardType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.done,
                  validator: (String? value) {
                    return (GetUtils.isNullOrBlank(value) ?? true)
                        ? "required"
                        : null;
                  },
                  enabled: true,
                  labelText: "Discount Price",
                  hintText: "Enter Discount Price",
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (controller.formKey.currentState?.validate() ??
                          false) {
                        if(controller.Id == ""){
                          await controller.AddProductApi();
                        }else {
                          await controller.UpdateProductApi();
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      controller.Id == "" ? "Add Product" :  "Update Product",
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ).pSymmetric(h: 12, v: 50),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}