import 'package:flutter/material.dart';

class ProductListItem extends StatelessWidget {
  final String name;
  final String price;
  final String stock;
  final String imageUrl;

  const ProductListItem({
    super.key,
    required this.name,
    required this.price,
    required this.stock,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            imageUrl,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 50,
                height: 50,
                color: Colors.grey[300],
                child: const Icon(Icons.image),
              );
            },
          ),
        ),
        title: Text(name),
        subtitle: Text('Stock: $stock'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              price,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              int.parse(stock) < 5 ? 'Stock faible' : 'En stock',
              style: TextStyle(
                color: int.parse(stock) < 5 ? Colors.red : Colors.green,
                fontSize: 12,
              ),
            ),
          ],
        ),
        onTap: () {
          // TODO: Naviguer vers les détails du produit
        },
      ),
    );
  }
}
