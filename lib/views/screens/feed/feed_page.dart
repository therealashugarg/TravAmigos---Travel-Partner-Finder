// ignprefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travelamigos/controllers/auth_controller.dart';
import 'package:travelamigos/controllers/get_feed_controller.dart';
import 'package:travelamigos/demodata/user_json.dart';
import 'package:travelamigos/main.dart';
import 'package:travelamigos/views/screens/feed/comments_screen.dart';
import 'package:travelamigos/views/screens/post/add_post.dart';
import 'package:travelamigos/views/screens/search/search_screen.dart';
import 'package:travelamigos/views/widgets/addpost_icon.dart';
import 'package:timeago/timeago.dart' as tago;

class FeedPage extends StatefulWidget {
  FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final GetFeedController feedController = Get.put(GetFeedController());
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60), child: customAppBar),
      body: SingleChildScrollView(child: getBody()),
    );
  }

  Widget customAppBar = AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    title: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            "TravAmigos",
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
    actions: [
      IconButton(
          onPressed: () {
            Get.to(SearchScreen());
          },
          icon: Icon(
            Icons.search,
            color: Colors.black,
          )),
      IconButton(
          onPressed: () {
            Get.to(const AddPostScreen());
          },
          icon: const AddPost()),
      IconButton(
          onPressed: () {
            AuthController.instance.logOut();
          },
          icon: const Icon(
            Icons.logout_outlined,
            color: Colors.black,
            size: 25,
          ))
    ],
  );

  _changeAppBar() {
    setState(() {
      customAppBar = AppBar(
        title: TextFormField(
          controller: searchController,
          decoration: InputDecoration(
              // field editing
              hintText: "Search",
              hintStyle: TextStyle(color: Colors.grey[400]),
              contentPadding: const EdgeInsets.only(left: 10),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
          // some keyboard settings
          textInputAction: TextInputAction.done,
        ),
      );
    });
  }

  Widget getBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // story profile
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      width: 58,
                      height: 58,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [Color(0xFFFFE0DF), Color(0xFFE1F6F4)]),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 28,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Row(
                      children: List.generate(usersList.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Container(
                            width: 58,
                            height: 58,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image:
                                        NetworkImage(usersList[index]['img']),
                                    fit: BoxFit.cover)),
                          ),
                        );
                      }),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Obx(() {
            // print("++++++++");
            return SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    // posts feed
                    children:
                        List.generate(feedController.postList.length, (index) {
                      final postData = feedController.postList[index];
                      //final planData = postController.planList[index];
                      // final planData = postController.planList[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: Column(
                          children: [
                            Container(
                              // height: 400,
                              child: Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 288,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.4),
                                              spreadRadius: 2,
                                              blurRadius: 15,
                                              offset: const Offset(0, 1))
                                        ],
                                        image: DecorationImage(
                                            image:
                                                NetworkImage(postData.imageUrl),
                                            fit: BoxFit.cover),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                  Container(
                                      width: double.infinity,
                                      height: 288,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color:
                                              Colors.black.withOpacity(0.20))),
                                  Container(
                                    width: double.infinity,
                                    height: 288,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(postData
                                                            .profilePhoto),
                                                  ),
                                                  const SizedBox(
                                                    width: 12,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        postData.username,
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      const SizedBox(
                                                        height: 3,
                                                      ),
                                                      Text(
                                                        tago.format(postData
                                                            .datePublished
                                                            .toDate()),
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.8)),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              // const Icon(
                                              //   Icons.menu_rounded,
                                              //   color: Colors.white,
                                              //   size: 20,
                                              // )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                width: 70,
                                                height: 27,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            27),
                                                    color:
                                                        const Color(0xFFE5E5E5)
                                                            .withOpacity(0.5)),
                                                child: InkWell(
                                                  onTap: () => feedController
                                                      .likePost(postData.id),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Icon(
                                                        postData.likes.contains(
                                                                AuthController
                                                                    .instance
                                                                    .user
                                                                    .uid)
                                                            ? Icons.favorite
                                                            : Icons
                                                                .favorite_outline_rounded,
                                                        color: Colors.white,
                                                        size: 14,
                                                      ),
                                                      Text(
                                                        postData.likes.length
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 13,
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 70,
                                                height: 27,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            27),
                                                    color:
                                                        const Color(0xFFE5E5E5)
                                                            .withOpacity(0.5)),
                                                child: InkWell(
                                                  onTap: () =>
                                                      Get.to(CommentScreen(
                                                    id: postData.id,
                                                  )),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .chat_bubble_outline_rounded,
                                                        color: Colors.white,
                                                        size: 14,
                                                      ),
                                                      Text(
                                                        postData
                                                            .commentCount.length
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 13,
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 70,
                                                height: 27,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            27),
                                                    color:
                                                        const Color(0xFFE5E5E5)
                                                            .withOpacity(0.5)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    const Icon(
                                                      Icons.reply,
                                                      color: Colors.white,
                                                      size: 14,
                                                    ),
                                                    Text(
                                                      postData.shareCount.length
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Container(child: Column(
                            //   children: [
                            //     Text(planData.date),
                            //     Text(planData.place)
                            //   ],
                            // ))
                          ],
                        ),
                      );
                    }),
                  ),
                  Column(
                    // plans feed
                    children:
                        List.generate(feedController.planList.length, (index) {
                      final planData = feedController.planList[index];

                      //final planData = postController.planList[index];
                      // final planData = postController.planList[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: Column(
                          children: [
                            Container(
                              // height: 400,
                              child: Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 288,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Palette.kToDark.withOpacity(0.5),
                                          // Color.fromARGB(255, 242, 209, 208),
                                          const Color(0xffB8E8FC)
                                              .withOpacity(0.7),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.4),
                                            spreadRadius: 2,
                                            blurRadius: 15,
                                            offset: const Offset(0, 1))
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Center(
                                          child: Text(
                                        planData.plan,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 288,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(planData
                                                            .profilePhoto),
                                                  ),
                                                  const SizedBox(
                                                    width: 12,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        planData.username,
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      const SizedBox(
                                                        height: 3,
                                                      ),
                                                      Text(
                                                        "${planData.place} on ${DateFormat('dd-MM-yyyy').format(planData.date.toDate())}"
                                                        // ""
                                                        ,
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.8)),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              // const Icon(
                                              //   Icons.menu_rounded,
                                              //   color: Colors.white,
                                              //   size: 20,
                                              // )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                width: 70,
                                                height: 27,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            27),
                                                    color:
                                                        const Color(0xFFE5E5E5)
                                                            .withOpacity(0.5)),
                                                child: InkWell(
                                                  onTap: () => feedController
                                                      .likePlan(planData.id),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Icon(
                                                        planData.likes.contains(
                                                                AuthController
                                                                    .instance
                                                                    .user
                                                                    .uid)
                                                            ? Icons.favorite
                                                            : Icons
                                                                .favorite_outline_rounded,
                                                        color: Colors.white,
                                                        size: 14,
                                                      ),
                                                      Text(
                                                        planData.likes.length
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 13,
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 70,
                                                height: 27,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            27),
                                                    color:
                                                        const Color(0xFFE5E5E5)
                                                            .withOpacity(0.5)),
                                                child: InkWell(
                                                  onTap: () {},
                                                  // => Get.to(CommentScreen(id: Pos,)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .chat_bubble_outline_rounded,
                                                        color: Colors.white,
                                                        size: 14,
                                                      ),
                                                      Text(
                                                        planData
                                                            .commentCount.length
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 13,
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 70,
                                                height: 27,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            27),
                                                    color:
                                                        const Color(0xFFE5E5E5)
                                                            .withOpacity(0.5)),
                                                child: InkWell(
                                                  onTap: () => feedController
                                                      .interestedPeople(
                                                          planData.id),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Icon(
                                                        planData.interestedCount
                                                                .contains(
                                                                    AuthController
                                                                        .instance
                                                                        .user
                                                                        .uid)
                                                            ? Icons
                                                                .back_hand_rounded
                                                            : Icons
                                                                .back_hand_outlined,
                                                        color: Colors.white,
                                                        size: 14,
                                                      ),
                                                      Text(
                                                        planData.interestedCount
                                                            .length
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 13,
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Container(child: Column(
                            //   children: [
                            //     Text(planData.date),
                            //     Text(planData.place)
                            //   ],
                            // ))
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}
