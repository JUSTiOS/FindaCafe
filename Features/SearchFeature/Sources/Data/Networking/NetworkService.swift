import Foundation
import Alamofire
import Combine

protocol NetworkService {
    associatedtype T
    
    func getDataFromNetwork() -> Result<T, Never>
}
