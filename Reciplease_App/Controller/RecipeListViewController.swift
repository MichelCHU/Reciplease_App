//
//  RecipeListViewController.swift
//  Reciplease_App
//
//  Created by Square on 24/02/2022.
//

import UIKit

class RecipeListViewController: UIViewController {
    
    // MARK: - IBOulet
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    private var hits = [Hit]()
    var recipeResponse: ResponseRecipe?
    var recipleaseDetail: RecipleaseDetails?
    private var service =  ServiceRecipes()
    
    // MARK: - VIEWS LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nibName = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "TableViewCell")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? RecipeDetailViewController else { return }
        detailVC.recipleaseDetails = recipleaseDetail
    }
}

// MARK: - Extention UITableViewDataSource
extension RecipeListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeResponse?.hits.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
                as? TableViewCell else { return UITableViewCell() }
        cell.showListRecipe = recipeResponse?.hits[indexPath.row].recipe
        return cell
    }
}
// MARK: - Extention UITableViewDelegate

extension RecipeListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = recipeResponse?.hits[indexPath.row].recipe
        recipleaseDetail = RecipleaseDetails(label: detail?.label ?? "", image: detail?.image ?? "", url: detail?.url ?? "", yield: String(detail?.yield ?? 0), ingredientLines: detail?.ingredientLines ?? [] , totalTime: String(detail?.totalTime ?? 0 ))
        
        performSegue(withIdentifier: "segueRecipeToDetail", sender: self)
    }
    
    // CFGloat Hauteur de 100
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

