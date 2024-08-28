
import 'package:fake_store/screens/home.dart';
import 'package:fake_store/services/apiService.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget{
  TextEditingController nameController = TextEditingController(text: "mor_2314");
  TextEditingController passwordController = TextEditingController(text: "83r5^_");

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter shop'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
               ),
            ),

             const SizedBox(height: 30),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
               ),
            ),

            const SizedBox(height: 30),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () async {
                  final getToken = await ApiService().userLogin(
                    nameController.text,passwordController.text
                    
                  );

                  if (getToken['token']!= null){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("SUCCESS! Your Token id is ${getToken['token']}"),
                      backgroundColor: Colors.green));
                      Future.delayed(const Duration(seconds: 2),(){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
                      });
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Username or Password Incorrect"),
                      backgroundColor: Colors.red,
                      
                      ));
                  }
                },
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
               ),
            ),

          ],
        ),
      ),
    );
  }
}