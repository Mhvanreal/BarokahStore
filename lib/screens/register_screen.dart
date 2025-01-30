import 'package:barokah/Page/register/register_bloc.dart';
import 'package:barokah/Page/register/register_event.dart';
import 'package:barokah/Page/register/register_state.dart';
// import 'package:barokah/data/app_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController pertanyaanController = TextEditingController();
  final TextEditingController jawabanController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            print("Current state: $state");
            if (state is RegisterSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Registration successful!')),
              );
            } else if (state is RegisterFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: pertanyaanController,
                  decoration: InputDecoration(labelText: 'Pertanyaan Untuk Keamanan'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your pertanyaan untuk keamanan akun';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: jawabanController,
                  decoration: InputDecoration(labelText: 'Jawaban untuk Keamanan'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your jawaban untuk keamanan akun';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                BlocBuilder<RegisterBloc, RegisterState>(
                  builder: (context, state) {
                    if (state is RegisterLoading) {
                      return CircularProgressIndicator();
                    }
                    return ElevatedButton(
                      onPressed: () {
                        if (!formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Tolong Isi text Diatas yang masih Kosong'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }
                        final name = nameController.text;
                        final email = emailController.text;
                        final password = passwordController.text;
                        final pertanyaan = pertanyaanController.text;
                        final jawaban = jawabanController.text;

                        context.read<RegisterBloc>().add(
                              RegisterUser(
                                name: name,
                                email: email,
                                password: password,
                                pertanyaan: pertanyaan,
                                jawaban: jawaban,
                              ),
                            );
                      },
                      child: Text('Register'),
                    );
                  },
                ),
                SizedBox(height: 20),
                // ElevatedButton(
                //   onPressed: () async {
                //     await AppDatabase().deleteAllData();
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       SnackBar(content: Text('Semua data berhasil dihapus!')),
                //     );
                //   },
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.red,
                //   ),
                //   child: Text('Hapus Semua Data'),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
