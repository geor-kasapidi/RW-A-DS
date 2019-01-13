import XCTest

class BSTTests: XCTestCase {
    func testInsert() {
        let bst = BST<Int>()

        XCTAssert(bst.toArray() == [])

        bst.insert(1)
        bst.insert(0)

        debugPrint(bst)

        XCTAssert(bst.toArray() == [0, 1])

        bst.insert(2)

        debugPrint(bst)

        XCTAssert(bst.toArray() == [0, 1, 2])

        bst.insert(10)
        bst.insert(-10)

        debugPrint(bst)

        XCTAssert(bst.toArray() == [-10, 0, 1, 2, 10])
    }

    func testContains() {
        let bst = BST<Int>()

        bst.insert(1)
        bst.insert(2)
        bst.insert(3)

        XCTAssert(bst.contains(1))
        XCTAssert(bst.contains(2))
        XCTAssert(bst.contains(3))
        XCTAssert(!bst.contains(4))
    }

    func testInsert2() {
        let bst = BST<Int>()

        let testValues = [10, 17, 12, 25, 50, 37, 32, 27, 33, 45, 75, 63, 87]

        testValues.forEach(bst.insert)

        XCTAssert(testValues.sorted() == bst.toArray())
    }

    func testRemove() {
        let bst = BST<Int>()

        let testValues = [10, 17, 12, 25, 50, 37, 32, 27, 33, 45, 75, 63, 87]

        testValues.forEach(bst.insert)

        let removeElement: (Int) -> Void = { value in
            XCTAssert(bst.contains(value))
            bst.remove(value)
            debugPrint(bst)
            XCTAssert(!bst.contains(value))
        }

        removeElement(25)
        removeElement(27)
        removeElement(10)
        removeElement(37)
    }

    func testRawBST() {
        do {
            let x1 = BinaryTreeNode(0)
            let x2 = BinaryTreeNode(1)
            let x3 = BinaryTreeNode(2)
            let x4 = BinaryTreeNode(3)
            let x5 = BinaryTreeNode(4)
            let x6 = BinaryTreeNode(5)
            let x7 = BinaryTreeNode(6)

            x4.left = x2
            x4.right = x6

            x2.right = x3
            x2.left = x1

            x6.left = x5
            x6.right = x7

            XCTAssert(x4.isBST)
        }

        do {
            let x1 = BinaryTreeNode(0)
            let x2 = BinaryTreeNode(1)
            let x3 = BinaryTreeNode(2)
            let x4 = BinaryTreeNode(3)
            let x5 = BinaryTreeNode(0)
            let x6 = BinaryTreeNode(5)
            let x7 = BinaryTreeNode(6)

            x4.left = x2
            x4.right = x6

            x2.right = x3
            x2.left = x1

            x6.left = x5
            x6.right = x7

            XCTAssert(!x4.isBST)
        }
    }

    func testContainsAllFrom() {
        do {
            let bst1 = BST<Int>()
            bst1.insert(1)
            bst1.insert(2)
            bst1.insert(3)

            let bst2 = BST<Int>()
            bst2.insert(1)
            bst2.insert(2)
            bst2.insert(3)

            XCTAssert(bst1.containsAllFrom(otherBST: bst2))
        }

        do {
            let bst1 = BST<Int>()
            bst1.insert(2)
            bst1.insert(3)
            bst1.insert(4)

            let bst2 = BST<Int>()
            bst2.insert(1)
            bst2.insert(2)
            bst2.insert(3)
            bst2.insert(4)

            XCTAssert(!bst1.containsAllFrom(otherBST: bst2))
        }
    }
}
