import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7EBE5),
      appBar: AppBar(
        backgroundColor: Color(0xFFF7EBE5),
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 10.0),
        children: <Widget>[
//           ListTile(
//             contentPadding: EdgeInsets.symmetric(horizontal: 20),
//             leading: Icon(
//               Icons.share,
//               size: 25,
//               color: Colors.black,
//             ),
//             title: Text(
//               'Share to friends',
//               style: TextStyle(fontSize: 18),
//             ),
//             onTap: () {
//               Share.share('''
// 👇Download this App👇
// https://play.google.com/store/apps/details?id=com.smw.sotranslator \n\n
// ⚡✨ Check out the So Translator App ⚡✨
//   ''');
//             },
//           ),
          // Divider(
          //   height: 0,
          // ),
          // ListTile(
          //   contentPadding: EdgeInsets.symmetric(horizontal: 20),
          //   leading: Icon(
          //     Icons.star_rate_outlined,
          //     size: 25,
          //     color: Colors.black,
          //   ),
          //   title: Text(
          //     'Give us Rating',
          //     style: TextStyle(fontSize: 18),
          //   ),
          //   onTap: () {
          //     _launchURL(
          //         'https://play.google.com/store/apps/details?id=com.smw.sotranslator');
          //   },
          // ),
          // Divider(
          //   height: 0,
          // ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            leading: Icon(
              Icons.privacy_tip,
              size: 25,
              color: Colors.black,
            ),
            title: Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              _launchURL(
                  'https://www.termsfeed.com/live/aea60b8a-8573-4fa9-afbf-fe1749b98e93');
            },
          ),
          Divider(
            height: 0,
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            leading: Icon(
              Icons.private_connectivity_rounded,
              size: 25,
              color: Colors.black,
            ),
            title: Text(
              'Terms and Condition',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              _launchURL(
                  'https://www.termsfeed.com/live/ec9f82a6-4de9-4d7c-9e50-86095c55a8db');
            },
          ),
          Divider(
            height: 0,
          ),
        ],
      ),
    );
  }
}