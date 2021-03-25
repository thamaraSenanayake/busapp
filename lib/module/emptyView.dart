import 'package:flutter/material.dart';

import '../const.dart';

class EmptyView extends StatefulWidget {
  final String msg;
  EmptyView({Key key,@required this.msg}) : super(key: key);

  @override
  _EmptyViewState createState() => _EmptyViewState();
}

class _EmptyViewState extends State<EmptyView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                widget.msg,
                style: TextStyle(
                  color: AppData.primaryColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
            Container(
              height: 200,
              child: Image.asset(
                "assets/emptyView.jpg",
                fit: BoxFit.fitWidth,
              ),
            ),
          ],
        ),
      ),
    );
  }
}