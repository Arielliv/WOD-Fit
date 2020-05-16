import 'package:flutter/material.dart';

class WorkoutTitleView extends StatelessWidget {
  final String name;
  final String date;
  final String workoutId;
  final String userImageUrl;
  final Function press;

  const WorkoutTitleView({
    Key key,
    this.name,
    this.date,
    this.workoutId,
    this.userImageUrl,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Hero(
      tag: workoutId,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          margin: EdgeInsets.only(bottom: 16),
          width: size.width - 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(38.5),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 33,
                color: Color(0xFFD3D3D3).withOpacity(.84),
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding:const EdgeInsets.all(10.0),
                              child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        userImageUrl,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Workout : $name \n",
                      style: TextStyle(
                        fontSize: 16,
                        //kBlackColor
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: date,
                      // LightBlackColor
                      style: TextStyle(color: Colors.black38),
                    ),
                  ],
                ),
              ),
              Spacer(),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),
                onPressed: press,
              )
            ],
          ),
        ),
      ),
    );
  }
}
