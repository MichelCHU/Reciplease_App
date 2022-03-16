//
//  RecipeFavoriteViewController.swift
//  Reciplease_App
//
//  Created by Square on 24/02/2022.
//

import UIKit
import CoreData

class RecipeFavoriteViewController: UIViewController {
    
    // MARK: - IBoulet
    
    @IBOutlet weak var favoriteTableView: UITableView!
    
    // MARK: - Properties
    
    var recipleaseDetail: RecipleaseDetails!
    private var coreDataManager: CoreDataManager?
    private var footerText: String {
        "Nothing in your Favorites. \n You need to add some recipes in your Favorite list !"
    }
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coreDataStack = appDelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
        
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        favoriteTableView.register(nib, forCellReuseIdentifier: "TableViewCell")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? RecipeDetailViewController else { return }
        detailVC.recipleaseDetails = recipleaseDetail
    }
}

//MARK: - PRIVATE METHODS

extension RecipeFavoriteViewController {
    
    private func deleteFromFavoriteCells(at indexPath: IndexPath) {
        guard let label = coreDataManager?.entityRecipe[indexPath.row].label else { return }
        coreDataManager?.deleteFavorites(using: label)
        presentAlert(title: "Delete From Favorite", message: "The recipe: \(label) has been removed from your favorites")
        favoriteTableView.reloadData()
    }
}

// MARK: - Extension UItableViewDataSource and Delegate

extension RecipeFavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager?.entityRecipe.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.showFavoriteRecipe = coreDataManager?.entityRecipe[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let add = coreDataManager?.entityRecipe[indexPath.row]
        recipleaseDetail = RecipleaseDetails(label: add?.label ?? "",
                                             image: add?.image ?? "",
                                             url: add?.url ?? "",
                                             yield: add?.yield ?? "",
                                             ingredientLines: add?.ingredientLines ?? [],
                                             totalTime: add?.totalTime ?? "")
        performSegue(withIdentifier: "segueFavoriteToDetail", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteFromFavoriteCells(at: indexPath)
            tableView.reloadData()
        }
    }
    
    // tableView "FooterView" if no Favorite
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: tableView.center.x, y: tableView.center.y, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        let title = UILabel(frame: footerView.bounds)
        title.text = footerText
        title.textAlignment = .center
        title.textColor = .lightGray
        title.font = UIFont(name: "System Light", size: 17)
        title.lineBreakMode = .byWordWrapping
        title.numberOfLines = 0
        footerView.addSubview(title)
        return coreDataManager?.entityRecipe.count == 0 ? footerView : nil
    }
}
