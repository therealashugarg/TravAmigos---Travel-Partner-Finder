import 'package:flutter/material.dart';
import 'package:travelamigos/constants.dart';
import 'package:travelamigos/main.dart';

class InterestedPage extends StatelessWidget {
  const InterestedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.kToDark,
      body: SafeArea(
        child: Column(
          children: [
            _top(),
            _body(),
          ],
        ),
      ),
    );
  }

  Widget _top() {
    return Container(
      color: Palette.kToDark,
      padding: const EdgeInsets.only(top: 30, left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Interested people',
              style: TextStyle(
                  fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          SizedBox(
                height: 35,
              ),
        ],
      ),
    );
  }
  Widget _body() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45), topRight: Radius.circular(45)),
          color: Colors.white,
        ),
        child: const Center(child: Text('No interested member found, \nplease wait for the responses.', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),))
        // ListView(
        //   padding: const EdgeInsets.only(top: 35),
        //   physics: const BouncingScrollPhysics(),
        //   children: const [
            
        //   ],
        // ),
      ),
    );
  }
}
