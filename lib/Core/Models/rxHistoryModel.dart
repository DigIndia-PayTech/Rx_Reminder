class RxHistory {
  String trackId,rx_name, track_date, track_time,status,rx_id,type,total_tablets,start_date,end_date;
  List<HisFamilyList> hisfamilyMembers = [];
  List<HisWhenInDay>  hiswhenInDay= [];
}

class HisFamilyList {
  String name, mobile;
}

class HisWhenInDay {
  String attribute, time, count, when;
}
