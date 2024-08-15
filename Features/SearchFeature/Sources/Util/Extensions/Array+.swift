import Foundation

extension Array {
    func sortCafe() -> [NearbyCafeEntity] {
        guard var array = self as? [NearbyCafeEntity] else {
            return []
        }
        
        for stand in 0..<(array.count - 1) {
            var minIndex = stand
            
            for index in (stand + 1)..<array.count {
                if Double(array[index].distance)! < Double(array[minIndex].distance)! {
                    minIndex = index
                }
            }
            array.swapAt(stand, minIndex)
        }
        return array
    }
}
