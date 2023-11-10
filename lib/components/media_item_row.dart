import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:youtube_downloader/components/selected_box.dart';
import 'package:youtube_downloader/models/media_stream.dart';

class MediaItemRow extends StatefulWidget {
  const MediaItemRow({super.key, required this.stream});

  final MediaStream stream;

  @override
  State<MediaItemRow> createState() => _MediaItemRowState();
}

class _MediaItemRowState extends State<MediaItemRow> {
  static const videoIcon = Icon(Icons.videocam_outlined, size: 32);

  var _isSelected = false;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: _switchState,
        child: Row(
          children: [
            videoIcon,
            const Gap(8),
            Text(widget.stream.resolution),
            const Spacer(),
            Text(widget.stream.format.toUpperCase()),
            const Spacer(),
            Text(widget.stream.megabytesSize),
            const Gap(8),
            SelectedBox(activeColor: Colors.red, selected: _isSelected),
          ],
        ),
      );

  void _switchState() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }
}
