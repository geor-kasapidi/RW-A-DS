import XCTest

class GraphDFSTests: XCTestCase {
    func test1() {
        let graph = Graph<String, Bool>(vertices: ["A", "B", "C", "D", "E", "F", "G", "H"])

        graph.add(edge: true, from: "A", to: "B", backToo: true)
        graph.add(edge: true, from: "A", to: "C", backToo: true)
        graph.add(edge: true, from: "A", to: "D", backToo: true)
        graph.add(edge: true, from: "E", to: "B", backToo: true)
        graph.add(edge: true, from: "E", to: "H", backToo: true)
        graph.add(edge: true, from: "E", to: "F", backToo: true)
        graph.add(edge: true, from: "F", to: "C", backToo: true)
        graph.add(edge: true, from: "F", to: "G", backToo: true)
        graph.add(edge: true, from: "C", to: "G", backToo: true)

        XCTAssert(graph.dfs(from: "A") == ["A", "B", "E", "F", "C", "G", "H", "D"])
    }

    func test2() {
        let graph = Graph<String, Bool>(vertices: ["A", "B", "C", "D", "E", "F", "G", "H"])

        graph.add(edge: true, from: "A", to: "B", backToo: true)
        graph.add(edge: true, from: "A", to: "C", backToo: true)
        graph.add(edge: true, from: "A", to: "D", backToo: true)
        graph.add(edge: true, from: "E", to: "B", backToo: true)
        graph.add(edge: true, from: "E", to: "H", backToo: true)
        graph.add(edge: true, from: "E", to: "F", backToo: true)
        graph.add(edge: true, from: "F", to: "C", backToo: true)
        graph.add(edge: true, from: "F", to: "G", backToo: true)
        graph.add(edge: true, from: "C", to: "G", backToo: true)

        XCTAssert(graph.dfs(from: "A") == graph.dfsr(from: "A"))
    }

    func test3() {
        let graph = Graph<String, Bool>(vertices: ["A", "B", "C", "D", "E"])

        graph.add(edge: true, from: "A", to: "B", backToo: false)
        graph.add(edge: true, from: "B", to: "C", backToo: false)
        graph.add(edge: true, from: "A", to: "D", backToo: false)
        graph.add(edge: true, from: "D", to: "C", backToo: false)
        graph.add(edge: true, from: "C", to: "E", backToo: false)

        XCTAssert(!graph.hasCycle(from: "D"))

        graph.add(edge: true, from: "E", to: "C", backToo: false)

        XCTAssert(graph.hasCycle(from: "D"))
    }
}
