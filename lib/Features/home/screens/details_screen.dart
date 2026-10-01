//l pantalla que mostrara al dar click al item
import 'package:backlog_tracker/Features/home/models/item.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final Item item;

  const DetailsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(92, 179, 229, 252),
        title: Text(item.categoria, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Text(
              item.titulo,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextField(),
          ],
        ),
      ),
    );
  }
}
