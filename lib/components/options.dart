import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kodiak/utils/constants.dart';

class Options extends StatefulWidget {
  final String optionSelected;
  final Function() onTap;

  const Options({super.key, required this.optionSelected, required this.onTap});

  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: const Color(darkBlue)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Text(
                widget.optionSelected,
                style: const TextStyle(color: Color(darkBlue)),
              ),
            ),
            const Icon(
              CupertinoIcons.chevron_down,
              color: Color(darkBlue),
            )
          ],
        ),
      ),
    );
  }
}
