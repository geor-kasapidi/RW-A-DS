extension Collection {
    var midIndex: Index {
        return index(startIndex, offsetBy: distance(from: startIndex, to: endIndex)/2)
    }
}

extension Collection where Element: Comparable {
    func mergeSorted() -> [Element] {
        return MergeSort.sort(self)
    }
}

final class MergeSort {
    private init() {}

    static func sort<CollectionType: Collection>(_ collection: CollectionType) -> [CollectionType.Element] where CollectionType.Element: Comparable {
        guard collection.count > 1 else {
            return Array(collection)
        }

        let mid = collection.midIndex

        let left = sort(collection[..<mid])
        let right = sort(collection[mid...])

        return merge(left, right)
    }

    static func merge<CollectionType: Collection>(_ left: CollectionType, _ right: CollectionType) -> [CollectionType.Element] where CollectionType.Element: Comparable {
        var result: [CollectionType.Element] = []

        var leftIndex: CollectionType.Index = left.startIndex
        var rightIndex: CollectionType.Index = right.startIndex

        while true {
            var leftElement: CollectionType.Element?
            var rightElement: CollectionType.Element?

            if leftIndex < left.endIndex {
                leftElement = left[leftIndex]
            }

            if rightIndex < right.endIndex {
                rightElement = right[rightIndex]
            }

            if let x = leftElement, let y = rightElement {
                if x <= y {
                    result.append(x)

                    leftIndex = left.index(after: leftIndex)
                }

                if y <= x {
                    result.append(y)

                    rightIndex = right.index(after: rightIndex)
                }
            } else if let x = leftElement {
                result.append(x)

                leftIndex = left.index(after: leftIndex)
            } else if let y = rightElement {
                result.append(y)

                rightIndex = right.index(after: rightIndex)
            } else {
                break
            }
        }

        return result
    }
}
