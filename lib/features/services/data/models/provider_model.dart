import 'package:flutter/material.dart';

class ServiceProvider {
  final String id;
  final String name;
  final String description;
  final String phoneNumber;
  final String email;
  final String address;
  final double latitude;
  final double longitude;
  final List<String> services;
  final double rating;
  final int reviewCount;
  final List<String> images;
  final String category;
  final String group;

  ServiceProvider({
    required this.id,
    required this.name,
    required this.description,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.services,
    required this.rating,
    required this.reviewCount,
    required this.images,
    required this.category,
    required this.group,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'phoneNumber': phoneNumber,
      'email': email,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'services': services,
      'rating': rating,
      'reviewCount': reviewCount,
      'images': images,
      'category': category,
      'group': group,
    };
  }

  factory ServiceProvider.fromJson(Map<String, dynamic> json) {
    return ServiceProvider(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      services: List<String>.from(json['services']),
      rating: json['rating'],
      reviewCount: json['reviewCount'],
      images: List<String>.from(json['images']),
      category: json['category'],
      group: json['group'],
    );
  }
}
