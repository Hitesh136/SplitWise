//
//  BalancesViewController.swift
//  Splitwise
//
//  Created by Hitesh  Agarwal on 08/04/24.
//

import UIKit

class BalancesViewController: UIViewController {
		
		@IBOutlet weak var tableView: UITableView! {
				didSet {
						tableView.dataSource = self
						tableView.register(UINib(nibName: "BalanceTableViewCell", bundle: nil), forCellReuseIdentifier: "BalanceTableViewCell")
				}
		}
		
		var viewModel: ViewBalanceViewModel!
		
		override func viewDidLoad() {
				super.viewDidLoad()
				tableView.reloadData()
		}
		
		static func getInstance(viewModel: ViewBalanceViewModel) -> BalancesViewController? {
				let storyboard = UIStoryboard(name: "Main", bundle: nil)
				guard let viewController = storyboard.instantiateViewController(withIdentifier: "BalancesViewController") as? BalancesViewController else {
						return nil
				}
				viewController.viewModel = viewModel
				return viewController
		}
}

extension BalancesViewController: UITableViewDataSource {
		func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
				return viewModel.numberOfRow()
		}
		
		func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
				guard let cell = tableView.dequeueReusableCell(withIdentifier: "BalanceTableViewCell", for: indexPath) as? BalanceTableViewCell else { return UITableViewCell() }
				
				let cellViewModel = viewModel.cellViewModel(atIndexPath: indexPath)
				cell.configureCell(cellViewModel: cellViewModel)
				return cell
		}
}
