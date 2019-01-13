import XCTest

class GraphBFSTests: XCTestCase {
    func test1() {
        let graph = Graph<String, Bool>(vertices: ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"])

        graph.add(edge: true, from: "A", to: "B", backToo: true)
        graph.add(edge: true, from: "A", to: "C", backToo: true)
        graph.add(edge: true, from: "A", to: "D", backToo: true)
        graph.add(edge: true, from: "I", to: "C", backToo: true)
        graph.add(edge: true, from: "I", to: "D", backToo: true)
        graph.add(edge: true, from: "I", to: "F", backToo: true)
        graph.add(edge: true, from: "I", to: "G", backToo: true)
        graph.add(edge: true, from: "I", to: "J", backToo: true)
        graph.add(edge: true, from: "F", to: "E", backToo: true)
        graph.add(edge: true, from: "F", to: "G", backToo: true)
        graph.add(edge: true, from: "E", to: "H", backToo: true)

        print(graph.description)

        XCTAssert(graph.bfs(from: "A") == ["A", "B", "C", "D", "I", "F", "G", "J", "E", "H"])

        XCTAssert(graph.vertices.map({ graph.bfs(from: $0).count }).max()! == graph.vertices.count)
    }

    func test2() {
        let graph = Graph<String, Bool>(vertices: ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"])

        graph.add(edge: true, from: "A", to: "B", backToo: true)
        graph.add(edge: true, from: "A", to: "C", backToo: true)
        graph.add(edge: true, from: "A", to: "D", backToo: true)
        graph.add(edge: true, from: "I", to: "C", backToo: true)
        graph.add(edge: true, from: "I", to: "D", backToo: true)
        graph.add(edge: true, from: "I", to: "F", backToo: true)
        graph.add(edge: true, from: "I", to: "G", backToo: true)
        graph.add(edge: true, from: "I", to: "J", backToo: true)
        graph.add(edge: true, from: "F", to: "E", backToo: true)
        graph.add(edge: true, from: "F", to: "G", backToo: true)
        graph.add(edge: true, from: "E", to: "H", backToo: true)

        print(graph.description)

        XCTAssert(graph.bfsr(from: "A") == ["A", "B", "C", "D", "I", "F", "G", "J", "E", "H"])

        XCTAssert(graph.vertices.map({ graph.bfs(from: $0).count }).max()! == graph.vertices.count)
    }

    func test3() {
        let graph = Graph<String, Bool>(vertices: ["A", "B", "C", "D", "E", "F", "G", "H"])

        graph.add(edge: true, from: "A", to: "B", backToo: true)
        graph.add(edge: true, from: "A", to: "C", backToo: true)
        graph.add(edge: true, from: "A", to: "D", backToo: true)
        graph.add(edge: true, from: "E", to: "F", backToo: true)
        graph.add(edge: true, from: "E", to: "H", backToo: true)
        graph.add(edge: true, from: "F", to: "G", backToo: true)

        print(graph.description)

        XCTAssert(graph.bfs(from: "A") == ["A", "B", "C", "D"])

        XCTAssert(graph.vertices.map({ graph.bfs(from: $0).count }).max()! != graph.vertices.count)
    }

    func test4() {
        let graph = Graph<String, Bool>(vertices: ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"])

        graph.add(edge: true, from: "A", to: "B", backToo: true)
        graph.add(edge: true, from: "A", to: "C", backToo: true)
        graph.add(edge: true, from: "A", to: "D", backToo: true)
        graph.add(edge: true, from: "I", to: "C", backToo: true)
        graph.add(edge: true, from: "I", to: "D", backToo: true)
        graph.add(edge: true, from: "I", to: "F", backToo: true)
        graph.add(edge: true, from: "I", to: "G", backToo: true)
        graph.add(edge: true, from: "I", to: "J", backToo: true)
        graph.add(edge: true, from: "F", to: "E", backToo: true)
        graph.add(edge: true, from: "F", to: "G", backToo: true)
        graph.add(edge: true, from: "E", to: "H", backToo: true)

        XCTAssert(graph.bfs(from: "A") == graph.bfsr(from: "A"))
    }
}
