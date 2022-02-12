import 'package:helper/utils/extensions.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

import 'package:money_formatter/money_formatter.dart';

class FlutterHelper {
  static bool firstTimeOpenApp = true;

  static double convertDegreeToRadian(double degree) {
    return degree / (180 * math.pi) * 10;
  }

  static enterFullScreen(context, bool gotoLandScape) async {
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersive,
    );

    if (gotoLandScape) {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
  }

  static exitFullScreen(context) async {
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    );

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  static String formatUtcTime(
      {required String dateUtc,
      required format,
      required languageCode,
      BuildContext? context,
      String? newPattern}) {
    try {
      var dateTime = DateFormat(newPattern ?? "yyyy-MM-dd'T'HH:mm:ss.SSSSSS")
          .parse(dateUtc, true);
      var dateLocal = dateTime.toLocal();

      return DateFormat(format,
              context == null || format == 'dd/MM/yy' ? "en" : languageCode)
          .format(dateLocal);
    } catch (e) {
      return '-:--';
    }
  }

  static String parseTime(
      {required BuildContext context,
      String? newPattern,
      required String input,
      required languageCode,
      required String format}) {
    try {
      var locale = languageCode;
      var dateTime = DateFormat(newPattern, locale).parse(input);
      return DateFormat(format, locale).format(dateTime);
    } catch (e) {
      return '-:--';
    }
  }

  static String parseDateTime(
      {BuildContext? context,
      String? newPattern,
      required DateTime input,
      required String format,
      required languageCode}) {
    try {
      String locale = 'en';
      if (context != null) {
        locale = languageCode;
      }

      return DateFormat(format, locale).format(input);
    } catch (e) {
      return '-:--';
    }
  }

  static String formatCurrency(double? number) {
    final formatCurrency = NumberFormat.currency(locale: 'en-US', symbol: '\$');
    String currency = formatCurrency.format(number ?? 0);
    if (currency.split('.')[1] == '00') {
      return currency.split('.')[0];
    }
    return currency;
  }

  static String formatDateTimeReadble(
    String dateTime, {
    String pattern = 'dd/MM/yy',
    required String todayStr,
    required String yesterDayStr,
    required languageCode,
  }) {
    try {
      DateTime now = DateTime.now();
      var date = DateFormat(pattern).parse(dateTime);
      if (date.year == now.year &&
          date.month == now.month &&
          date.day == now.day) {
        return todayStr;
      }
      if (date.year == now.year &&
          date.month == now.month &&
          date.day + 1 == now.day) {
        return yesterDayStr;
      }

      return DateFormat(pattern, languageCode).format(date);
    } catch (e) {
      return '-';
    }
  }

  static bool checkOrientationLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  static String formatDurationToHHmm({
    required Duration duration,
    required bool isToText,
    required String secStr,
    required String minStr,
    required String hourStr,
  }) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    String oneDigitMinutes = duration.inMinutes.remainder(60).toString();
    String oneDigitSeconds = duration.inSeconds.remainder(60).toString();
    if (duration.inHours == 0) {
      if (isToText) {
        if (duration.inMinutes == 0) {
          return '$oneDigitSeconds$secStr';
        } else {
          if (oneDigitSeconds != '0') {
            return '$oneDigitMinutes$minStr $oneDigitSeconds$secStr';
          } else {
            return '$oneDigitMinutes$minStr';
          }
        }
      } else {
        return "$twoDigitMinutes:$twoDigitSeconds";
      }
    } else {
      if (isToText) {
        if (oneDigitSeconds != '0') {
          return '${duration.inHours}$hourStr $twoDigitMinutes$minStr $oneDigitSeconds$secStr';
        } else {
          if (duration.inMinutes > 0) {
            return '${duration.inHours}$hourStr $twoDigitMinutes$minStr';
          } else {
            return '${duration.inHours}$hourStr';
          }
        }
      } else {
        return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
      }
    }
  }

  static bool isToday(String date) {
    try {
      var dateTime = DateTime.parse(date);
      return dateTime.isToday();
    } catch (e) {
      return false;
    }
  }

  static String formatDateToTime(
      {required String dateUTC, required languageCode}) {
    //2021-10-06T00:00:06
    try {
      var locale = languageCode;
      DateTime dt = DateTime.parse(dateUTC).toLocal();
      return DateFormat('hh:mm a', locale).format(dt);
    } catch (e) {
      return '-:--';
    }
  }

  static String formatFromToTime(
      {required languageCode, required String fromDateUTC, toDateUTC}) {
    //2021-10-06T00:00:06
    String startTime =
        formatDateToTime(languageCode: languageCode, dateUTC: fromDateUTC);
    String endTime =
        formatDateToTime(languageCode: languageCode, dateUTC: toDateUTC);
    if (startTime.split(' ')[1] == endTime.split(' ')[1]) {
      return '${startTime.split(' ')[0]} - $endTime';
    }
    return '$startTime - $endTime';
  }

  static String formatDateFromUTC(
      {required BuildContext context,
      required String dateUTC,
      required languageCode,
      String? pattern}) {
    //2021-10-06T00:00:06
    try {
      var locale = languageCode;
      DateTime dt = DateTime.parse(dateUTC).toLocal();
      return DateFormat(pattern ?? 'MMM dd', locale).format(dt);
    } catch (e) {
      return '-:--';
    }
  }

  static String parseFileUrl(String file) {
    return file.replaceAll(' ', '%20');
  }

  static String formatBitrate(int bitrate) {
    if (bitrate < 1000) {
      return "$bitrate bit/s";
    }
    if (bitrate < 1000000) {
      final kbit = (bitrate / 1000).floor();
      return "~$kbit KBit/s";
    }
    final mbit = (bitrate / 1000000).floor();
    return "~$mbit MBit/s";
  }

  static String formatMoney(double value) {
    try {
      MoneyFormatterOutput fo = MoneyFormatter(amount: value).output;
      return fo.nonSymbol;
    } catch (e) {
      return value.toStringAsFixed(2);
    }
  }
}
