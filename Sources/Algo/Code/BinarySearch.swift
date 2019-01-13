public extension RandomAccessCollection where Element: Comparable {
    func binarySearchIndex(of value: Element, in range: Range<Index>? = nil) -> Index? {
        let range = range ?? startIndex..<endIndex

        guard range.lowerBound < range.upperBound else {
            return nil
        }

        let size = distance(from: range.lowerBound, to: range.upperBound)
        let middle = index(range.lowerBound, offsetBy: size/2)

        if self[middle] == value {
            return middle
        } else if self[middle] > value {
            return binarySearchIndex(of: value, in: range.lowerBound..<middle)
        } else {
            return binarySearchIndex(of: value, in: index(after: middle)..<range.upperBound)
        }
    }

    func binarySearchIndices(of value: Element) -> Range<Index>? {
        guard let idx = binarySearchIndex(of: value) else {
            return nil
        }

        var lowerIndex = idx
        var upperIndex = idx

        while true {
            let next = index(after: upperIndex)
            let prev = index(before: lowerIndex)

            if next < endIndex && self[next] == value {
                upperIndex = next
            }

            if prev >= startIndex && self[prev] == value {
                lowerIndex = prev
            }

            if upperIndex != next && lowerIndex != prev {
                break
            }
        }

        return lowerIndex..<index(after: upperIndex)
    }
}
