import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelamigos/controllers/comments_controller.dart';
import 'package:travelamigos/main.dart';
import 'package:timeago/timeago.dart' as tago;
 
class CommentScreen extends StatelessWidget {
  final String id;
  CommentScreen({super.key, required this.id});

  TextEditingController _commentController = TextEditingController();
  CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    commentController.updatePostId(id);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            onPressed: () {
              Get.back();
            },
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(children: [
            Expanded(
              child: Obx(() {
                return ListView.builder(
                    itemCount: commentController.comments.length,
                    itemBuilder: (context, index) {
                      final comment = commentController.comments[index];
                      return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.black,
                            backgroundImage: NetworkImage(comment.profilePhoto),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 15),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            comment.username,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: Colors.grey[600]),
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                  Icons
                                                      .favorite_border_outlined,
                                                  size: 15),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "${comment.likes.length}",
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          comment.comment,
                                          softWrap: true,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Colors.black),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          const Spacer(),
                                          Text(
                                            tago.format(
                                                comment.datePublished.toDate()),
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.blue),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          ));
                    });
              }),
            ),
            const Divider(),
            ListTile(
              title: TextFormField(
                controller: _commentController,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  labelText: 'Comment',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.grey[400],
                  ),
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Palette.kToDark)),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Palette.kToDark)),
                ),
              ),
              trailing: TextButton(
                onPressed: () {
                  commentController.postComment(_commentController.text);
                  _commentController.clear();
                },
                child: const Text(
                  'Send',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
