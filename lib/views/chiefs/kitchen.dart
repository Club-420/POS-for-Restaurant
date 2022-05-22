import 'package:flutter/material.dart';

class KitchenView extends StatefulWidget {
  const KitchenView({Key? key}) : super(key: key);

  @override
  State<KitchenView> createState() => _KitchenViewState();
}

class _KitchenViewState extends State<KitchenView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Kitchen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('kitchen is being constructed'),
      ),
    );
  }
}
