class StepModel {
  final int id;
  final String text;

  StepModel({this.id, this.text});

  static List<StepModel> list = [
    StepModel(
      id: 1,
      text: "It is very difficult to take care of ownself,\nahere we are to\nremind your health process",
    ),
    StepModel(
      id: 2,
      text:
      "We will always remind your schedule.\nIt is now our responsibility\nto protect your health",
    ),
    StepModel(
      id: 3,
      text: "With us you wont put yourself\nor your loved ones at risk\nby missing the dosage",
    ),
  ];
}
