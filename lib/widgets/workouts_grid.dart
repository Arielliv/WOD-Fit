import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wod_fit/widgets/workout_widget.dart';
import '../providers/workouts.dart';

class WorkoutsGrid extends StatelessWidget {
  final bool showOnlyFavorites;

  WorkoutsGrid(this.showOnlyFavorites);
  
  @override
  Widget build(BuildContext context) {
    final workoutsData = Provider.of<Workouts>(context);
    final workouts =
        showOnlyFavorites ? null : workoutsData.workouts;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: workouts.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: workouts[i],
        child: Container(
          child: WorkoutWidget(),
        ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
