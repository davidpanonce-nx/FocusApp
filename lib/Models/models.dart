class FocusUser {
  final String? username;
  final int? focusTime;
  final String? feedBack;
  final int? credits;

  FocusUser({this.username, this.focusTime, this.feedBack, this.credits});

  // FocusUser.fromJson(Map<String, dynamic> parsedJson)
  //     : username = parsedJson['name'],
  //       focusTime = parsedJson['']
}

class FocusUserData {
  final String? uid;
  final String? username;
  final int? focusTime;
  final String? feedBack;
  final int? credits;

  FocusUserData(
      {this.uid, this.username, this.focusTime, this.feedBack, this.credits});
}
