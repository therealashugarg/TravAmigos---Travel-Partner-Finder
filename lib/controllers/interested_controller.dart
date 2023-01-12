import 'package:get/get.dart';
import 'package:travelamigos/models/interestedmodel/interested_model.dart';

class InterestedController extends GetxController {
  final Rx<List<Interested>> _comments = Rx<List<Interested>>([]);
  List<Interested> get interests => _comments.value;

  String _planId = "";

  updatePostId(String id) {
    _planId = id;
    // getInterest();
  }
}