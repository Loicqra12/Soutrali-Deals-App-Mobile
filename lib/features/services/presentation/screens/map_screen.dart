import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../data/mock_providers.dart';
import '../../data/models/provider_model.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  LatLng _currentPosition = const LatLng(5.3364, -4.0267); // Position fixe à Abidjan
  List<ServiceProvider> _filteredProviders = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  void _loadInitialData() {
    setState(() {
      _filteredProviders = mockProviders;
      _createMarkers();
      _isLoading = false;
    });
  }

  void _createMarkers() {
    _markers = _filteredProviders.map((provider) {
      return Marker(
        markerId: MarkerId(provider.id),
        position: LatLng(provider.latitude, provider.longitude),
        infoWindow: InfoWindow(
          title: provider.name,
          snippet: provider.description,
        ),
        onTap: () => _showProviderDetails(provider),
      );
    }).toSet();
  }

  void _showProviderDetails(ServiceProvider provider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.2,
        maxChildSize: 0.8,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Text(
                  provider.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 20),
                    Text(' ${provider.rating} (${provider.reviewCount} avis)'),
                  ],
                ),
                const SizedBox(height: 8),
                Text(provider.description),
                const SizedBox(height: 16),
                Text(
                  'Services proposés:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: provider.services.map((service) => Chip(
                    label: Text(service),
                  )).toList(),
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: const Icon(Icons.location_on),
                  title: Text(provider.address),
                ),
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: Text(provider.phoneNumber),
                  onTap: () {/* Implémenter l'appel */},
                ),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: Text(provider.email),
                  onTap: () {/* Implémenter l'envoi d'email */},
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {/* Implémenter la réservation */},
                    child: const Text('Réserver'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              setState(() {
                _mapController = controller;
              });
            },
            initialCameraPosition: CameraPosition(
              target: _currentPosition,
              zoom: 13,
            ),
            markers: _markers,
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Card(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Rechercher un service...',
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'filter',
            onPressed: () {/* Implémenter les filtres */},
            child: const Icon(Icons.filter_list),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'location',
            onPressed: () {
              _mapController?.animateCamera(
                CameraUpdate.newLatLng(_currentPosition),
              );
            },
            child: const Icon(Icons.my_location),
          ),
        ],
      ),
    );
  }
}
