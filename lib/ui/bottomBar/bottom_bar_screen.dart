
import 'package:flutter/material.dart';
import 'package:mosque_finder/ui/bottomBar/screens/home_screen.dart';
import 'package:mosque_finder/ui/bottomBar/screens/nimaz_screen.dart';

class BottomBarScreen extends StatefulWidget {
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;
  List<Widget> _tabs = [];

  void _onItemTapped(int index) {
    _selectedIndex = index;

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabs = [const HomeScreen(), const NimazScreen()];
    // EasyLocalization.of(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined , size: 20,),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined , size: 20,),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.green,
          onTap: (index) => _onItemTapped(index),
        ),
        body: _tabs[_selectedIndex],
      ),
    );
  }
}