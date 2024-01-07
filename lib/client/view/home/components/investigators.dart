import 'package:ecrime/admin/view/view_admin_barrel.dart';
import 'package:ecrime/client/res/images.dart';
import 'package:flutter/material.dart';

class InvestigatorsPage extends StatelessWidget {
  final List<String> investigators = [
    'Moazzam - SHO',
    'Talha - Inspector',
    'Furqan - Sub Inspector',
    'Ali - DSP',
    'Babar - ASP',
    'Zeeshan - SP',
    'Zulqarnain - SSP',
  ];

  InvestigatorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Investigators'),
      ),
      body: BackgroundFrame(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: investigators.length,
            itemBuilder: (context, index) {
              // Check if it's the first item to show a circular avatar
              if (index % 2 == 0) {
                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: AssetImage(
                          AppImages.police), // Replace with your dummy image
                    ),
                    title: Text(investigators[index]),
                  ),
                );
              } else {
                // For other items, show regular ListTile without avatar
                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: AssetImage(
                          AppImages.policeMan), // Replace with your dummy image
                    ),
                    title: Text(investigators[index]),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
