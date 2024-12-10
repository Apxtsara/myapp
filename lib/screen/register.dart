import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:myapp/model/profile.dart';
import 'package:myapp/screen/home.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile(); // สร้างออบเจ็กต์ Profile
  String? confirmPassword; // ตัวแปรสำหรับเก็บรหัสผ่านที่ยืนยัน

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF5F2),
      resizeToAvoidBottomInset: true, // ปรับขนาดหน้าจอเมื่อแป้นพิมพ์เปิดใช้งาน
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // ย้อนกลับไปยังหน้า HomeScreen
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40), // ระยะห่างด้านบน
                const Text(
                  "Create a user account",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),

                // ฟิลด์สำหรับอีเมล
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  validator: MultiValidator([
                    RequiredValidator(errorText: "กรุณาป้อนอีเมล"),
                    EmailValidator(errorText: "รูปแบบอีเมลไม่ถูกต้อง"),
                  ]),
                  onSaved: (String? email) {
                    profile.email = email; // บันทึกอีเมลลงใน Profile
                  },
                ),
                const SizedBox(height: 15),

                // ฟิลด์สำหรับชื่อ
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  validator:
                      RequiredValidator(errorText: "กรุณาป้อนชื่อผู้ใช้"),
                  onSaved: (String? name) {
                    profile.username = name; // บันทึกชื่อผู้ใช้ลงใน Profile
                  },
                ),
                const SizedBox(height: 15),

                // ฟิลด์สำหรับรหัสผ่าน
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  validator: RequiredValidator(errorText: "กรุณาป้อนรหัสผ่าน"),
                  obscureText: true,
                  onSaved: (String? password) {
                    profile.password = password; // บันทึกรหัสผ่านลงใน Profile
                  },
                ),
                const SizedBox(height: 15),

                // ฟิลด์สำหรับยืนยันรหัสผ่าน
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "กรุณายืนยันรหัสผ่าน";
                    }
                    if (value != profile.password) {
                      return "รหัสผ่านไม่ตรงกัน";
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 20),

                // ปุ่มลงทะเบียน
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: const Color(0xFF9900FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Register",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState?.save();

                        // พิมพ์ค่าหลังจากบันทึกข้อมูล
                        print(
                            "Username: ${profile.username}, Email: ${profile.email}, Password: ${profile.password}");

                        // ย้ายไปที่หน้า HomeScreen หลังจากลงทะเบียนสำเร็จ
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                          (route) => false,
                        );
                      }
                    },
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
