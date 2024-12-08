import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/service_bloc.dart';
import '../widgets/service_card.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_view.dart';

class ServiceListPage extends StatelessWidget {
  const ServiceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Services'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search
            },
          ),
        ],
      ),
      body: BlocBuilder<ServiceBloc, ServiceState>(
        builder: (context, state) {
          if (state is ServiceLoading) {
            return const LoadingView();
          }
          
          if (state is ServiceError) {
            return ErrorView(
              message: state.message,
              onRetry: () {
                context.read<ServiceBloc>().add(ServicesFetchRequested());
              },
            );
          }
          
          if (state is ServicesLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.services.length,
              itemBuilder: (context, index) {
                final service = state.services[index];
                return ServiceCard(
                  service: service,
                  onTap: () {
                    // TODO: Navigate to service details
                  },
                );
              },
            );
          }
          
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Authenticated && state.user.isProvider) {
            return FloatingActionButton(
              onPressed: () {
                // TODO: Navigate to add service
              },
              child: const Icon(Icons.add),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
