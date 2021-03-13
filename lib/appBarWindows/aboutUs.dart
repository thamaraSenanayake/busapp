import 'package:flutter/material.dart';
import 'package:quickbussl/module/topBar.dart';
import '../const.dart';

class AboutUs extends StatefulWidget {
  AboutUs({Key key,}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  double _width =0.0;
  
  @override
  void initState() { 
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
    });
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopBarModule(
              title: "About Us", 
              buttonClick: (){
                Navigator.pop(context);
              }, 
              iconData: Icons.arrow_back
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
              child: Text(
                "Deserunt pariatur laboris occaecat ullamco sit fugiat nostrud ipsum ut. Sunt velit officia veniam elit eiusmod mollit excepteur magna excepteur velit. Qui ea sit eu amet. Cupidatat pariatur ex nulla commodo deserunt quis laborum sint aute duis qui. Duis sint cillum ullamco consequat ipsum incididunt Lorem ut ullamco. Sint commodo quis et sint commodo ad voluptate irure tempor aute laborum aliqua. Aute non ullamco consequat commodo in reprehenderit.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: AppData.blackColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                  wordSpacing:1
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}