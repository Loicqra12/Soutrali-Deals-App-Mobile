import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/bottom_nav_bar.dart';

class FreelancesPage extends StatelessWidget {
  const FreelancesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Freelances'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => context.push('/notifications'),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: _mockFreelancers.length,
        itemBuilder: (context, index) {
          final freelancer = _mockFreelancers[index];
          return _buildFreelancerCard(context, freelancer);
        },
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
    );
  }

  Widget _buildFreelancerCard(BuildContext context, Map<String, String> freelancer) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => context.push('/freelancer/${freelancer['id']}'),
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  color: Colors.grey[200],
                ),
                child: const Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      freelancer['name']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      freelancer['profession']!,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, size: 16, color: Colors.amber[700]),
                        const SizedBox(width: 4),
                        Text(
                          freelancer['rating']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final List<Map<String, String>> _mockFreelancers = [
  {
    'id': '1',
    'name': 'John Doe',
    'profession': 'Plombier',
    'rating': '4.8',
  },
  {
    'id': '2',
    'name': 'Jane Smith',
    'profession': 'Électricienne',
    'rating': '4.7',
  },
  {
    'id': '3',
    'name': 'Mike Johnson',
    'profession': 'Peintre',
    'rating': '4.9',
  },
  {
    'id': '4',
    'name': 'Sarah Wilson',
    'profession': 'Jardinière',
    'rating': '4.6',
  },
  {
    'id': '5',
    'name': 'David Brown',
    'profession': 'Menuisier',
    'rating': '4.8',
  },
  {
    'id': '6',
    'name': 'Emma Davis',
    'profession': 'Femme de ménage',
    'rating': '4.7',
  },
];
