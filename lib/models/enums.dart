enum courseType { Amrap, Emom, Regular }
enum workoutPartType { Strength, Metcon, CashOut, WarmUp }
enum exerciseType { Time, Iteration }

List<Map<String, String>> getEnumValues(List<dynamic> values) {
  List<Map<String, String>> listOfValues = [];
  values.forEach((val) => listOfValues
      .add({'name': val.toString().split('.').last, 'value': val.toString()}));
  return listOfValues;
}
