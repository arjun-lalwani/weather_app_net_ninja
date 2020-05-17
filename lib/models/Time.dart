class Time {
  int _hours;
  int _minutes;
  bool _isDay;
  String dateTime;

  Time(this.dateTime) {
    String time = dateTime.substring(
        dateTime.indexOf('T') + 1, dateTime.indexOf('.') - 3);
    this._hours = int.parse(time.substring(0, time.indexOf(':')));
    this._minutes =
        int.parse(time.substring(time.indexOf(':') + 1, time.length));
    this._isDay = (this._hours > 12) ? true : false;
  }

  String twelveHourClock() {
    String timeUnit = (_hours > 12) ? "PM" : "AM";
    String minutes = (_minutes < 10) ? "0$_minutes" : "$_minutes";
    String hour = "$_hours";
    if (_hours == 0) {
      hour = "12";
    } else if (_hours > 12) {
      hour = "${_hours - 12}";
    }
    return "$hour:$minutes $timeUnit";
  }

  String partOfDay() {
    if (_hours > 16 && _hours < 20) {
      return "evening";
    } else if (_hours >= 20 || _hours <= 6) {
      return "night";
    } else {
      return "day";
    }
  }

  bool isDay() => this._isDay;
}
