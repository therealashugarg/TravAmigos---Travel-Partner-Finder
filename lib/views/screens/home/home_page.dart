// prefer_const_literals_to_create_immutables

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travelamigos/controllers/value_controller.dart';
import 'package:travelamigos/main.dart';
import 'package:travelamigos/views/screens/chats/chat_page.dart';
import 'package:travelamigos/views/screens/feed/feed_page.dart';
import 'package:travelamigos/views/screens/interested/interested_page.dart';
import 'package:travelamigos/views/screens/profile/myprofile_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final pageController = Get.put(ValueController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: pageController.pageIndex.value,
          children: [
            FeedPage(),
            const InterestedPage(),
            const ChatPage(),
            MyProfileScreen()
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          child: GNav(
            gap: 10,
            color: Colors.grey[600],
            activeColor: Colors.white,
            rippleColor: Colors.grey[800]!,
            hoverColor: Colors.grey[700]!,
            padding: const EdgeInsets.all(16),
            onTabChange: (page) {
              pageController.pageIndex.value = page;
            },
            tabs: [
              GButton(
                icon: LineIcons.home,
                text: 'Home',
                iconColor: Colors.grey[800],
                iconActiveColor: Colors.white,
                textColor: Colors.white,
                backgroundColor: Palette.kToDark,
              ),
              GButton(
                icon: LineIcons.heart,
                text: 'Interested',
                iconColor: Colors.grey[800],
                iconActiveColor: Colors.white,
                textColor: Colors.white,
                backgroundColor: Palette.kToDark,
              ),
              GButton(
                icon: LineIcons.weixinWechat,
                text: 'Chats',
                iconColor: Colors.grey[800],
                iconActiveColor: Colors.white,
                textColor: Colors.white,
                backgroundColor: Palette.kToDark,
              ),
              GButton(
                icon: LineIcons.user,
                text: 'Profile',
                iconColor: Colors.grey[800],
                iconActiveColor: Colors.white,
                textColor: Colors.white,
                backgroundColor: Palette.kToDark,
              )
            ],
          ),
        ),
      ),
    );
  }
}
