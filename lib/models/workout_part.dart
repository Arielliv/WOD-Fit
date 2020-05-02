import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wod_fit/models/course.dart';
import './enums.dart';
part 'workout_part.g.dart';


@JsonSerializable()
class WorkoutPart {
  workoutPartType type;
  Course course;

  WorkoutPart({
    @required this.type,
    @required this.course,
  });

  /// A necessary factory constructor for creating a new WorkoutPart instance
  /// from a map. Pass the map to the generated `_$WorkoutPartFromJson()` constructor.
  /// The constructor is named after the source class, in this case, WorkoutPart.
  factory WorkoutPart.fromJson(Map<String, dynamic> json) => _$WorkoutPartFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$WorkoutPartToJson`.
  Map<String, dynamic> toJson() => _$WorkoutPartToJson(this);


  // Map<String, dynamic> toJson() => {
  //       'type': EnumToString.parse(type),
  //       'course': course.toJson(),
  //     };
}
