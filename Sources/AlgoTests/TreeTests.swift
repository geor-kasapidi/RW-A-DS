import XCTest

class TreeTests: XCTestCase {
    func testDepthFirstForEach() {
        let tree = makeBeverageTree()

        var array: [String] = []

        tree.forEachDepthFirst { node in
            array.append(node.value)
        }

        XCTAssert(array == ["Beverages",
                            "hot",
                            "tea",
                            "black",
                            "green",
                            "chai",
                            "coffee",
                            "cocoa",
                            "cold",
                            "soda",
                            "ginger ale",
                            "bitter lemon",
                            "milk"])
    }

    func testLevelOrderForEach() {
        let tree = makeBeverageTree()

        var array: [String] = []

        tree.forEachLevelOrder { (node, _) -> Bool in
            array.append(node.value)

            return true
        }

        XCTAssert(array == ["Beverages",
                            "hot",
                            "cold",
                            "tea",
                            "coffee",
                            "cocoa",
                            "soda",
                            "milk",
                            "black",
                            "green",
                            "chai",
                            "ginger ale",
                            "bitter lemon"])
    }

    func testSearch() {
        let tree = makeBeverageTree()

        XCTAssert(tree.contains("chai"))
        XCTAssert(!tree.contains("ipa"))
    }

    func testLevelOrderForEach2() {
        let tree = TreeNode(15)
            .add(node: TreeNode(1)
                .add(node: TreeNode(1))
                .add(node: TreeNode(5))
                .add(node: TreeNode(0)))
            .add(node: TreeNode(17)
                .add(node: TreeNode(2)))
            .add(node: TreeNode(20)
                .add(node: TreeNode(5))
                .add(node: TreeNode(7)))

        var result: String = ""
        var currentLevel: Int = 0

        tree.forEachLevelOrder { (node, level) -> Bool in
            if level != currentLevel {
                currentLevel += 1

                result += "\n"
            }

            result.append("\(node.value) ")

            return true
        }

        XCTAssert(result == "15 \n1 17 20 \n1 5 0 2 5 7 ")
    }

    // MARK: -

    private func makeBeverageTree() -> TreeNode<String> {
        let tree = TreeNode("Beverages")
        let hot = TreeNode("hot")
        let cold = TreeNode("cold")
        let tea = TreeNode("tea")
        let coffee = TreeNode("coffee")
        let chocolate = TreeNode("cocoa")
        let blackTea = TreeNode("black")
        let greenTea = TreeNode("green")
        let chaiTea = TreeNode("chai")
        let soda = TreeNode("soda")
        let milk = TreeNode("milk")
        let gingerAle = TreeNode("ginger ale")
        let bitterLemon = TreeNode("bitter lemon")
        tree.add(node: hot)
        tree.add(node: cold)
        hot.add(node: tea)
        hot.add(node: coffee)
        hot.add(node: chocolate)
        cold.add(node: soda)
        cold.add(node: milk)
        tea.add(node: blackTea)
        tea.add(node: greenTea)
        tea.add(node: chaiTea)
        soda.add(node: gingerAle)
        soda.add(node: bitterLemon)

        return tree
    }
}
