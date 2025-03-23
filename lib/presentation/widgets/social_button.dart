// Social Button Widget
import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final String icon;
  const SocialLoginButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
        shape: BoxShape.circle,
      ),
      child: Image.asset(icon, width: 30, height: 30),
    );
  }
}
