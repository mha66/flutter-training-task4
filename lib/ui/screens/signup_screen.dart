import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task4/ui/layout.dart';

import '../widgets/text_formfield_widget.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccountPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameC = TextEditingController();

  TextEditingController emailC = TextEditingController();

  TextEditingController passwordC = TextEditingController();

  TextEditingController phoneC = TextEditingController();

  bool obscurePassword = true;

  Future<bool> saveUserData({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String uid,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
        'uid': uid,
      }, SetOptions(merge: true));
      return true;
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
      return false;
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
            .then((value) async {
          if (value.user != null) {
            await saveUserData(
                    name: name,
                    email: email,
                    password: password,
                    phone: phone,
                    uid: value.user!.uid)
                .then((value) {
              if (value) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Layout()));
              }
            });
          }
        });
      } catch (error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    }
  }

  void togglePasswordVisibility() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Sign up',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                  ),
                  const SizedBox(height: 120),
                  TextAndFormField(
                    text: 'Name',
                    controller: nameC,
                    hintText: 'First Name',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name must be filled';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextAndFormField(
                    text: 'Email',
                    controller: emailC,
                    hintText: 'example@domain.com',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email must be filled';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextAndFormField(
                    text: 'Password',
                    controller: passwordC,
                    hintText: 'Examp!ePassw0rd123',
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
                          togglePasswordVisibility();
                        },
                        splashRadius: 1,
                        icon: obscurePassword
                            ? const Icon(Icons.visibility_off,
                                color: Color(0xFF330707))
                            : const Icon(
                                Icons.visibility,
                                color: Colors.blue,
                              )),
                  ),
                  const SizedBox(height: 20),
                  TextAndFormField(
                    text: 'Phone',
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
                  ElevatedButton(
                      onPressed: () async {
                        await signUp(
                          name: nameC.text,
                          email: emailC.text,
                          password: passwordC.text,
                          phone: phoneC.text,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF330707),
                          minimumSize: const Size(190, 45),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: const Text(
                        'Sign up',
                        style: TextStyle(fontSize: 20),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
