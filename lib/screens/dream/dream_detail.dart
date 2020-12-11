import 'package:dreamer/common/dream_consumer.dart';
import 'package:dreamer/common/widgets/dream_post_header.dart';
import 'package:dreamer/common/widgets/dreamer_scaffold.dart';
import 'package:dreamer/common/widgets/text_ful_divider.dart';
import 'package:dreamer/view_models/dreams_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DreamDetail extends StatefulWidget {
  final String identifier;

  const DreamDetail({Key key, @required this.identifier}) : super(key: key);

  @override
  _DreamDetailState createState() => _DreamDetailState();
}

class _DreamDetailState extends State<DreamDetail> {
  @override
  Widget build(BuildContext context) {
    return DreamerScaffold(
      body: ChangeNotifierProvider(
        create: (context) => DreamViewModel()..loadDream(widget.identifier),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: DreamConsumer<DreamViewModel>(
            builder: (context, dreamVewModel, child) {
              final dream = dreamVewModel.dream.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DreamPostHeader(dream: dream),
                  SizedBox(height: 16),
                  Text(dream.text),
                  SizedBox(height: 32),
                  TextFulDivider(
                    startFlex: 0,
                    text: Text(
                      "Elements",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    endFlex: 1,
                  ),
                  SizedBox(height: 16),
                ],
              );
            },
            loadingBuilder: (context, dream, child) => Column(
              children: [
                Text("Loading"),
              ],
            ),
            errorBuilder: (context, dream, child) => Column(
              children: [
                Text("Ops! ${dream.errorMessage}"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
