private final class TrieNode<Key: Hashable> {
    var key: Key?
    weak var parent: TrieNode<Key>?
    var children: [Key: TrieNode<Key>] = [:]
    var isTerminating: Bool = false

    init(key: Key?, parent: TrieNode<Key>?) {
        self.key = key
        self.parent = parent
    }
}

final class Trie<CollectionType: RangeReplaceableCollection> where CollectionType.Element: Hashable {
    private typealias Node = TrieNode<CollectionType.Element>

    private let root = Node(key: nil, parent: nil)

    init() {}

    // MARK: -

    func insert(_ collection: CollectionType) {
        var current = root

        for element in collection {
            if current.children[element] == nil {
                current.children[element] = Node(key: element, parent: current)
            }

            current = current.children[element]!
        }

        if current.isTerminating {
            return
        }

        current.isTerminating = true

        count += 1
    }

    func contains(_ collection: CollectionType) -> Bool {
        var current = root

        for element in collection {
            guard let node = current.children[element] else {
                return false
            }

            current = node
        }

        return current.isTerminating
    }

    func remove(_ collection: CollectionType) {
        var current = root

        for element in collection {
            guard let node = current.children[element] else {
                return
            }

            current = node
        }

        guard current.isTerminating else {
            return
        }

        current.isTerminating = false

        while let parent = current.parent, current.children.isEmpty, !current.isTerminating {
            parent.children[current.key!] = nil

            current = parent
        }

        count -= 1
    }

    // MARK: -

    func collections(startingWith prefix: CollectionType) -> [CollectionType] {
        var current = root

        for element in prefix {
            guard let node = current.children[element] else {
                return []
            }

            current = node
        }

        return collections(withPrefix: prefix, after: current)
    }

    private func collections(withPrefix prefix: CollectionType, after root: Node) -> [CollectionType] {
        var result: [CollectionType] = []

        typealias Element = (node: Node, value: CollectionType)

        let queue = Queue<Element>()

        queue.enqueue((root, prefix))

        while let element = queue.dequeue() {
            if element.node.isTerminating {
                result.append(element.value)
            }

            element.node.children.values.forEach { node in
                var value = element.value
                value.append(node.key!)

                queue.enqueue((node, value))
            }
        }

        return result
    }

    // MARK: -

    var allCollections: [CollectionType] {
        return collections(withPrefix: CollectionType(), after: root)
    }

    private(set) var count: Int = 0

    var isEmpty: Bool {
        return count == 0
    }
}
