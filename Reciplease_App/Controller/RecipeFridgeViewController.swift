//
//  RecipeFridgeViewController.swift
//  Reciplease_App
//
//  Created by Square on 24/02/2022.
//

import UIKit

class RecipeFridgeViewController: UIViewController, UITextViewDelegate {
    
    
    //MARK: - IBoulet
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var ingredientTextView: UITextView!
    @IBOutlet weak var buttonAdd: UIButton!
    @IBOutlet weak var buttonClear: UIButton!
    @IBOutlet weak var buttonSearch: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK:- Properties
    
    private let service = ServiceRecipes()
    private var ingredientsLine = [String]()
    var recipeResponse: ResponseRecipe?
    
    // MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyboard()
        ingredientTextView.delegate = self
        buttonAdd.layer.cornerRadius = 5
        buttonClear.layer.cornerRadius = 5
        buttonSearch.layer.cornerRadius = 5
    }
    
    //MARK: - IBAction
    
    @IBAction func buttonAddTapped(_ sender: UIButton) {
        if ingredientTextField.text != "" {
            ingredientsLine.append(ingredientTextField.text!)
            ingredientTextView.text = "- " + ingredientsLine.joined(separator: "\n- ")
            ingredientTextField.text = ""
        }
        else {
            presentAlert(title: "Error !", message: "Please add a ingredient")
        }
    }
    
    @IBAction func buttonClearTapped(_ sender: Any) {
        ingredientTextView.text.removeAll()
        ingredientsLine.removeAll()
    }
    
    @IBAction func buttonSearchTapped(_ sender: Any) {
        makeApiCall()
    }
    
    //MARK: - Methods
    
    private func makeApiCall() {
        if ingredientTextView.text.isEmpty {
            presentAlert(title: "Error", message: "Please add one ingredient before continue !")
        } else {
            activityIndicator(activityIndicator: activityIndicator, button: buttonSearch, showActivityIndicator: true)
            service.getData(ingredientQ: ingredientsLine) { result in
                DispatchQueue.main.async { [self] in
                    switch result {
                    case .success(let data) :
                        activityIndicator(activityIndicator: activityIndicator, button: buttonSearch, showActivityIndicator: true)
                        self.ingredientsLine = [""]
                        self.recipeResponse = data
                        self.performSegue(withIdentifier: "segueListViewController", sender: nil)
                    case .failure:
                        self.presentAlert(title: "Error", message: "Network error")
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let recipesList = segue.destination as? RecipeListViewController else { return }
        recipesList.recipeResponse = recipeResponse
    }
}
