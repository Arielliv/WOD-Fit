import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wod_fit/models/course.dart';
import 'package:wod_fit/models/enums.dart';
import 'package:wod_fit/models/exercise.dart';
import 'package:wod_fit/models/workout_part.dart';
import 'package:wod_fit/providers/workout.dart';
import '../providers/workouts.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import '../utils/utils.dart';

class AddWorkoutScreen extends StatefulWidget {
  static const routeName = '/add-workout';
  @override
  _AddWorkoutScreenState createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  final _form = GlobalKey<FormState>();

  List<FocusNode> _focusCourseTimeOrSetNodes = [];
  List<List<FocusNode>> _focusExecerciseNameNodes = [[]];
  List<List<FocusNode>> _focusExecerciseTimeOrSetNodes = [[]];

  var _newWorkout = Workout(
    date: null,
    id: null,
    title: '',
    creatorId: '',
    creatorImageUrl: '',
    workoutParts: [
      WorkoutPart(
        type: workoutPartType.WarmUp,
        course: Course(
          type: courseType.Regular,
          exercises: [
            Exercise(
              name: '',
              type: exerciseType.Iteration,
            )
          ],
        ),
      )
    ],
  );

  // var _isInit = true;
  var _isLoading = false;
  @override
  void initState() {
    super.initState();

    _focusCourseTimeOrSetNodes =
        List<FocusNode>.generate(1, (int index) => FocusNode());
    _focusExecerciseNameNodes = new List.generate(
        1, (int index) => List.generate(1, (int index) => FocusNode()));
    _focusExecerciseTimeOrSetNodes = new List.generate(
        1, (int index) => List.generate(1, (int index) => FocusNode()));
  }

  @override
  void dispose() {
    super.dispose();
    _focusCourseTimeOrSetNodes.forEach((node) => node..dispose());
    _focusExecerciseNameNodes.forEach(
        (listOfNodes) => listOfNodes.forEach(((node) => node..dispose())));
    _focusExecerciseTimeOrSetNodes.forEach(
        (listOfNodes) => listOfNodes.forEach(((node) => node..dispose())));
  }

  void addExercise(
    int index,
  ) {
    if (_newWorkout.workoutParts[index] != null &&
        _newWorkout.workoutParts[index].course != null) {
      _focusExecerciseNameNodes[index].add(FocusNode());
      _focusExecerciseTimeOrSetNodes[index].add(FocusNode());
      setState(() {
        _newWorkout.workoutParts[index].course.exercises.add(Exercise(
          name: '',
        ));
      });
    }
  }

  void addWorkoutPart() {
    setState(() {
      _focusCourseTimeOrSetNodes.add(FocusNode());
      _focusExecerciseNameNodes
          .add(List.generate(1, (int index) => FocusNode()));
      _focusExecerciseTimeOrSetNodes
          .add(List.generate(1, (int index) => FocusNode()));
      _newWorkout.workoutParts.add(WorkoutPart(
        course: Course(
          exercises: [
            Exercise(
              name: '',
            )
          ],
        ),
      ));
    });
  }

  void updateWorkoutType(
    int index,
    String type,
  ) {
    if (_newWorkout.workoutParts[index] != null) {
      setState(() {
        _newWorkout.workoutParts[index].type =
            EnumToString.fromString(workoutPartType.values, type);
      });
    }
  }

  void updateCourseTime(
    int index,
    String time,
  ) {
    if (_newWorkout.workoutParts[index] != null &&
        _newWorkout.workoutParts[index].course != null) {
      setState(() {
        _newWorkout.workoutParts[index].course.time = int.parse(time);
      });
    }
  }

  void updateCourseSets(
    int index,
    String sets,
  ) {
    if (_newWorkout.workoutParts[index] != null &&
        _newWorkout.workoutParts[index].course != null) {
      setState(() {
        _newWorkout.workoutParts[index].course.sets = int.parse(sets);
      });
    }
  }

  void updateCourseType(
    int index,
    String type,
  ) {
    if (_newWorkout.workoutParts[index] != null &&
        _newWorkout.workoutParts[index].course != null) {
      setState(() {
        _newWorkout.workoutParts[index].course.type =
            EnumToString.fromString(courseType.values, type);
      });
    }
  }

