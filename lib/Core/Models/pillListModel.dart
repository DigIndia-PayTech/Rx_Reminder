class Pill {
  String rxId, rxTitle, type, totalTablets, rxStatus, timeData, reminderStatus = 'Skipped';
  String startDate, endDate;
  List<FamilyList> familyMembers = [];
  List<WhenInDay> whenInDay = [];
}

class FamilyList {
  String name, mobile;
}

class WhenInDay {
  String attribute, time, count, when;
}
