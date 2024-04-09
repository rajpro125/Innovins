import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutterinterviewproject/common/app_text_form_field.dart";
import "package:flutterinterviewproject/controllers/register_controller.dart";
import "package:flutterinterviewproject/routes/Route.dart";
import "package:get/get.dart";
import "package:velocity_x/velocity_x.dart";

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/image/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                SizedBox(height: 10,),
                AppTextFormField(
                  inputTextColor: Colors.white,
                  labelColor: Colors.white,
                  enabledColor: Colors.white,
                  hintTextColor: Colors.white,
                  requiredField: true,
                  controller: controller.nameController,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  validator: (String? value) {
                    return (GetUtils.isNullOrBlank(value) ?? true)
                        ? "required"
                        : null;
                  },
                  enabled: true,
                  autofillHints: const <String>[
                    AutofillHints.name,
                  ],
                  labelText: "Name",
                  hintText: "Enter Name",
                  prefixIcon: const Icon(Icons.person, color: Colors.white,),
                ),
                AppTextFormField(
                  inputTextColor: Colors.white,
                  labelColor: Colors.white,
                  enabledColor: Colors.white,
                  hintTextColor: Colors.white,
                  requiredField: true,
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  validator: (String? value) {
                    return (GetUtils.isNullOrBlank(value) ?? true)
                        ? "required"
                        : !GetUtils.isEmail(value ?? "")
                        ? "Invalid"
                        : null;
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.deny(RegExp(r"\s")),
                  ],
                  enabled: true,
                  autofillHints: const <String>[
                    AutofillHints.email,
                  ],
                  labelText: "Email Address",
                  hintText: "Enter Email Address",
                  prefixIcon: const Icon(Icons.email, color: Colors.white,),
                  suffixIcon: const SizedBox(),
                ),
                AppTextFormField(
                  inputTextColor: Colors.white,
                  labelColor: Colors.white,
                  enabledColor: Colors.white,
                  hintTextColor: Colors.white,
                  requiredField: true,
                  controller: controller.mobileController,
                  keyboardType: TextInputType.phone,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  validator: (String? value) {
                    return (GetUtils.isNullOrBlank(value) ?? true)
                        ? "required"
                        : null;
                  },
                  autofillHints: const <String>[
                    AutofillHints.telephoneNumber,
                  ],
                  enabled: true,
                  labelText: "Mobile No",
                  hintText: "Enter Mobile No",
                  prefixIcon: const Icon(Icons.call, color: Colors.white,),
                ),
                Obx(() => AppTextFormField(
                  inputTextColor: Colors.white,
                  labelColor: Colors.white,
                  enabledColor: Colors.white,
                  hintTextColor: Colors.white,
                  requiredField: true,
                  controller: controller.passwordController,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.done,
                  obscureText: controller.isObscure.value,
                  maxLines: 1,
                  validator: (String? value) {
                    return (value == null || value.isEmpty) ? "Password is required" : null;
                  },
                  enabled: true,
                  labelText: "Password",
                  hintText: "Enter Password",
                  prefixIcon: const Icon(Icons.key, color: Colors.white,),
                  suffixIcon: IconButton(
                    icon: Icon(controller.isObscure.value ? Icons.visibility_off : Icons.visibility, color: Colors.white,),
                    onPressed: () {
                      controller.togglePasswordVisibility();
                    },
                  ),
                )),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (controller.formKey.currentState?.validate() ??
                          false) {
                        await controller.registerApi();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "SignUp",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ).pSymmetric(h: 10, v: 20),
                ),
                GestureDetector(
                  onTap: () => Get.offNamed(RouteName.root),
                  child: Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(text: "Already have an account?"),
                          TextSpan(
                            text: " Sign In",
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}