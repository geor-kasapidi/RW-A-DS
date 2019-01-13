extension MutableCollection {
    mutating func bubbleSort(_ inOrder: (Element, Element) -> Bool) {
        guard count > 1 else {
            return
        }

        for end in indices.reversed() {
            var isSorted = true

            var cursor = startIndex

            while cursor < end {
                let next = index(after: cursor)

                if !inOrder(self[cursor], self[next]) {
                    swapAt(cursor, next)

                    isSorted = false
                }

                cursor = next
            }

            if isSorted {
                return
            }
        }
    }
}

extension MutableCollection {
    mutating func selectionSort(_ inOrder: (Element, Element) -> Bool) {
        guard count > 1 else {
            return
        }

        for current in indices {
            var candidate = current

            var cursor = index(after: candidate)

            while cursor < endIndex {
                if !inOrder(self[candidate], self[cursor]) {
                    candidate = cursor
                }

                cursor = index(after: cursor)
            }

            if candidate != current {
                swapAt(candidate, current)
            }
        }
    }
}

extension MutableCollection where Self: BidirectionalCollection {
    mutating func insertionSort(_ inOrder: (Element, Element) -> Bool) {
        guard count > 1 else {
            return
        }

        for current in indices {
            var cursor = current

            while cursor > startIndex {
                let prev = index(before: cursor)

                if inOrder(self[prev], self[cursor]) {
                    break
                }

                swapAt(prev, cursor)

                cursor = prev
            }
        }
    }
}

extension MutableCollection where Self: BidirectionalCollection {
    mutating func customReverse() {
        guard count > 1 else {
            return
        }

        var left = startIndex
        var right = index(before: endIndex)

        while distance(from: left, to: right) > 0 {
            swapAt(left, right)

            left = index(after: left)
            right = index(before: right)
        }
    }
}

extension Array where Element == Int {
    mutating func radixSort() {
        guard count > 1 else {
            return
        }

        let n = self.count
        let base = 10
        var digits = 1

        while true {
            var buckets = Array<[Int]>(repeating: [], count: base)

            forEach { number in
                let digit = (number / digits) % base

                buckets[digit].append(number)
            }

            digits *= base

            self = buckets.flatMap { $0 }

            if buckets[0].count == n {
                break
            }
        }
    }
}

extension Array where Element: Equatable {
    func heapSorted(_ sort: @escaping (Element, Element) -> Bool) -> [Element] {
        let heap = Heap(elements: self, sort: sort)

        var result: [Element] = []

        while let element = heap.remove() {
            result.append(element)
        }

        return result
    }
}
