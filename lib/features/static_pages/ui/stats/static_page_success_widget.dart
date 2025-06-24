import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../data/entities/static_page_entity.dart';

class StaticPageSuccessWidget extends StatelessWidget {
  const StaticPageSuccessWidget(this.staticPageEntity, {super.key});
  final List<StaticPageEntity> staticPageEntity;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ListView.separated(
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HtmlWidget(
                staticPageEntity[index].title,
                textStyle: AppTextStyles.balooBhaijaan2W500Size16KPrimary1000
                    .copyWith(fontSize: 16),
              ),
              12.sbH,
              HtmlWidget(
                staticPageEntity[index].body,
                textStyle: AppTextStyles.balooBhaijaan2W400Size13kPrimary1000
                    .copyWith(fontSize: 14),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) => 12.sbH,
        itemCount: staticPageEntity.length,
      ),
    );
  }
}
