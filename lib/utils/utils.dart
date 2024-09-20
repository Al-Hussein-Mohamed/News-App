String calcTime(String time) {
  DateTime dateTime = DateTime.parse(time);
  if (dateTime.year != DateTime.now().year) {
    int difference = DateTime.now().year - dateTime.year;
    return "$difference year${difference > 1 ? "s" : ""} ago";
  }
  if (dateTime.month != DateTime.now().month) {
    int difference = DateTime.now().month - dateTime.month;
    return "$difference month${difference > 1 ? "s" : ""} ago";
  }
  if (dateTime.day != DateTime.now().day) {
    int difference = DateTime.now().day - dateTime.day;
    return "$difference day${difference > 1 ? "s" : ""} ago";
  }
  if (dateTime.hour != DateTime.now().hour) {
    int difference = DateTime.now().hour - dateTime.hour;
    return "$difference hour${difference > 1 ? "s" : ""} ago";
  }
  if (dateTime.minute != DateTime.now().minute) {
    int difference = DateTime.now().minute - dateTime.minute;
    return "$difference minute${difference > 1 ? "s" : ""} ago";
  }

  int difference = DateTime.now().second - dateTime.second;
  return "$difference second${difference > 1 ? "s" : ""} ago";
}