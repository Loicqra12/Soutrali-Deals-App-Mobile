import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../reviews/presentation/pages/review_page.dart';
import '../../../reviews/data/review_service.dart';
import '../../domain/models/freelancer.dart';
import '../../../../shared/widgets/bottom_nav_bar.dart';

class FreelanceProfilePage extends StatelessWidget {
  final Freelancer freelancer;
  final String? currentUserId;

  const FreelanceProfilePage({
    Key? key,
    required this.freelancer,
    this.currentUserId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(freelancer.name),
              background: Image.network(
                freelancer.imageUrl.isNotEmpty 
                    ? freelancer.imageUrl 
                    : 'https://ui-avatars.com/api/?name=${Uri.encodeComponent(freelancer.name)}&size=256&background=random',
                fit: BoxFit.cover,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  // Implémenter le partage
                },
              ),
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {
                  // Implémenter l'ajout aux favoris
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            freelancer.profession,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              RatingBarIndicator(
                                rating: freelancer.rating,
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 20.0,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                freelancer.rating.toString(),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        '${freelancer.hourlyRate.toInt()} FCFA/h',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Localisation
                  ListTile(
                    leading: const Icon(Icons.location_on),
                    title: Text(freelancer.location),
                    contentPadding: EdgeInsets.zero,
                  ),

                  // Disponibilité
                  ListTile(
                    leading: const Icon(Icons.access_time),
                    title: Text(freelancer.availability),
                    contentPadding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 24),

                  // Compétences
                  Text(
                    'Compétences',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: freelancer.skills.map((skill) {
                      return Chip(
                        label: Text(skill),
                        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // Expérience
                  Text(
                    'Expérience',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${freelancer.yearsOfExperience} années d\'expérience',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),

                  // Avis et évaluations
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.rate_review),
                      title: const Text('Avis et évaluations'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () async {
                        if (currentUserId != null) {
                          final reviewService = await ReviewService.getInstance();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReviewPage(
                                freelancerId: freelancer.id,
                                currentUserId: currentUserId!,
                                reviewService: reviewService,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Veuillez vous connecter pour voir les avis'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Boutons d'action
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/chat',
                              arguments: freelancer,
                            );
                          },
                          icon: const Icon(Icons.chat),
                          label: const Text('Contacter'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/booking',
                              arguments: freelancer,
                            );
                          },
                          icon: const Icon(Icons.calendar_today),
                          label: const Text('Réserver'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.all(16),
                          ),
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
      bottomNavigationBar: const BottomNavBar(currentIndex: 1), // 1 pour l'onglet Freelances
    );
  }
}
