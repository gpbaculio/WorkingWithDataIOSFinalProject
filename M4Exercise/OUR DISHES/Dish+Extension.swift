import Foundation
import CoreData


extension Dish {

    static func createDishesFrom(menuItems:[MenuItem],
                                 _ context:NSManagedObjectContext) {
        for menuItem in menuItems {
                    guard !dishExists(withID: menuItem.id, in: context) else {
                        continue // skip this menu item if a dish with the same ID already exists
                    }
                    
                    let dish = Dish(context: context)
                    dish.name = menuItem.title
                    dish.price = Float(menuItem.price)
                }
                
                do {
                    try context.save()
                } catch let error {
                    print("Could not save dishes: \(error.localizedDescription)")
                }
        
    }
    static func dishExists(withID id: UUID, in context: NSManagedObjectContext) -> Bool {
            let request: NSFetchRequest<Dish> = Dish.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            request.fetchLimit = 1
            
            do {
                let count = try context.count(for: request)
                return count > 0
            } catch {
                print("Error checking if dish exists: \(error.localizedDescription)")
                return false
            }
        }
    
}
