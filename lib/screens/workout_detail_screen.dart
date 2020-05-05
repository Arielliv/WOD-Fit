import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wod_fit/models/enums.dart';
import 'package:wod_fit/models/exercise.dart';
import 'package:wod_fit/models/workout_part.dart';
import 'package:wod_fit/utils/utils.dart';
import 'package:intl/intl.dart';
import '../providers/workouts.dart';

class WorkoutDetailScreen extends StatelessWidget {
  static const routeName = '/workout-detail';

  String getCourseText(workoutPart) {
    if (workoutPart.course.type == courseType.Amrap ||
        workoutPart.course.type == courseType.Emom) {
      return '${EnumToString.parse(workoutPart.type)} part for ${workoutPart.course.time} minutes';
    } else {
      return '${EnumToString.parse(workoutPart.type)} part X ${workoutPart.course.sets.toString()}';
    }
  }

  List<Widget> getExercises(List<Exercise> exercsies) {
    return Utils.mapIndexed(
      exercsies,
      (index, Exercise exercsie) => Container(
        padding: EdgeInsets.all(10),
        color: Colors.yellow,
        width: double.infinity,
        height: 45,
        child: Text(
          exercsie.type == exerciseType.Iteration
              ? '${exercsie.name} X ${exercsie.iteration}'
              : '${exercsie.name} in ${exercsie.time} seconds',
          softWrap: true,
          textAlign: TextAlign.center,
        ),
      ),
    ).toList();
  }

  List<Widget> getWorkoutparts(List<WorkoutPart> workoutParts) {
    return Utils.mapIndexed(
      workoutParts,
      (index, WorkoutPart workoutPart) => Container(
        height: workoutParts.length == 1 ? 1000 : 500,
        color: Colors.blue,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  color: Colors.lightGreen,
                  height: 50,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    getCourseText(workoutPart),
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            ...getExercises(workoutPart.course.exercises),
          ],
        ),
      ),
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    final itemId = ModalRoute.of(context).settings.arguments as String;
    final loadedWorkout = Provider.of<Workouts>(
      context,
      listen: false,
    ).findById(itemId);

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(loadedWorkout.title),
              background: Hero(
                tag: loadedWorkout.id,
                child: Image(
                  image: NetworkImage(
                      'https://wallpaperaccess.com/full/1244783.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(DateFormat.yMMMd().format(loadedWorkout.date),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.left),
                ),
                ...getWorkoutparts(loadedWorkout.workoutParts),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
