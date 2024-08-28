import 'package:flutter/material.dart'; // Ensure this import is correct
import 'verify_email_page.dart';  // Ensure this import is correct and the file exists

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool agreeToTerms = false;
  String selectedProfileImage = '';
  final List<String> cities = [
    'Manila', 'Quezon City', 'Davao City', 'Cebu City', 'Zamboanga City',
    'Taguig', 'Pasig', 'Cagayan de Oro', 'Parañaque', 'Makati',
    'Las Piñas', 'Bacolod', 'General Santos', 'Marikina', 'Muntinlupa',
    'Calamba', 'Iloilo City', 'Mandaluyong', 'Angeles City', 'Valenzuela',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Account'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20),
              _buildTextField(controller: nameController, label: 'Name'),
              SizedBox(height: 20),
              _buildTextField(controller: emailController, label: 'Email'),
              SizedBox(height: 20),
              _buildBirthdayField(context),
              SizedBox(height: 20),
              _buildCityDropdown(),
              SizedBox(height: 20),
              _buildTextField(controller: passwordController, label: 'Password', isPassword: true),
              SizedBox(height: 20),
              _buildTextField(controller: confirmPasswordController, label: 'Confirm Password', isPassword: true),
              SizedBox(height: 20),
              Text('Select Profile Image:', style: TextStyle(color: Colors.grey, fontSize: 16)),
              SizedBox(height: 10),
              _buildProfileImages(),
              SizedBox(height: 20),
              _buildTermsAndPrivacy(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && _validateForm()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VerifyEmailPage()),
                    );
                  } else {
                    _showErrorDialog('Please complete all fields correctly.');
                  }
                },
                child: Text('Sign Up'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  primary: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool isPassword = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
        suffixIcon: isPassword ? Icon(Icons.visibility_off) : null,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        if (label == 'Email' && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }

  Widget _buildBirthdayField(BuildContext context) {
    return TextField(
      controller: birthdayController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Birthday',
        suffixIcon: Icon(Icons.calendar_today),
      ),
      readOnly: true,  // Prevent manual input
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );

        if (pickedDate != null) {
          String formattedDate = '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
          setState(() {
            birthdayController.text = formattedDate;
          });
        }
      },
    );
  }

  Widget _buildCityDropdown() {
    return DropdownButtonFormField<String>(
      value: cityController.text.isEmpty ? null : cityController.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'City',
      ),
      items: cities.map((String city) {
        return DropdownMenuItem<String>(
          value: city,
          child: Text(city),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          cityController.text = newValue ?? '';
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a city';
        }
        return null;
      },
    );
  }

  Widget _buildProfileImages() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildProfileImageChoice('assets/profile1.png'),
        SizedBox(width: 10),
        _buildProfileImageChoice('assets/profile2.png'),
        SizedBox(width: 10),
        _buildProfileImageChoice('assets/profile3.png'),
        SizedBox(width: 10),
        _buildProfileImageChoice('assets/profile4.png'),
      ],
    );
  }

  Widget _buildProfileImageChoice(String imagePath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedProfileImage = imagePath;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: selectedProfileImage == imagePath
              ? Border.all(color: Colors.green, width: 3)
              : null,
        ),
        child: CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(imagePath),
        ),
      ),
    );
  }

  Widget _buildTermsAndPrivacy() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: agreeToTerms,
          onChanged: (bool? value) {
            setState(() {
              agreeToTerms = value ?? false;
            });
          },
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              agreeToTerms = !agreeToTerms;
            });
          },
          child: Text(
            'I agree to the Terms and Privacy Policy',
            style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue),
          ),
        ),
      ],
    );
  }

  bool _validateForm() {
    if (selectedProfileImage.isEmpty) {
      _showErrorDialog('Please select a profile image.');
      return false;
    }
    if (!agreeToTerms) {
      _showErrorDialog('You must agree to the terms and privacy policy.');
      return false;
    }
    return true;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
