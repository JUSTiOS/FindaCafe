import SwiftUI

public class TagSectionViewModel: ObservableObject {
    var sectionTitle: String = ""
    var sectionItems: [String] = []
    
    @Published var sectionSelectedState: [Bool] = []
    
    init(sectionTitle: String, sectionItems: [String]) {
        self.sectionTitle = sectionTitle
        self.sectionItems = sectionItems
        
        sectionSelectedState = Array(repeating: false, count: sectionItems.count)
    }
    
    func tagSelected(tagTitle: String) {
        guard let index = sectionItems.firstIndex(of: tagTitle) else { return }
        
        if sectionSelectedState[index] == false {
            sectionSelectedState.indices.forEach { sectionSelectedState[$0] = false }
            sectionSelectedState[index] = true
        } else {
            sectionSelectedState[index] = false
        }
        
    }
    
    func checkTagSelected(tagTitle: String) -> Bool {
        guard let index = sectionItems.firstIndex(of: tagTitle) else { return false }
        return sectionSelectedState[index]
    }
    
    func saveTagList() {
        
    }
}
