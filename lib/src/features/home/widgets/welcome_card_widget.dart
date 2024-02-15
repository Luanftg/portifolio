import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portifolio/src/features/home/widgets/welcome_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomeCardWidget extends StatelessWidget {
  const WelcomeCardWidget({
    super.key,
    required this.animationController,
  });
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Image.asset(
                filterQuality: FilterQuality.high,
                'assets/images/luan.jpg',
                colorBlendMode: BlendMode.darken,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: WelcomeWidget(
              animationController: animationController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              const Text('Contatos'),
              TextButton.icon(
                  onPressed: () async {
                    final Uri emailLaunchUri = Uri(
                      scheme: 'mailto',
                      path: 'luanftgimenez@email.com',
                    );

                    launchUrl(emailLaunchUri);
                  },
                  icon: const Icon(Icons.mail),
                  label: const Text(
                    'luanftgimenez@gmail.com',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontStyle: FontStyle.italic,
                    ),
                  )),
              TextButton.icon(
                  onPressed: () async {
                    final Uri emailLaunchUri = Uri.parse(
                        'https://www.linkedin.com/in/luan-fonseca-34b02bbb/');

                    launchUrl(emailLaunchUri);
                  },
                  icon: const FaIcon(FontAwesomeIcons.linkedinIn),
                  label: const Text(
                    'LinkedIn',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontStyle: FontStyle.italic,
                    ),
                  )),
              TextButton.icon(
                  onPressed: () async {
                    final Uri emailLaunchUri = Uri.parse(
                      'https://github.com/Luanftg',
                    );

                    launchUrl(emailLaunchUri);
                  },
                  icon: const FaIcon(FontAwesomeIcons.github),
                  label: const Text(
                    'Github',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontStyle: FontStyle.italic,
                    ),
                  )),
            ]),
          )
        ],
      ),
    );
  }
}
