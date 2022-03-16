//
//  RecipeDetailViewController.swift
//  Reciplease_App
//
//  Created by Square on 24/02/2022.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    
    // MARK: - IBOULET
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var recipeYield: UILabel!
    @IBOutlet weak var recipeTotalTime: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTableView: UITableView!
    @IBOutlet weak var buttonDirection: UIButton!
    @IBOutlet weak var contentViewTimer: UIView!
    @IBOutlet weak var contentViewImage: UIView!
    @IBOutlet weak var buttonAddFavorite: UIBarButtonItem!
    
    // MARK: - Properties
    private var coreDataManager: CoreDataManager?
    var recipleaseDetails: RecipleaseDetails?
    private var imageWithColor: UIImage {
        return UIImage(systemName: "star.fill")!
    }
    
    private var initialImage: UIImage {
        return UIImage(systemName: "star")!
    }
    
    //MARK: - IBACTION
    @IBAction func buttonAddFavoriteTapped(_ sender: Any) {
        if coreDataManager?.alreadySavedInFavorite(using: recipleaseDetails?.label ?? "" ) == true {
            buttonAddFavorite.image = initialImage
            coreDataManager?.deleteFavorites(using: recipleaseDetails?.label ?? "" )
        } else {
            guard let add = recipleaseDetails else { return }
            coreDataManager?.addFavorite(label: add.label, image: add.image ?? "", ingredientLines: add.ingredientLines , totalTime: add.totalTime ?? "" , url: add.url, yield: add.yield ?? "")
            buttonAddFavorite.image = imageWithColor
        }
    }
    
    @IBAction func buttonDirectionTapped(_ sender: Any) {
        guard let linkUrl = recipleaseDetails?.url,
              let recipeURL = URL(string: linkUrl) else { return presentAlert(title: "Error Network", message: "Can't redirection")}
        UIApplication.shared.open(recipeURL, options: [:], completionHandler: nil)
    }
    
    // MARK: - VIEWS LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeTableView.dataSource = self
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coreDataStack = appDelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
        loadDataFavorite()
        customContentTimerView(view: contentViewTimer)
        customButton()
    }
}

// MARK: - Private Method

extension RecipeDetailViewController {
    
    private func loadDataFavorite(){
        if let imageURL = recipleaseDetails?.image, let url = URL(string: imageURL) { recipeImage.load(url: url)}
        recipeLabel.text = recipleaseDetails?.label
        recipeTotalTime.text = (recipleaseDetails?.totalTime)! + " min"
        recipeYield.text = recipleaseDetails?.yield
    }
    
    private func customContentTimerView(view: UIView) {
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 5
    }
    
    private func customButton() {
        buttonDirection.layer.cornerRadius = 5
    }
}

// MARK: - Extension UItableViewDataSource and Delegate

extension RecipeDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipleaseDetails?.ingredientLines.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        cell.textLabel?.text = recipleaseDetails?.ingredientLines[indexPath.row]
        return cell
    }
}

