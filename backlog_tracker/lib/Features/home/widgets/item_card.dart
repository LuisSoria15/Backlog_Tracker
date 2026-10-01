//nuestra tarjeta de item
import 'package:backlog_tracker/Features/home/models/item.dart';
import 'package:backlog_tracker/Features/home/screens/details_screen.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final Item item;

  final ValueChanged<bool?>? onCheckboxChanged;

  const ItemCard({super.key, required this.item, this.onCheckboxChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: const Color.fromARGB(187, 144, 202, 249),
      child: ListTile(
        leading: const SizedBox(width: 16),
        title: Center(
          child: Text(
            item.titulo,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        subtitle: Center(
          child: Text(
            item.categoria,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => DetailsScreen(item: item),
            ),
          );
        },
        trailing: Checkbox(
          value: item.completado,
          onChanged: onCheckboxChanged,
        ),
      ),
    );
  }
}
