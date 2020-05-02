import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
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
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print('Card tapped.');
        },
        child: Hero(
          tag: workout.id,
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    userImageUrl,
                  ),
                  backgroundColor: Colors.transparent,
                ),
                title: Text(workout.title),
                trailing: Text(DateFormat.yMMMd().format(workout.date))),
          ]),
        ),
      ),
    );
  }
}
