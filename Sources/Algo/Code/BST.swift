class BST<T: Comparable>: Equatable {
    static func == (lhs: BST<T>, rhs: BST<T>) -> Bool {
        return lhs.root == rhs.root
    }

    fileprivate var root: BinaryTreeNode<T>?

    // MARK: -

    func insert(_ value: T) {
        root = insert(value, in: root)
    }

    func remove(_ value: T) {
        root = remove(value, in: root)
    }

    func contains(_ value: T) -> Bool {
        var cursor = root

        while let node = cursor {
            if node.value == value {
                return true
            }

            cursor = value < node.value ? node.left : node.right
        }

        return false
    }

    // MARK: -

    private func insert(_ value: T, in node: BinaryTreeNode<T>?) -> BinaryTreeNode<T> {
        guard let node = node else {
            return BinaryTreeNode(value)
        }

        if value < node.value {
            node.left = insert(value, in: node.left)
        } else {
            node.right = insert(value, in: node.right)
        }

        return check(node: node)
    }

    private func remove(_ value: T, in node: BinaryTreeNode<T>?) -> BinaryTreeNode<T>? {
        guard let node = node else {
            return nil
        }

        if value == node.value {
            if node.left == nil && node.right == nil { return nil }
            if node.left == nil { return node.right }
            if node.right == nil { return node.left }

            node.value = node.right!.minValue

            node.right = remove(value, in: node.right)
        } else if value < node.value {
            node.left = remove(value, in: node.left)
        } else if value > node.value {
            node.right = remove(value, in: node.right)
        }

        return check(node: node)
    }

    // MARK: -

    func check(node: BinaryTreeNode<T>) -> BinaryTreeNode<T> {
        return node
    }
}

extension BST {
    @discardableResult
    func traverse(visit: (T) -> Bool) -> Bool {
        return root?.traverseInOrder(visit: visit) ?? false
    }

    func toArray() -> [T] {
        var result: [T] = []

        traverse {
            result.append($0)

            return true
        }

        return result
    }
}

extension BST {
    func containsAllFrom(otherBST bst: BST<T>) -> Bool {
        return bst.traverse {
            return contains($0)
        }
    }
}

extension BST: CustomDebugStringConvertible where T: Codable {
    var debugDescription: String {
        return root?.debugDescription ?? "Empty BST"
    }
}
