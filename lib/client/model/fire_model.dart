class FIRModel {
   String? victimType;
   String? firType;
   String? name;
   String? evidenceUrl;

   String? fathersName;
   String? cnic;
   String? phoneNumber;
   String? address;
   String? incidentDistrict;
   String? incidentAddress;
   DateTime incidentDateTime = DateTime.now();
   String? nearestPoliceStation;
   String? incidentSubject;
   String? incidentDetails;
  FIRModel( {this.name, this.phoneNumber,this.victimType, this.firType, this.fathersName, this.cnic, this.address, this.incidentDistrict, this.incidentAddress, this.nearestPoliceStation, this.incidentSubject, this.incidentDetails});

}