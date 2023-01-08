import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:gofast/exports/export_services.dart';

class CustomSnackbarContent extends StatelessWidget {
  const CustomSnackbarContent({
    Key? key,
    required this.errorText,
    required this.message,
    required this.containerClr,
    required this.bubblesClr,
  }) : super(key: key);

  final String errorText;
  final String message;
  final Color containerClr;
  final Color bubblesClr;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          height: 90,
          decoration: BoxDecoration(
              color: containerClr,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Row(
            children: [
              const SizedBox(
                width: 48,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: textStyle(18, Colors.white, FontWeight.w500),
                    ),
                    const Spacer(),
                    Text(
                      errorText,
                      textAlign: TextAlign.center,
                      style: textStyle(12, Colors.white, FontWeight.w500),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: ClipRRect(
            borderRadius:
                const BorderRadius.only(bottomLeft: Radius.circular(20)),
            child: SvgPicture.asset(
              'assets/icons/bubbles.svg',
              height: 48,
              width: 40,
              color: bubblesClr,
            ),
          ),
        ),
        Positioned(
          top: -20,
          left: 0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/fail.svg',
                height: 40,
              ),
              Positioned(
                top: 10,
                child: SvgPicture.asset(
                  'assets/icons/close.svg',
                  height: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
