import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task4/cubit/app_cubit.dart';
import 'package:task4/ui/layout.dart';
import 'package:task4/ui/screens/signup_screen.dart';
import 'package:task4/ui/widgets/text_formfield_widget.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailC = TextEditingController();

  final TextEditingController passwordC = TextEditingController();

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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.15),
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
                  const SizedBox(height: 70),
                  BlocBuilder<AppCubitA, AppStateA>(
                    builder: (context, state) {
                      if (state is SignOutDoneState) {
                        emailC.text = context.read<AppCubitA>().userData!.email;
                      }
                      return TextAndFormField(
                        controller: emailC,
                        hintText: 'Enter your email',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email is empty';
                          }
                          return null;
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  BlocConsumer<AppCubitA, AppStateA>(
                    listener: (context, state) {
                      obscurePassword = state is! PasswordVisible;
                    },
                    builder: (context, state) {
                      if (state is SignOutDoneState) {
                        passwordC.text =
                            context.read<AppCubitA>().userData!.password;
                      }
                      return TextAndFormField(
                        controller: passwordC,
                        hintText: 'Enter your password',
                        obscureText: obscurePassword,
                        //state is LoginPasswordObscured,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is empty';
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                            onPressed: () {
                              context
                                  .read<AppCubitA>()
                                  .togglePasswordVisibility();
                            },
                            splashRadius: 1,
                            icon:
                                obscurePassword //state is LoginPasswordObscured
                                    ? const Icon(Icons.visibility_off,
                                        color: Color(0xFF300046))
                                    : const Icon(Icons.visibility,
                                        color: Colors.blue)),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  BlocConsumer<AppCubitA, AppStateA>(
                    listener: (context, state) {
                      if (state is LoginErrorState) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(state.error)));
                      } else if (state is LoginDoneState) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Layout()));
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              await context.read<AppCubitA>().login(
                                  email: emailC.text, password: passwordC.text);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF300046),
                              minimumSize: Size(
                                  MediaQuery.of(context).size.width * 0.88,
                                  MediaQuery.of(context).size.height * 0.073),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          child: state is LoginLoadingState
                              ? const Center(
                                  child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                              : const Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w600),
                                ));
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
                  const SizedBox(height: 55),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          color: Color(0xFF1E232C),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateAccountPage()));
                          },
                          child: const Text(
                            'Register Now',
                            style: TextStyle(
                              color: Color(0xFFF14336),
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


