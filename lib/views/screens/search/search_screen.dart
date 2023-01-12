import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:travelamigos/views/screens/profile/user_profile_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUser = false;

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: TextFormField(
          controller: searchController,
          decoration: InputDecoration(
            // field editing
            hintText: "Search",
            hintStyle: TextStyle(color: Colors.grey[400]),
            contentPadding: const EdgeInsets.only(left: 20),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            suffixIcon: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    isShowUser = false;
                  });
                  searchController.clear();
                }),
          ),
          scrollPadding: EdgeInsets.all(20.0),
          // some keyboard settings
          textInputAction: TextInputAction.done,
          onChanged: (value) {
            setState(() {
              isShowUser = true;
            });
          },
        ),
      ),
      body: isShowUser
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where('username',
                      isGreaterThanOrEqualTo: searchController.text)
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text('No user found'),
                  );
                }
                return ListView.builder(
                    itemCount: (snapshot.data! as dynamic).docs.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Get.to(UserProfileScreen(uid: (snapshot.data! as dynamic).docs[index]['uid'])),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                (snapshot.data! as dynamic).docs[index]
                                    ['profilephoto']),
                          ),
                          title: Text((snapshot.data! as dynamic).docs[index]
                              ['username']),
                        ),
                      );
                    });
              },
            )
          : Padding(
              padding: EdgeInsets.only(top: 10),
              child: FutureBuilder(
                  future: FirebaseFirestore.instance.collection('posts').get(),
                  builder: ((context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                          child: const CircularProgressIndicator());
                    }
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
                      child: StaggeredGridView.countBuilder(
                        crossAxisCount: 3,
                        itemCount: (snapshot.data as dynamic).docs.length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            (snapshot.data as dynamic).docs[index]['imageUrl'],
                            fit: BoxFit.cover,
                          );
                        },
                        staggeredTileBuilder: (index) => StaggeredTile.count(
                            (index % 7 == 0) ? 2 : 1, (index % 7 == 0) ? 2 : 1),
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                      ),
                    );
                  })),
            ),
    );
  }
}
