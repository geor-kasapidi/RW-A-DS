private final class Node<T> {
    let value: T

    init(_ value: T) {
        self.value = value
    }

    var next: Node<T>? {
        didSet {
            next?.prev = self
        }
    }

    weak var prev: Node<T>?
}

extension Node {
    var length: Int {
        var cursor = self
        var counter = 0

        while let next = cursor.next {
            cursor = next
            counter += 1
        }

        return counter + 1
    }

    func node(at position: Int) -> Node<T> {
        var cursor = self
        var counter = 0

        while let next = cursor.next, counter < position {
            cursor = next
            counter += 1
        }

        return cursor
    }

    func makeCopy() -> Node<T> {
        let head = Node(value)
        var tail = head

        var cursor = self

        while let next = cursor.next {
            let node = Node(next.value)

            tail.next = node
            tail = node

            cursor = next
        }

        return head
    }

    func reversed() -> Node<T> {
        var cursor = self

        while let next = cursor.next {
            cursor = next
        }

        let head = Node(cursor.value)
        var tail = head

        while let prev = cursor.prev {
            let node = Node(prev.value)

            tail.next = node
            tail = node

            cursor = prev
        }

        return head
    }
}

extension Node where T: Comparable {
    func removedAll(_ value: T) -> Node<T>? {
        var cursor: Node<T>? = self

        while cursor?.value == value {
            cursor = cursor?.next
        }

        guard let head = cursor.flatMap({ Node($0.value) }) else {
            return nil
        }

        var tail = head

        while let next = cursor?.next {
            if next.value != value {
                let node = Node(next.value)

                tail.next = node
                tail = node
            }

            cursor = next
        }

        return head
    }

    private func sortedInsert(_ newValue: T) -> Node<T> {
        let node = Node(newValue)

        if newValue < value {
            node.next = self

            return node
        }

        var cursor = self

        while let next = cursor.next {
            if newValue < next.value {
                cursor.next = node

                node.next = next

                return self
            }

            cursor = next
        }

        cursor.next = node

        return self
    }

    func sortedMergeWith(other: Node<T>) -> Node<T> {
        var head = makeCopy()

        head = head.sortedInsert(other.value)

        var cursor = other

        while let next = cursor.next {
            head = head.sortedInsert(next.value)

            cursor = next
        }

        return head
    }
}

struct LinkedList<T> {
    private var head: Node<T>?

    //  MARK: -

    mutating func insert(_ value: T, at index: Int) {
        makeCopyIfNeeded()

        let newNode = Node(value)

        guard index > 0, let prevNode = head?.node(at: index - 1) else {
            newNode.next = head
            head = newNode

            return
        }

        newNode.next = prevNode.next
        prevNode.next = newNode
    }

    @discardableResult
    mutating func remove(at index: Int) -> T? {
        makeCopyIfNeeded()

        guard index > 0, let node = head?.node(at: index), node !== head else {
            defer { head = head?.next }

            return head?.value
        }

        defer { node.prev?.next = node.next }

        return node.value
    }

    // MARK: -

    mutating func push(_ value: T) {
        insert(value, at: 0)
    }

    @discardableResult
    mutating func pop() -> T? {
        return remove(at: 0)
    }

    mutating func append(_ value: T) {
        insert(value, at: Int.max)
    }

    @discardableResult
    mutating func removeLast() -> T? {
        return remove(at: Int.max)
    }

    // MARK: -

    func reversed() -> LinkedList<T> {
        var list = LinkedList<T>()

        list.head = head?.reversed()

        return list
    }

    var length: Int {
        return head?.length ?? 0
    }

    // MARK: -

    private mutating func makeCopyIfNeeded() {
        guard !isKnownUniquelyReferenced(&head) else { return }

        head = head?.makeCopy()
    }
}

extension LinkedList where T: Comparable {
    mutating func removeAll(_ value: T) {
        head = head?.removedAll(value)
    }

    func sortedMergeWith(list other: LinkedList<T>) -> LinkedList<T> {
        var list = LinkedList<T>()

        if let head1 = head, let head2 = other.head {
            list.head = head1.sortedMergeWith(other: head2)
        } else if let head1 = head {
            list.head = head1.makeCopy()
        } else if let head2 = other.head {
            list.head = head2.makeCopy()
        }

        return list
    }
}

extension LinkedList {
    func toArray() -> [T] {
        guard let head = head else { return [] }

        var array = [head.value]

        var currentNode = head

        while let nextNode = currentNode.next {
            array.append(nextNode.value)

            currentNode = nextNode
        }

        return array
    }
}
