import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelamigos/constants.dart';
import 'package:travelamigos/controllers/auth_controller.dart';
import 'package:travelamigos/main.dart';
import 'package:travelamigos/views/screens/auth/register.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final loginController = Get.put(AuthController());

    return Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: whiteColor,
        body: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back,
                            size: 32, color: Colors.black54))),
                const SizedBox(height: 18),
                Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Palette.kToDark.shade200, shape: BoxShape.circle),
                    child: Image.asset('assets/images/illustration-3.png')),
                const SizedBox(height: 140),
                const Text("Login",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 28),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      // email field start
                      TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                              // prefix email icon
                              prefixIcon: const Icon(Icons.alternate_email),
                              // field editing
                              hintText: "Email/Username",
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              labelText: "Email/Username",
                              contentPadding: const EdgeInsets.only(left: 10),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          // some keyboard settings
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          autofillHints: const [AutofillHints.email]),
                      // email field end
                      const SizedBox(height: 25),
                      Obx(() => TextField(
                          controller: passwordController,
                          decoration: InputDecoration(
                              // prefix lock icon
                              prefixIcon: const Icon(Icons.https_outlined),
                              // suffix visibility icon
                              suffixIcon: IconButton(
                                  icon: loginController.isPasswordHidden.value
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                  onPressed: () {
                                    loginController.isPasswordHidden.value =
                                        !loginController.isPasswordHidden.value;
                                  }),
        
                              // field editing
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              labelText: "Password",
                              // errorText: 'Wrong password',
                              contentPadding: const EdgeInsets.only(left: 10),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          // password visibility on or off
                          obscureText: loginController.isPasswordHidden.value)),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (emailController.text.trim().isEmpty) {
                              Get.snackbar("About Login", "Login message",
                                  backgroundColor: darkPurple.withOpacity(0.4),
                                  snackPosition: SnackPosition.BOTTOM,
                                  titleText: const Text("Login failed",
                                      style: TextStyle(color: whiteColor)),
                                  messageText: const Text(
                                    "Please enter your email or username",
                                    style: TextStyle(color: whiteColor),
                                  ));
                            } else if (passwordController.text.trim().isEmpty) {
                              Get.snackbar("About Login", "Login message",
                                  backgroundColor: darkPurple.withOpacity(0.4),
                                  snackPosition: SnackPosition.BOTTOM,
                                  titleText: const Text("Login failed",
                                      style: TextStyle(color: whiteColor)),
                                  messageText: const Text(
                                    "Please enter your password",
                                    style: TextStyle(color: whiteColor),
                                  ));
                            } else {
                              AuthController.instance.login(
                                  emailController.text.trim(),
                                  passwordController.text.trim());
                            }
                          },
                          style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all<Color>(Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0XFFA56FF8)),
                              elevation:
                                  MaterialStateProperty.resolveWith<double>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.disabled)) {
                                    return 0;
                                  }
                                  return 0;
                                },
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                              ))),
                          child: const Padding(
                            padding: EdgeInsets.all(24.0),
                            child: Text('Submit', style: TextStyle(fontSize: 18)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Register()));
                          },
                          child: Center(
                              child: Text('Not a member? Register now.',
                                  style: TextStyle(
                                      color: Colors.grey[500],
                                      fontWeight: FontWeight.w500))))
                    ],
                  ),
                ),
              ],
            ),
          )),
        ));
  }
}
