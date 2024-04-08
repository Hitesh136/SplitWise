//
//  AddBalanceViewController.swift
//  Splitwise
//
//  Created by Hitesh  Agarwal on 08/04/24.
//

import UIKit

class AddBalanceViewController: UIViewController {

		@IBOutlet weak var expenseLabel: UILabel!
		@IBOutlet weak var expenseTextField: UITextField!
		
		@IBOutlet weak var totalAmountLabel: UILabel!
		@IBOutlet weak var totalAmountTextField: UITextField!
		
		@IBOutlet weak var paidByTextField: UITextField!
		
		@IBOutlet weak var partiTextField1: UITextField!
		@IBOutlet weak var partiTextField2: UITextField!
		
		var viewModel: AddBalanceViewModel!
		
		static func getInstance(viewModel: AddBalanceViewModel) -> AddBalanceViewController? {
				let storyboard = UIStoryboard(name: "Main", bundle: nil)
				guard let viewController = storyboard.instantiateViewController(withIdentifier: "AddBalanceViewController") as? AddBalanceViewController else {
						return nil
				}
				viewController.viewModel = viewModel
				return viewController
		}
		
		override func viewDidLoad() {
				super.viewDidLoad()
		}
		
		@IBAction func actionAdd() {
				viewModel.reset()
				viewModel.balanceTitle = expenseLabel.text ?? ""
				viewModel.totalAmount = Double(totalAmountTextField.text ?? "") ?? 0
				viewModel.payer = paidByTextField.text ?? ""
				viewModel.participants.append(partiTextField1.text ?? "")
				viewModel.participants.append(partiTextField2.text ?? "")
				
				let balancesViewModel = ViewBalanceViewModel(balanceModel: viewModel.buildExpense())
				if let viewController = BalancesViewController.getInstance(viewModel: balancesViewModel) {
						navigationController?.pushViewController(viewController, animated: true)
				}
		}
}

