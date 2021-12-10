import 'package:intl/intl.dart';

enum PasswordValidType {
  atLeast6Characters,
  atLeast8Characters,
  strongPassword,
}

extension StringX on String {
  ///Example: abc -> a
  String getFirstWord() {
    try {
      return split(' ').first;
    } catch (e) {
      return '';
    }
  }

  ///Example: abc -> Abc
  String upperCaseFristLetter() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  ///Example: "120"-> 120.0
  double? toDouble({fractionDigits = 2}) {
    try {
      return double.tryParse(
          double?.tryParse(this)!.toStringAsFixed(fractionDigits));
    } catch (e) {
      return null;
    }
  }

  ///Check valid email
  bool isValidEmail() {
    var regExpEmail =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+";
    return RegExp(regExpEmail).hasMatch(this);
  }

  //Check valid name: at least 2 characters
  bool isValidName() {
    return length >= 2;
  }

  //Check valid fullName: at least 2 words
  bool isValidFullName() {
    bool isValid = false;
    if (trim().split(' ').length >= 2) {
      isValid = true;
    }
    return isValid;
  }

  /// Example: Nate Diaz -> return {'first_name':'Nate', 'last_name':'Diaz'}
  Map<String, dynamic> getFristNameLastName() {
    var fullNames = toString().trim().split(' ');
    var firstName = "";
    var lastName = "";
    fullNames.removeWhere((element) => element.trim() == '');
    firstName = fullNames.first.toString();
    if (fullNames.length > 1) {
      fullNames.removeAt(0);
      lastName = fullNames.reduce((a, b) => a + " " + b);
    }
    return {'first_name': firstName, 'last_name': lastName};
  }

  ///Example: Nate Diaz -> return "Nate"
  String getFirstName() {
    try {
      return getFristNameLastName()['first_name'];
    } catch (e) {
      return '-';
    }
  }

  ///Check valid password
  bool isValidPassword(
      {PasswordValidType passwordValidType =
          PasswordValidType.strongPassword}) {
    switch (passwordValidType) {
      case PasswordValidType.atLeast6Characters:
        return length >= 6;
      case PasswordValidType.atLeast8Characters:
        return length >= 8;
      case PasswordValidType.strongPassword:
        var regexPassword =
            r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[\^$*.\[\]{}\(\)?\-“!@#%&/,><\’:;|_~`])\S{8,99}";
        return RegExp(regexPassword).hasMatch(this);
    }
  }

  /// 8:30 PM
  String format12H() {
    return DateFormat('hh:mm a').format(DateTime.parse(this));
  }
}

extension DoubleX on double {
  /// 3.333333=> 3.33
  double? toCurrencyUnit() {
    try {
      return double.tryParse(toStringAsFixed(2));
    } catch (e) {
      return 0.0;
    }
  }
}

extension DateTimeX on DateTime {
  bool isToday() {
    var now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  String format12H() {
    return DateFormat('hh:mm a').format(this);
  }

  String format24H() {
    return DateFormat('HH:mm').format(this);
  }

  String formatHumableReadable({bool showTime = false}) {
    return DateFormat('dd MMM yyyy').format(this);
  }

  String format(String format) {
    return DateFormat(format).format(this);
  }

  bool isSameDay(DateTime dateTime) {
    return day == dateTime.day &&
        dateTime.month == month &&
        dateTime.year == year;
  }
}
