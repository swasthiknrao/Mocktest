import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_screen.dart';

const Color kPrimaryBlue = Color(0xFFAED8D7);
const Color kAccentOrange = Color(0xFFFF5522);
const Color kBackgroundColor = Color(0xFFF2F9FC);
const Color kWhite = Colors.white;

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationScreen({super.key, required this.phoneNumber});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final PageController _pageController = PageController();
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );
  bool _isVerifying = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildOtpPage(),
            _buildVerificationPage(),
            _buildSuccessPage(),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpPage() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(height: 30),
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [kAccentOrange, kPrimaryBlue],
                ).createShader(bounds),
                child: const Text(
                  'Verification Code',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'We sent a code to ${widget.phoneNumber}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  6,
                  (index) => _buildOtpBox(index),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: _buildResendButton(),
              ),
            ],
          ),
        ),
        if (_isVerifying)
          Container(
            color: Colors.black26,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kAccentOrange),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildOtpBox(int index) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 200 + (index * 100)),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: SizedBox(
            width: 50,
            height: 50,
            child: TextFormField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: kPrimaryBlue),
                ),
              ),
              onChanged: (value) {
                if (value.length == 1 && index < 5) {
                  _focusNodes[index + 1].requestFocus();
                }
                if (value.length == 1 && index == 5) {
                  _verifyOtp();
                }
              },
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildVerificationPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(kAccentOrange),
              strokeWidth: 8,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Verifying OTP...',
            style: TextStyle(
              fontSize: 20,
              color: kAccentOrange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 100,
            color: kAccentOrange,
          ),
          const SizedBox(height: 24),
          const Text(
            'Verification Successful!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kAccentOrange,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Continue to Home',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResendButton() {
    return TextButton.icon(
      onPressed: () {
        // TODO: Implement resend OTP
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('OTP resent successfully!'),
            backgroundColor: kAccentOrange,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
      icon: Icon(Icons.refresh, color: kAccentOrange),
      label: Text(
        'Resend Code',
        style: TextStyle(
          color: kAccentOrange,
          fontSize: 16,
        ),
      ),
    );
  }

  void _verifyOtp() async {
    String otp = _controllers.map((controller) => controller.text).join();
    if (otp.length == 6) {
      setState(() => _isVerifying = true);

      // Animate to verification page
      await _pageController.animateToPage(
        1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );

      // Simulate verification delay
      await Future.delayed(const Duration(seconds: 2));

      // Animate to success page
      await _pageController.animateToPage(
        2,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );

      setState(() => _isVerifying = false);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }
}
