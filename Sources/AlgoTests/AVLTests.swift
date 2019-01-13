import XCTest

class AVLTests: XCTestCase {
    func testBalanceFactor() {
        let x1 = BinaryTreeNode(50)
        let x2 = BinaryTreeNode(25)
        let x3 = BinaryTreeNode(75)
        let x4 = BinaryTreeNode(37)
        let x5 = BinaryTreeNode(40)

        x1.left = x2
        x1.right = x3
        x2.right = x4
        x4.right = x5

        XCTAssert(x1.balanceFactor == 2)
        XCTAssert(x2.balanceFactor == -2)
        XCTAssert(x3.balanceFactor == 0)
        XCTAssert(x4.balanceFactor == -1)
        XCTAssert(x5.balanceFactor == 0)
    }

    func testInsert() {
        let tree = AVL<Int>()

        (0..<15).forEach(tree.insert)

        debugPrint(tree)
    }

    func testRemove() {
        let tree = AVL<Int>()

        [15,10,16,18].forEach(tree.insert)

        debugPrint(tree)

        tree.remove(10)

        debugPrint(tree)
    }
}
