class WalletTransaction {
    String amount;
    String created_at;
    int id;
    String pay_status;
    String payment_id;
    String ref;
    String track_id;
    String tran_id;
    String updated_at;

    WalletTransaction({this.amount, this.created_at, this.id, this.pay_status, this.payment_id, this.ref, this.track_id, this.tran_id, this.updated_at});

    factory WalletTransaction.fromJson(Map<String, dynamic> json) {
        return WalletTransaction(
            amount: json['amount'], 
            created_at: json['created_at'], 
            id: json['id'], 
            pay_status: json['pay_status'], 
            payment_id: json['payment_id'], 
            ref: json['ref'], 
            track_id: json['track_id'], 
            tran_id: json['tran_id'], 
            updated_at: json['updated_at'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['amount'] = this.amount;
        data['created_at'] = this.created_at;
        data['id'] = this.id;
        data['pay_status'] = this.pay_status;
        data['payment_id'] = this.payment_id;
        data['ref'] = this.ref;
        data['track_id'] = this.track_id;
        data['tran_id'] = this.tran_id;
        data['updated_at'] = this.updated_at;
        return data;
    }
}