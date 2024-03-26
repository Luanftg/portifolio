import 'package:animations_package/animations_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portifolio/src/core/extensions/date_format_extension.dart';
import 'package:portifolio/src/core/layout/mobile/mobile_layout.dart';
import 'package:portifolio/src/core/layout/responsive_layout.dart';
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
import 'package:portifolio/src/features/courses/domain/course_model.dart';
import 'package:portifolio/src/features/courses/presentation/add_course_page.dart';
import 'package:portifolio/src/features/courses/widgets/course_item_widget.dart';
import 'package:portifolio/src/features/home/bloc/event/home_event.dart';
import 'package:portifolio/src/features/home/bloc/home_bloc.dart';
import 'package:portifolio/src/features/home/bloc/state/home_state.dart';
import 'package:portifolio/src/features/home/views/initial_home_view.dart';
import 'package:portifolio/src/features/home/views/projects_view.dart';
import 'package:portifolio/src/features/home/views/training_view.dart';
import 'package:portifolio/src/features/projects/project_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TimeLineConfig timeLineConfig;
  late final MenuController _menuController;
  @override
  void initState() {
    super.initState();
    timeLineConfig = TimeLineConfig();
    _menuController = MenuController();
  }

  @override
  void dispose() {
    _menuController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        iSaveCourseService: SaveFirebaseCourseService(),
        iProjectService: ProjectService(),
        iCourseService: GetFirebaseCoursesService(),
      ),
      child: Builder(
        builder: (context) {
          return ResponsiveLayout(
            mobile: const MobileLayout(),
            desktop: Scaffold(
              appBar: AppBar(backgroundColor: Colors.transparent, actions: [
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  curve: Curves.easeInOut,
                  builder: (context, value, child) => Opacity(
                    opacity: value,
                    child: TextButton(
                      onHover:
                          (context.read<HomeBloc>().state is InitialHomeState)
                              ? (value) {
                                  return value
                                      ? context.read<HomeBloc>().add(
                                            ChangeColorEvent(
                                              value
                                                  ? Colors.amberAccent
                                                  : Colors.white70,
                                              title: 'Início',
                                            ),
                                          )
                                      : null;
                                }
                              : null,
                      onPressed: () => context.read<HomeBloc>().add(
                            ChangeView(view: HomeView.initial),
                          ),
                      child: const Text('Início'),
                    ),
                  ),
                  duration: const Duration(seconds: 1),
                ),
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  curve: Curves.easeInOut,
                  builder: (context, value, child) => Opacity(
                    opacity: value,
                    child: TextButton(
                      onHover:
                          (context.read<HomeBloc>().state is InitialHomeState)
                              ? (value) => value
                                  ? context.read<HomeBloc>().add(
                                        ChangeColorEvent(
                                          value
                                              ? Colors.purpleAccent
                                              : Colors.white70,
                                          title: 'Projetos',
                                        ),
                                      )
                                  : null
                              : null,
                      onPressed: () => context.read<HomeBloc>().add(
                            ChangeView(view: HomeView.projects),
                          ),
                      child: const Text('Projetos'),
                    ),
                  ),
                  duration: const Duration(milliseconds: 1500),
                ),
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  curve: Curves.easeInOut,
                  builder: (context, value, child) => Opacity(
                    opacity: value,
                    child: TextButton(
                      onHover: (context.read<HomeBloc>().state
                              is InitialHomeState)
                          ? (value) => value
                              ? context.read<HomeBloc>().add(
                                    ChangeColorEvent(
                                      value ? Colors.redAccent : Colors.white70,
                                      title: 'Formação',
                                    ),
                                  )
                              : null
                          : null,
                      onPressed: () => context.read<HomeBloc>().add(
                            ChangeView(view: HomeView.training),
                          ),
                      child: const Text('Formação'),
                    ),
                  ),
                  duration: const Duration(milliseconds: 1800),
                ),
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  curve: Curves.easeInOut,
                  builder: (context, value, child) => Opacity(
                    opacity: value,
                    child: TextButton(
                      onHover:
                          (context.read<HomeBloc>().state is InitialHomeState)
                              ? (value) => value
                                  ? context.read<HomeBloc>().add(
                                        ChangeColorEvent(
                                          value ? Colors.cyan : Colors.white70,
                                          title: 'TimeLine',
                                        ),
                                      )
                                  : null
                              : null,
                      onPressed: () {
                        context.read<HomeBloc>().add(
                              ChangeView(view: HomeView.timeline),
                            );
                      },
                      child: const Text('TimeLine'),
                    ),
                  ),
                  duration: const Duration(milliseconds: 2000),
                ),
                context.read<HomeBloc>().isUserLogged
                    ? MenuAnchor(
                        controller: _menuController,
                        menuChildren: [
                          MenuItemButton(
                            child: const Text('Adicionar Curso'),
                            onPressed: () =>
                                Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      BlocProvider(
                                create: (context) => CourseBloc(
                                    InitialCourseState(courses: []),
                                    uploadFileService:
                                        FirebaseUploadFileService(),
                                    filePickerService: FilePickerServiceImp(),
                                    iGetCoursesService:
                                        GetFirebaseCoursesService(),
                                    iSaveCourseService:
                                        SaveFirebaseCourseService()),
                                child: const AddCoursePage(),
                              ),
                            )),
                          )
                        ],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () => _menuController.isOpen
                                ? _menuController.close()
                                : _menuController.open(),
                            child: CircleAvatar(
                              child: context
                                      .read<HomeBloc>()
                                      .userInitials
                                      .isEmpty
                                  ? const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    )
                                  : Text(
                                      context.read<HomeBloc>().userInitials,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                            ),
                          ),
                        ),
                      )
                    : TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: 1),
                        curve: Curves.easeInOut,
                        builder: (context, value, child) => Opacity(
                          opacity: value,
                          child: TextButton(
                            onHover: (context.read<HomeBloc>().state
                                    is InitialHomeState)
                                ? (value) => value
                                    ? context.read<HomeBloc>().add(
                                          ChangeColorEvent(
                                            value
                                                ? Colors.greenAccent
                                                : Colors.white70,
                                            title: 'Entrar',
                                          ),
                                        )
                                    : null
                                : null,
                            onPressed: () {
                              context
                                  .read<HomeBloc>()
                                  .add(ChangeView(view: HomeView.authHomeView));
                            },
                            child: const Text('Entrar'),
                          ),
                        ),
                        duration: const Duration(milliseconds: 2000),
                      ),
              ]),
              body: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return switch (state) {
                    InitialHomeState() => InitialHomeView(
                        endColor: state.endColor,
                        title: state.title,
                      ),
                    TrainingHomeState() => const TrainingView(),
                    ProjectsHomeState() =>
                      ProjectsView(projects: state.projects),
                    TimeLineHomeState() => TimeLineWidget(
                        timeLineConfig: timeLineConfig,
                        dataCard: state.dataCard,
                        onHover: (event) => onHover(
                          event,
                          state.dataCard.serie,
                        ),
                        onTap: (item) => Hero(
                          tag: 'tag',
                          child: InkWell(
                            onTap: () => Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        Hero(
                                  tag: 'tag',
                                  child: Scaffold(
                                    appBar: AppBar(
                                      title: Text(item.name),
                                    ),
                                    body: Center(
                                      child: CourseItemWidget(
                                        courseModel: (item.items.first.object
                                                as CourseModel?) ??
                                            CourseModel(
                                              title: state
                                                  .dataCard.serie.first.name,
                                              titlePath: 'titlePath',
                                              description: state.dataCard.serie
                                                  .first.description,
                                              minister: 'minister',
                                              institution: 'institution',
                                              workload: 'workload',
                                              imagePath: 'imagePath',
                                              startDate: DateTime.now(),
                                              endDate: DateTime(2024),
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                              ),
                            ),
                            child: ListTile(
                              leading: Column(
                                children: [
                                  const Icon(
                                    Icons.date_range_outlined,
                                    size: 16,
                                  ),
                                  const Text('Data de Início'),
                                  Text(item.items.first.timestamp
                                      .toBrasilianFormat())
                                ],
                              ),
                              trailing: Column(
                                children: [
                                  const Icon(
                                    Icons.date_range_outlined,
                                    size: 16,
                                  ),
                                  const Text('Data de Término'),
                                  Text(item.items.last.timestamp
                                      .toBrasilianFormat())
                                ],
                              ),
                              title: Text(
                                item.name,
                              ),
                              subtitle: Text(item.description),
                            ),
                          ),
                        ),
                        startDate: DateTime.now(),
                        endDate: DateTime.now().add(
                          const Duration(days: 365),
                        ),
                      ),
                    AuthenticationHomeState() => BlocProvider(
                        create: (context) => AuthBloc(UnloggedState(),
                            authService: FirebaseAuthService()),
                        child: const AuthPage(),
                      ),
                    HomeState() => const Center(
                        child: BlobPainter(),
                      ),
                  };
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void onHover(PointerHoverEvent event, List<DataSeries> dataSeries) {
    bool inside = false;
    for (var serie in dataSeries) {
      if (serie.rect != null) {
        inside = serie.rect?.contains(event.localPosition) ?? false;
        if (inside) {
          setState(() {
            timeLineConfig
              ..newYearBg1 = Colors.black
              ..newYearBg2 = Colors.amber;
          });
          // showDialog(
          //   context: context,
          //   builder: (context) =>
          //       AlertDialog(content: Text('Clicou no ${serie.name}'),),
          // );
        } else {
          setState(() {
            timeLineConfig
              ..newYearBg1 = Colors.amber
              ..newYearBg2 = Colors.black;
            // ..monthRatio = 12;
          });
        }
      }
    }
  }
}
