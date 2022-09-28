enum DocKeyCalcTip {
  createdBy,
  timestamp,
  purchaseAmount,
  star,
  numOfPeople,
  note,
  totalTip,
  totalPay,
  tipPerPerson,
  amountPerPerson,
}

class TipCalc {
  String? docId;
  String? createBy;
  DateTime? timestamp;
  double? purchaseAmount;
  double? star;
  int? numOfPeople;
  String? note;
  double? totalTip;
  double? totalPay;
  double? tipPerPerson;
  double? amountPerPerson;

  TipCalc({
    this.docId,
    this.createBy,
    this.timestamp,
    this.purchaseAmount,
    this.star,
    this.numOfPeople,
    this.note,
    this.totalTip,
    this.totalPay,
    this.tipPerPerson,
    this.amountPerPerson,
  }) {}

  // serialization
  Map<String, dynamic> toFirestoreDoc() {
    return {
      DocKeyCalcTip.createdBy.name: createBy,
      DocKeyCalcTip.timestamp.name: timestamp,
      DocKeyCalcTip.purchaseAmount.name: purchaseAmount,
      DocKeyCalcTip.star.name: star,
      DocKeyCalcTip.numOfPeople.name: numOfPeople,
      DocKeyCalcTip.note.name: note,
      DocKeyCalcTip.totalTip.name: totalTip,
      DocKeyCalcTip.totalPay.name: totalPay,
      DocKeyCalcTip.tipPerPerson.name: tipPerPerson,
      DocKeyCalcTip.amountPerPerson.name: amountPerPerson,
    };
  }

  // deserialization
  static TipCalc? fromFirestoreDoc(
      {required String docId, required Map<String, dynamic> doc}) {
    return TipCalc(
      docId: docId,
      createBy: doc[DocKeyCalcTip.createdBy.name],
      timestamp: doc[DocKeyCalcTip.timestamp.name] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(
              doc[DocKeyCalcTip.timestamp].millisecondsSinceEpoch),
      purchaseAmount: doc[DocKeyCalcTip.purchaseAmount.name],
      star: doc[DocKeyCalcTip.star.name],
      numOfPeople: doc[DocKeyCalcTip.numOfPeople.name],
      note: doc[DocKeyCalcTip.note.name],
      totalTip: doc[DocKeyCalcTip.totalTip.name],
      totalPay: doc[DocKeyCalcTip.totalPay.name],
      tipPerPerson: doc[DocKeyCalcTip.tipPerPerson.name],
      amountPerPerson: doc[DocKeyCalcTip.amountPerPerson.name],
    );
  }

  static String? validatePurchaseAmount(String? value) {
    if (double.tryParse(value!) == null || double.parse(value) == 0) {
      return 'Insert a number';
    }
    return null;
  }
}
