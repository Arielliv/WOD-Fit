import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wod_fit/widgets/app_drawer.dart';

import '../providers/workouts.dart';

enum FilterOptions { Favorites, All }

class WorkoutsOverviewScreen extends StatefulWidget {
  @override
  _WorkoutsOverviewScreenState createState() => _WorkoutsOverviewScreenState();
}

class _WorkoutsOverviewScreenState extends State<WorkoutsOverviewScreen> {
  var _isInit = false;
  var _isLoading = false;
  var _showOnlyFavorites = false;

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      _isLoading = true;
      Provider.of<Workouts>(context).fetchAndSetWorkouts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }

    _isInit = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('W.O.D - Fit'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text('Only Favorites'),
                  value: FilterOptions.Favorites),
              PopupMenuItem(child: Text('Show All'), value: FilterOptions.All),
            ],
          )
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.of(context).pushNamed(AddWorkoutScreen.routeName);
      //   },
      //   tooltip: 'Create new workout',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
