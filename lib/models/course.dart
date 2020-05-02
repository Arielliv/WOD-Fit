import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wod_fit/models/enums.dart';
import 'package:wod_fit/models/exercise.dart';
part 'course.g.dart';

@JsonSerializable()
class Course {
  courseType type;
  int time;
  int sets;
  List<Exercise> exercises;

  Course({
    @required this.type,
    @required this.exercises,
    this.time,
  });

  /// A necessary factory constructor for creating a new Course instance
  /// from a map. Pass the map to the generated `_$CourseFromJson()` constructor.
  /// The constructor is named after the source class, in this case, Course.
  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$CourseToJson`.
  Map<String, dynamic> toJson() => _$CourseToJson(this);

  // Map<String, dynamic> toJson() => {
  //       'type': EnumToString.parse(type),
  //       'time': time,
  //       'sets': sets,
  //       'exercises':
  //           exercises.map((exercise) => exercise.toJson()).toList().toString(),
  //     };
}
