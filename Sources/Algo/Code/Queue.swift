final class Queue<T> {
    private final class Node {
        let value: T

        init(_ value: T) {
            self.value = value
        }

        var next: Node?
        var prev: Node?
    }

    // MARK: -

    private var head: Node?
    private var tail: Node?

    func enqueue(_ value: T) {
        let node = Node(value)

        if tail == nil {
            tail = node
            head = tail
        } else {
            node.next = tail
            tail?.prev = node
            tail = node
        }
    }

    @discardableResult
    func dequeue() -> T? {
        defer {
            if head === tail {
                head = nil
                tail = nil
            } else {
                head?.prev?.next = nil
                head = head?.prev
            }
        }

        return head?.value
    }

    var peek: T? {
        return head?.value
    }

    var isEmpty: Bool {
        return head == nil
    }

    func reversed() -> Queue<T> {
        let queue = Queue<T>()

        guard let tail = tail else { return queue }

        queue.enqueue(tail.value)

        var currentNode = tail

        while let nextNode = currentNode.next {
            queue.enqueue(nextNode.value)

            currentNode = nextNode
        }

        return queue
    }
}

extension Queue {
    func toArray() -> [T] {
        guard let tail = tail else { return [] }

        var array = [tail.value]

        var currentNode = tail

        while let nextNode = currentNode.next {
            array.append(nextNode.value)

            currentNode = nextNode
        }

        return array
    }
}
