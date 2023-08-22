import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task4/cubit/app_cubit.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<AppCubitA, AppStateA>(
        builder: (context, state) {
          if (state is UserDataLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (context.read<AppCubitA>().userData != null) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(500),
                                border: Border.all(color: const Color(0xFF6FA2DE), width: 2)
                            ),
                            child: CircleAvatar(
                              backgroundImage: context
                                          .read<AppCubitA>()
                                          .userData!
                                          .image ==
                                      ''
                                  ? const NetworkImage(
                                      'https://banner2.cleanpng.com/20180722/gfc/kisspng-user-profile-2018-in-sight-user-conference-expo-5b554c0968c377.0307553315323166814291.jpg')
                                  : NetworkImage(
                                      context.read<AppCubitA>().userData!.image),
                              radius: MediaQuery.of(context).size.height * 0.1,
                              child: state is UploadImageLoadingState
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ))
                                  : null,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: const Color(0xFFF4F4F4),
                                borderRadius: BorderRadius.circular(50),
                                border:
                                    Border.all(width: 1, color: Colors.black)),
                            child: IconButton(
                                onPressed: () {
                                  context.read<AppCubitA>().pickImage();
                                },
                                icon: SvgPicture.asset(
                                    'assets/icons/add_profile_photo.svg')),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 70),
                    ProfileInfo(
                        text:
                            'User Name: ${context.read<AppCubitA>().userData!.name}'),
                    ProfileInfo(
                        text:
                            'Email: ${context.read<AppCubitA>().userData!.email}'),
                    ProfileInfo(
                        text:
                            'Phone Number: ${context.read<AppCubitA>().userData!.phone}'),
                  ],
                ),
              ),
            );
          } else {
            return const Text('error');
          }
        },
      ),
    );
  }
}

class ProfileInfo extends StatelessWidget {
  final String text;

  const ProfileInfo({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      decoration: BoxDecoration(
          color: const Color(0xFFDADADA),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1, color: Colors.black)),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontFamily: 'Urbanist',
          fontSize: 20,
        ),
      ),
    );
  }
}
