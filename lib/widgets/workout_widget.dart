// import '../providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/workout.dart';

class WorkoutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final authData = Provider.of<Auth>(context, listen: false);
    final item = Provider.of<Workout>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          // onTap: () {
          //   Navigator.of(context).pushNamed(
          //     ItemDetailScreen.routeName,
          //     arguments: item.id,
          //   );
          // },
          child: Hero(
            tag: item.id,
            child: FadeInImage(
              placeholder: NetworkImage('https://i.dlpng.com/static/png/4556688-workout-png-96-images-in-collection-page-3-workout-png-images-398_406_preview.webp'),
              image: NetworkImage('https://i.dlpng.com/static/png/4556688-workout-png-96-images-in-collection-page-3-workout-png-images-398_406_preview.webp'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          // leading: Consumer<Workout>(
          //   builder: (ctx, item, child) => IconButton(
          //     icon: Icon(
          //         item.isFavorite ? Icons.favorite : Icons.favorite_border),
          //     color: Theme.of(context).accentColor,
          //     onPressed: () {
          //       item.toggleFavoriteStatus(
          //         authData.token,
          //         authData.userId,
          //       );
          //     },
          //   ),
          // ),
          title: Text(
            item.title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
