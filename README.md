# Practice
Practice programs

### General Purpose Node
Use Node for memory efficent collection
 
```swift
final class Node {
    var val: Any
    var link: Node?
    init(_ val: Any) {
        self.val = val
    }
}
```
### Swift enumurate Elements Using Blocks
Handy swift extention
```swift
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
```
### Swap two Integers in place 
```swift
// Helper call-by-ref swap function
func integerSwap(_ a: inout Int, _ b: inout Int) {
    (a, b) = (b, a)
}
```
### Two Sum problem
```swift
typealias Pair = (Int, Int)
func twoSum(_ arr: [Int], sum: Int) -> [Pair] {
    var pairs = Array<Pair>()
    var seen = Set<Int>()
    arr.forEach { (item) in
        let diff = sum - item
        if seen.contains(diff) {
            let pair:Pair = (min(diff, item), max(item, diff))
            pairs.append(pair)
        }
        seen.insert(item)
    }
    return pairs
}
```
```swift
print(twoSum([4,5,1,8], sum: 6))
print(twoSum([3,5,2,-4,8,11], sum: 7))

```

### Minimum Swaps in Array
```swift
func minimumSwapsAsc(_ arr: [Int]) -> Int {
    var arr = arr
    var minSwaps = 0
    var index = 0
    let n = arr.count - 1
    
    while index < n {
        let indexValLess1 = arr[index] - 1
        if index < indexValLess1 {
            print("index \(index) n \(n)  value \(indexValLess1)")
            arr.swapAt(index, max(n, indexValLess1))
            print(arr)
            minSwaps += 1
            index -= 1
        }
        index += 1
    }
    
    return minSwaps
}

//print("Minimum Swaps : \(minimumSwapsAsc([3,4,1,2]))")

func minimumSwapsDsce(_ arr: [Int]) -> Int {
    var arr = arr
    var minSwaps = 0
    var index = 0
    let n = arr.count - 1
    let size = arr.count
    while index < n {
        if arr[index] != (size - index) {
            arr.swapAt(index, min(size - arr[index], n))
            minSwaps += 1
        }else {
            index += 1
        }
        
    }
    
    return minSwaps
}

print("Minimum Swaps : \(minimumSwapsDsce([3,4,1,2]))")

```
### Merge Two String
```swift
func mergeStrings(a: String, b: String) -> String {
    var combine = [Character]()
    var i = 0
    var j = 0
    
    while i < a.count && j < b.count {
        var idx = a.index(a.startIndex, offsetBy: i)
        combine.append(a[idx])
        idx = b.index(b.startIndex, offsetBy: j)
        combine.append(b[idx])
        i += 1
        j += 1
        
    }
    
    if (i != a.count) {
        let remainStart = a.index(a.startIndex, offsetBy: i)
        combine.append(contentsOf: a[remainStart..<a.endIndex])
    }
    if (j != b.count) {
        let remainStart = b.index(b.startIndex, offsetBy: j)
        combine.append(contentsOf: b[remainStart..<b.endIndex])
    }
    return String(combine)
    
}
```
```swift
print(mergeStrings(a: "abc", b: "def"))
```

