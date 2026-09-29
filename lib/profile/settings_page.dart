import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notifications = true;
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          // ================= ACCOUNT =================

          _sectionTitle("Account"),

          _settingsTile(
            icon: Icons.person_outline,
            title: "Edit Profile",
            subtitle: "Update your personal information",
            onTap: () {
              // Navigate to Edit Profile
            },
          ),

          const SizedBox(height: 20),

          // ================= PREFERENCES =================

          _sectionTitle("Preferences"),

          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            secondary: const Icon(
              Icons.notifications_outlined,
            ),
            title: const Text("Notifications"),
            subtitle: const Text(
              "Receive notifications and updates",
            ),
            value: notifications,
            onChanged: (value) {
              setState(() {
                notifications = value;
              });
            },
          ),

          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            secondary: const Icon(
              Icons.dark_mode_outlined,
            ),
            title: const Text("Dark Mode"),
            subtitle: const Text(
              "Change the appearance of the app",
            ),
            value: darkMode,
            onChanged: (value) {
              setState(() {
                darkMode = value;
              });
            },
          ),

          _settingsTile(
            icon: Icons.language,
            title: "Language",
            subtitle: "English",
            onTap: () {
              // Language selection
            },
          ),

          const SizedBox(height: 20),

          // ================= PRIVACY =================

          _sectionTitle("Privacy & Security"),

          _settingsTile(
            icon: Icons.privacy_tip_outlined,
            title: "Privacy",
            subtitle: "Manage your privacy settings",
            onTap: () {
              // Privacy page
            },
          ),

          _settingsTile(
            icon: Icons.lock_outline,
            title: "Change Password",
            subtitle: "Update your account password",
            onTap: () {
              // Change password
            },
          ),

          const SizedBox(height: 20),

          // ================= ABOUT =================

          _sectionTitle("About"),

          _settingsTile(
            icon: Icons.description_outlined,
            title: "Terms & Conditions",
            onTap: () {
              // Terms page
            },
          ),

          _settingsTile(
            icon: Icons.policy_outlined,
            title: "Privacy Policy",
            onTap: () {
              // Privacy Policy
            },
          ),

          _settingsTile(
            icon: Icons.info_outline,
            title: "About BJIO",
            subtitle: "Version 1.0.0",
            onTap: () {
              // About page
            },
          ),
        ],
      ),
    );
  }

  // ================= SECTION TITLE =================

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ================= SETTINGS TILE =================

  Widget _settingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,

      leading: Icon(icon),

      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),

      subtitle: subtitle != null
          ? Text(subtitle)
          : null,

      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
      ),

      onTap: onTap,
    );
  }
}