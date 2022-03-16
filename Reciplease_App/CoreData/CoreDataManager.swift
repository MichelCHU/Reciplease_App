//
//  CoreDataManager.swift
//  Reciplease_App
//
//  Created by Square on 25/02/2022.
//

import Foundation
import CoreData

class CoreDataManager {
    // MARK: - PROPERTIES
    
    private let coreDataStack: CoreDataStack
    private let managedObjectContext: NSManagedObjectContext
    
    var entityRecipe: [EntityRecipe] {
        let request: NSFetchRequest<EntityRecipe> = EntityRecipe.fetchRequest()
        guard let recipes = try? managedObjectContext.fetch(request) else { return [] }
        return recipes
    }
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }
    
    func addFavorite (label: String, image: String, ingredientLines: [String], totalTime: String, url: String, yield: String) {
        let recipesEntity = EntityRecipe(context: managedObjectContext)
        recipesEntity.label = label
        recipesEntity.image = image
        recipesEntity.ingredientLines = ingredientLines
        recipesEntity.totalTime = totalTime + " min"
        recipesEntity.url = url
        recipesEntity.yield = yield
        coreDataStack.saveContext()
    }
    
    // MARK: - Delete Recipes From Favorites
    
    func deleteFavorites(using label: String) {
        let request: NSFetchRequest<EntityRecipe> = EntityRecipe.fetchRequest()
        request.predicate = NSPredicate(format: "label == %@", label)
        guard let favoritesRecipe = try? managedObjectContext.fetch(request) else { return }
        favoritesRecipe.forEach { managedObjectContext.delete($0) }
        coreDataStack.saveContext()
    }
    
    
    // MARK: - Recipe Already Exist in Favorite
    
    func alreadySavedInFavorite(using label: String) -> Bool {
        let request: NSFetchRequest<EntityRecipe> = EntityRecipe.fetchRequest()
        request.predicate = NSPredicate(format: "label == %@", label)
        guard let favoritesRecipe = try? managedObjectContext.fetch(request) else { return false }
        if favoritesRecipe.isEmpty {
            return false
        }
        return true
    }
}
