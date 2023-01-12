import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelamigos/views/screens/auth/login.dart';
import 'package:travelamigos/views/screens/auth/register.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                child: Column(children: [
                  Image.asset('assets/images/welcome.png', width: 360),
                  const SizedBox(height: 28),
                  const Text("TravAmigos",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 38),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            Get.to(const Register());
                          },
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
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
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      side: const BorderSide(
                                          width: 2, color: Color(0XFFA56FF8)),
                                      borderRadius:
                                          BorderRadius.circular(40.0)))),
                          child: const Padding(
                              padding: EdgeInsets.all(22.0),
                              child: Text('Create Account',
                                  style: TextStyle(fontSize: 18))))),
                  const SizedBox(height: 22),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            Get.to(const LoginPage());
                          },
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
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
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      side: const BorderSide(
                                          width: 2, color: Color(0XFFA56FF8)),
                                      borderRadius:
                                          BorderRadius.circular(40.0)))),
                          child: const Padding(
                              padding: EdgeInsets.all(24.0),
                              child: Text('Login',
                                  style: TextStyle(
                                      color: Color(0XFFA56FF8),
                                      fontSize: 18))))),
                  const Spacer(),
                  SizedBox(
                    width: 280,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'By Signing up, you agree to the ',
                              style: TextStyle(fontSize: 12),
                            ),
                            GestureDetector(
                                onTap: (() {}),
                                child: const Text('Terms of use &',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0XFFA56FF8))))
                          ],
                        ),
                        const SizedBox(height: 5),
                        GestureDetector(
                          onTap: (() {}),
                          child: const Text('privacy policy',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0XFFA56FF8))),
                        )
                      ],
                    ),
                  )
                ]))));
  }
}
