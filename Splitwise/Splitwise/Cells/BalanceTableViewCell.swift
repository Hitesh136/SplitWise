//
//  BalanceTableViewCell.swift
//  Splitwise
//
//  Created by Hitesh  Agarwal on 08/04/24.
//

import UIKit

class BalanceCellViewModel {
	let expenseModel: ExpenseModel
	init(expenseModel: ExpenseModel) {
		self.expenseModel = expenseModel
	}
	
	var userName: String {
		return expenseModel.payer
	}
	
	var amount: String {
		return "\(expenseModel.amount)"
	}
}

class BalanceTableViewCell: UITableViewCell {

		@IBOutlet weak var userNameLabel: UILabel!
		@IBOutlet weak var amountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	var cellViewModel: BalanceCellViewModel!

	func configureCell(cellViewModel: BalanceCellViewModel) {
		self.cellViewModel = cellViewModel
		self.userNameLabel.text = cellViewModel.userName
		self.amountLabel.text = cellViewModel.amount
	}
}
