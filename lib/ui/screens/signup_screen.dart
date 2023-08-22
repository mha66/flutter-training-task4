import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task4/cubit/app_cubit.dart';
import 'package:task4/ui/layout.dart';

import '../widgets/text_formfield_widget.dart';

class CreateAccountPage extends StatelessWidget {
  CreateAccountPage({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameC = TextEditingController();

  final TextEditingController emailC = TextEditingController();

  final TextEditingController passwordC = TextEditingController();

  final TextEditingController confirmPasswordC = TextEditingController();

  final TextEditingController phoneC = TextEditingController();

  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.height * 0.05,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: const Color(0xFFDADADA), width: 1)),
                        child: const Icon(CupertinoIcons.back)
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Welcome back! Glad\nto see you, Again!',
                      style: TextStyle(
                        color: Color(0xFF1E232C),
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextAndFormField(
                    controller: nameC,
                    hintText: 'Username',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name must be filled';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextAndFormField(
                    controller: emailC,
                    hintText: 'Email',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email must be filled';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  BlocConsumer<AppCubitA, AppStateA>(
                    listener: (context, state) {
                      obscurePassword = state is! PasswordVisible;
                    },
                    builder: (context, state) {
                      return TextAndFormField(
                        controller: passwordC,
                        hintText: 'Password',
                        obscureText: obscurePassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password must be filled';
                          } else if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          } else if (!value.contains(RegExp(r'(\d+)'))) {
                            return 'Password must contain digits';
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                            onPressed: () {
                              context.read<AppCubitA>().togglePasswordVisibility();
                            },
                            splashRadius: 1,
                            icon: obscurePassword
                                ? const Icon(Icons.visibility_off,
                                color: Color(0xFF300046))
                                : const Icon(
                              Icons.visibility,
                              color: Colors.blue,
                            )),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  TextAndFormField(
                    controller: confirmPasswordC,
                    hintText: 'Confirm Password',
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password must be confirmed';
                      } else if (value != passwordC.text) {
                        return 'Passwords don\'t match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextAndFormField(
                    controller: phoneC,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: false, decimal: false),
                    hintText: 'Phone Number',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Phone must be filled';
                      } else if (value.length < 11) {
                        return 'Phone number must be at least 11 digits';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  BlocConsumer<AppCubitA, AppStateA>(
                    listener: (context, state) {
                      if (state is SignupDoneState) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Layout()));
                      } else if (state is SignupErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.error.toString())));
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              await context.read<AppCubitA>().signUp(
                                name: nameC.text,
                                email: emailC.text,
                                password: passwordC.text,
                                phone: phoneC.text,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF300046),
                              minimumSize: Size(
                                  MediaQuery.of(context).size.width * 0.88,
                                  MediaQuery.of(context).size.height * 0.073),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          child: state is SignupLoadingState
                              ? const Center(
                            child: CircularProgressIndicator(
                                color: Colors.white),
                          )
                              : const Text(
                            'Register',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600),
                          )
                      );
                    },
                  ),
                  const SizedBox(height: 35),
                  const Row(
                    children: [
                      Expanded(
                          child: Divider(
                            color: Color(0xFFE8ECF4),
                            thickness: 1,
                          )),
                      SizedBox(width: 8),
                      Text(
                        'Or Login with',
                        style: TextStyle(
                            color: Color(0xFF6A707C),
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                          child: Divider(
                            color: Color(0xFFE8ECF4),
                            thickness: 1,
                          )),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.069,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: const Color(0xFFDADADA), width: 1)),
                          child: SvgPicture.asset('assets/icons/facebook.svg',
                              fit: BoxFit.scaleDown),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.069,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: const Color(0xFFDADADA), width: 1)),
                          child: SvgPicture.asset('assets/icons/google.svg',
                              fit: BoxFit.scaleDown),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.069,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: const Color(0xFFDADADA), width: 1)),
                          child: SvgPicture.asset('assets/icons/apple.svg',
                              fit: BoxFit.scaleDown),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
