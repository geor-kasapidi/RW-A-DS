import XCTest

class BinaryTreeTests: XCTestCase {
    func testInOrderTraverse() {
        let tree = makeTestTree()

        var array: [Int] = []

        tree.traverseInOrder { value in
            array.append(value)

            return true
        }

        XCTAssert(array == [0,1,5,7,8,9])
    }

    func testPreOrderTraverse() {
        let tree = makeTestTree()

        var array: [Int] = []

        tree.traversePreOrder { value in
            array.append(value)

            return true
        }

        XCTAssert(array == [7,1,0,5,9,8])
    }

    func testPostOrderTraverse() {
        let tree = makeTestTree()

        var array: [Int] = []

        tree.traversePostOrder { value in
            array.append(value)

            return true
        }

        XCTAssert(array == [0,5,1,8,9,7])
    }

    func testSerizalization() {
        let tree1 = makeTestTree()

        let tree2 = try! BinaryTreeNode<Int>.decode(jsonData: tree1.jsonData)

        XCTAssert(tree1 == tree2)
    }

    func testHeight1() {
        let tree = makeTestTree()

        XCTAssert(tree.height == 2)
    }

    func testHeight2() {
        let x1 = BinaryTreeNode(0)
        let x2 = BinaryTreeNode(1)
        let x3 = BinaryTreeNode(2)
        let x4 = BinaryTreeNode(3)
        let x5 = BinaryTreeNode(4)
        let x6 = BinaryTreeNode(5)

        x5.left = x4
        x5.right = x6

        x4.left = x1
        x4.right = x2
        x2.right = x3

        XCTAssert(x5.height == 3)
        XCTAssert(x6.height == 0)
        XCTAssert(x4.height == 2)
        XCTAssert(x1.height == 0)
        XCTAssert(x2.height == 1)
        XCTAssert(x3.height == 0)
    }

    // MARK: -

    private func makeTestTree() -> BinaryTreeNode<Int> {
        let zero = BinaryTreeNode(0)
        let one = BinaryTreeNode(1)
        let five = BinaryTreeNode(5)
        let seven = BinaryTreeNode(7)
        let eight = BinaryTreeNode(8)
        let nine = BinaryTreeNode(9)
        seven.left = one
        one.left = zero
        one.right = five
        seven.right = nine
        nine.left = eight
        return seven
    }

    func testRotate() {
        let x1 = BinaryTreeNode(1)
        let x2 = BinaryTreeNode(2)
        let x3 = BinaryTreeNode(3)
        let x4 = BinaryTreeNode(4)
        let x5 = BinaryTreeNode(5)
        let x6 = BinaryTreeNode(6)
        let x7 = BinaryTreeNode(7)

        x4.left = x2
        x4.right = x6

        x2.left = x1
        x2.right = x3

        x6.left = x5
        x6.right = x7

        debugPrint(x4)

        do {
            var result: [Int] = []

            x4.traverseInOrder {
                result.append($0)

                return true
            }

            XCTAssert(result == [1,2,3,4,5,6,7])
        }

        x4.rotate()

        debugPrint(x4)

        do {
            var result: [Int] = []

            x4.traverseInOrder {
                result.append($0)

                return true
            }

            XCTAssert(result == [7,6,5,4,3,2,1])
        }
    }
}
