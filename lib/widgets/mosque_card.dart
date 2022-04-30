import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'custom_text.dart';
import 'mosque_detail_card.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String location;
  final String rating;
  final String distance;
  final String fajr;
  final String zuhr;
  final String jummah;
  final String asr;
  final String maghrib;
  final String isha;
  const EventCard({
    Key? key,
    required this.title,
    required this.location,
    required this.rating,
    required this.distance,
    required this.fajr,
    required this.zuhr,
    required this.jummah,
    required this.asr,
    required this.maghrib,
    required this.isha,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 140,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 1, color: Color(0xff707070).withOpacity(0.2)))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 2,
          ),
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: "https://cdn-icons-png.flaticon.com/512/89/89021.png",
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Container(
                        width: 50,
                        height: 50,
                        child: Center(
                          child: CircularProgressIndicator(
                            value: downloadProgress.progress,
                          ),
                        )),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: CustomText(
                    text: title,
                    textSize: 16,
                    fontWeight: FontWeight.bold,
                    textColor: Color(0xff707070)),
              ),
              const SizedBox(
                height: 8,
              ),
              EventDetailCard(
                text: location,
                icon: 'location.png',
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  RatingBar.builder(
                    initialRating: rating == "null" ? 0 : double.parse(rating),
                    tapOnlyMode: false,
                    ignoreGestures: true,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 20,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (double value) {},
                  ),
                  CustomText(
                      text: rating == "null" ? "0" : rating,
                      textSize: 13,
                      fontWeight: FontWeight.w500,
                      textColor: Colors.black),
                ],
              ),
              Row(children: [
                const CustomText(
                    text: "Distance : ",
                    textSize: 13,
                    fontWeight: FontWeight.bold,
                    textColor: Colors.black),
                CustomText(
                    text: distance == "null" ? "0" : distance,
                    textSize: 13,
                    fontWeight: FontWeight.w500,
                    textColor: Colors.black),
                const CustomText(
                    text: " meters",
                    textSize: 13,
                    fontWeight: FontWeight.w500,
                    textColor: Colors.black),
              ]),
              // Row(children: const [
              //   CustomText(
              //       text: "Jammat Timings :",
              //       textSize: 13,
              //       fontWeight: FontWeight.bold,
              //       textColor: Colors.black),
              // ]),
              // Row(children: [
              //   Column(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         const CustomText(
              //             text: "Fajr",
              //             textSize: 13,
              //             fontWeight: FontWeight.bold,
              //             textColor: Colors.black),
              //         CustomText(
              //             text: fajr == "null" ? "0" : fajr,
              //             textSize: 13,
              //             fontWeight: FontWeight.w500,
              //             textColor: Colors.black),
              //       ]),
              //   Column(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         const CustomText(
              //             text: "Zuhr",
              //             textSize: 13,
              //             fontWeight: FontWeight.bold,
              //             textColor: Colors.black),
              //         CustomText(
              //             text: zuhr == "null" ? "0" : zuhr,
              //             textSize: 13,
              //             fontWeight: FontWeight.w500,
              //             textColor: Colors.black),
              //       ]),
              //   Column(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         const CustomText(
              //             text: "Jummah",
              //             textSize: 13,
              //             fontWeight: FontWeight.bold,
              //             textColor: Colors.black),
              //         CustomText(
              //             text: jummah == "null" ? "0" : jummah,
              //             textSize: 13,
              //             fontWeight: FontWeight.w500,
              //             textColor: Colors.black),
              //       ]),
              //   Column(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         const CustomText(
              //             text: "Asr",
              //             textSize: 13,
              //             fontWeight: FontWeight.bold,
              //             textColor: Colors.black),
              //         CustomText(
              //             text: asr == "null" ? "0" : asr,
              //             textSize: 13,
              //             fontWeight: FontWeight.w500,
              //             textColor: Colors.black),
              //       ]),
              //   Column(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         const CustomText(
              //             text: "Maghrib",
              //             textSize: 13,
              //             fontWeight: FontWeight.bold,
              //             textColor: Colors.black),
              //         CustomText(
              //             text: maghrib == "null" ? "0" : maghrib,
              //             textSize: 13,
              //             fontWeight: FontWeight.w500,
              //             textColor: Colors.black),
              //       ]),
              //   Column(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         const CustomText(
              //             text: "Isha",
              //             textSize: 13,
              //             fontWeight: FontWeight.bold,
              //             textColor: Colors.black),
              //         CustomText(
              //             text: isha == "null" ? "0" : isha,
              //             textSize: 13,
              //             fontWeight: FontWeight.w500,
              //             textColor: Colors.black),
              //       ]),
              // ]),
            ],
          )
        ],
      ),
    );
  }
}
