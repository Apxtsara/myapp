import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // สร้างตัวแปรสำหรับเก็บข้อมูล username และ password
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // ฟังก์ชันสำหรับการล็อกอิน
  void _login() {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    // ตัวอย่างการตรวจสอบข้อมูล (สามารถปรับเปลี่ยนได้ตามต้องการ)
    if (username == "admin" && password == "password") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("เข้าสู่ระบบสำเร็จ")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFFDF5F2), // พื้นหลังสีเดียวกับ RegisterScreen
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey, // ใช้ formKey สำหรับการตรวจสอบฟอร์ม
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Text(
                  "Login to your account",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),

                // ฟอร์มสำหรับชื่อผู้ใช้
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: "Username",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  validator:
                      RequiredValidator(errorText: "กรุณาป้อนชื่อผู้ใช้"),
                ),
                const SizedBox(height: 15),

                // ฟอร์มสำหรับรหัสผ่าน
                TextFormField(
                  controller: _passwordController,
                  obscureText: true, // ทำให้ข้อความใน password ไม่แสดง
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  validator: RequiredValidator(errorText: "กรุณาป้อนรหัสผ่าน"),
                ),
                const SizedBox(height: 15),
                const SizedBox(height: 20),

                // ปุ่มล็อกอิน
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _login();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: const Color(0xFF9900FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
