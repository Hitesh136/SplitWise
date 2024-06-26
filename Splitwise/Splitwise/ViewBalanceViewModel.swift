//
//  ViewBalanceViewModel.swift
//  Splitwise
//
//  Created by Hitesh  Agarwal on 08/04/24.
//

import Foundation

class ViewBalanceViewModel {
		
		private let balanceModel: BalanceModel
		var cellModels = [BalanceCellViewModel]()
		
		init(balanceModel: BalanceModel) {
				self.balanceModel = balanceModel
				configureModel()
		}
		
		func configureModel() {
				let perShare = balanceModel.totalAmount / Double((balanceModel.participants.count + 1))
		
				
				var newAmount: Double = perShare * Double(balanceModel.participants.count)
				if let amount = AmountSing.shared.pastTrans[balanceModel.payer] {
						newAmount += amount
				}
				AmountSing.shared.pastTrans[balanceModel.payer] = newAmount
				
				
				let firstExpense = ExpenseModel(payer: balanceModel.payer,
																				amount: newAmount)
				cellModels.append(BalanceCellViewModel(expenseModel: firstExpense))
				for parti in balanceModel.participants {
						
						var newPartiAmount: Double = -perShare
						if let amount = AmountSing.shared.pastTrans[parti] {
								newPartiAmount += amount
						}
						AmountSing.shared.pastTrans[parti] = newPartiAmount
						let partiExpense = ExpenseModel(payer: parti, amount: newPartiAmount)
						cellModels.append(BalanceCellViewModel(expenseModel: partiExpense))
				}
		}
		
		func numberOfRow() -> Int {
				return cellModels.count
		}
		
		func cellViewModel(atIndexPath indexPath: IndexPath) -> BalanceCellViewModel {
				return cellModels[indexPath.row]
		}
		
}