  void updateExerciseName(
    int index,
    int secondIndex,
    String name,
  ) {
    if (_newWorkout.workoutParts[index] != null &&
        _newWorkout.workoutParts[index].course != null &&
        _newWorkout.workoutParts[index].course.exercises[secondIndex] != null) {
      setState(() {
        _newWorkout.workoutParts[index].course.exercises[secondIndex].name =
            name;
      });
    }
  }

  void updateExercisesType(
    int index,
    int secondIndex,
    String type,
  ) {
    if (_newWorkout.workoutParts[index] != null &&
        _newWorkout.workoutParts[index].course != null &&
        _newWorkout.workoutParts[index].course.exercises[secondIndex] != null) {
      setState(() {
        _newWorkout.workoutParts[index].course.exercises[secondIndex].type =
            EnumToString.fromString(exerciseType.values, type);
      });
    }
  }

  void updateExerciseTime(
    int index,
    int secondIndex,
    String time,
  ) {
    if (_newWorkout.workoutParts[index] != null &&
        _newWorkout.workoutParts[index].course != null &&
        _newWorkout.workoutParts[index].course.exercises[secondIndex] != null) {
      setState(() {
        _newWorkout.workoutParts[index].course.exercises[secondIndex].time =
            int.parse(time);
      });
    }
  }

  void updateExerciseIteration(
    int index,
    int secondIndex,
    String iteration,
  ) {
    if (_newWorkout.workoutParts[index] != null &&
        _newWorkout.workoutParts[index].course != null &&
        _newWorkout.workoutParts[index].course.exercises[secondIndex] != null) {
      setState(() {
        _newWorkout.workoutParts[index].course.exercises[secondIndex]
            .iteration = int.parse(iteration);
      });
    }
  }

  void updateTitleWorkout(String title) {
    _newWorkout = Workout(
      title: title,
      creatorId: _newWorkout.creatorId,
      creatorImageUrl: _newWorkout.creatorId,
      id: _newWorkout.id,
      workoutParts: _newWorkout.workoutParts,
      date: null,
    );
  }

  void onSaveWorkout() {
    _newWorkout = Workout(
      title: _newWorkout.title,
      workoutParts: _newWorkout.workoutParts,
      creatorId: '',
      creatorImageUrl: '',
      id: ',',
      date: null,
    );
  }

  String numberFieldValidator(value, fieldName) {
    if (value.isEmpty) {
      return 'Please enter a $fieldName';
    }
    return null;
  }

