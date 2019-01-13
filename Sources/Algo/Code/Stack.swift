final class Stack<T> {
    private final class Node {
        let value: T

        init(_ value: T) {
            self.value = value
        }

        var prev: Node?
    }

    // MARK: -

    private var top: Node?

    func push(_ value: T) {
        let node = Node(value)

        node.prev = top

        top = node
    }

    @discardableResult
    func pop() -> T? {
        defer { top = top?.prev }

        return top?.value
    }

    func peek() -> T? {
        return top?.value
    }

    var isEmpty: Bool {
        return top == nil
    }
}

extension Stack {
    func toArray() -> [T] {
        guard let top = top else { return [] }

        var array = [top.value]

        var currentNode = top

        while let prevNode = currentNode.prev {
            array.append(prevNode.value)

            currentNode = prevNode
        }

        return array
    }
}