### Delete Products
```swift
func deleteProducts(ids: [Int], m: Int) -> Int{
    var array = ids
    
    // 1. create counted hash-map
    var dict: [Int: Int] = [:]
    array.forEach { (element) in
        if dict.contains(where: { return $0.key == element }) {
            if var val = dict[element] {
                val += 1
                dict[element] = val
            }
        }else {
            dict[element] = 1
        }
    }

    /// 2. get lowest counted element
    
    func getlowest() -> Int {
        var lowElement = array[0]
        for (_, ele) in dict.enumerated() {
            if ele.value == 0 {
                continue
            }
            if let val = dict[lowElement] {
                if ele.value < val {
                    lowElement = ele.key
                }
            }
        }
        return lowElement
    }
    
   // 3. Remove low counted element
    for _ in  0..<m {
        let low = getlowest()
        print("Low counted element \(low)")
        // reduce count
        if var val = dict[low] {
            val -= 1
            dict[low] = val
        }
    }
    // create final array
    var list = [Int]()
    for (_, ele) in dict.enumerated() {
        if ele.value != 0 {
            list.append(ele.key)
        }
    }
    
    
    return list.count
}
```
```swift
print("Products left  \(deleteProducts(ids: [1,1,1,1,2,3,4,4], m: 2))")
```
### Seperate 0's on left and 1's on right in Array
```swift
func seperate(_ arr: [Int]) -> [Int] {
    
    var list = arr
    var startIndex = 0
    var endIndex = list.count - 1
    var i = 0
    
    while i <= endIndex {
        if list[i] == 0 {
            list.swapAt(startIndex, i)
            startIndex += 1
        }else if list[i] == 1 {
            list.swapAt(endIndex, i)
            endIndex -= 1
        }else {
            i += 1
        }
    }
    return list
}
```
```swift
print(seperate([3,2,1,1,0,7,8,0,1,0,1,0,34,42,123,4444,1,1,0]))
```
### Counting Valley
```swift
func countingValleys(n: Int, s: String) -> Int {
    var count = 0
    var level = 0
    
    for char in s {
        if char == "U" {
            level += 1
            if level == 0 {
                count += 1
            }
        }else {
            level -= 1
        }
        
    }
    return count
    
}
```
```swift
print("Valley Count \(countingValleys(n: 12, s: "DDUUDDUDUUUD"))")
```
### Jumping Clouds
```swift
func jumpingOnClouds(_ array: [Int]) -> Int {
    var minJumps = 0
    var currentIndex = 0
    while currentIndex < array.count - 1 {
        var nextIndex = currentIndex + 2
        if nextIndex >= array.count || array[nextIndex] == 1  {
            nextIndex -= 1
        }
        minJumps += 1
        currentIndex = nextIndex
    }
    return minJumps
}
```
```swift
print("minJump count = \(jumpingOnClouds([0,1,0,0,0,1,0]))")
print("minJump count = \(jumpingOnClouds([0,0,1,0,0,1,0]))")
print("minJump count = \(jumpingOnClouds([0,0,0,1,0,0]))")
```
### Repeated String
```swift
func repeatedString(s: String, n: Int) -> Int {
    var count = 0
    for char in s {
        if char == "a" {
            count += 1
        }
    }
    let repetations: CLongLong = CLongLong(n / s.count)
    var result = CLongLong(count) * repetations
    let rem = n % s.count
    var i = 0
    while i < rem {
        let idx = s.index(s.startIndex, offsetBy: i)
        if s[idx] == "a" {
            result += 1
        }
        i += 1
    }
    return Int(result)
}
```
```swift
print("a's count = \(repeatedString(s: "qwtruq", n: 10))")
```
### Hourglass Sum
```swift
func hourglassSum(arr: [[Int]]) -> Int {
    var totalSum = Int.min
    print(totalSum)
    for i in 0...3 {
        for j in 0...3 {
            var sum = 0
            sum += arr[i][j] + arr[i][j+1] + arr[i][j+2]
            sum += arr[i+1][j+1]
            sum += arr[i+2][j] + arr[i+2][j+1] + arr[i+2][j+2]
            
//            print("[\(i)][\(j)] [\(i)][\(j+1)] [\(i)][\(j+2)]")
//            print("  [\(i+1)][\(j+1)]")
//            print("[\(i+2)][\(j)] [\(i+2)][\(j+1)] [\(i+2)][\(j+2)]")
            
//            print("\(arr[i][j]) \(arr[i][j+1]) \(arr[i][j+2])")
//            print("  \(arr[i+1][j+1])")
//            print("\(arr[i+2][j]) \(arr[i+2][j+1]) \(arr[i+2][j+2])")
            
//            print("---- \(sum)")
            if sum > totalSum {
                totalSum = sum
            }
        }
    }
    return totalSum
}
```
```swift
let TwoD = [[1,1,1,0,0,0],
            [0,1,0,0,0,0],
            [1,1,1,0,0,0],
            [0,0,2,4,4,0],
            [0,0,0,2,0,0],
            [0,0,1,2,4,0]
            ]
let another2D = [[-9,-9,-9,1,1,1],
    [0,-9,0,4,3,2],
    [-9,-9,-9,1,2,3],
    [0,0,8,6,6,0],
    [0,0,0,-2,0,0],
    [0,0,1,2,4,0]]
let DDD = [
    [1,1,1,0,0,0],
    [0,1,0,0,0,0],
    [1,1,1,0,0,0],
    [0,0,0,0,0,0],
    [0,0,0,0,0,0],
    [0,0,0,0,0,0]]

print("Max HourGlass Sum: \(hourglassSum(arr: DDD))")
```
### Binary Search
```swift
/// Precondition input array should be sorrted
func binarySearch<U: Comparable>(_ arr: [U], element: U) -> Int? {
    var low = 0
    var high = arr.count - 1
    while low <= high {
        let mid = (low + high) / 2
        if arr[mid] == element {
            return mid
        }
        if arr[mid] > element {
            high = mid - 1
        }else {
            low = mid + 1
        }
    }
    return nil
}
```
### Counted Alphabets
```swift
func countedAlphabets(_ text: String) -> [Character : Int] {
    var countedAlphabets : [Character : Int] =
        ["a" : 0, "b" : 0, "c" : 0, "d" : 0, "e" : 0,
         "f" : 0, "g" : 0, "h" : 0, "i" : 0, "j" : 0,
         "k" : 0, "l" : 0, "m" : 0, "n" : 0, "o" : 0,
         "p" : 0, "q" : 0, "r" : 0, "s" : 0, "t" : 0,
         "u" : 0, "v" : 0, "w" : 0, "x" : 0, "y" : 0,
         "z" : 0]
    
    for char in text.lowercased() {
        if countedAlphabets.keys.contains(where: { $0 == char }) {
            countedAlphabets[char] = countedAlphabets[char]! + 1
        }
    }
    return countedAlphabets
}
```
```swift
print(countedAlphabets("My name is nagesh aa"))
```
> Alternate
```swift
var countedAlphabets = NSCountedSet.init(object:"")
for char in "my name is nagesh" {
    countedAlphabets.add(char)
}
print(countedAlphabets)
```

