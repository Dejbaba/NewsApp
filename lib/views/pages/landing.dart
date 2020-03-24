import 'package:flutter/material.dart';
import 'package:news/utils/constants.dart';

class Landing extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return _Landing();
  }


}

class _Landing extends State<Landing>{

  var setColor1 = false;
  var setColor2 = false;
  var selected;
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: height(context),
          width: width(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: height(context) / 3, left: width(context) / 20, right: width(context) / 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Welcome. \n Please Select to get News",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: width(context) / 15),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: height(context) / 20,),
                    /*ClipOval(
                      clipBehavior: Clip.antiAlias,
                    ),*/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              setColor1 = true;
                              setColor2 = false;
                              selected = "ng";
                            });
                          },
                          child: ClipOval(
                            clipBehavior: Clip.hardEdge,
                            child: Container(
                              color: setColor1 ? Colors.blue : Colors.transparent,
                              height: height(context) / 4,
                              width: width(context) / 2.6,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                      radius: width(context) / 8,
                                      backgroundImage:AssetImage("assets/Nigeria.gif")
                                  ),
                                  Text(
                                    "Nigeria",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: width(context) / 25),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              setColor2 = true;
                              setColor1 = false;
                              selected = "others";

                            });
                          },
                          child: ClipOval(
                            clipBehavior: Clip.hardEdge,
                            child: Container(
                              color: setColor2 ? Colors.blue : Colors.transparent,
                              height: height(context) / 4,
                              width: width(context) / 2.6,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                      radius: width(context) / 8,
                                      backgroundImage:AssetImage("assets/globe.gif")
                                  ),
                                  Text(
                                    "Others",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: width(context) / 25),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: height(context) / 15,
                width: width(context),
                child: RaisedButton(
                  elevation: 3,
                  color: Colors.blue,
                  child: Text(
                    "Proceed",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: width(context) / 25,
                        color: Colors.white
                    ),
                    textAlign: TextAlign.start,
                  ),
                  onPressed: (){
                    if(selected == "others"){
                      Navigator.pushNamed(context, '/home');
                    }else if(!setColor1 && !setColor2){
                      print("You have ro select an option to proceed");
                    } else{
                      print("Fetch Articles from Nigeria");
                      Navigator.pushNamed(context, '/nigerianNews');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}