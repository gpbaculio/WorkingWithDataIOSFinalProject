import Foundation
import CoreData


extension Dish {

    class func createDishesFrom(menuItems: [MenuItem], context: NSManagedObjectContext) {
        for item in menuItems {
            let request = Dish.fetchRequest() as NSFetchRequest<Dish>
            request.predicate = NSPredicate(format: "name == %@", item.title)
            do {
                let results = try context.fetch(request)
                if let existingDish = results.first {
                    // if the dish already exists, update its price
                    existingDish.price = Float(item.price) ?? 0
                } else {
                    // if the dish doesn't exist, create a new one
                    let newDish = Dish(context: context)
                    newDish.name = item.title
                    newDish.price = Float(item.price) ?? 0
                }
            } catch {
                print("Error fetching Dish objects: \(error)")
            }
        }
        
        do {
            try context.save()
        } catch {
            print("Error saving Dish objects: \(error)")
        }
    }
}
