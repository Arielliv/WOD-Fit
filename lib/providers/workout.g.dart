// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Workout _$WorkoutFromJson(Map<String, dynamic> json) {
  return Workout(
    id: json['id'] as String,
    title: json['title'] as String,
    creatorId: json['creatorId'] as String,
    workoutParts: (json['workoutParts'] as List)
        ?.map((e) =>
            e == null ? null : WorkoutPart.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    creatorImageUrl: json['creatorImageUrl'] as String,
    date: Workout._fromJson(json['date'] as int),
  );
}

Map<String, dynamic> _$WorkoutToJson(Workout instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'creatorId': instance.creatorId,
      'creatorImageUrl': instance.creatorImageUrl,
      'date': Workout._toJson(instance.date),
      'workoutParts': instance.workoutParts?.map((e) => e?.toJson())?.toList(),
    };
