import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelamigos/constants.dart';
import 'package:travelamigos/controllers/auth_controller.dart';
import 'package:travelamigos/main.dart';
import 'package:travelamigos/views/screens/auth/login.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final registerController = Get.put(AuthController());

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
                    child: Image.asset('assets/images/illustration-2.png')),
                const SizedBox(height: 68),
                const Text("Register",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 28),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      // username field start
                      TextFormField(
                          controller: usernameController,
                          decoration: InputDecoration(
                              // prefix person icon
                              prefixIcon:
                                  const Icon(Icons.account_circle_outlined),
                              // field editing
                              hintText: "Username",
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              labelText: "Username",
                              contentPadding: const EdgeInsets.only(left: 10),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)))),
                      // username field end
                      const SizedBox(height: 25),
                      // email field start
                      TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                              // prefix email icon
                              prefixIcon: const Icon(Icons.alternate_email),
                              // field editing
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              labelText: "Email",
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
                      // password field start
                      Obx(() => TextField(
                          controller: passwordController,
                          decoration: InputDecoration(
                              // prefix lock icon
                              prefixIcon: const Icon(Icons.https_outlined),
                              // suffix visibility icon
                              suffixIcon: IconButton(
                                  icon: registerController.isPasswordHidden.value
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                  onPressed: () {
                                    registerController.isPasswordHidden.value =
                                        !registerController
                                            .isPasswordHidden.value;
                                  }),
        
                              // field editing
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              labelText: "Password",
                              contentPadding: const EdgeInsets.only(left: 10),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          // password visibility on or off
                          obscureText:
                              registerController.isPasswordHidden.value)),
                      // password field end
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (usernameController.text.isEmpty) {
                              Get.snackbar("About Register", "Register message",
                                  backgroundColor: darkPurple.withOpacity(0.4),
                                  snackPosition: SnackPosition.BOTTOM,
                                  titleText: const Text("Register failed",
                                      style: TextStyle(color: whiteColor)),
                                  messageText: const Text(
                                    "Please enter username",
                                    style: TextStyle(color: whiteColor),
                                  ));
                            } else if (emailController.text.trim().isEmpty) {
                              Get.snackbar("About Register", "Register message",
                                  backgroundColor: darkPurple.withOpacity(0.4),
                                  snackPosition: SnackPosition.BOTTOM,
                                  titleText: const Text("Register failed",
                                      style: TextStyle(color: whiteColor)),
                                  messageText: const Text(
                                    "Please enter your email",
                                    style: TextStyle(color: whiteColor),
                                  ));
                            } else if (passwordController.text.trim().isEmpty) {
                              Get.snackbar("About Register", "Register message",
                                  backgroundColor: darkPurple.withOpacity(0.4),
                                  snackPosition: SnackPosition.BOTTOM,
                                  titleText: const Text("Register failed",
                                      style: TextStyle(color: whiteColor)),
                                  messageText: const Text(
                                    "Please enter your password",
                                    style: TextStyle(color: whiteColor),
                                  ));
                            } else {
                              AuthController.instance.register(
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                  usernameController.text.trim());
                            }
                          },
                          style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all<Color>(Colors.white),
                              elevation:
                                  MaterialStateProperty.resolveWith<double>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.disabled)) {
                                    return 0;
                                  }
                                  return 0;
                                },
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0XFFA56FF8)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      side: const BorderSide(
                                          width: 2, color: Color(0XFFA56FF8)),
                                      borderRadius:
                                          BorderRadius.circular(40.0)))),
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
                                builder: (context) => const LoginPage()));
                          },
                          child: Center(
                              child: Text('Already a member? Log In.',
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
