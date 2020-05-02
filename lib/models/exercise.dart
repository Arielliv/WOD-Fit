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

  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);
  Map<String, dynamic> toJson() => _$ExerciseToJson(this);

  // Map<String, dynamic> toJson() => {
  //       'type': EnumToString.parse(type),
  //       'time': time,
  //       'iteration': iteration,
  //       'name': name
  //     };
}
