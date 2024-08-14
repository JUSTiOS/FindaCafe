import CoreData

class CoreDataService {
    let persistentContainer: NSPersistentContainer
    var cafeInfo: [CafeInfo] = []
    
    init() {
        persistentContainer = NSPersistentContainer(name: "CafeCoreData")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                print("Error occurs in Loading PersistentContainer, \(error)")
            } else {
                print("Success Loading persistentContainer")
            }
        }
    }
    
    func fetchCafeInfo() -> Result<CafeInfo, CoreDataError> {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<CafeInfo>(entityName: "CafeInfo")
        
        do {
            cafeInfo = try context.fetch(request)
            return .success(cafeInfo.first ?? CafeInfo())
        } catch {
            print("Error occurs in fetching data from NSManagedObjectContext")
            return .failure(.FetchError)
        }
    }
    
    func addCafeInfo(
        vibe: String,
        toilet: String,
        storeSize: String,
        powerSocket: String,
        etc: String,
        congestion: String,
        phone: String,
        longitude: String,
        latitude: String,
        distance: String,
        categoryName: String,
        cafeName: String,
        address: String
    ) -> Result<Bool, CoreDataError> {
        guard let entity = NSEntityDescription.entity(forEntityName: "CafeInfo", in: persistentContainer.viewContext) else { return .failure(.AddError) }
        
        guard let tagEntity = NSEntityDescription.entity(forEntityName: "TagInfo", in: persistentContainer.viewContext) else { return .failure(.AddError)}
        
        let data = NSManagedObject(entity: entity, insertInto: persistentContainer.viewContext)
        
        data.setValue(vibe, forKey: "vibe")
        data.setValue(toilet, forKey: "toilet")
        data.setValue(storeSize, forKey: "storeSize")
        data.setValue(powerSocket, forKey: "powerSocket")
        data.setValue(congestion, forKey: "congestion")
        data.setValue(etc, forKey: "etc")
        
        return save()
    }
    
    func updateCafeInfo(
        vibe: String,
        toilet: String,
        storeSize: String,
        powerSocket: String,
        etc: String,
        congestion: String
    ) -> Result<Bool, CoreDataError> {
        let fetchData = fetchCafeInfo()
        
        switch fetchData {
        case .success(let data):
            data.vibe = vibe
            data.toilet = toilet
            data.storeSize = storeSize
            data.powerSocket = powerSocket
            data.etc = etc
            data.congestion = congestion
            return save()
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func deleteCafeInfo() -> Result<Bool, CoreDataError> {
        let context = persistentContainer.viewContext
        
        let fetchData = fetchCafeInfo()
        switch fetchData {
        case .success(let data):
            context.delete(data)
            return save()
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func save() -> Result<Bool, CoreDataError> {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
                return .success(true)
            } catch {
                print("Error occurs while Saving Data")
                return .failure(.SaveError)
            }
        } else {
            return .failure(.SaveError)
        }
    }
}
