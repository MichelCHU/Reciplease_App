//
//  TableViewCell.swift
//  Reciplease_App
//
//  Created by Square on 25/02/2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var tableViewLabel: UILabel!
    @IBOutlet weak var tableViewIngredientLines: UILabel!
    @IBOutlet weak var tableViewImage: UIImageView!
    @IBOutlet weak var tableViewYield: UILabel!
    @IBOutlet weak var TableViewTotalTimer: UILabel!
    @IBOutlet weak var tableViewContentView: UIView!
    
    var recipeEntity: EntityRecipe?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    var showListRecipe: Recipe? {
        didSet {
            if let imageUrl = showListRecipe?.image, let url = URL(string: imageUrl) {
                tableViewImage.load(url: url)
            }
            tableViewLabel.text = showListRecipe?.label
            TableViewTotalTimer.text =  "\(Int(showListRecipe!.totalTime))" + " min"
            tableViewYield.text = "\(Int(showListRecipe!.yield))"
            tableViewIngredientLines.text = showListRecipe?.ingredientLines.joined(separator: ",")
        }
    }
    
    var showFavoriteRecipe: EntityRecipe? {
        didSet {
            if let imageURL = showFavoriteRecipe?.image, let url = URL(string: imageURL) { tableViewImage.load(url: url)
            }
            tableViewLabel.text = showFavoriteRecipe?.label
            tableViewIngredientLines.text = showFavoriteRecipe?.ingredientLines?.joined(separator: ",")
            TableViewTotalTimer.text = showFavoriteRecipe?.totalTime
            tableViewYield.text = showFavoriteRecipe?.yield
        }
    }
}
