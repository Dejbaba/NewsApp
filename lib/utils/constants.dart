import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;



final String baseUrl = "https://newsapi.org/v2";
final String apiKey = "c24b89bf8fe84b4eb7b7ef067b76fb9f";
final bool devMode = false;
final String username = "username";
final String isremember = "is_remember";
final String emptyEmailField = "Email field cannot be empty!";
final String emptyTextField = "Field cannot be empty!";
final String emptyPasswordField = "Password field cannot be empty";
final String invalidEmailField =
    "Email provided isn\'t valid.Try another email address";
final String passwordLengthError = "Password length must be greater than 6";
final String emptyUsernameField = "Username  cannot be empty";
final String usernameLengthError = "Username length must be greater than 6";
final String emailRegex = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
    "\\@" +
    "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
    "(" +
    "\\." +
    "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
    ")+";
final String verificationText =
    '''We sent a verification code to you registered mobile number +234 807 *** **90. Please enter verification code below''';

//popup dialog message on account setup page 1
final String popUpMessage = "You have to select an account";

//popup dialog message for mismatch passwords
final String passwordMismatchMessage =
    "Your passwords have to match to continue.";

//error message on creating account
final String emailDuplicateMsg =
    "Op! This email address has already been registered";

//error message for no Internet/Network Connection
final String noNetworkMsg = "Op! Check your internet connection and try again";

//default image placeholder for network image
final String defaultPlaceholder = "https://via.placeholder.com/150/FFFFFF/000000    /?text=Sorry, \nNo Image";

//MediaQuery Width
double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

//Mediaquery Height
double height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

String filterContent(String content) {
  var filteredContent = content.split("…|\\Q...\\E");
  String summary = filteredContent[0];
  return summary;
}

//convert datetime format to normal date(dd-mm-yy)
String dateFormatter(String date) {
  var formatter = new DateFormat('yyyy-MM-dd');
  DateTime dateTime = formatter.parse(date);
  String formatted = formatter.format(dateTime);
  var reformatDate = formatted.split("-");
  String formattedDate = reformatDate[2]+"-"+reformatDate[1]+"-"+reformatDate[0];

  print(formatted);
  return formattedDate;
}


//dummy list of different news categories
List<String> newsCategory = [
  "Business",
  "Entertainment",
  "General",
  "Health",
  "Science",
  "Sports",
  "Technology",
];

//List of "List of categories"
List<String> business;
List<String> entertainment;
List<String> general;
List<String> health;
List<String> science;
List<String> sports;
List<String> technology;

List<List<String>> listOfCategories = [business, entertainment, general, health, science, sports, technology];







String splitSourceName(String source){

  String jointWord = "";

  if(source.contains("-")){
    var parts = source.split("-");
    for(int i = 0; i < parts.length; i++){
      jointWord += parts[i]+"_";
    }
    String filteredJointWord = jointWord.substring(0, jointWord.length - 1);
    return filteredJointWord;
  }else{
    return source;
  }
}

String imageName(String imageName){

  String jointWord = "";

  if(imageName.contains("-")){
    var parts = imageName.split("-");
    for(int i = 0; i < parts.length; i++){
      jointWord += parts[i]+" ";
    }

    return jointWord.trim();
  }else{
    return imageName;
  }
}


String imageFileName(String imageName){

  String picName = splitSourceName(imageName);
  if(picName.contains("google_news")){
    return "google_news";
  }else if(picName.contains("mtv_news")){
    return "mtv_news";
  }else if(picName.contains("business_insider")){
    return "business_insider";
  }else{
    return picName.trim();
  }

}




// get color for source container
Color getColor(int index) {
  final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.deepOrange,
    Colors.pink,
    Colors.orange,
    Colors.purple
  ];
  return colors[index];

}