  String textFieldValidator(value, fieldName) {
    if (value.isEmpty) {
      return 'Please enter a $fieldName';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    if (double.parse(value) <= 0) {
      return 'Please enter a number greter then zero';
    }
    return null;
  }

  String dropdownValidator(value, fieldName){
    if (value == null) {
      return 'Please choose a $fieldName';
    }
    return null;
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Workouts>(context, listen: false)
          .addWorkout(_newWorkout);
    } catch (error) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occurred'),
          content: Text(error.toString()), //some thing went wrong
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  List<Widget> getListCourseFeilds(
    WorkoutPart workoutPart,
    List<WorkoutPart> workoutParts,
    int workoutPartindex,
  ) {
    return Utils.mapIndexed(
      workoutPart.course.exercises,
      (exerciseIndex, Exercise exercise) => SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Container(
              child: TextFormField(
                initialValue: '',
                decoration: InputDecoration(labelText: 'Exercise name'),
                textInputAction: TextInputAction.next,
                onChanged: (value) =>
                    updateExerciseName(workoutPartindex, exerciseIndex, value),
                onSaved: (value) {
                  updateExerciseName(workoutPartindex, exerciseIndex, value);
                  onSaveWorkout();
                },
                validator: (value) =>
                    textFieldValidator(value, 'exercise name'),
                focusNode: _focusExecerciseNameNodes[workoutPartindex]
                    [exerciseIndex],
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(
                    _focusExecerciseTimeOrSetNodes[workoutPartindex]
                        [exerciseIndex]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                    flex: 8,
                    child: Container(
                      margin: EdgeInsets.only(right: 5.0),
                      child: DropDownFormField(
                        titleText: 'Exercise type',
                        hintText: 'Please choose one',
                        value: EnumToString.parse(exercise.type),
                        onSaved: (value) {
                          updateExercisesType(
                              workoutPartindex, exerciseIndex, value);
                          onSaveWorkout();
                        },
                        onChanged: (value) {
                          updateExercisesType(
                              workoutPartindex, exerciseIndex, value);
                        },
                        dataSource: EnumToString.toList(exerciseType.values)
                            .map((type) => {"display": type, "value": type})
                            .toList(),
                        textField: 'display',
                        valueField: 'value',
                        validator: (value) =>
                            dropdownValidator(value, 'exercise type'),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 7,
                    child: Container(
                      margin: EdgeInsets.only(left: 5.0),
                      padding: EdgeInsets.only(top: 16.0),
                      child: exercise.type == exerciseType.Time
                          ? TextFormField(
                              initialValue: '',
                              decoration:
                                  InputDecoration(labelText: 'Exercise Time'),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              onChanged: (value) => updateExerciseTime(
                                  workoutPartindex, exerciseIndex, value),
                              onSaved: (value) {
                                updateExerciseTime(
                                    workoutPartindex, exerciseIndex, value);
                                onSaveWorkout();
                              },
                              validator: (value) =>
                                  numberFieldValidator(value, 'how long will it take'),
                              focusNode: _focusExecerciseTimeOrSetNodes[
                                  workoutPartindex][exerciseIndex],
                              onFieldSubmitted: (_) {
                                if (exerciseIndex <
                                    workoutPart.course.exercises.length - 1) {
                                  FocusScope.of(context).requestFocus(
                                      _focusExecerciseNameNodes[
                                          workoutPartindex][exerciseIndex + 1]);
                                }
                                if (workoutPartindex <
                                    workoutParts.length - 1) {
                                  FocusScope.of(context).requestFocus(
                                      _focusCourseTimeOrSetNodes[
                                          workoutPartindex + 1]);
                                }
                              },
                            )
                          : TextFormField(
                              initialValue: '',
                              decoration:
                                  InputDecoration(labelText: 'Exercise Sets number'),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              onChanged: (value) => updateExerciseIteration(
                                  workoutPartindex, exerciseIndex, value),
                              onSaved: (value) {
                                updateExerciseIteration(
                                    workoutPartindex, exerciseIndex, value);
                                onSaveWorkout();
                              },
                              validator: (value) =>
                                  numberFieldValidator(value, 'number of sets'),
                              focusNode: _focusExecerciseTimeOrSetNodes[
                                  workoutPartindex][exerciseIndex],
                              onFieldSubmitted: (_) {
                                if (exerciseIndex <
                                    workoutPart.course.exercises.length - 1) {
                                  FocusScope.of(context).requestFocus(
                                      _focusExecerciseNameNodes[
                                          workoutPartindex][exerciseIndex + 1]);
                                }
                                if (workoutPartindex <
                                    workoutParts.length - 1) {
                                  FocusScope.of(context).requestFocus(
                                      _focusCourseTimeOrSetNodes[
                                          workoutPartindex + 1]);
                                }
                              },
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).toList();
  }

  List<Widget> getListFeilds(workoutParts) {
    return Utils.mapIndexed(
      workoutParts,
      (workoutPartindex, WorkoutPart workoutPart) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height / 8,
            width: double.infinity,
            child: Container(
              padding: EdgeInsets.only(top: 5.0),
              margin: EdgeInsets.only(bottom: 3.0),
              child: DropDownFormField(
                titleText: 'Workout part type',
                hintText: 'Please choose one',
                value: EnumToString.parse(workoutPart.type),
                onSaved: (value) {
                  updateWorkoutType(workoutPartindex, value);
                  onSaveWorkout();
                },
                onChanged: (value) =>
                    updateWorkoutType(workoutPartindex, value),
                dataSource: EnumToString.toList(workoutPartType.values)
                    .map((type) => {"display": type, "value": type})
                    .toList(),
                textField: 'display',
                valueField: 'value',
                validator: (value) =>
                    dropdownValidator(value, 'workout part type'),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 8,
                  child: Container(
                    margin: EdgeInsets.only(right: 5.0),
                    child: DropDownFormField(
                      titleText: 'Course type',
                      hintText: 'Please choose one',
                      value: EnumToString.parse(workoutPart.course.type),
                      validator: (value) =>
                          dropdownValidator(value, 'course type'),
                      onSaved: (value) {
                        updateCourseType(workoutPartindex, value);
                        onSaveWorkout();
                      },
                      onChanged: (value) =>
                          updateCourseType(workoutPartindex, value),
                      dataSource: EnumToString.toList(courseType.values)
                          .map((type) => {"display": type, "value": type})
                          .toList(),
                      textField: 'display',
                      valueField: 'value',
                    ),
                  ),
                ),
                Flexible(
                  flex: 7,
                  child: Container(
                    margin: EdgeInsets.only(left: 5.0),
                    padding: EdgeInsets.only(top: 16.0),
                    child: (workoutPart.course.type == courseType.Amrap ||
                            workoutPart.course.type == courseType.Emom)
                        ? TextFormField(
                            initialValue: '',
                            decoration:
                                InputDecoration(labelText: '${EnumToString.parse(workoutPart.course.type)} Time'),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            onChanged: (value) =>
                                updateCourseTime(workoutPartindex, value),
                            onSaved: (value) {
                              updateCourseTime(workoutPartindex, value);
                              onSaveWorkout();
                            },
                            validator: (value) =>
                                numberFieldValidator(value, 'how long will it take'),
                            focusNode:
                                _focusCourseTimeOrSetNodes[workoutPartindex],
                            onFieldSubmitted: (_) => FocusScope.of(context)
                                .requestFocus(
                                    _focusExecerciseNameNodes[workoutPartindex]
                                        [0]),
                          )
                        : TextFormField(
                            initialValue: '',
                            decoration:
                                InputDecoration(labelText: 'Course Sets'),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            onChanged: (value) =>
                                updateCourseSets(workoutPartindex, value),
                            onSaved: (value) {
                              updateCourseSets(workoutPartindex, value);
                              onSaveWorkout();
                            },
                            validator: (value) =>
                                numberFieldValidator(value, 'number of sets'),
                            focusNode:
                                _focusCourseTimeOrSetNodes[workoutPartindex],
                            onFieldSubmitted: (_) => FocusScope.of(context)
                                .requestFocus(
                                    _focusExecerciseNameNodes[workoutPartindex]
                                        [0]),
                          ),
                  ),
                ),
              ],
            ),
          ),
          ...getListCourseFeilds(workoutPart, workoutParts, workoutPartindex),
          Padding(
            padding: const EdgeInsets.only(top:10.0, bottom: 10.0),
            child: Container(
              width: double.infinity,
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                onPressed: () {
                  addExercise(workoutPartindex);
                },
                padding: EdgeInsets.all(10.0),
                child: const Text(
                  'Add exercise',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Workout'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _newWorkout.title,
                      decoration: InputDecoration(labelText: 'Workout Title'),
                      textInputAction: TextInputAction.next,
                      onChanged: (value) => updateTitleWorkout(value),
                      onSaved: (value) {
                        updateTitleWorkout(value);
                        onSaveWorkout();
                      },
                      validator: (value) =>
                          textFieldValidator(value, 'workout title'),
                      onFieldSubmitted: (_) => FocusScope.of(context)
                          .requestFocus(_focusCourseTimeOrSetNodes[0]),
                    ),
                    ...getListFeilds(_newWorkout.workoutParts),
                    Padding(
                      padding: const EdgeInsets.only(top:5.0),
                      child: Container(
                        width: double.infinity,
                        child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          onPressed: () {
                            addWorkoutPart();
                          },
                          padding: EdgeInsets.all(10.0),
                          child: const Text(
                            'Add workout part',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
