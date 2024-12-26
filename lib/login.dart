import 'package:asset_tracker/components/common_widgets.dart';
import 'package:asset_tracker/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _login() async {
    // Your login logic here
    LoginController controller = LoginController();
    await controller.loginUser(
        emailController.text, passwordController.text, context);

    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
    } else {
      print("Please fill in all fields.");
    }
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      body: KeyboardListener(
        autofocus: true,
        focusNode: FocusNode(),
        onKeyEvent: (event) {
          if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.enter) {
            _login(); // Trigger login when "Enter" is pressed
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Center(
            child: SizedBox(
              height: 550,
              width: 400,
              child: Card(
                color: Colors.blueGrey[900],
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Image.asset(
                          'assets/acino.png', // Path to your PNG file
                          // width: 100, // Adjust size as needed
                          height: 55,
                          fit: BoxFit.contain, // Control how the image fits
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Asset Manager',
                        style: GoogleFonts.roboto(
                            color: Colors.grey[400],
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Welcome back ',
                        style: GoogleFonts.roboto(
                            color: Colors.grey[400],
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '😁',
                        style: GoogleFonts.roboto(
                            color: Colors.grey[400],
                            fontSize: 28,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Enter Your Credentials to Login',
                        style: GoogleFonts.roboto(
                            color: Colors.grey[400],
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          children: [
                            Container(
                              width: 400,
                              height: 35,
                              child: TextFormField(
                                focusNode: _focusNode,
                                autofocus: true,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    hintText: 'Email Address',
                                    prefixIcon: Icon(
                                      Icons.email,
                                      size: 21,
                                    ),
                                    fillColor: Colors.grey[300],
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: const Color.fromARGB(
                                                255, 16, 99, 166))),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blueGrey))),
                                controller: emailController,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 400,
                              height: 35,
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    hintText: 'Password',
                                    fillColor: Colors.grey[300],
                                    prefixIcon: Icon(Icons.lock, size: 21),
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: const Color.fromARGB(
                                                255, 16, 99, 166))),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blueGrey))),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 35,
                              child: CommonWidgets.button(
                                  icon: Icons.login,
                                  label: 'Login',
                                  onPressed: () async {
                                    LoginController controller =
                                        LoginController();
                                    await controller.loginUser(
                                        emailController.text,
                                        passwordController.text,
                                        context);
                                  }),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        'Developed by: Acino META Team',
                        style: GoogleFonts.roboto(
                          color: Colors.orange[300],
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
