import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  // Replace these with actual values
  final String appVersion = "1.0.0";
  final String contactEmail = "mailto:support@chessapp.com";
  // final String rateAppUrl = "https://play.google.com/store/apps/details?id=com.example.chessapp";

  // void _launchURL(String url) async {
  //   if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
  //     throw 'Could not launch $url';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white10,
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          sectionHeader("📱 Account & App Info"),

          buildTile(
            title: "About This App",
            subtitle: "Learn and play chess from basics to master level.",
            icon: Icons.info_outline,
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "Chess Mastery",
                applicationVersion: appVersion,
                applicationLegalese: "© 2025 Chess Mastery Inc.",
              );
            },
          ),
          buildTile(
            title: "Version",
            subtitle: appVersion,
            icon: Icons.verified,
          ),
          buildTile(
            title: "Contact / Feedback",
            subtitle: "support@chessapp.com",
            icon: Icons.email_outlined,
            onTap: () {
              //  _launchURL(contactEmail)
            },
          ),
          buildTile(
            title: "Rate Us",
            subtitle: "Tell others what you think",
            icon: Icons.star_border,
            onTap: () {
              //  _launchURL(rateAppUrl)
            },
          ),
        ],
      ),
    );
  }

  Widget sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey[200],
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildTile({
    required String title,
    required String subtitle,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      tileColor: Colors.white12,
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70)),
      trailing: onTap != null
          ? const Icon(Icons.chevron_right, color: Colors.white54)
          : null,
    );
  }
}
