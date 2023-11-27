import 'package:flutter/material.dart';

import 'package:untitled9/screens/home_screen.dart';
import 'package:untitled9/screens/screens.dart';
class CustomAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 24.0,
      ),
      color: Colors.red,

      child: SafeArea(
        child: Row(
          children: [
            //image of logo
            const SizedBox(width: 12.0),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _AppBarButton(title: 'TV Series', onTap: () => print('TV Series'),),
                  _AppBarButton(title: 'FILMS', onTap: () => print('FILMS'),),
                  _AppBarButton(title: 'WATCH LIST', onTap: () => print('WATCH LIST'),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBarButton extends StatelessWidget {
  final String title;
  final Function() onTap; // Change the type of onTap

  const _AppBarButton({
    Key? key, // Change the type of key
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
