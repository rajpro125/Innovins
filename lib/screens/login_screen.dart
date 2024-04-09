import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutterinterviewproject/common/app_text_form_field.dart";
import "package:flutterinterviewproject/controllers/login_controller.dart";
import "package:flutterinterviewproject/routes/Route.dart";
import "package:get/get.dart";
import "package:velocity_x/velocity_x.dart";

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/image/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                ),
                const SizedBox(height: 15),
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
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (controller.formKey.currentState?.validate() ??
                          false) {
                        await controller.loginApi();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "SignIn",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ).pSymmetric(h:10),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => Get.offNamed(RouteName.registerScreen),
                  child: Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "Don't have an account yet?",
                            style:
                            TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          TextSpan(
                            text: " SignUp",
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 16
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ).centered(),
          ),
        ),
      ),
    );
  }
}
