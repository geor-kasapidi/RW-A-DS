final class HeapBasedPriorityQueue<T: Equatable> {
    private let heap: Heap<T>

    init(sort: @escaping (T, T) -> Bool) {
        heap = Heap(sort: sort)
    }

    // MARK: -

    var isEmpty: Bool {
        return heap.isEmpty
    }

    var peek: T? {
        return heap.peek()
    }

    func enqueue(_ element: T) {
        heap.insert(element)
    }

    func dequeue() -> T? {
        return heap.remove()
    }
}

final class ArrayBasedPriorityQueue<T: Equatable> {
    private var array: [T] = []

    private let sort: (T, T) -> Bool

    init(sort: @escaping (T, T) -> Bool) {
        self.sort = sort
    }

    // MARK: -

    var isEmpty: Bool {
        return array.isEmpty
    }

    var peek: T? {
        return array.last
    }

    func enqueue(_ element: T) {
        array.append(element)

        var i = array.count - 1

        while i > 0 && sort(array[i - 1], array[i]) {
            array.swapAt(i - 1, i)

            i -= 1
        }
    }

    func dequeue() -> T? {
        guard !array.isEmpty else {
            return nil
        }
        
        return array.removeLast()
    }
}
