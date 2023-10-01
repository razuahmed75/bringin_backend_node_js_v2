import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../res/app_dummy_models/dummy_data.dart';
import '../../../res/app_font.dart';
import '../../../res/color.dart';
import '../../../res/constants/strings.dart';
import '../../../res/dimensions.dart';
import '../../../widgets/app_bar.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _scrollController = ScrollController();
    return Scaffold(
      appBar: appBarWidget(
          title: "Bringin - Terms & Conditions",
          titleSize: height(18),
          onBackPressed: () => Get.back(),
          actions: []),
      body: Padding(
        padding: Dimensions.kDefaultPadding / 2,
        child: CupertinoScrollbar(
          controller: _scrollController,
          radius: Radius.circular(30),
          thickness: 5,
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: Dimensions.kDefaultPadding / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(20),

                  /// terms description
                  Text(AppStrings.termsDes, style: Styles.bodyMedium2),
                  const Gap(20),

                  /// rules 1
                  _rules1(),
                  const Gap(20),

                  /// rules 2
                  _rules2(),
                  const Gap(20),

                  /// rules 3
                  _rules3(),
                  const Gap(20),

                  /// rules 4
                  _rules4(),
                  const Gap(20),

                  /// rules 5
                  _rules5(),
                  const Gap(20),

                  /// rules 6
                  _rules6(),
                  const Gap(20),

                  /// rules 7
                  _rules7(),
                  const Gap(20),

                  /// rules 8
                  _rules8(),
                  const Gap(20),

                  /// rules 9
                  _rules9(),
                  const Gap(20),

                  /// rules 10
                  _rules10(),
                  const Gap(20),

                  /// rules 11
                  _rules11(),
                  const Gap(20),

                  /// rules 12
                  _rules12(),
                  const Gap(20),

                  /// rules 13
                  _rules13(),
                  const Gap(35),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _rules13() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _boldText(text: "13. Termination:"),
        _thinText(text: AppStrings.rules13First),
        const Gap(20),
        RichText(
            text: TextSpan(children: [
          TextSpan(
            text: AppStrings.rules13Middle,
            style: Styles.bodyMedium2,
          ),
          TextSpan(
            text: AppStrings.rules13Last,
            recognizer: TapGestureRecognizer()
              ..onTap = () async{
                 final Uri params = Uri(
                    scheme: 'mailto',
                    path: 'hello@bringin.io',
                  );
                await launchUrl(params);
              },
            style: Styles.bodyMedium2.copyWith(color: AppColors.mainColor),
          ),
        ]))
      ],
    );
  }
  
  Widget _rules12() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _boldText(text: AppStrings.rules12Title),
        _thinText(text: AppStrings.rules12Des),
        const Gap(20),
        richText(firstText: "${AppStrings.rules12ATitle} ", secondText: AppStrings.rules12ADes),
        const Gap(20),
        richText(firstText: "${AppStrings.rules12BTitle} ", secondText: AppStrings.rules12BDes),
        richText(firstText: "${AppStrings.rules12BListTitle} ", secondText: AppStrings.rules12BListDes),
        const Gap(20),
        richText(firstText: "${AppStrings.rules12CTitle} ", secondText: AppStrings.rules12CDes),
        richText(firstText: "${AppStrings.rules12CListTitle} ", secondText: AppStrings.rules12CListDes),
        const Gap(20),
        richText(firstText: "${AppStrings.rules12DTitle} ", secondText: AppStrings.rules12DDes1),
        const Gap(20),
        _thinText(text: AppStrings.rules12DDes2),
      ],
    );
  }
  
  Widget _rules11() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _boldText(text: "11. Cancellation:"),
        _thinText(text: AppStrings.rules11),
        const Gap(20),
        richText(firstText: "${AppStrings.rules11ATitle} ", secondText: AppStrings.rules11ADes),
        rulesList(text: AppStrings.rules11AList1),
        rulesList(text: AppStrings.rules11AList2),
        rulesList(text: AppStrings.rules11AList3),
        const Gap(20),
        richText(firstText: "${AppStrings.rules11BTitle} ", secondText: AppStrings.rules11BDes),
        rulesList(text: AppStrings.rules11BList1),
        rulesList(text: AppStrings.rules11BList2),
        rulesList(text: AppStrings.rules11BList3),
        const Gap(20),
        richText(firstText: "${AppStrings.rules11CTitle} ", secondText: AppStrings.rules11CDes),
        const Gap(20),
        richText(firstText: "${AppStrings.rules11DTitle} ", secondText: AppStrings.rules11DDes1),
        const Gap(20),
        _thinText(text: AppStrings.rules11DDes2),
      ],
    );
  }

  Widget richText({required String firstText, required String secondText}) {
    return RichText(text: TextSpan(
        text: firstText,
        style: Styles.bodyMedium1.copyWith(fontWeight: FontWeight.w700),
        children: [
          TextSpan(
            text: secondText,
            style: Styles.bodyMedium2,
          ),
        ],
      ));
  }

  Widget rulesList({required String text}) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("•", style: Styles.bodyMedium1.copyWith(fontWeight: FontWeight.w700)),
          const Gap(10),
          Container(
            width: Dimensions.screenWidth*.85,
            child: Text(text,style: Styles.bodyMedium2)),
        ],
      );
  }

  Widget _rules10() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _boldText(text: "10. Payment Method and Conditions"),
        _thinText(text: AppStrings.rules10),
      ],
    );
  }

  Widget _rules9() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _boldText(text: "9. Product, Services and Pricing"),
        _thinText(text: AppStrings.rules9First),
        const Gap(20),
        _thinText(text: AppStrings.rules9Second),
        const Gap(20),
        _boldText(text: AppStrings.rules9Third),
        const Gap(10),
        Table(
          border: TableBorder.all(width: 1, color: AppColors.blackColor),
          children: [
            /// first row
            TableRow(
              children: DummyData.termstableRow1.map((cell) {
                return _buildRow(cell: cell, fontWeight: FontWeight.w600);
              }).toList(),
            ),

            /// second row
            TableRow(
              children: DummyData.termstableRow2.map((cell) {
                return _buildRow(cell: cell);
              }).toList(),
            ),

            /// third row
            TableRow(
              children: DummyData.termstableRow3.map((cell) {
                return _buildRow(cell: cell);
              }).toList(),
            ),

            /// fourth row
            TableRow(
              children: DummyData.termstableRow4.map((cell) {
                return _buildRow(cell: cell);
              }).toList(),
            ),

            /// fifth row
            TableRow(
              children: DummyData.termstableRow5.map((cell) {
                return _buildRow(cell: cell);
              }).toList(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRow(
      {required String cell, FontWeight? fontWeight = FontWeight.w400}) {
    return Padding(
      padding: EdgeInsets.all(height(8)),
      child: Center(
        child: Text(cell,
            style: Styles.smallText1.copyWith(fontWeight: fontWeight)),
      ),
    );
  }

  Widget _rules8() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _boldText(text: "8. How We protect Your Personal Data"),
        _thinText(text: AppStrings.rules8First),
        const Gap(20),
        _thinText(text: AppStrings.rules8Last),
      ],
    );
  }

  Widget _rules7() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _boldText(text: "7. How We Use Personal Data"),
        _thinText(text: AppStrings.rules7First),
        const Gap(20),
        _thinText(text: AppStrings.rules7A),
        const Gap(20),
        _thinText(text: AppStrings.rules7B),
        const Gap(20),
        _thinText(text: AppStrings.rules7C),
        const Gap(20),
        _thinText(text: AppStrings.rules7D),
        const Gap(20),
        _thinText(text: AppStrings.rules7E),
        const Gap(20),
        _thinText(text: AppStrings.rules7F),
        const Gap(20),
        _thinText(text: AppStrings.rules7G),
        const Gap(20),
        _thinText(text: AppStrings.rules7Last),
      ],
    );
  }

  Widget _rules6() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _boldText(text: "6. How We Collect Personal Data"),
        _thinText(text: AppStrings.rules6),
      ],
    );
  }

  Widget _rules5() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _boldText(text: "5. Intellectual Property"),
        _thinText(text: AppStrings.rules5First),
        const Gap(20),
        _thinText(text: AppStrings.rules5Middle),
        const Gap(20),
        RichText(
            text: TextSpan(
          children: [
            TextSpan(
              text: "Report: ",
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: font(16),
                fontWeight: FontWeight.w700,
                color: AppColors.blackColor,
              ),
            ),
            TextSpan(
              text: AppStrings.rules5Last,
              style: Styles.bodyMedium2,
            ),
          ],
        ))
      ],
    );
  }

  Widget _rules4() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _boldText(text: "4. Content, Copyright or Links"),
        const Gap(20),
        _thinText(text: AppStrings.rules4A),
        const Gap(20),
        _thinText(text: AppStrings.rules4B),
        const Gap(20),
        _thinText(text: AppStrings.rules4C),
        const Gap(20),
        _thinText(text: AppStrings.rules4D),
      ],
    );
  }

  Widget _rules3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _boldText(text: "3. User Accounts"),
        const Gap(20),

        /// A
        _boldText(text: "A) Recruiter Account:"),
        _thinText(text: AppStrings.rules3A),
        const Gap(20),

        /// B
        _boldText(text: "B) Job Seeker Account:"),
        _thinText(text: AppStrings.rules3B),
      ],
    );
  }

  Widget _rules2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _boldText(text: "2. Third-Party Links and Accounts"),
        _thinText(text: AppStrings.rules2),
      ],
    );
  }

  Widget _rules1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _boldText(text: "1. General Rules"),
        _thinText(text: AppStrings.rules1),
      ],
    );
  }

  _boldText({required String text}) {
    return Text(text,
        style: Styles.bodyMedium1.copyWith(fontWeight: FontWeight.w700));
  }

  _thinText({required String text}) {
    return Text(text, style: Styles.bodyMedium2);
  }
}
