import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portifolio/src/features/home/bloc/event/home_event.dart';
import 'package:portifolio/src/features/home/bloc/home_bloc.dart';
import 'package:portifolio/src/features/home/bloc/state/home_state.dart';
import 'package:portifolio/src/features/home/views/initial_home_view.dart';
import 'package:portifolio/src/features/home/views/mobile_projects_view.dart';
import 'package:portifolio/src/features/home/views/mobile_training_view.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  context.read<HomeBloc>().add(
                        ChangeView(view: HomeView.initial),
                      );
                },
                child: const Text('Início'),
              ),
              TextButton(
                onPressed: () => context.read<HomeBloc>().add(
                      ChangeView(view: HomeView.projects),
                    ),
                child: const Text('Projetos'),
              ),
              TextButton(
                onPressed: () => context.read<HomeBloc>().add(
                      ChangeView(view: HomeView.training),
                    ),
                child: const Text('Formação'),
              ),
              TextButton(
                onPressed: () => context.read<HomeBloc>().add(
                      ChangeView(view: HomeView.contacts),
                    ),
                child: const Text('Contato'),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return switch (state) {
            InitialHomeState() => const InitialHomeView(),
            TrainingHomeState() => const MobileTrainingView(),
            ProjectsHomeState() => MobileProjectsView(projects: state.projects),
            HomeState() => const Center(
                child: CircularProgressIndicator(),
              ),
          };
        },
      ),
    );
  }
}
