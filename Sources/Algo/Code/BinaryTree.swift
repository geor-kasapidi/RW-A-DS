import Foundation

final class BinaryTreeNode<T> {
    var value: T

    init(_ value: T) {
        self.value = value
    }

    var left: BinaryTreeNode<T>?
    var right: BinaryTreeNode<T>?

    // MARK: -

    @discardableResult
    func traverseInOrder(visit: (T) -> Bool) -> Bool {
        var moveOn = true
        traverseInOrder(moveOn: &moveOn, visit: visit)
        return moveOn
    }

    private func traverseInOrder(moveOn: inout Bool, visit: (T) -> Bool) {
        if !moveOn { return }
        left?.traverseInOrder(moveOn: &moveOn, visit: visit)
        moveOn = visit(value)
        right?.traverseInOrder(moveOn: &moveOn, visit: visit)
    }

    // MARK: -

    @discardableResult
    func traversePreOrder(visit: (T) -> Bool) -> Bool {
        var moveOn = true
        traversePreOrder(moveOn: &moveOn, visit: visit)
        return moveOn
    }

    private func traversePreOrder(moveOn: inout Bool, visit: (T) -> Bool) {
        if !moveOn { return }
        moveOn = visit(value)
        left?.traversePreOrder(moveOn: &moveOn, visit: visit)
        right?.traversePreOrder(moveOn: &moveOn, visit: visit)
    }

    // MARK: -

    @discardableResult
    func traversePostOrder(visit: (T) -> Bool) -> Bool {
        var moveOn = true
        traversePostOrder(moveOn: &moveOn, visit: visit)
        return moveOn
    }

    private func traversePostOrder(moveOn: inout Bool, visit: (T) -> Bool) {
        if !moveOn { return }
        left?.traversePostOrder(moveOn: &moveOn, visit: visit)
        right?.traversePostOrder(moveOn: &moveOn, visit: visit)
        moveOn = visit(value)
    }

    // MARK: -

    func rotate() {
        rotate(node: self)
    }

    private func rotate(node: BinaryTreeNode<T>) {
        swap(&node.left, &node.right)

        node.left.flatMap(rotate)
        node.right.flatMap(rotate)
    }

    // MARK: -

    var balanceFactor: Int {
        return leftHeight - rightHeight
    }

    var height: Int {
        return max(leftHeight, rightHeight) + 1
    }

    var leftHeight: Int {
        return left?.height ?? -1
    }

    var rightHeight: Int {
        return right?.height ?? -1
    }

    // MARK: -

    var minValue: T {
        return left?.minValue ?? value
    }

    var maxValue: T {
        return right?.maxValue ?? value
    }
}

extension BinaryTreeNode: Equatable where T: Equatable {
    static func == (lhs: BinaryTreeNode<T>, rhs: BinaryTreeNode<T>) -> Bool {
        return lhs.value == rhs.value && lhs.left == rhs.left && lhs.right == rhs.right
    }
}

extension BinaryTreeNode: Codable, CustomDebugStringConvertible where T: Codable {
    static func decode(jsonData: Data) throws -> BinaryTreeNode<T> {
        return try JSONDecoder().decode(BinaryTreeNode<T>.self, from: jsonData)
    }

    var jsonData: Data {
        return try! JSONEncoder().encode(self)
    }

    var debugDescription: String {
        return String(data: jsonData, encoding: .utf8)!
    }
}

extension BinaryTreeNode where T: Comparable {
    var isBST: Bool {
        return checkBST(node: self, min: nil, max: nil)
    }

    private func checkBST(node: BinaryTreeNode<T>?, min: T?, max: T?) -> Bool {
        guard let node = node else {
            return true
        }

        if let min = min, node.value < min {
            return false
        }

        if let max = max, node.value >= max {
            return false
        }

        let checkLeft = checkBST(node: node.left, min: min, max: node.value)
        let checkRight = checkBST(node: node.right, min: node.value, max: max)

        return checkLeft && checkRight
    }
}
