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

  List<List<FocusNode>> _focusCourseTimeOrSetNodes = [[]];
  List<List<List<FocusNode>>> _focusExecerciseNameNodes = [
    [[]]
  ];
  List<List<List<FocusNode>>> _focusExecerciseTimeOrSetNodes = [
    [[]]
  ];

  var _newWorkout = Workout(
    date: null,
    id: null,
    title: '',
    creatorId: '',
    creatorImageUrl: '',
    workoutParts: [
      WorkoutPart(
        type: workoutPartType.WarmUp,
        courses: [
          Course(
            type: courseType.Regular,
            exercises: [
              Exercise(
                description: '',
              )
            ],
          ),
        ],
      ),
    ],
  );

  // var _isInit = true;
  var _isLoading = false;
  @override
  void initState() {
    super.initState();

    _focusCourseTimeOrSetNodes =
        new List.generate(1, (_) => List.generate(1, (_) => FocusNode()));
    _focusExecerciseNameNodes = new List.generate(1,
        (_) => List.generate(1, (_) => List.generate(1, (_) => FocusNode())));
    _focusExecerciseTimeOrSetNodes = new List.generate(1,
        (_) => List.generate(1, (_) => List.generate(1, (_) => FocusNode())));
  }

  @override
  void dispose() {
    super.dispose();
    _focusCourseTimeOrSetNodes.forEach(
        (listOfNodes) => listOfNodes.forEach(((node) => node.dispose())));
    _focusExecerciseNameNodes.forEach((listOfNodes1) => listOfNodes1.forEach(
        (listOfNodes2) => listOfNodes2.forEach(((node) => node.dispose()))));

    _focusExecerciseTimeOrSetNodes.forEach((listOfNodes1) =>
        listOfNodes1.forEach((listOfNodes2) =>
            listOfNodes2.forEach(((node) => node.dispose()))));
  }

  void addExercise(
    int workoutIndex,
    int courseIndex,
  ) {
    if (_newWorkout.workoutParts[workoutIndex] != null &&
        _newWorkout.workoutParts[workoutIndex].courses[courseIndex] != null) {
      _focusExecerciseNameNodes[workoutIndex][courseIndex].add(FocusNode());
      _focusExecerciseTimeOrSetNodes[workoutIndex][courseIndex]
          .add(FocusNode());
      setState(() {
        _newWorkout.workoutParts[workoutIndex].courses[courseIndex].exercises
            .add(Exercise(
          description: '',
        ));
      });
    }
  }

  void removeExercise(
    int workoutIndex,
    int courseIndex,
  ) {
    if (_newWorkout.workoutParts[workoutIndex] != null &&
        _newWorkout.workoutParts[workoutIndex].courses[courseIndex] != null &&
        _newWorkout.workoutParts[workoutIndex].courses[courseIndex].exercises
                .length >
            0) {
      _focusExecerciseNameNodes[workoutIndex][courseIndex].removeLast();
      _focusExecerciseTimeOrSetNodes[workoutIndex][courseIndex].removeLast();
      setState(() {
        _newWorkout.workoutParts[workoutIndex].courses[courseIndex].exercises
            .removeLast();
      });
    }
  }

  void addCourse(
    int workoutIndex,
  ) {
    if (_newWorkout.workoutParts[workoutIndex] != null) {
      setState(() {
        _focusCourseTimeOrSetNodes[workoutIndex].add(FocusNode());
        _focusExecerciseNameNodes[workoutIndex]
            .add(List.generate(1, (_) => FocusNode()));
        _focusExecerciseTimeOrSetNodes[workoutIndex]
            .add(List.generate(1, (_) => FocusNode()));
        _newWorkout.workoutParts[workoutIndex].courses.add(
          Course(
            type: courseType.Regular,
            exercises: [
              Exercise(
                description: '',
              )
            ],
          ),
        );
      });
    }
  }

  void removeCourse(
    int workoutIndex,
  ) {
    if (_newWorkout.workoutParts[workoutIndex] != null &&
        _newWorkout.workoutParts[workoutIndex].courses.length > 0) {
      _focusExecerciseNameNodes[workoutIndex].removeLast();
      _focusExecerciseTimeOrSetNodes[workoutIndex].removeLast();
      setState(() {
        _focusCourseTimeOrSetNodes.removeLast();
        _focusExecerciseNameNodes.removeLast();
        _focusExecerciseTimeOrSetNodes.removeLast();
        _newWorkout.workoutParts.removeLast();
      });
    }
  }

  void addWorkoutPart() {
    setState(() {
      _focusCourseTimeOrSetNodes.add(List.generate(1, (_) => FocusNode()));
      _focusExecerciseNameNodes
          .add(List.generate(1, (_) => List.generate(1, (_) => FocusNode())));
      _focusExecerciseTimeOrSetNodes
          .add(List.generate(1, (_) => List.generate(1, (_) => FocusNode())));
      _newWorkout.workoutParts.add(WorkoutPart(
        courses: [
          Course(
             type: courseType.Regular,
            exercises: [
              Exercise(
                description: '',
              )
            ],
          ),
        ],
      ));
    });
  }

  void removeWorkoutPart() {
    setState(() {
      _focusCourseTimeOrSetNodes.removeLast();
      _focusExecerciseNameNodes.removeLast();
      _focusExecerciseTimeOrSetNodes.removeLast();
      _newWorkout.workoutParts.removeLast();
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
    int workoutIndex,
    int courseIndex,
    String time,
  ) {
    if (_newWorkout.workoutParts[workoutIndex] != null &&
        _newWorkout.workoutParts[workoutIndex].courses[courseIndex] != null) {
      setState(() {
        _newWorkout.workoutParts[workoutIndex].courses[courseIndex].time =
            int.parse(time);
      });
    }
  }

  void updateCourseSets(
    int workoutIndex,
    int courseIndex,
    String sets,
  ) {
    if (_newWorkout.workoutParts[workoutIndex] != null &&
        _newWorkout.workoutParts[workoutIndex].courses != null) {
      setState(() {
        _newWorkout.workoutParts[workoutIndex].courses[courseIndex].sets =
            int.parse(sets);
      });
    }
  }

  void updateCourseType(
    int workoutIndex,
    int courseIndex,
    String type,
  ) {
    if (_newWorkout.workoutParts[workoutIndex] != null &&
        _newWorkout.workoutParts[workoutIndex].courses != null) {
      setState(() {
        _newWorkout.workoutParts[workoutIndex].courses[courseIndex].type =
            EnumToString.fromString(courseType.values, type);
      });
    }
  }

  void updateExerciseName(
    int workoutIndex,
    int courseIndex,
    int exericiseIndex,
    String description,
  ) {
    if (_newWorkout.workoutParts[workoutIndex] != null &&
        _newWorkout.workoutParts[workoutIndex].courses[courseIndex] != null &&
        _newWorkout.workoutParts[workoutIndex].courses[courseIndex]
                .exercises[exericiseIndex] !=
            null) {
      setState(() {
        _newWorkout.workoutParts[workoutIndex].courses[courseIndex]
            .exercises[exericiseIndex].description = description;
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

  String textFieldValidator(value, fieldName) {
    if (value.isEmpty) {
      return 'Please enter a$fieldName';
    }
    return null;
  }

  String numberFieldValidator(value, fieldName) {
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

  String dropdownValidator(value, fieldName) {
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

  List<Widget> getListExericies(
    Course course,
    List<WorkoutPart> workoutParts,
    int workoutPartindex,
    int courseindex,
  ) {
    return Utils.mapIndexed(
      course.exercises,
      (exerciseIndex, Exercise exercise) => SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(5.0),
              // decoration: BoxDecoration(
              //   color: Colors.white54,
              //   borderRadius: BorderRadius.only(
              //       topLeft: Radius.circular(3),
              //       topRight: Radius.circular(3),
              //       bottomLeft: Radius.circular(3),
              //       bottomRight: Radius.circular(3)),
              //   boxShadow: [
              //     BoxShadow(
              //       color: Colors.grey.withOpacity(0.2),
              //       spreadRadius: 5,
              //       blurRadius: 7,
              //       offset: Offset(0, 3), // changes position of shadow
              //     ),
              //   ],
              // ),
              padding: const EdgeInsets.all(5.0),
              child: TextFormField(
                initialValue: '',
                decoration: InputDecoration(labelText: 'Exercise'),
                textInputAction: TextInputAction.next,
                onChanged: (value) => updateExerciseName(
                    workoutPartindex, courseindex, exerciseIndex, value),
                onSaved: (value) {
                  updateExerciseName(
                      workoutPartindex, courseindex, exerciseIndex, value);
                  onSaveWorkout();
                },
                validator: (value) => textFieldValidator(value, 'n exercise'),
                focusNode: _focusExecerciseNameNodes[workoutPartindex]
                    [courseindex][exerciseIndex],
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(
                    _focusExecerciseTimeOrSetNodes[workoutPartindex]
                        [courseindex][exerciseIndex]),
              ),
            ),
          ],
        ),
      ),
    ).toList();
  }

  List<Widget> getListCourses(
    WorkoutPart workoutPart,
    List<WorkoutPart> workoutParts,
    int workoutPartindex,
  ) {
    return Utils.mapIndexed(
      workoutPart.courses,
      (courseIndex, Course course) => Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Flexible(
                flex: 8,
                child: Container(
                  margin: EdgeInsets.only(right: 5.0),
                  child: DropDownFormField(
                    titleText: 'Course type',
                    hintText: 'Please choose one',
                    value: EnumToString.parse(course.type),
                    validator: (value) =>
                        dropdownValidator(value, 'course type'),
                    onSaved: (value) {
                      updateCourseType(workoutPartindex, courseIndex, value);
                      onSaveWorkout();
                    },
                    onChanged: (value) =>
                        updateCourseType(workoutPartindex, courseIndex, value),
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
                  child: TextFormField(
                    initialValue: '',
                    decoration: InputDecoration(
                        labelText: (course.type == courseType.Amrap ||
                                course.type == courseType.Emom)
                            ? '${EnumToString.parse(course.type)} Time'
                            : 'Course Sets'),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    onChanged: (value) => (course.type == courseType.Amrap ||
                            course.type == courseType.Emom)
                        ? updateCourseTime(workoutPartindex, courseIndex, value)
                        : updateCourseSets(
                            workoutPartindex, courseIndex, value),
                    onSaved: (value) {
                      (course.type == courseType.Amrap ||
                              course.type == courseType.Emom)
                          ? updateCourseTime(
                              workoutPartindex, courseIndex, value)
                          : updateCourseSets(
                              workoutPartindex, courseIndex, value);
                      onSaveWorkout();
                    },
                    validator: (value) => numberFieldValidator(
                        value,
                        (course.type == courseType.Amrap ||
                                course.type == courseType.Emom)
                            ? 'how long will it take'
                            : 'number of sets'),
                    focusNode: _focusCourseTimeOrSetNodes[workoutPartindex]
                        [courseIndex],
                    onFieldSubmitted: (_) => FocusScope.of(context)
                        .requestFocus(
                            _focusExecerciseNameNodes[workoutPartindex]
                                [courseIndex][0]),
                  ),
                ),
              ),
            ],
          ),
          ...getListExericies(
              course, workoutParts, workoutPartindex, courseIndex),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  width: 190,
                  child: RaisedButton(
                    color: Theme.of(context).errorColor,
                    onPressed: () {
                      removeExercise(workoutPartindex, courseIndex);
                    },
                    padding: EdgeInsets.all(10.0),
                    child: const Text(
                      'Remove exercise',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  width: 160,
                  child: RaisedButton(
                    onPressed: () {
                      addExercise(workoutPartindex, courseIndex);
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
              ),
            ],
          )
        ],
      ),
    ).toList();
  }

  List<Widget> getListWorkoutParts(workoutParts) {
    return Utils.mapIndexed(
      workoutParts,
      (workoutPartindex, WorkoutPart workoutPart) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
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
              onChanged: (value) => updateWorkoutType(workoutPartindex, value),
              dataSource: EnumToString.toList(workoutPartType.values)
                  .map((type) => {"display": type, "value": type})
                  .toList(),
              textField: 'display',
              valueField: 'value',
              validator: (value) =>
                  dropdownValidator(value, 'workout part type'),
            ),
          ),
          ...getListCourses(workoutPart, workoutParts, workoutPartindex),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  width: 190,
                  child: RaisedButton(
                    color: Theme.of(context).errorColor,
                    onPressed: () {
                      removeCourse(workoutPartindex);
                    },
                    padding: EdgeInsets.all(10.0),
                    child: const Text(
                      'Remove course',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  width: 160,
                  child: RaisedButton(
                    onPressed: () {
                      addCourse(workoutPartindex);
                    },
                    padding: EdgeInsets.all(10.0),
                    child: const Text(
                      'Add course',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
                          textFieldValidator(value, ' workout title'),
                      onFieldSubmitted: (_) => FocusScope.of(context)
                          .requestFocus(_focusCourseTimeOrSetNodes[0][0]),
                    ),
                    ...getListWorkoutParts(_newWorkout.workoutParts),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
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
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Container(
                            width: double.infinity,
                            child: RaisedButton(
                              color:
                                  Theme.of(context).errorColor.withOpacity(0.9),
                              onPressed: () {
                                removeWorkoutPart();
                              },
                              padding: EdgeInsets.all(10.0),
                              child: const Text(
                                'Remove workout part',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
