import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wod_fit/screens/workout_detail_screen.dart';
import 'package:wod_fit/screens/workout_details_screen.dart';
import '../providers/workout.dart';
import '../providers/auth.dart';

class WorkoutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final authData = Provider.of<Auth>(context, listen: false);
    final workout = Provider.of<Workout>(context, listen: false);
    final userImageUrl = Provider.of<Auth>(context, listen: false).imageUrl;

    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            WorkoutDetailScreen.routeName,
            arguments: workout.id,
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Hero(
              tag: workout.id,
              child: Material(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      userImageUrl,
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text(workout.title),
                  trailing: Text(DateFormat.yMMMd().format(workout.date)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
