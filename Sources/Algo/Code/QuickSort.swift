import Foundation

final class QuickSort {
    static func naive<T: Comparable>(_ a: [T]) -> [T] {
        guard a.count > 1 else {
            return a
        }

        let pivot = a[a.count/2]

        var less: [T] = []
        var equal: [T] = []
        var greater: [T] = []

        a.forEach {
            if $0 < pivot {
                less.append($0)
            } else if $0 > pivot {
                greater.append($0)
            } else {
                equal.append($0)
            }
        }

        return naive(less) + equal + naive(greater)
    }

    // MARK: - lomuto

    static func lomuto<T: Comparable>(_ a: inout [T]) {
        lomuto(&a, low: 0, high: a.count - 1)
    }

    private static func lomuto<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
        guard low < high else {
            return
        }

        let pivot = a[high]

        var i = low

        for j in low..<high {
            if a[j] <= pivot {
                a.swapAt(i, j)

                i += 1
            }
        }

        a.swapAt(i, high)

        lomuto(&a, low: low, high: i - 1)
        lomuto(&a, low: i + 1, high: high)
    }

    // MARK: - hoare

    static func hoare<T: Comparable>(_ a: inout [T]) {
        hoare(&a, low: 0, high: a.count - 1)
    }

    private static func hoare<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
        guard low < high else {
            return
        }

        let pivot = a[low]

        var i = low - 1
        var j = high + 1

        while true {
            repeat { i += 1 } while a[i] < pivot
            repeat { j -= 1 } while a[j] > pivot

            if i < j {
                a.swapAt(i, j)
            } else {
                break
            }
        }

        hoare(&a, low: low, high: j)
        hoare(&a, low: j + 1, high: high)
    }

    // MARK: - hoare iteratively

    static func hoareIteratively<T: Comparable>(_ a: inout [T]) {
        let stack = Stack<(Int, Int)>()

        stack.push((0, a.count - 1))

        while let (low, high) = stack.pop() {
            guard low < high else {
                continue
            }

            let pivot = a[low]

            var i = low - 1
            var j = high + 1

            while true {
                repeat { i += 1 } while a[i] < pivot
                repeat { j -= 1 } while a[j] > pivot

                if i < j {
                    a.swapAt(i, j)
                } else {
                    break
                }
            }

            stack.push((j + 1, high))
            stack.push((low, j))
        }
    }

    // MARK: - median of 3

    static func lomuto3median<T: Comparable>(_ a: inout [T]) {
        let low = 0
        let high = a.count - 1
        let mid = (low + high) / 2

        if a[low] > a[mid] {
            a.swapAt(low, mid)
        }

        if a[low] > a[high] {
            a.swapAt(low, high)
        }

        if a[mid] > a[high] {
            a.swapAt(mid, high)
        }

        a.swapAt(mid, high)

        lomuto(&a, low: low, high: high)
    }

    // MARK: - dutch flag

    static func dutchFlag<T: Comparable>(_ a: inout [T]) {
        dutchFlag(&a, low: 0, high: a.count - 1)
    }

    private static func dutchFlag<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
        guard low < high else {
            return
        }

        let pivot = a[high]

        var less = low
        var equal = low
        var greater = high

        while equal <= greater {
            if a[equal] < pivot {
                a.swapAt(less, equal)
                less += 1
                equal += 1
            } else if a[equal] == pivot {
                equal += 1
            } else {
                a.swapAt(equal, greater)
                greater -= 1
            }
        }

        dutchFlag(&a, low: low, high: less - 1)
        dutchFlag(&a, low: greater, high: high)
    }
}
