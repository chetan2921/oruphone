import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:last_try/login_pages/verification_otp.dart';
import 'package:last_try/models/loginpage1_model.dart';
import 'package:last_try/services/api_call.dart';

class Loginpage1Widget extends StatefulWidget {
  const Loginpage1Widget({super.key, required String userName});

  @override
  State<Loginpage1Widget> createState() => _Loginpage1WidgetState();
}

class _Loginpage1WidgetState extends State<Loginpage1Widget> {
  late Loginpage1Model _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isTermsAccepted = false; // Track checkbox state

  @override
  void initState() {
    super.initState();
    _model = Loginpage1Model();
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void _requestOtp() async {
    if (!_isTermsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please accept the terms and conditions.')),
      );
      return;
    }

    String mobileNumber = _model.textController!.text.trim();

    if (mobileNumber.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a valid 10-digit mobile number.')),
      );
      return;
    }

    try {
      // Call the API to generate OTP
      final response =
          await ApiService().generateOtp(91, int.parse(mobileNumber));

      if (response != null && response['status'] == 'SUCCESS') {
        // Navigate to OTP Verification Page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Loginpage1CopyWidget(
              mobileNumber: mobileNumber,
              countryCode: '+91', // Pass the correct country code
            ),
          ),
        );
      } else {
        // Handle API error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to generate OTP. Please try again.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 4),
          ),
        );
      }
    } catch (e) {
      // Handle exceptions (e.g., network error)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Dismiss keyboard on tap outside
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: AlignmentDirectional(0, 0),
                child: Text(
                  'Welcome ',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const Align(
                alignment: AlignmentDirectional(0, 0),
                child: Text('Sign in to continue'),
              ),
              const SizedBox(height: 20),
              // Add an image above the mobile number area
              Center(
                child: Image.asset(
                  'assets/images/Logo.png', // Replace with your image URL
                  width: 200,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Material(
                color: Colors.transparent,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Enter your Mobile Number'),
                            TextFormField(
                              controller: _model.textController,
                              focusNode: _model.textFieldFocusNode,
                              keyboardType: TextInputType.phone,
                              maxLength: 10, // Restrict to 10 digits
                              inputFormatters: [
                                FilteringTextInputFormatter
                                    .digitsOnly, // Allow only digits
                              ],
                              decoration: InputDecoration(
                                counterText: "",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                prefixText: "+91 ", // Add +91 as prefix
                                prefixStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                suffixIcon: const Icon(Icons.phone),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'We\'ll send you a verification code to confirm your number',
                        ),
                        const SizedBox(height: 20),
                        // Add a checkbox for terms and conditions
                        Row(
                          children: [
                            Checkbox(
                              value: _isTermsAccepted,
                              onChanged: (value) {
                                setState(() {
                                  _isTermsAccepted = value ?? false;
                                });
                              },
                            ),
                            const Text('Accept terms and conditions'),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _requestOtp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0B3095),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text('Continue',
                                  style: TextStyle(color: Colors.white)),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward,
                                  color: Colors.white, size: 18),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
