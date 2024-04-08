//
//  AddBalanceViewModel.swift
//  Splitwise
//
//  Created by Hitesh  Agarwal on 08/04/24.
//

import Foundation


struct BalanceModel {
	var balanceTitle: String
	var totalAmount: Double
	var payer: String
	var participants: [String]
}

class AddBalanceViewModel {
	
	var balanceTitle: String = ""
	var totalAmount: Double = 0
	var payer: String = ""
	var participants = [String]()
	
	func buildExpense() -> BalanceModel {
		return BalanceModel(balanceTitle: balanceTitle, totalAmount: totalAmount, payer: payer, participants: participants)
	}
}

struct ExpenseModel {
	var payer: String
	var amount: Double
}



class AmountSing {
	
	static public let shared = AmountSing()
	private init() {}
	
	var pastTrans = [String: Double]()
	
	func updateTrans(_ user: String, _ amount: Double) {
		pastTrans[user] = amount
	}
	
	
	func settle() {
		var rec = pastTrans.filter { keyValue in
			keyValue.value > 0
		}.map { keyPair in
			return ExpenseModel(payer: keyPair.key, amount: keyPair.value)
		}.sorted(by: { $0.amount > $1.amount })
		var send = pastTrans.filter { keyValue in
			keyValue.value < 0
		}.map { keyPair in
			return ExpenseModel(payer: keyPair.key, amount: keyPair.value)
		}.sorted(by: { $0.amount > $1.amount })
		
		var settleArray = [SettleModel]()
		while let recFirst = rec.first, let sendFirst = send.first {
			if recFirst.amount == sendFirst.amount {
				settleArray.append(SettleModel(rec: recFirst.payer, send: sendFirst.payer, amount: recFirst.amount))
				rec.remove(at: 0)
				send.remove(at: 0)
			} else if recFirst.amount > sendFirst.amount {
				settleArray.append(SettleModel(rec: recFirst.payer, send: sendFirst.payer, amount: sendFirst.amount))
				rec[0].amount -= sendFirst.amount
				send.remove(at: 0)
			} else if recFirst.amount < sendFirst.amount {
				settleArray.append(SettleModel(rec: recFirst.payer, send: sendFirst.payer, amount: recFirst.amount))
				rec.remove(at: 0)
				send[0].amount -= recFirst.amount
			}
		}
		pastTrans.removeAll()
		
	}
	
}

struct SettleModel {
	var rec: String
	var send: String
	var amount: Double
}

