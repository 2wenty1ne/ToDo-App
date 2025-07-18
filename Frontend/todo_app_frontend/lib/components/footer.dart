import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  bool _isNavCircleOpen = false;

  void _changeNavCirlceState() {
    setState(() {
      if (_isNavCircleOpen) {
        _isNavCircleOpen = false;
      }
      else {
        _isNavCircleOpen = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
