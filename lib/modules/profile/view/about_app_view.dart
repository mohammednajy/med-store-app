import 'package:flutter/material.dart';
import '../../../core/services/remote_services/base_model.dart';
import '../../../core/utils/color_manager.dart';

import '../../../core/utils/extentions.dart';
import '../../../core/widgets/appbar_custom.dart';
import '../../../core/widgets/loading_widget.dart';
import '../controller/profile_controller.dart';
import 'package:provider/provider.dart';

class AboutAppView extends StatefulWidget {
  const AboutAppView({Key? key}) : super(key: key);

  @override
  State<AboutAppView> createState() => _AboutAppViewState();
}

class _AboutAppViewState extends State<AboutAppView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ProfileController>().aboutTheApp();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(title: 'عن التطبيق'),
      body: Consumer<ProfileController>(
          builder: (context, profileController, child) {
        if (profileController.aboutApp.status == Status.COMPLETED) {
          return ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            children: [
              Card(
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...profileController.aboutApp.data!
                          .map(
                            (e) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '• ${e.title}',
                                  style: context.h1.copyWith(fontSize: 14),
                                ),
                                Text(e.description, style: context.b1),
                              ],
                            ),
                          )
                          .toList(),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'انضم إلينا اليوم واستمتع بتجربة تسوق مميزة للأدوات الطبية!',
                        style: context.h1.copyWith(
                          fontSize: 14,
                          color: ColorManager.blue,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        } else if (profileController.aboutApp.status == Status.ERROR) {
          return Text('something went wrong');
        } else {
          return loading();
        }
      }),
    );
  }
}
