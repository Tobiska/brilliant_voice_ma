class Question {
  final String questionText;
  final String answerText;

  Question({required this.questionText, required this.answerText});
  Question.shrink(): questionText = "", answerText = "";

  Question copyWith(Question question) {
    return Question(
        questionText: question.questionText,
        answerText: question.answerText
    );
  }
}