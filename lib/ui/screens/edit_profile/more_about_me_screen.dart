import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:pinput/pinput.dart';

class MoreAboutMeScreen extends ConsumerStatefulWidget {
  const MoreAboutMeScreen({super.key});

  @override
  ConsumerState<MoreAboutMeScreen> createState() => _MoreAboutMeScreenState();
}

class _MoreAboutMeScreenState extends ConsumerState<MoreAboutMeScreen> {
  TextEditingController _titleController = TextEditingController();
  String enteredText = '';

  @override
  Widget build(BuildContext context) {
    final expertWatch = ref.watch(editExpertProvider);
    final expertRead = ref.watch(editExpertProvider);
    return Scaffold(
        appBar: AppBarWidget(
            leading: InkWell(
              child: Image.asset(ImageConstants.backIcon),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            trailingIcon: InkWell(
              onTap: () {
                expertRead.updateAboutApi();
              },
              child: TitleMediumText(
                title: StringConstants.done,
                fontFamily: FontWeightEnum.w700.toInter,
              ).addPaddingRight(14),
            )),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TitleLargeText(
                title: StringConstants.moreAboutMe,
                titleColor: ColorConstants.bottomTextColor,
                fontFamily: FontWeightEnum.w700.toInter,
              ),
              30.0.spaceY,
              // TextFormFieldWidget(
              //   onChanged: (value) {
              //     setState(() {
              //       enteredText = value;
              //     });
              //   },
              //   decoration: InputDecoration(
              //       focusedBorder: OutlineInputBorder(
              //         borderSide: BorderSide(color: ColorConstants.borderColor, width: 1.0),
              //       ),
              //       enabledBorder: OutlineInputBorder(
              //         borderSide: BorderSide(color: ColorConstants.borderColor, width: 1.0),
              //       ),
              //       //counter: Text("5/20"),
              //       counterText: '${enteredText.length.toString()}/1500 character',
              //       border: InputBorder.none,
              //       isDense: true,
              //       contentPadding: EdgeInsets.all(10)),
              //   //maxLengthEnforcement: MaxLengthEnforcement.none,
              //   maxLines: 10,
              //   maxLength: 1500,
              //   minLines: 8,
              //   hintText: StringConstants.moreAboutMe,
              //   textInputAction: TextInputAction.done,
              //   controller: expertWatch.aboutMeController,
              //   onFieldSubmitted: (value) {},
              // ),
              30.0.spaceY,
              Container(
                height: 150,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorConstants.borderColor,
                    ),
                    color: ColorConstants.whiteColor,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8, top: 2, right: 4),
                  child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          enteredText = value;
                        });
                      },
                      textAlign: TextAlign.left,
                      cursorColor: ColorConstants.blackColor,
                      maxLines: 10,
                      maxLength: 1500,
                      minLines: 8,
                      controller: _titleController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          //counter: Text("5/20"),
                          counterText: '${enteredText.length.toString()}/1500 character',
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.all(10))),
                ),
              ),
              30.0.spaceY,
              TitleSmallText(
                title: StringConstants.professionalSkills,
                titleTextAlign: TextAlign.center,
                maxLine: 4,
              ),
            ],
          ).addAllPadding(20),
        ));
  }
}
