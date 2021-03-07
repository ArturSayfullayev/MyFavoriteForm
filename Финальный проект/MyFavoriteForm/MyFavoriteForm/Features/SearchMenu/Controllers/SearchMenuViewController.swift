//
//  SearchMenuViewController.swift
//  MyFavoriteForm
//
//  Created by Artur on 19.02.2021.
//

import UIKit

class SearchMenuViewController: UITableViewController {
    // MARK: - Properties      
    private lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add,
                                     target: self,
                                     action: #selector(self.openAddProduct))
        
        return button
    }()
    
    private var modelForPresent : [FoodModelFromFileManager.Menu] = []
    var baseModel : [FoodModelFromFileManager.Menu] = [] {
        didSet {
            FoodFileManager.shared.writeDataWithNSCodable(with: Logic.shared.userKeyMenuCodable,
                                                          model: self.baseModel)
        }
    }
   
    // MARK: - GUI Properties
    lazy var searchBar = UISearchController(searchResultsController: nil)
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.rightBarButtonItem = self.addButton
        
        self.setTableView()
        self.setSearchBar()
        self.setModelMenu()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.addProduct),
                                               name: .productName,
                                               object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelForPresent.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath)
        
        if let cell = cell as? TableViewCell {
                cell.setCell(title: self.modelForPresent[indexPath.row].name,
                             description: "Белки: \(self.modelForPresent[indexPath.row].proteins), жиры: \(self.modelForPresent[indexPath.row].fats), углеводы: \(self.modelForPresent[indexPath.row].carbohydrates),\nобщая калорийность: \(self.modelForPresent[indexPath.row].calories).")
        }
        cell.selectionStyle = .none
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        Logic.shared.setAdditionalMenu(menu: self.modelForPresent[indexPath.row])
        
        let vc = AddMenuViewController()
        vc.mainView.setLableMenu(menu: self.modelForPresent[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    override func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let remove = UIContextualAction(style: .destructive,
                                        title: "Удалить") { [weak self] (action, view, completionHandler) in
            guard let self = self else { return }
            self.tableView.performBatchUpdates({
                self.modelForPresent.remove(at: indexPath.row)
                self.baseModel.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                FoodFileManager.shared.writeDataWithNSCodable(with: Logic.shared.userKeyMenuCodable,
                                                              model: self.modelForPresent)
            })
        }
        return UISwipeActionsConfiguration(actions: [remove])
    }

    // MARK: - Methods
    @objc private func addProduct(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let product = userInfo["product"] as? FoodModelFromFileManager.Menu else { return }
        self.baseModel.insert(product, at: 0)
        self.searchBar.isActive = true
    }
    
    @objc private func openAddProduct() {
        let vc = AddProductViewController()
        self.present(vc, animated: true)
    }
    private func setTableView() {
        self.tableView.tableFooterView = UIView()
        self.tableView.register(TableViewCell.self,
                                forCellReuseIdentifier: TableViewCell.reuseIdentifier)
    }
    private func setSearchBar() {
        self.navigationItem.searchController = self.searchBar
        self.searchBar.searchResultsUpdater = self
        self.searchBar.obscuresBackgroundDuringPresentation = false
        self.searchBar.searchBar.placeholder = "Search"
        self.definesPresentationContext = true
    }
    private func setModelMenu() {
        guard let model = FoodFileManager.shared.readDataWithCodable(
                with: Logic.shared.userKeyMenuCodable) else { return }
        self.modelForPresent = model
        self.baseModel = model
    }
}

extension SearchMenuViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        
        let additionalMenu = self.baseModel
        self.modelForPresent = !searchText.isEmpty
            ? self.baseModel.filter { $0.name.lowercased().contains(searchText.lowercased()) }
            : additionalMenu
        
        self.tableView.reloadData()
    }
}
