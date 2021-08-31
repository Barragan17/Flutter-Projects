import 'package:flutter/material.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final id = routeArgs['id'];
    return Scaffold(
      appBar: AppBar(
        title: Text(id!),
      ),
      body: Center(
        child: Text('Food ID: $id'),
      ),
    );
  }
}