import 'package:flutter/material.dart';
import 'package:quickbussl/module/topBar.dart';
import '../const.dart';

class PrivacyPolicy extends StatefulWidget {
  PrivacyPolicy({Key key,}) : super(key: key);

  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  
  @override
  void initState() { 
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopBarModule(
              title: "Privacy Policy", 
              buttonClick: (){
                Navigator.pop(context);
              }, 
              iconData: Icons.arrow_back
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
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