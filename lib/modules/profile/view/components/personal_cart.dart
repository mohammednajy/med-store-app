import 'package:flutter/material.dart';
import '../../../../core/services/local_services/shared_perf.dart';
import '../../../../core/utils/extentions.dart';

import '../../../../core/utils/color_manager.dart';

class PersonalCardInfo extends StatefulWidget {
  const PersonalCardInfo({
    Key? key,
  }) : super(key: key);

  @override
  State<PersonalCardInfo> createState() => _PersonalCardInfoState();
}

class _PersonalCardInfoState extends State<PersonalCardInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.person,
            size: 60,
            color: ColorManager.blue,
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                SharedPrefController().getUser().name,
                style: context.h1.copyWith(fontSize: 20),
              ),
              Text(
                SharedPrefController().getUser().email,
                style: context.b1.copyWith(
                  fontSize: 13,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
