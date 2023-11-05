import 'package:flutter/material.dart';
import 'package:ecrime/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColor.primaryColor,
        ),
      ),
      title: 'E-Crime Report System',
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Home Screen",
              style: TextStyle(
                color: AppColor.whiteColor,
                fontFamily: interExtraBold,
                fontSize: 20,
              ),
            ),
            centerTitle: true,
          ),
          backgroundColor: AppColor.primaryColor,
          body: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.backgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(backgroundRadius),
                      topRight: Radius.circular(backgroundRadius),
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 36.0, left: 10, right: 10),
                    child: Column(
                      children: [
                        Text(
                          'How Can We help you',
                          style: TextStyle(
                            color: AppColor.primaryColor,
                            fontSize: 20,
                            fontFamily: interExtraBold,
                          ),
                        ),
                        const SizedBox(
                          height: 76,
                        ),
                        Row(
                          children: [],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
