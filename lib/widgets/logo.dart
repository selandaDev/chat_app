import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String texto;

  const Logo({Key? key, required this.texto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        margin: EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Image(image: AssetImage('assets/tag-logo.png')),
            SizedBox(height: 20),
            Text(texto, style: TextStyle(fontSize: 30))
          ],
        ),
      ),
    );
  }
}
