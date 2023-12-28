
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';




class BottomNavigationContainer extends StatelessWidget {
  final int index = 1;

  const BottomNavigationContainer({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height= MediaQuery.of(context).size.height;
    var width= MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
      height:  1.sh,
      width: 370,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:  BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          index == 1 ? Column(
            children: [
              IconButton(
                  enableFeedback: false,
                  onPressed: () {

                  },
                  icon: Icon(
                    Icons.home,
                    color: Colors.black,
                    size: width*0.06,
                  )
              ),
              Container(
                color: Color(0xff008B74),
                height: 2,
                width: width*0.07,
              )
            ],
          ) : IconButton(
              enableFeedback: false,
              onPressed: () {

              },
              icon: Icon(
                Icons.home,
                color: Colors.black,
                size: width*0.06,
              )
          ),
          index == 2 ? Column(
            children: [
              IconButton(
                  enableFeedback: false,
                  onPressed: () {

                  },
                  icon: Icon(
                    Icons.energy_savings_leaf,
                    color: Colors.black,
                    size: width*0.06,
                  )
              ),
              Container(
                color: Color(0xff008B74),
                height: 2,
                width: width*0.07,
              )
            ],
          ) : IconButton(
              enableFeedback: false,
              onPressed: () {

              },
              icon: Icon(
                Icons.energy_savings_leaf,
                color: Colors.black,
                size: width*0.06,
              )
          ),

          index == 3 ? Column(
            children: [
              IconButton(
                  enableFeedback: false,
                  onPressed: () {

                  },
                  icon: Icon(
                    Icons.document_scanner,
                    color: Colors.black,
                    size: width*0.06,
                  )
              ),
              Container(
                color: Color(0xff008B74),
                height: 2,
                width: width*0.07,
              )
            ],
          ) : IconButton(
              enableFeedback: false,
              onPressed: () {

              },
              icon: Icon(
                Icons.document_scanner,
                color: Colors.black,
                size: width*0.06,
              )
          ),
          index == 4 ? Column(
            children: [
              IconButton(
                  enableFeedback: false,
                  onPressed: () {

                  },
                  icon: Icon(
                    Icons.games,
                    color: Colors.black,
                    size: width*0.06,
                  )
              ),
              Container(
                color: Color(0xff008B74),
                height: 2,
                width: width*0.07,
              )
            ],
          ) : IconButton(
              enableFeedback: false,
              onPressed: () {

              },
              icon: Icon(
                Icons.games,
                color: Colors.black,
                size: width*0.06,
              )
          ),

        ],
      ),
    );
  }
}
