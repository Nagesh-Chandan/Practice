import UIKit

extension Array {
    func enumurateElements(_ closure: (Element, Int, inout Bool) -> Void ) {
        var flag = false
        for (index, element) in self.enumerated() {
            if flag {
                return
            }
            closure(element, index, &flag)
        }
    }
    // Aletrnative
    func enumurateItems(_ clousre: (Element, Int) -> Bool) {
        for (index, element) in self.enumerated() {
            let flag = clousre(element, index)
            if flag {
                return
            }
        }
    }
}
[1,2,3,4,5,6].enumurateElements {
    $2 = $0 == 3
    print($0)
}
print("-----")
[1,2,3,4,5,6].enumurateItems {(item,idx) in
    print(item)
    return item == 3
}
