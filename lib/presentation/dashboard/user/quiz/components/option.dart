import 'package:flutter/material.dart';
import 'package:quiz_app/domain/constants.dart';
import 'package:quiz_app/infrastructure/models/answer.dart';
import 'package:quiz_app/presentation/dashboard/user/quiz/bloc/answer/answer_quiz_state.dart';

class Option extends StatelessWidget {
  const Option({
    Key? key,
    required this.text,
    required this.press,
    required this.isSelected,
    required this.index,
    required this.answer,
    required this.questionAnwers,
  }) : super(key: key);

  final bool isSelected;
  final int index;
  final Answer answer;
  final List<QuestionAnswer> questionAnwers;
  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    // return GetBuilder<QuestionController>(
    //     init: QuestionController(),
    //     builder: (qnController) {

    Color getTheRightColor() {
      if (questionAnwers.any((element) => element.answerId == answer.id)) {
        return kGreenColor;
      }
      return kGrayColor;
    }

    IconData getTheRightIcon() {
      return getTheRightColor() == kRedColor ? Icons.close : Icons.done;
    }

    return InkWell(
      onTap: press,
      child: Container(
        margin: const EdgeInsets.only(top: kDefaultPadding),
        padding: const EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
          border: Border.all(color: getTheRightColor()),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${index + 1}. $text',
              style: TextStyle(color: getTheRightColor(), fontSize: 16),
            ),
            Container(
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                color: getTheRightColor() == kGrayColor
                    ? Colors.transparent
                    : getTheRightColor(),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: getTheRightColor()),
              ),
              child: getTheRightColor() == kGrayColor
                  ? null
                  : Icon(getTheRightIcon(), size: 16),
            )
          ],
        ),
      ),
    );
  }
}
