import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task4/data/data_source/data_source.dart';
import 'package:task4/ui/layout.dart';
import 'package:task4/ui/screens/signup_screen.dart';
import 'package:task4/ui/widgets/text_formfield_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailC = TextEditingController();

  TextEditingController passwordC = TextEditingController();

  bool obscurePassword = true;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
            .then((value) {
          if (value.user != null) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Layout()));
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
  void initState() {
    if (DataSource.userData != null) {
      emailC.text = DataSource.userData!.email;
      passwordC.text = DataSource.userData!.password;
    }
    super.initState();
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
                    'Login',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                  ),
                  const SizedBox(height: 120),
                  TextAndFormField(
                    text: 'Email',
                    controller: emailC,
                    hintText: 'Email',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email is empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextAndFormField(
                    text: 'Password',
                    controller: passwordC,
                    hintText: 'Password',
                    obscureText: obscurePassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password is empty';
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
                            : const Icon(Icons.visibility, color: Colors.blue)
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                      onPressed: () async {
                        await login(
                            email: emailC.text, password: passwordC.text);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF330707),
                          minimumSize: const Size(190, 45),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 20),
                      )),
                  const SizedBox(height: 12),
                  const Text(
                    'OR',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CreateAccountPage()));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF330707),
                          minimumSize: const Size(190, 45),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: const Text(
                        'Create Account',
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
