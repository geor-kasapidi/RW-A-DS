final class Heap<Element: Equatable> {
    private(set) var elements: [Element] = []
    
    private let sort: (Element, Element) -> Bool

    init(elements: [Element] = [], sort: @escaping (Element, Element) -> Bool) {
        self.elements = elements
        self.sort = sort

        if !elements.isEmpty {
            for i in stride(from: elements.count/2 - 1, through: 0, by: -1) {
                siftDown(from: i)
            }
        }
    }

    // MARK: -

    var isEmpty: Bool {
        return elements.isEmpty
    }

    var count: Int {
        return elements.count
    }

    func peek() -> Element? {
        return elements.first
    }

    func leftChildIndex(ofParentIndex index: Int) -> Int {
        return 2 * index + 1
    }

    func rightChildIndex(ofParentIndex index: Int) -> Int {
        return 2 * index + 2
    }

    func parentIndex(ofChildAt index: Int) -> Int {
        return (index - 1) / 2
    }

    // MARK: -

    func insert(_ value: Element) {
        elements.append(value)

        siftUp(from: count - 1)
    }

    func remove() -> Element? {
        return remove(at: 0)
    }

    func remove(at index: Int) -> Element? {
        guard index < count else {
            return nil
        }

        if index == count - 1 {
            return elements.removeLast()
        }

        elements.swapAt(index, count - 1)

        defer {
            siftDown(from: index)
            siftUp(from: index)
        }

        return elements.removeLast()
    }

    func indexOf(element: Element) -> Int? {
        guard !isEmpty else {
            return nil
        }

        return indexOf(element: element, startingAt: 0)
    }

    // MARK: -

    func toBinaryTree() -> BinaryTreeNode<Element>? {
        return makeBinaryTreeNode(at: 0)
    }

    private func makeBinaryTreeNode(at index: Int) -> BinaryTreeNode<Element>? {
        guard index < count else {
            return nil
        }

        let node = BinaryTreeNode(elements[index])
        node.left = makeBinaryTreeNode(at: leftChildIndex(ofParentIndex: index))
        node.right = makeBinaryTreeNode(at: rightChildIndex(ofParentIndex: index))

        return node
    }

    // MARK: -

    func merge(with heap: Heap<Element>) {
        heap.elements.forEach(insert)
    }

    // MARK: -

    private func siftDown(from index: Int) {
        var parent = index

        while true {
            let left = leftChildIndex(ofParentIndex: parent)
            let right = rightChildIndex(ofParentIndex: parent)

            var candidate = parent

            if left < count && sort(elements[left], elements[candidate]) {
                candidate = left
            }

            if right < count && sort(elements[right], elements[candidate]) {
                candidate = right
            }

            if candidate == parent {
                return
            }

            elements.swapAt(parent, candidate)

            parent = candidate
        }
    }

    private func siftUp(from index: Int) {
        var child = index

        while child > 0 {
            let parent = parentIndex(ofChildAt: child)

            if !sort(elements[child], elements[parent]) {
                return
            }

            elements.swapAt(child, parent)

            child = parent
        }
    }

    private func indexOf(element: Element, startingAt i: Int) -> Int? {
        if sort(element, elements[i]) {
            return nil
        }

        if element == elements[i] {
            return i
        }

        return indexOf(element: element, startingAt: leftChildIndex(ofParentIndex: i)) ?? indexOf(element: element, startingAt: rightChildIndex(ofParentIndex: i))
    }
}
