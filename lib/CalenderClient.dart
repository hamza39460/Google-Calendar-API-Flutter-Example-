import 'dart:developer';

import 'package:flutter/material.dart';
import "package:googleapis_auth/auth_io.dart";
import 'package:googleapis/calendar/v3.dart';
import 'package:url_launcher/url_launcher.dart';

class CalendarClient {
  static const _scopes = const [CalendarApi.CalendarScope];

  insert(title, startTime, endTime) {
    var _clientID = new ClientId("YOUR_CLIENT_ID", "");
    clientViaUserConsent(_clientID, _scopes, prompt).then((AuthClient client) {
      var calendar = CalendarApi(client);
      calendar.calendarList.list().then((value) => print("VAL________$value"));

      String calendarId = "primary";
      Event event = Event(); // Create object of event

      event.summary = title;

      EventDateTime start = new EventDateTime();
      start.dateTime = startTime;
      start.timeZone = "GMT+05:00";
      event.start = start;

      EventDateTime end = new EventDateTime();
      end.timeZone = "GMT+05:00";
      end.dateTime = endTime;
      event.end = end;
      try {
        calendar.events.insert(event, calendarId).then((value) {
          print("ADDEDDD_________________${value.status}");
          if (value.status == "confirmed") {
            log('Event added in google calendar');
          } else {
            log("Unable to add event in google calendar");
          }
        });
      } catch (e) {
        log('Error creating event $e');
      }
    });
  }

  void prompt(String url) async {
    print("Please go to the following URL and grant access:");
    print("  => $url");
    print("");

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

/// Note:::: i have used calendar/v3.dart package to understand things this package is already included in GoogleApi package
/// you can access the package as i have told above

// import 'dart:developer';
// import 'dart:io' show Platform;

// import "package:googleapis_auth/auth_io.dart";
// import 'package:googleapis/calendar/v3.dart';
// import 'package:url_launcher/url_launcher.dart';

// class CalendarClient {
//   var _credentials;

//   static const _scopes = const [CalendarApi.CalendarEventsScope];

//   insert(context, title, date, startTime, endTime) {
// if (Platform.isAndroid) {
//   _credentials = new ClientId(
//       "878169543212-ugngo0bm18hu3lh83nk76bidts9c4q2r.apps.googleusercontent.com",
//       "");
// } else if (Platform.isIOS) {
//   _credentials = new ClientId(
//       "126777344627-ibdaobtrs4n62a0l7h19fs04h73pbqqf.apps.googleusercontent.com",
//       "");
// }

//     if (_credentials != null) {
//       clientViaUserConsent(_credentials, _scopes, prompt)
//           .then((AuthClient client) {
//         var calendar = CalendarApi(client);

//         String calendarId =
//             "primary"; //"primary "If you want to work on primary calender of logged in user
//         //but if you want to get any other calendar of logged in user
//         //use following code to get list of all calendar and then work on
//         //calendar.calendarList.list(); //this will return list of all calendars of logged in user
//         //you can then fetch calendarID of specific calendar by asking the user
//         Event event = Event(); // Create object of event

//         event.summary = title;
//         //event.description="OPTIMEET TEST 1";

//         DateTime startDateTime = DateTime.parse("$date $startTime");
//         EventDateTime start = new EventDateTime();
//         start.dateTime = startDateTime;
//         start.timeZone = "GMT+05:00";

//         event.start = start;

//         DateTime endDateTime = DateTime.parse("$date $endTime");
//         EventDateTime end = new EventDateTime();
//         end.timeZone = "GMT+05:00";
//         end.dateTime = endDateTime;

//         event.end = end;

//         // set description of event. You can set more things like date created
//         // to check what you can add else open the implementation of calendar/v3.dart package and go to Event class
//         // you can direct open the class implementation by placing the cursor over Event() (where object is created above)
//         // for android studio press Ctrl + Alt + B , for vs code press f12
//         // in the implementation they have provided comments and documents that can help you understand

//         try {
//           calendar.events.insert(event, calendarId).then((value) {
//             print("ADDEDDD_________________${value.status}");
//             if (value.status == "confirmed") {
//               // Dialogs().displayToast(
//               //     context, "Event added in google calendar", 0);
//               log('Event added in google calendar');
//             } else {
//               log("Unable to add event in google calendar");
//               // Dialogs().displayToast(
//               //     context, "Unable to add event in google calendar", 0);
//             }
//           });
//         } catch (e) {
//           log('Error creating event $e');
//           // Dialogs().displayToast(context, e, 0);
//         } // function to insert event
//         // incase of any confusion i will recommed to go to implementation of calendar/v3.dart
//         // and read comments of their codez
//       });
//     }
//   }

//   void prompt(String url) async {
//     print("Please go to the following URL and grant access:");
//     print("  => $url");
//     print("");

//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
// }

// /// Note:::: i have used calendar/v3.dart package to understand things this package is already included in GoogleApi package
// /// you can access the package as i have told above
