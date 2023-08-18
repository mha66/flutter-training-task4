import 'package:flutter/material.dart';

import '../../data/data_source/data_source.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    if (DataSource.isLoadingProfile) {
      Future.delayed(Duration.zero, () async {
        await DataSource.getDataFromFirebase();
        setState(() {
          DataSource.isLoadingProfile = false;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DataSource.isLoadingProfile
      ? const Center( child: CircularProgressIndicator())
      : Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: Text(
                  'Profile',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
              ),
              const SizedBox(height: 120),
              ProfileInfo(title: 'First Name', text: DataSource.userData!.name),
              ProfileInfo(title: 'Phone', text: DataSource.userData!.phone),
              ProfileInfo(title: 'Email', text: DataSource.userData!.email),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileInfo extends StatelessWidget {
  final String title;
  final String text;

  const ProfileInfo({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.only(left: 12, top: 7, bottom: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF6F6666),
        borderRadius:  BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFFB7B6B6),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
