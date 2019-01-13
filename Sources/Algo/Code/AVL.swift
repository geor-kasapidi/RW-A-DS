final class AVL<T: Comparable>: BST<T> {
    override func check(node: BinaryTreeNode<T>) -> BinaryTreeNode<T> {
        return balanced(node: node)
    }

    // MARK: -

    private func balanced(node: BinaryTreeNode<T>) -> BinaryTreeNode<T> {
        switch node.balanceFactor {
        case 2:
            if let left = node.left, left.balanceFactor == -1 {
                return leftRightRotate(node: node)
            } else {
                return rightRotate(node: node)
            }
        case -2:
            if let right = node.right, right.balanceFactor == 1 {
                return rightLeftRotate(node: node)
            } else {
                return leftRotate(node: node)
            }
        default:
            return node
        }
    }

    private func leftRotate(node: BinaryTreeNode<T>) -> BinaryTreeNode<T> {
        let pivot = node.right!
        node.right = pivot.left
        pivot.left = node
        return pivot
    }

    private func rightRotate(node: BinaryTreeNode<T>) -> BinaryTreeNode<T> {
        let pivot = node.left!
        node.left = pivot.right
        pivot.right = node
        return pivot
    }

    private func rightLeftRotate(node: BinaryTreeNode<T>) -> BinaryTreeNode<T> {
        guard let right = node.right else {
            return node
        }

        node.right = rightRotate(node: right)

        return leftRotate(node: node)
    }

    private func leftRightRotate(node: BinaryTreeNode<T>) -> BinaryTreeNode<T> {
        guard let left = node.left else {
            return node
        }

        node.left = leftRotate(node: left)

        return rightRotate(node: node)
    }
}
