import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final Function(String) search;

  const SearchTextField({Key? key, required this.search}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onChanged: (val) => search(val),
        style: const TextStyle(
            letterSpacing: 0,
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500),
        decoration: InputDecoration(
            hintText: "Search Mosque",
            hintStyle: const TextStyle(
                letterSpacing: 0.5,
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.normal),
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Colors.grey.shade200,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.transparent)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(8)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.transparent))));
  }
}
