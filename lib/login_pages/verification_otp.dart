import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:last_try/login_pages/name_page.dart';
import 'package:last_try/services/api_call.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Loginpage1CopyWidget extends StatefulWidget {
  final String mobileNumber;

  const Loginpage1CopyWidget({
    super.key,
    required this.mobileNumber,
    required String countryCode,
  });

  @override
  State<Loginpage1CopyWidget> createState() => _Loginpage1CopyWidgetState();
}

class _Loginpage1CopyWidgetState extends State<Loginpage1CopyWidget> {
  final TextEditingController otpController = TextEditingController();

  void _validateOtp() async {
    String otp = otpController.text.trim();

    if (otp.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a valid 4-digit OTP')),
      );
      return;
    }

    try {
      // Call the API to validate OTP
      final response = await ApiService()
          .validateOtp(91, int.parse(widget.mobileNumber), int.parse(otp));

      if (response != null && response['status'] == 'SUCCESS') {
        // Navigate to the next screen (e.g., Home Screen or Confirm Name Screen)
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const NameInput(
              name: '',
            ), // Replace with your next screen
          ),
        );
      } else {
        // Handle API error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid OTP. Please try again.'),
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Verify Mobile Number',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Enter the 4-digit OTP sent to your mobile number via SMS',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: PinCodeTextField(
                  appContext: context,
                  length: 4,
                  keyboardType: TextInputType.number,
                  controller: otpController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {},
                  pinTheme: PinTheme(
                    fieldHeight: 50,
                    fieldWidth: 40,
                    borderWidth: 2,
                    shape: PinCodeFieldShape.box,
                    activeColor: Colors.black,
                    inactiveColor: Colors.grey,
                    selectedColor: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _validateOtp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF16088D),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                ),
                child: const Text('Verify OTP',
                    style: TextStyle(color: Colors.white)),
              ),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Resend OTP feature coming soon!')),
                  );
                },
                child: const Text('Resend OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
