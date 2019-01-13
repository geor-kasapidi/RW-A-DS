final class TreeNode<T> {
    let value: T

    init(_ value: T) {
        self.value = value
    }

    private(set) var children: [TreeNode<T>] = []

    @discardableResult
    func add(node: TreeNode<T>) -> Self {
        children.append(node)

        return self
    }

    // MARK: -

    func forEachDepthFirst(visit: (TreeNode<T>) -> Void) {
        visit(self)

        children.forEach {
            $0.forEachDepthFirst(visit: visit)
        }
    }

    func forEachLevelOrder(visit: (TreeNode<T>, Int) -> Bool) {
        let queue = Queue<(TreeNode<T>, Int)>()

        queue.enqueue((self, 0))

        while let element = queue.dequeue() {
            if !visit(element.0, element.1) {
                return
            }

            element.0.children.forEach { node in
                queue.enqueue((node, element.1 + 1))
            }
        }
    }
}

extension TreeNode where T: Equatable {
    func contains(_ value: T) -> Bool {
        var result = false

        forEachLevelOrder { (node, _) -> Bool in
            if node.value == value {
                result = true

                return false
            }

            return true
        }

        return result
    }
}
