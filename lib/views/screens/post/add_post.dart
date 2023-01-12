// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:travelamigos/constants/strings.dart';
import 'package:travelamigos/controllers/upload_plan_controller.dart';
import 'package:travelamigos/views/screens/post/confirm_screen.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  File? pickedImage;

  Future pickImage() async {
    final image = await ImagePicker().getImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      pickedImage = File(image.path);
    });
  }

  String? planText = '';
  String? placeText = '';
  TextEditingController planController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  DateTime dateController = DateTime.now();

  UploadPlanController uploadPlanController = Get.put(UploadPlanController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    planController.addListener(() {
      setState(() {
        planText = planController.text;
      });
    });
    placeController.addListener(() {
      setState(() {
        placeText = placeController.text;
      });
    });
  }

  /*
  String location = "Search Location";
  TextEditingController _controller = TextEditingController();
  var uuid = Uuid();
  String _sessionToken = '122344';
  List<dynamic> _placesList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }

    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    String kPLACES_API_KEY = googleApikey;
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';

    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();

    print(data);
    if (response.statusCode == 200) {
      setState(() {
        _placesList = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(Icons.arrow_back,
                          size: 32, color: Colors.black54))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 82),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(25.0)),
                child: TabBar(
                  indicator: BoxDecoration(
                      color: const Color(0XFFA56FF8),
                      borderRadius: BorderRadius.circular(25.0)),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black54,
                  tabs: const [
                    Tab(
                      text: 'Plan',
                    ),
                    Tab(
                      text: 'Post',
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: TabBarView(children: [
              // Plan Page
              Column(
                children: [
                  const SizedBox(height: 30),
                  Form(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28.0,
                      ),
                      child: Column(
                        children: [
                          CupertinoButton(
                              child: Text(
                                '${dateController.month} - ${dateController.day} - ${dateController.year}',
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                              onPressed: () {
                                showCupertinoModalPopup(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SizedBox(
                                          height: 250,
                                          child: CupertinoDatePicker(
                                            backgroundColor: Colors.white,
                                            initialDateTime: dateController,
                                            minimumYear: dateController.year,
                                            minimumDate: dateController,
                                            // minimumDate: dateController,
                                            // firstDate: DateTime.now()
                                            // .subtract(Duration(days: 1)),
                                            onDateTimeChanged:
                                                (DateTime newTime) {
                                              setState(() {
                                                dateController = newTime;
                                              });
                                            },
                                            mode: CupertinoDatePickerMode.date,
                                          ));
                                    });
                              }),
                          TextFormField(
                            controller: placeController,
                            decoration: const InputDecoration(
                                hintText: 'Search Places'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: planController,
                            maxLines: 5,
                            // onChanged: (text) {
                            //   setState(() {
                            //     planText = text;
                            //   });
                            // },
                            decoration: const InputDecoration(hintText: 'Plan'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      if (planText!.isNotEmpty || placeText!.isNotEmpty) {
                        uploadPlanController.uploadPlan(dateController,
                            placeText.toString(), planText.toString());
                      } else {
                        return;
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 82),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: planText!.isEmpty || placeText!.isEmpty
                                ? Colors.grey[300]
                                : const Color(0XFFA56FF8)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(
                                'Next',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: planText!.isEmpty || placeText!.isEmpty
                                      ? Colors.black54
                                      : Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20)
                ],
              ),
              // Post Page
              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                const SizedBox(height: 35),
                if (pickedImage != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: SizedBox(
                      width: 380,
                      height: 380,
                      child: Image.file(
                        File(pickedImage!.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                const Spacer(),
                InkWell(
                  onTap: pickImage,
                  child: Container(
                    width: 190,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.grey[300]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: Text(
                            'Upload',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                            height: 24,
                            child: Image.asset(
                              'assets/icons/cloud-upload.png',
                              color: Colors.black54,
                            )),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    if (pickedImage != null) {
                      Get.to(ConfirmScreen(
                        imageFile: File(pickedImage!.path),
                        imagePath: pickedImage!.path,
                      ));
                    } else {
                      return;
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 82),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: pickedImage == null
                              ? Colors.grey[300]
                              : const Color(0XFFA56FF8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              'Next',
                              style: TextStyle(
                                fontSize: 14,
                                color: pickedImage == null
                                    ? Colors.black54
                                    : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20)
              ])
            ]))
          ],
        ),
      )),
    );
  }
}

/*
                          Positioned(
                            //search input bar
                            top: 10,
                            child: InkWell(
                              onTap: () async {
                                var place = await PlacesAutocomplete.show(
                                    context: context,
                                    apiKey: googleApikey,
                                    mode: Mode.overlay,
                                    types: [],
                                    strictbounds: false,
                                    components: [
                                      Component(Component.country, 'np')
                                    ],
                                    //google_map_webservice package
                                    onError: (err) {
                                      print(err);
                                    });

                                if (place != null) {
                                  setState(() {
                                    location = place.description.toString();
                                  });

                                  //form google_maps_webservice package
                                  final plist = GoogleMapsPlaces(
                                    apiKey: googleApikey,
                                    apiHeaders:
                                        await GoogleApiHeaders().getHeaders(),
                                    //from google_api_headers package
                                  );
                                  String placeid = place.placeId ?? "0";
                                  final detail =
                                      await plist.getDetailsByPlaceId(placeid);
                                  final geometry = detail.result.geometry!;
                                  final lat = geometry.location.lat;
                                  final lang = geometry.location.lng;
                                  var newlatlang = LatLng(lat, lang);
                                }
                              },
                              child: Card(
                                child: Container(
                                  padding: EdgeInsets.all(0),
                                  width: MediaQuery.of(context).size.width - 40,
                                  child: ListTile(
                                    title: Text(
                                      location,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    trailing: Icon(Icons.search),
                                    dense: true,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          */