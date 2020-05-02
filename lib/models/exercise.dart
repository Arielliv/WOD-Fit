import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wod_fit/models/enums.dart';
part 'exercise.g.dart';

@JsonSerializable()
class Exercise {
  exerciseType type;
  int time;
  int iteration;
  String name;

  Exercise({
    @required this.type,
    @required this.name,
    this.time,
    this.iteration,
  });

  /// A necessary factory constructor for creating a new Exercise instance
  /// from a map. Pass the map to the generated `_$ExerciseFromJson()` constructor.
  /// The constructor is named after the source class, in this case, Exercise.
  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$ExerciseToJson`.
  Map<String, dynamic> toJson() => _$ExerciseToJson(this);

  // Map<String, dynamic> toJson() => {
  //       'type': EnumToString.parse(type),
  //       'time': time,
  //       'iteration': iteration,
  //       'name': name
  //     };
}
