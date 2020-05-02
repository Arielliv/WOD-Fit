// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_part.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutPart _$WorkoutPartFromJson(Map<String, dynamic> json) {
  return WorkoutPart(
    type: _$enumDecodeNullable(_$workoutPartTypeEnumMap, json['type']),
    course: json['course'] == null
        ? null
        : Course.fromJson(json['course'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$WorkoutPartToJson(WorkoutPart instance) =>
    <String, dynamic>{
      'type': _$workoutPartTypeEnumMap[instance.type],
      'course': instance.course?.toJson(),
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$workoutPartTypeEnumMap = {
  workoutPartType.Strength: 'Strength',
  workoutPartType.Metcon: 'Metcon',
  workoutPartType.CashOut: 'CashOut',
  workoutPartType.WarmUp: 'WarmUp',
};
