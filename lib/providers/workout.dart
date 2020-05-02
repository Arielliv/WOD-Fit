import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wod_fit/models/workout_part.dart';
part 'workout.g.dart';

@JsonSerializable()
class Workout with ChangeNotifier {
  final String id;
  final String title;
  final String creatorId;
  final String creatorImageUrl;
  List<WorkoutPart> workoutParts;

  Workout({
    @required this.id,
    @required this.title,
    @required this.creatorId,
    @required this.workoutParts,
    @required this.creatorImageUrl,
  });

  /// A necessary factory constructor for creating a new Workout instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, Workout.
  factory Workout.fromJson(Map<String, dynamic> jsonVal, String id) {
    var d = {"workoutParts": jsonVal['workoutParts']};
    var l = json.decode(json.encode(d));
    jsonVal["workoutParts"] = json.decode(jsonVal['workoutParts']) as List;
    jsonVal["id"] = id;
    return _$WorkoutFromJson(jsonVal);
  }

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$WorkoutToJson`.
  Map<String, dynamic> toJson() => _$WorkoutToJson(this);

  // factory Workout.fromJson(Map<String, dynamic> json) =>
  //     _$WorkoutFromJson(json);
  // Map<String, dynamic> toJson() => _$WorkoutFromJson(this);

  // final String baseUrl = 'https://wod-fit-46e9a.firebaseio.com/';

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'title': title,
  //     'creatorId': creatorId,
  //     'creatorImageUrl': creatorImageUrl,
  //     'workoutParts': workoutParts
  //         .map((workoutPart) => workoutPart.toJson())
  //         .toList()
  //         .toString(),
  //   };
  // }
}
