import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:mosque_finder/services/api_services.dart';
import 'package:mosque_finder/widgets/custom_text.dart';
import 'package:permission_handler/permission_handler.dart';

class NimazScreen extends StatefulWidget {
  const NimazScreen({Key? key}) : super(key: key);

  @override
  State<NimazScreen> createState() => _NimazScreenState();
}

class _NimazScreenState extends State<NimazScreen> {
  var response;
  var hijriRespose;
  List timing = [];
  List jumatTimming = [];
  String higri = "";
  List nimazTime = ["Fajr", "Dhuhr", "Asar", "Maghrib", "Isha"];
  String? _timeString;
  String? lat;
  String? long;
  String? date;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime now = DateTime.now();
    date = DateFormat('dd MMM yyyy').format(now);
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(minutes: 1), (Timer t) => _getTime());
    _checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getUI(context),
    );
  }

  Widget _getUI(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/turkey_mosque.jpg"),
              fit: BoxFit.fill)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomText(
                text: _timeString!,
                textSize: 42,
                fontWeight: FontWeight.normal,
                textColor: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomText(
                text: date!,
                textSize: 18,
                fontWeight: FontWeight.normal,
                textColor: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomText(
                text: higri,
                textSize: 18,
                fontWeight: FontWeight.normal,
                textColor: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomText(
                text: "Namaz Timing",
                textSize: 21,
                fontWeight: FontWeight.w700,
                textColor: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            color: Colors.black.withOpacity(0.5),
            child: timing.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: timing.length,
                    itemBuilder: (context, i) {
                      DateTime now = DateTime.now();
                      String formattedDate =
                          DateFormat('dd MMM yyyy').format(now);
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Center(
                          child: Container(
                            height: 90,
                            width: 90,
                            child: Column(
                              children: [
                                CustomText(
                                    text: nimazTime[i],
                                    textSize: 16,
                                    fontWeight: FontWeight.normal,
                                    textColor: Colors.white),
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Image.asset('assets/images/alarm.png'),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomText(
                                    text: timing[i],
                                    textSize: 16,
                                    fontWeight: FontWeight.normal,
                                    textColor: Colors.white),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomText(
                text: "Jamat Timing",
                textSize: 21,
                fontWeight: FontWeight.w700,
                textColor: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 105,
            width: MediaQuery.of(context).size.width,
            color: Colors.black.withOpacity(0.5),
            child: jumatTimming.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: jumatTimming.length,
                    itemBuilder: (context, i) {
                      DateTime now = DateTime.now();
                      String formattedDate =
                          DateFormat('dd MMM yyyy').format(now);
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Center(
                          child: SizedBox(
                            height: 90,
                            width: 90,
                            child: Column(
                              children: [
                                CustomText(
                                    text: nimazTime[i],
                                    textSize: 16,
                                    fontWeight: FontWeight.normal,
                                    textColor: Colors.white),
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Image.asset('assets/images/alarm.png'),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomText(
                                    text: jumatTimming[i],
                                    textSize: 16,
                                    fontWeight: FontWeight.normal,
                                    textColor: Colors.white),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
          )
        ],
      ),
    );
  }

  _getData(String city) async {
    response = await ApiServices().getNimazTime(city);
    timing = [
      "${response[0]['fajr']}",
      "${response[0]['dhuhr']}",
      "${response[0]['asr']}",
      "${response[0]['maghrib']}",
      "${response[0]['isha']}"
    ];

    ///Fajar Time
    String fajarTime;
    String s = response[0]['fajr'];
    int idx = s.indexOf(":");
    String fajar = s.substring(idx + 1).trim();
    String am = fajar.replaceAll("am", "");
    int addTime = int.parse(am) + 40;
    int hourPlus = int.parse(s.substring(0, idx).trim());
    if (addTime >= 60) {
      addTime = addTime - 60;
      hourPlus++;
    }
    while (addTime % 5 != 0) {
      addTime++;
    }
    if (addTime == 0) {
      fajarTime = "$hourPlus:$addTime$addTime am";
    } else if (addTime < 10) {
      int c = 0;
      fajarTime = "$hourPlus:$c$addTime am";
    } else if (addTime == 60) {
      int c = 0;
      hourPlus++;
      fajarTime = "$hourPlus:$c$c am";
    } else
      fajarTime = "$hourPlus:$addTime am";
    setState(() {});

    /// Asar Time
    String asarTime;
    String asar = response[0]['asr'];
    int asrIndex = asar.indexOf(":");
    String asarMinute = asar.substring(asrIndex + 1).trim();
    String amRemove = asarMinute.replaceAll("pm", "");
    int asarAddedTime = int.parse(amRemove) + 25;
    if (asarAddedTime >= 0 && asarAddedTime <= 15) {
      int a = asarAddedTime - 0;
      int b = 15 - asarAddedTime;
      int c = 0;
      if (a < b) {
        c = 0;
      } else {
        c = 15;
      }
      int hourPlus = int.parse(asar.substring(0, asrIndex).trim());
      if (c == 0) {
        asarTime = "$hourPlus:$c$c pm";
      } else
        asarTime = "$hourPlus:$c pm";
      setState(() {});
    } else if (asarAddedTime >= 15 && asarAddedTime <= 30) {
      int a = asarAddedTime - 15;
      int b = 30 - asarAddedTime;
      int c = 0;
      if (a < b) {
        c = 15;
      } else {
        c = 30;
      }
      int hourPlus = int.parse(asar.substring(0, asrIndex).trim());
      asarTime = "$hourPlus:$c pm";
      setState(() {});
    } else if (asarAddedTime >= 30 && asarAddedTime <= 45) {
      int a = asarAddedTime - 30;
      int b = 45 - asarAddedTime;
      int c = 0;
      if (a < b) {
        c = 30;
      } else {
        c = 45;
      }
      int hourPlus = int.parse(asar.substring(0, asrIndex).trim());
      asarTime = "$hourPlus:$c pm";
      setState(() {});
    } else if (asarAddedTime >= 45 && asarAddedTime <= 60) {
      int a = asarAddedTime - 45;
      int b = 60 - asarAddedTime;
      int c = 0;
      if (a < b) {
        c = 45;
      } else {
        c = 0;
      }
      int hourPlus = int.parse(asar.substring(0, asrIndex).trim());
      if (c == 0) {
        hourPlus++;
        asarTime = "$hourPlus:$c$c pm";
      } else
        asarTime = "$hourPlus:$c pm";
      setState(() {});
    } else {
      int c = 0;
      if (asarAddedTime > 67) {
        c = 15;
      } else
        c = 0;
      int hourPlus = int.parse(asar.substring(0, asrIndex).trim()) + 1;
      if (c == 0) {
        asarTime = "$hourPlus:$c$c pm";
      } else
        asarTime = "$hourPlus:$c pm";

      setState(() {});
    }

    ///Isha Timming
    String ishaTiming;
    String isha = response[0]['isha'];
    int ishaIndex = isha.indexOf(":");
    String ishaMinute = isha.substring(ishaIndex + 1).trim();
    String pmRemove = ishaMinute.replaceAll("pm", "");
    int ishaAddedTime = int.parse(pmRemove) + 25;
    if (ishaAddedTime >= 0 && ishaAddedTime <= 15) {
      int a = ishaAddedTime - 0;
      int b = 15 - ishaAddedTime;
      int c = 0;
      if (a < b) {
        c = 0;
      } else {
        c = 15;
      }
      int hourPlus = int.parse(isha.substring(0, ishaIndex).trim());
      if (c == 0) {
        ishaTiming = "$hourPlus:$c$c pm";
      } else
        ishaTiming = "$hourPlus:$c pm";
      setState(() {});
    } else if (ishaAddedTime >= 15 && ishaAddedTime <= 30) {
      int a = ishaAddedTime - 15;
      int b = 30 - ishaAddedTime;
      int c = 0;
      if (a < b) {
        c = 15;
      } else {
        c = 30;
      }
      int hourPlus = int.parse(isha.substring(0, ishaIndex).trim());
      ishaTiming = "$hourPlus:$c pm";
      setState(() {});
    } else if (ishaAddedTime >= 30 && ishaAddedTime <= 45) {
      int a = ishaAddedTime - 30;
      int b = 45 - ishaAddedTime;
      int c = 0;
      if (a < b) {
        c = 30;
      } else {
        c = 45;
      }
      int hourPlus = int.parse(isha.substring(0, ishaIndex).trim());
      ishaTiming = "$hourPlus:$c pm";
      setState(() {});
    } else if (ishaAddedTime >= 45 && ishaAddedTime <= 60) {
      int a = ishaAddedTime - 45;
      int b = 60 - ishaAddedTime;
      int c = 0;
      if (a < b) {
        c = 45;
      } else {
        c = 0;
      }
      int hourPlus = int.parse(isha.substring(0, ishaIndex).trim());
      if (c == 0) {
        hourPlus++;
        ishaTiming = "$hourPlus:$c$c pm";
      } else {
        ishaTiming = "$hourPlus:$c pm";
      }
      setState(() {});
    } else {
      int c = 0;
      if (ishaAddedTime > 67) {
        c = 15;
      } else
        c = 0;
      int hourPlus = int.parse(isha.substring(0, ishaIndex).trim()) + 1;
      if (c == 0) {
        ishaTiming = "$hourPlus:$c$c pm";
      } else
        ishaTiming = "$hourPlus:$c pm";
    }
    setState(() {});
    jumatTimming = [
      fajarTime,
      "1:30 pm",
      asarTime,
      response[0]['maghrib'],
      ishaTiming
    ];
    setState(() {});
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm').format(dateTime);
  }

  _checkPermission() async {
    var status = await Permission.location.status;
    if (status.isGranted) {
      await _getCurrentLocation();
    } else {
      Permission.location.request();
      _checkPermission();
    }
  }

  _getCurrentLocation() async {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) async {
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        long = "${position.longitude}";
        lat = "${position.latitude}";
        setState(() {});
        await _getData(placemarks[0].locality!);
        await _getHijri();
      } catch (err) {}
      setState(() {});
    }).catchError((e) {
      print(e);
    });
  }

  _getHijri() async {
    print("called $lat $long ");
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd MMM yyyy').format(now);
    hijriRespose = await ApiServices()
        .getHijri(lat!, long!, "${now.month}", "${now.year}");
    for (var item in hijriRespose) {
      if (item["date"]["readable"] == formattedDate) {
        higri =
            "${item["date"]["hijri"]['month']['ar']}, ${item["date"]["hijri"]['day']}  ${item["date"]["hijri"]['year']}";
        setState(() {});
      }
    }
  }
}
