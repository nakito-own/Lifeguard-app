class Shift{
  final int id;
  final int leader_id;
  final String comment;
  final String timeStart;
  final String timeEnd;

  Shift({
    required this.id,
    required this.leader_id,
    required this.comment,
    required this.timeStart,
    this.timeEnd = ''
  });
   factory Shift.fromJson(Map<String, dynamic> json){
     return Shift(
       id: json['id'] is int ? json['id'] : 0,
       leader_id: json['leader'] is int ? json['leader'] : 0,
       comment: json['comment'] ?? '',
       timeStart: json['timeStart'] ?? '',
       timeEnd: json['timeEnd'] ?? '',
     );
   }
    Map<String, dynamic> toJson(){
     return{
       'id': id,
       'leader': leader_id,
       'comment': comment,
       'timeStart': timeStart,
       'timeEnd': timeStart
     };
   }
}