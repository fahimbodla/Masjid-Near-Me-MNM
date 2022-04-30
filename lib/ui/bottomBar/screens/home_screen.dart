import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:maps_toolkit/maps_toolkit.dart';
import 'package:mosque_finder/navigation/navigation.dart';
import 'package:mosque_finder/services/api_services.dart';
import 'package:mosque_finder/ui/bottomBar/screens/masjid_detail.dart';
import 'package:mosque_finder/widgets/custom_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mosque_finder/widgets/mosque_card.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../widgets/heading_text.dart';
import '../../../widgets/search_textfield.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> allMosque = [];
  List<dynamic> filterMosque = [];
  String lat = "";
  String long = "";
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref().child("test");
  String l1 = "";
  String l2 = "";
  var response;
  var hijriRespose;
  List timing = [];
  List jumatTimming = [];
  String higri = "";
  List nimazTime = ["Fajr", "Dhuhr", "Asar", "Maghrib", "Isha"];
  String? _timeString;
  String? date;
  late Position position1;
  // late BannerAd bannerAd;
  // bool isload = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkPermission(l1, l2);
    //initBanner();
  }
/*
  initBanner() {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: BannerAd.testAdUnitId,
        listener: BannerAdListener(
            onAdLoaded: (ad) {
              setState(() {
                isload = true;
              });
            },
            onAdFailedToLoad: (ad, error) {}),
        request: AdRequest());
    bannerAd.load();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: _getUI(context)),
    );
  }

  Widget _getUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 60,
          ),
          const HeadingText(
              heading: "Showing Mosques  In 1 KM",
              subHeading: "Find the Mosque near you"),
          SizedBox(
            height: 20,
          ),
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.blue,
            ),
            onPressed: _launchURL,
            child: new Text('Add New Masjid'),
          ),
          SearchTextField(
            search: (String) {
              _filter(String);
            },
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.65,
            width: MediaQuery.of(context).size.width,
            child: allMosque.isEmpty
                ? const Center(
                    child: CustomText(
                        text:
                            "No Mosque Found near you or\nAllow your location to get near-by mosque",
                        textSize: 14,
                        fontWeight: FontWeight.w500,
                        textColor: Colors.grey),
                  )
                : ListView.builder(
                    itemCount: filterMosque.isEmpty
                        ? allMosque.length
                        : filterMosque.length,
                    itemBuilder: (context, i) {
                      print(allMosque[i]);
                      return InkWell(
                        onTap: () {
                          NavigationHelper.pushRoute(
                              context,
                              MasjidDetailScreen(
                                masjidName: filterMosque.isEmpty
                                    ? allMosque[i]['name']
                                    : filterMosque[i]['name'],
                                meter: filterMosque.isEmpty
                                    ? "${SphericalUtil.computeDistanceBetween(LatLng(double.parse(l1), double.parse(l2)), LatLng(allMosque[i]['geometry']['location']['lat'], allMosque[i]['geometry']['location']['lng'])).round()}"
                                    : "${SphericalUtil.computeDistanceBetween(LatLng(double.parse(l1), double.parse(l2)), LatLng(filterMosque[i]['geometry']['location']['lat'], filterMosque[i]['geometry']['location']['lng'])).round()}",
                                location: filterMosque.isEmpty
                                    ? allMosque[i]['vicinity']
                                    : filterMosque[i]['vicinity'],
                                placeID: filterMosque.isEmpty
                                    ? allMosque[i]['place_id']
                                    : filterMosque[i]['place_id'],
                                long:
                                    '${allMosque[i]['geometry']['location']['lng']}',
                                lat:
                                    '${allMosque[i]['geometry']['location']['lat']}',
                              ));
                        },
                        child: EventCard(
                          rating: filterMosque.isEmpty
                              ? "${allMosque[i]['rating']}"
                              : "${filterMosque[i]['rating']}",
                          title: filterMosque.isEmpty
                              ? allMosque[i]['name']
                              : filterMosque[i]['name'],
                          location: filterMosque.isEmpty
                              ? allMosque[i]['vicinity']
                              : filterMosque[i]['vicinity'],
                          distance: filterMosque.isEmpty
                              ? "${SphericalUtil.computeDistanceBetween(LatLng(double.parse(l1), double.parse(l2)), LatLng(allMosque[i]['geometry']['location']['lat'], allMosque[i]['geometry']['location']['lng'])).round()}"
                              : "${SphericalUtil.computeDistanceBetween(LatLng(double.parse(l1), double.parse(l2)), LatLng(filterMosque[i]['geometry']['location']['lat'], filterMosque[i]['geometry']['location']['lng'])).round()}",
                          fajr: filterMosque.isEmpty ? "4:00" : "4:00",
                          zuhr: filterMosque.isEmpty ? "4:00" : "4:00",
                          jummah: filterMosque.isEmpty ? "4:00" : "4:00",
                          asr: filterMosque.isEmpty ? "4:00" : "4:00",
                          maghrib: filterMosque.isEmpty ? "4:00" : "4:00",
                          isha: filterMosque.isEmpty ? "4:00" : "4:00",
                        ),
                      );
                    }),
          )
        ],
      ),
    );
  }

  _getCurrentLocation(String $l1, String $l2) async {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((position1) async {
      l1 = "${position1.latitude}";
      l2 = "${position1.longitude}";
      await _getMosque("${position1.latitude}", "${position1.longitude}");
      // await _getMosque("33.5889", "71.4429");
      setState(() {});
    }).catchError((e) {
      print(e);
    });
  }

  _getMosque(String lat, String long) async {
    allMosque = await ApiServices().getresturents(lat, long);
    setState(() {});
  }

  _filter(String name) {
    filterMosque.clear();
    for (var item in allMosque) {
      var title = item['name'].toString().toLowerCase();
      if (title.toLowerCase().toString().contains(name.toString())) {
        filterMosque.add(item);
        setState(() {});
      }
    }
  }

  _launchURL() async {
    const url =
        'https://www.google.com/maps/@31.4607004,74.3219656,15z/data=!10m2!1e2!2e10';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _checkPermission(String $l1, String $l2) async {
    var status = await Permission.location.status;
    if (status.isGranted) {
      await _getCurrentLocation(l1, l2);
    } else {
      Permission.location.request();
      _checkPermission(l1, l2);
    }
  }
}
