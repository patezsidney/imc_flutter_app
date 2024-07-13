import 'package:flutter/material.dart';

class ImcListItem extends StatelessWidget {
  const ImcListItem({
    super.key,
    required this.title,
    required this.height,
    required this.weight,
    required this.creationDate,
    required this.id,
  });

  final String id;
  final String title;
  final String height;
  final String weight;
  final DateTime creationDate;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        key: Key(id),
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Altura: $height m | Peso: $weight Kg",
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              "${creationDate.day}/${creationDate.month}/${creationDate.year} ${creationDate.hour}:${creationDate.minute}",
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}
