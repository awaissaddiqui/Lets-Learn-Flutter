import 'package:flutter/material.dart';

import '../../../constant/const_color.dart';



class BottomNavigationBarInFlutter extends StatefulWidget {
  const BottomNavigationBarInFlutter({super.key});

  @override
  State<BottomNavigationBarInFlutter> createState() => _BottomNavigationBarInFlutterState();
}

class _BottomNavigationBarInFlutterState extends State<BottomNavigationBarInFlutter> {
 List<Widget> listWidget =[
   Center(child: Text("Home")),
   Center(child: Text("Seacrh")),
   Center(child: Text("Upload ")),
   Center(child: Text("Chats")),
   Center(child: Text("profile")),
 ];

  int selectedIndex = 0;
  void OnTap(int index){
    setState(() {
      selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0XFF1D242D),
        onTap: OnTap,
        currentIndex: selectedIndex,
        selectedItemColor: selectedTextBgColor,
        items: [
        BottomNavigationBarItem(icon: ImageIcon(AssetImage(selectedIndex==0?"/images/active.png":"/images/inActive.png")), label: "Home",),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
        BottomNavigationBarItem(icon: Container(
          width: 60,
          decoration: BoxDecoration(
            gradient: primaryColor,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.add),
          ),
        ),label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chats"),
        BottomNavigationBarItem(icon: Icon(selectedIndex==4?Icons.add:Icons.supervised_user_circle_outlined), label: "Profile"),

      ],



      ),
body: listWidget.elementAt(selectedIndex),
    );
  }
}
