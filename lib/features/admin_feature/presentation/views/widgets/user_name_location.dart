import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UserNameAndLocation extends StatelessWidget {
  const UserNameAndLocation({
    super.key,
    required this.userName,
    required this.lat,
    required this.lang, required this.color,
  });
  final Color color;
  final String userName;
  final double lat;
  final double lang;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            userName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        IconButton(
          onPressed: () async {
            Uri url = Uri.parse('http://maps.google.com/?q=$lat,$lang');
            await launchUrl(url);
          },
          icon: Icon(
            Icons.location_on,
            color: color,
            size: 28,
          ),
        ),
      ],
    );
  }
}