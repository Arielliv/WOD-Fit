import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Workout with ChangeNotifier {
  final String id;
  final String title;
  final String creatorId;

  Workout({
    @required this.id,
    @required this.title,
    @required this.creatorId,
  });

  final String baseUrl = 'https://wod-fit-46e9a.firebaseio.com/';
}
