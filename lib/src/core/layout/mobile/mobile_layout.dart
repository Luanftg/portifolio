import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portifolio/src/core/services/file_picker_service_imp.dart';
import 'package:portifolio/src/core/services/upload_file/firebase_upload_file_service.dart';
import 'package:portifolio/src/features/auth/auth_page.dart';
import 'package:portifolio/src/features/auth/bloc/auth_bloc.dart';
import 'package:portifolio/src/features/auth/bloc/states/auth_state.dart';
import 'package:portifolio/src/features/auth/data/remote/firebase/firebase_auth_service.dart';
import 'package:portifolio/src/features/courses/bloc/course_bloc.dart';
import 'package:portifolio/src/features/courses/bloc/state/course_satate.dart';
import 'package:portifolio/src/features/courses/data/remote/get_firebase_courses_service.dart';
import 'package:portifolio/src/features/courses/data/remote/save_firebase_course_service.dart';
import 'package:portifolio/src/features/courses/presentation/add_course_page.dart';
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
  final _menuController = MenuController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.transparent,
        width: 150,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              BlocBuilder(
                builder: (context, state) {
                  final menu = MenuAnchor(
                    controller: _menuController,
                    menuChildren: [
                      MenuItemButton(
                        child: const Text('Adicionar Curso'),
                        onPressed: () => Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    BlocProvider(
                              create: (context) => CourseBloc(
                                InitialCourseState(),
                                filePickerService: FilePickerServiceImp(),
                                iGetCoursesService: GetFirebaseCoursesService(),
                                iSaveCourseService: SaveFirebaseCourseService(),
                                uploadFileService: FirebaseUploadFileService(),
                              ),
                              child: const AddCoursePage(),
                            ),
                          ),
                        ),
                      )
                    ],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () => _menuController.isOpen
                            ? _menuController.close()
                            : _menuController.open(),
                        child: CircleAvatar(
                          child: context.read<HomeBloc>().userInitials.isEmpty
                              ? const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                )
                              : Text(
                                  context.read<HomeBloc>().userInitials,
                                  style: const TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                    ),
                  );

                  final textButton = TextButton(
                    onHover: (value) => value
                        ? context.read<HomeBloc>().add(
                              ChangeColorEvent(
                                value ? Colors.greenAccent : Colors.white70,
                                title: 'Entrar',
                              ),
                            )
                        : null,
                    onPressed: () {
                      context
                          .read<HomeBloc>()
                          .add(ChangeView(view: HomeView.authHomeView));
                    },
                    child: const Text('Entrar'),
                  );

                  return context.read<HomeBloc>().isUserLogged
                      ? menu
                      : textButton;
                },
                bloc: context.read<HomeBloc>(),
              ),
              TextButton(
                onHover: (value) {
                  return value
                      ? context.read<HomeBloc>().add(
                            ChangeColorEvent(
                              Colors.amberAccent,
                              title: 'Início',
                            ),
                          )
                      : null;
                },
                onPressed: () {
                  context.read<HomeBloc>().add(
                        ChangeView(view: HomeView.initial),
                      );
                  Navigator.of(context).pop();
                },
                child: const Text('Início'),
              ),
              TextButton(
                onHover: (value) => value
                    ? context.read<HomeBloc>().add(
                          ChangeColorEvent(Colors.purpleAccent,
                              title: 'Projetos'),
                        )
                    : null,
                onPressed: () {
                  context.read<HomeBloc>().add(
                        ChangeView(view: HomeView.projects),
                      );
                  Navigator.of(context).pop();
                },
                child: const Text('Projetos'),
              ),
              TextButton(
                onHover: (value) => value
                    ? context.read<HomeBloc>().add(
                          ChangeColorEvent(Colors.redAccent, title: 'Formação'),
                        )
                    : null,
                onPressed: () {
                  context.read<HomeBloc>().add(
                        ChangeView(view: HomeView.training),
                      );
                  if (mounted) {
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Formação'),
              ),
              TextButton(
                onHover: (value) => value
                    ? context.read<HomeBloc>().add(
                          ChangeColorEvent(Colors.greenAccent,
                              title: value ? 'Contato' : 'Luan Fonseca'),
                        )
                    : null,
                onPressed: () {
                  context.read<HomeBloc>().add(
                        ChangeView(view: HomeView.contacts),
                      );
                  Navigator.of(context).pop();
                },
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
            InitialHomeState() => InitialHomeView(
                endColor: state.endColor,
                title: state.title,
              ),
            TrainingHomeState() => const MobileTrainingView(),
            AuthenticationHomeState() => BlocProvider(
                create: (context) => AuthBloc(UnloggedState(),
                    authService: FirebaseAuthService()),
                child: const AuthPage(),
              ),
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
