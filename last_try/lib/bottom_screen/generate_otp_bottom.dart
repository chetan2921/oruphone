// otp_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:last_try/services/api_call.dart';
import 'package:last_try/login_pages/verification_otp.dart';

class OtpBottomSheet extends StatefulWidget {
  final VoidCallback? onSuccess;

  const OtpBottomSheet({super.key, this.onSuccess});

  @override
  _OtpBottomSheetState createState() => _OtpBottomSheetState();
}

class _OtpBottomSheetState extends State<OtpBottomSheet> {
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  bool _isTermsAccepted = false;

  void _handleOtpRequest() async {
    if (!_isTermsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please accept terms and conditions')),
      );
      return;
    }

    final mobileNumber = _phoneController.text.trim();
    if (mobileNumber.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter valid 10-digit mobile number')),
      );
      return;
    }

    try {
      final response =
          await ApiService().generateOtp(91, int.parse(mobileNumber));
      if (response != null && response['status'] == 'SUCCESS') {
        Navigator.pop(context); // Close bottom sheet
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Loginpage1CopyWidget(
              mobileNumber: mobileNumber,
              countryCode: '+91',
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Verify Mobile Number',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _phoneController,
              focusNode: _phoneFocusNode,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: 'Mobile Number',
                prefixText: '+91 ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: const Icon(Icons.phone),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: _isTermsAccepted,
                  onChanged: (value) =>
                      setState(() => _isTermsAccepted = value!),
                ),
                const Flexible(
                  child: Text(
                    'I agree to the terms and conditions',
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _handleOtpRequest,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0B3095),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Send OTP', style: TextStyle(color: Colors.white)),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }
}

// Utility function to show the bottom sheet from any screen
void showOtpBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const OtpBottomSheet(),
  );
}
