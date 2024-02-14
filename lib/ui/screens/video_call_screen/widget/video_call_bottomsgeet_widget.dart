import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class VideoCallWidget extends ConsumerStatefulWidget {
  const VideoCallWidget({super.key});

  @override
  ConsumerState<VideoCallWidget> createState() => _VideoCallWidgetState();
}

class _VideoCallWidgetState extends ConsumerState<VideoCallWidget> {
  @override
  Widget build(BuildContext context) {
    final callWatch = ref.watch(callProvider);
    final callRead = ref.read(callProvider);

    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.whiteColor.withOpacity(0.35),
        borderRadius: BorderRadius.only(topRight: Radius.circular(50.0), topLeft: Radius.circular(50.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  callRead.changeCameraColor();
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      // ref.watch(videoCallProvider)
                      color: callWatch.cameraOn
                          ? ColorConstants.whiteColor.withOpacity(0.25)
                          : ColorConstants.whiteColor.withOpacity(0.7),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 0),
                            color: ColorConstants.whiteColor.withOpacity(0.25),
                            spreadRadius: 1,
                            blurRadius: 4),
                      ],
                      shape: BoxShape.circle),
                  child: Image.asset(ImageConstants.cameraON),
                ),
              ),
              InkWell(
                onTap: () {
                  callRead.changeVideoColor();
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: callWatch.videoOn
                          ? ColorConstants.whiteColor.withOpacity(0.25)
                          : ColorConstants.whiteColor.withOpacity(0.7),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 0),
                            color: ColorConstants.whiteColor.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 4),
                      ],
                      shape: BoxShape.circle),
                  child: Image.asset(ImageConstants.videoOff),
                ),
              ),
              InkWell(
                onTap: () {
                  callRead.changeVoiceColor();
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: callWatch.voiceOn
                          ? ColorConstants.whiteColor.withOpacity(0.25)
                          : ColorConstants.whiteColor.withOpacity(0.7),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 0),
                            color: ColorConstants.whiteColor.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 4),
                      ],
                      shape: BoxShape.circle),
                  child: Image.asset(ImageConstants.voiceOff),
                ),
              ),
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    color: ColorConstants.whiteColor.withOpacity(0.2),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 0),
                          color: ColorConstants.whiteColor.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 4),
                    ],
                    shape: BoxShape.circle),
                child: Image.asset(ImageConstants.callCut),
              )
            ],
          ),
          30.0.spaceY,
          ShadowContainer(
            height: 42,
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            isShadow: false,
            offset: Offset(0, 0),
            backgroundColor: ColorConstants.whiteColor.withOpacity(0.2),
            shadowColor: ColorConstants.whiteColor.withOpacity(0.2),
            blurRadius: 4,
            spreadRadius: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.watch_later_outlined),
                6.0.spaceX,
                TitleLargeText(
                  title: '18:35',
                  fontFamily: FontWeightEnum.w400.toInter,
                  titleTextAlign: TextAlign.center,
                  titleColor: ColorConstants.blackColor,
                  fontSize: 20,
                ),
              ],
            ),
          ),
          // Container(
          //   height: 42,
          //   width: double.infinity,
          //   decoration: BoxDecoration(
          //     color: Color(0xffFFFFFF).withOpacity(0.3),
          //     borderRadius: BorderRadius.circular(15),
          //     boxShadow: [
          //       BoxShadow(offset: Offset(0, 0), color: Color(0xff000000).withOpacity(0.1), spreadRadius: 1, blurRadius: 4),
          //     ],
          //   ),
          //   padding: const EdgeInsets.all(10),
          //   margin: const EdgeInsets.all(10),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Icon(Icons.watch_later_outlined),
          //       4.0.spaceX,
          //       const Text(
          //         '18:35',
          //         textAlign: TextAlign.center,
          //         style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ).addAllPadding(20),
    );
  }
}
