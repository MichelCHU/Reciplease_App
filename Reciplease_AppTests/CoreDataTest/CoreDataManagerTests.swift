//
//  CoreDataManagerTests.swift
//  Reciplease_AppTests
//
//  Created by Square on 28/02/2022.
//

@testable import Reciplease_App
import XCTest

final class CoreDataManagerTests: XCTestCase {
    
    // MARK: - Properties
    
    var coreDataStack: MockCoreDataStack!
    var coreDataManager: CoreDataManager!
    var recipe = ["Chicken Vesuvio"]
    //MARK: - Tests Life Cycle
    
    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataManager = nil
        coreDataStack = nil
    }
    
    // MARK: - Tests
    
        func testAddFavoriteMethods_WhenAnEntityIsCreated_ThenShouldBeCorrectlySaved() {
    
            coreDataManager.addFavorite(label: "Chicken Vesuvio", image: "", ingredientLines: [""], totalTime: "60", url: "https://www.seriouseats.com/chicken-vesuvio-recipe", yield: "4")
            
            XCTAssertTrue(!coreDataManager.entityRecipe.isEmpty)
            XCTAssertTrue(coreDataManager.entityRecipe.count == 1)
            XCTAssertTrue(coreDataManager.entityRecipe[0].label! == "Chicken Vesuvio")
        }
    
    func testDeleteFavoriteMethod_WhenAnEntityIsCreated_ThenShouldBeCorrectlyDeleted() {
        
        coreDataManager.deleteFavorites(using: "Chicken Roast")
        coreDataManager.addFavorite(label: "Chicken Vesuvio", image: "", ingredientLines: [""], totalTime: "60", url: "https://www.seriouseats.com/chicken-vesuvio-recipe", yield: "4")
        coreDataManager.deleteFavorites(using: "Chicken Vesuvio")
        
        XCTAssertTrue(coreDataManager.entityRecipe.isEmpty)
    }
    
        func testCheckFavoriteMethod_WhenAnEntityIsFavorite_ThenShouldBeAlreadyAdded() {
            coreDataManager.addFavorite(label: "Chicken Vesuvio", image: "", ingredientLines: [""], totalTime: "60", url: "https://www.seriouseats.com/chicken-vesuvio-recipe", yield: "4")
            XCTAssertTrue(coreDataManager.alreadySavedInFavorite(using: "Chicken Vesuvio"))
            XCTAssertFalse(coreDataManager.entityRecipe.isEmpty)

        }
    
    func testCheckFavoriteSecondMethod_WhenAnEntityIsFavorite_ThenShouldBeAlreadyAdded() {
        coreDataManager.addFavorite(label: "Chicken Vesuvio", image: "", ingredientLines: [""], totalTime: "60", url: "https://www.seriouseats.com/chicken-vesuvio-recipe", yield: "4")
        coreDataManager.deleteFavorites(using: "Chicken Vesuvio")
        
        XCTAssertFalse(coreDataManager.alreadySavedInFavorite(using: "Chicken Vesuvio"))
        XCTAssertTrue(coreDataManager.entityRecipe.isEmpty)
    }
}
