import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glass/glass.dart';
import 'package:gofast/exports/export_pages.dart';
import 'package:gofast/exports/export_services.dart';
import 'package:gofast/widgets/custom_snack.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  // late AnimationController _animationController;
  // late Animation<double> _animation;
  late final TextEditingController _emailController =
      TextEditingController(text: '');
  late final TextEditingController _passwordController =
      TextEditingController(text: '');

  final FocusNode _passwordFocusNode = FocusNode();
  bool _obsecureText = false;
  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _loginFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submitFormOnLogin() async {
    final isValid = _loginFormKey.currentState!.validate();
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      try {
        await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim().toLowerCase(),
          password: _passwordController.text.trim(),
        );
      } catch (error) {
        setState(() {
          if (mounted) {
            _isLoading = false;
          }
        });
        // GlobalMethod.showErrorDialog(error: error.toString(), ctx: context);
        // print('error occured $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.transparent,
            behavior: SnackBarBehavior.floating,
            elevation: 0,
            duration: const Duration(seconds: 3),
            content: CustomSnackbarContent(
              message: "Oh snap!",
              errorText: ("Error: " + error.toString()),
              containerClr: const Color.fromRGBO(3, 62, 101, 1),
              bubblesClr: const Color(0xFF062026),
            ),
          ),
        );
      }
    }
    setState(() {
      if (mounted) {
        _isLoading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).iconTheme.color,
              image: const DecorationImage(
                  image: AssetImage("assets/images/extended.png"),
                  fit: BoxFit.cover,
                  opacity: 0.3),
            ),
          ),
          ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    right: 0,
                    left: 0,
                    bottom: -46,
                    child: Lottie.asset("assets/json/delivery.json",
                        fit: BoxFit.cover),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height*0.55,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(19),
                      color: Colors.black54,
                    ),
                    child: Form(
                      key: _loginFormKey,
                      child: Column(
                        children: [
                           SizedBox(
                            height: MediaQuery.of(context).size.height*0.12,
                            child: Text("GoFasta", style: textStyle(70, Colors.white, FontWeight.bold),),
                          ),

                          //email
                          EmailField(
                              passwordFocusNode: _passwordFocusNode,
                              emailController: _emailController),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025,
                          ),

                          //password
                          TextFormField(
                            cursorColor: Colors.white,
                            textInputAction: TextInputAction.next,
                            focusNode: _passwordFocusNode,
                            keyboardType: TextInputType.visiblePassword,
                            controller: _passwordController,
                            obscureText: !_obsecureText,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 8) {
                                return "Please enter a valid password";
                              } else {
                                return null;
                              }
                            },
                            style:
                                textStyle(18, Colors.white, FontWeight.normal),
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obsecureText = !_obsecureText;
                                  });
                                },
                                child: Icon(
                                  _obsecureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white,
                                ),
                              ),
                              hintText: 'Password ',
                              prefixIcon: const Icon(
                                CupertinoIcons.lock_circle,
                                color: Colors.white,
                                size: 30,
                              ),
                              hintStyle:
                                  textStyle(16, Colors.grey, FontWeight.normal),
                              isDense: true,
                              contentPadding: const EdgeInsets.all(6),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: Color(0xFFA1403B)),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),

                          MaterialButton(
                            onPressed: _submitFormOnLogin,
                            color:
                                Theme.of(context).progressIndicatorTheme.color,
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Login '.toUpperCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025,
                          ),

                          MaterialButton(
                            visualDensity: VisualDensity.compact,
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const Register();
                              }));
                            },
                            color: Theme.of(context).indicatorColor,
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Register'.toUpperCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const ForgotPasswordPage();
                                      },
                                    ),
                                  );
                                },
                                child: Text(
                                  'Forgot Password',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ).asGlass(tintColor: Colors.transparent, blurX: 4, blurY: 4),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class EmailField extends StatelessWidget {
  const EmailField({
    Key? key,
    required FocusNode passwordFocusNode,
    required TextEditingController emailController,
  })  : _passwordFocusNode = passwordFocusNode,
        _emailController = emailController,
        super(key: key);

  final FocusNode _passwordFocusNode;
  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.white,
      textInputAction: TextInputAction.next,
      onEditingComplete: () =>
          FocusScope.of(context).requestFocus(_passwordFocusNode),
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      validator: (value) {
        if (value!.isEmpty || !value.contains("@")) {
          return "Please enter a valid email address";
        } else {
          return null;
        }
      },
      style: textStyle(18, Colors.white, FontWeight.normal),
      decoration: InputDecoration(
        hintText: 'Email ',
        prefixIcon: const Icon(
          CupertinoIcons.mail,
          color: Colors.white,
        ),
        isDense: true,
        contentPadding: const EdgeInsets.all(6),
        hintStyle: textStyle(16, Colors.grey, FontWeight.normal),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.white),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xFFA1403B)),
        ),
      ),
    );
  }
}
