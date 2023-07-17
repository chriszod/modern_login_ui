import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modern_login_ui/components/my_button.dart';
import 'package:modern_login_ui/components/my_textfield.dart';
import 'package:modern_login_ui/components/square_tile.dart';
import 'package:modern_login_ui/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  //sign user in method
  void signUserIn() async {
    //show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    //error message
    void showErrorMessage(String message) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                backgroundColor: Colors.deepPurple,
                title: Center(
                    child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                )));
          });
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      //pop dialog circle
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop dialog circle
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(height: 50),

              // logo
              const Icon(
                Icons.lock,
                size: 100,
              ),

              const SizedBox(height: 50),

              //welcome back, you've been missed!
              Text(
                'Welcome back you\'ve been missed!',
                style: TextStyle(color: Colors.grey[700], fontSize: 16),
              ),

              const SizedBox(height: 25),

              //email textfield
              MyTextField(
                controller: emailController,
                hintText: 'email',
                obscuretext: false,
              ),

              const SizedBox(
                height: 10,
              ),

              //password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscuretext: true,
              ),

              const SizedBox(
                height: 10,
              ),

              //forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              //sign in button
              MyButton(
                text: 'Sign In',
                onTap: signUserIn,
              ),

              const SizedBox(height: 25),

              //or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey[400],
                        thickness: 0.5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey[400],
                        thickness: 0.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              //google + apple sign in buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //google logo
                  SquareTile(
                    imagePath: 'lib/images/google-logo.png',
                    onTap: () => AuthService().signInWithGoogle(),
                  ),

                  const SizedBox(
                    width: 10,
                  ),

                  //apple logo
                  SquareTile(
                    imagePath: 'lib/images/apple-logo.png',
                    onTap: () {},
                  ),
                ],
              ),

              const SizedBox(height: 50),

              //not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Register now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
