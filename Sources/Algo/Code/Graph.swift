final class Graph<VT: Hashable, ET> {
    let vertices: [VT]

    private let indices: [VT: Int]
    private var edges: [[ET?]]

    init(vertices: [VT]) {
        self.vertices = vertices
        indices = vertices.enumerated().reduce(into: [:], { $0[$1.1] = $1.0 })
        edges = vertices.map({ _ in Array<ET?>(repeating: nil, count: vertices.count) })
    }

    @discardableResult
    func add(edge: ET, from v1: VT, to v2: VT, backToo: Bool) -> Bool {
        guard let i1 = indices[v1], let i2 = indices[v2] else {
            return false
        }

        edges[i1][i2] = edge

        if backToo {
            edges[i2][i1] = edge
        }

        return true
    }

    private func neighbors(of vertex: VT) -> [VT] {
        guard let index = indices[vertex] else {
            return []
        }

        return edges[index].enumerated().compactMap { (index, edge) -> VT? in
            return edge != nil ? vertices[index] : nil
        }
    }

    // MARK: - iterative breadth first search

    func bfs(from startVertex: VT) -> [VT] {
        let queue = Queue<VT>()
        var enqueued: Set<VT> = []

        let enqueue: (VT) -> Void = {
            if enqueued.insert($0).inserted {
                queue.enqueue($0)
            }
        }

        enqueue(startVertex)

        var visited: [VT] = []

        while let vertex = queue.dequeue() {
            visited.append(vertex)

            neighbors(of: vertex).forEach(enqueue)
        }

        return visited
    }

    // MARK: - recursive breadth first search

    func bfsr(from startVertex: VT) -> [VT] {
        var visited: Set<VT> = [startVertex]
        var result: [VT] = [startVertex]

        bfsr(from: startVertex, visited: &visited, result: &result)

        return result
    }

    private func bfsr(from vertex: VT, visited: inout Set<VT>, result: inout [VT]) {
        var vs: [VT] = []

        neighbors(of: vertex).forEach {
            guard visited.insert($0).inserted else {
                return
            }

            result.append($0)

            vs.append($0)
        }

        vs.forEach {
            bfsr(from: $0, visited: &visited, result: &result)
        }
    }

    // MARK: - iterative depth first search

    func dfs(from startVertex: VT) -> [VT] {
        let stack = Stack<VT>()
        stack.push(startVertex)
        var pushed: Set<VT> = [startVertex]

        var visited: [VT] = [startVertex]

        outer: while let vertex = stack.peek() {
            for v in neighbors(of: vertex) {
                guard pushed.insert(v).inserted else {
                    continue
                }

                visited.append(v)

                stack.push(v)

                continue outer
            }

            stack.pop()
        }

        return visited
    }

    // MARK: - recursive depth first search

    func dfsr(from startVertex: VT) -> [VT] {
        var pushed: Set<VT> = [startVertex]

        var visited: [VT] = [startVertex]

        dfsr(from: startVertex, pushed: &pushed, visited: &visited)

        return visited
    }

    private func dfsr(from vertex: VT, pushed: inout Set<VT>, visited: inout [VT]) {
        neighbors(of: vertex).forEach {
            guard pushed.insert($0).inserted else {
                return
            }

            visited.append($0)

            dfsr(from: $0, pushed: &pushed, visited: &visited)
        }
    }

    // MARK: - detect cycles

    func hasCycle(from startVertex: VT) -> Bool {
        let stack = Stack<VT>()
        stack.push(startVertex)
        var pushed: Set<VT> = [startVertex]

        outer: while let vertex = stack.pop() {
            for v in neighbors(of: vertex) {
                guard pushed.insert(v).inserted else {
                    return true
                }

                stack.push(v)

                continue outer
            }
        }
        
        return false
    }
}

extension Graph where ET: Numeric {
    func totalSum(undirected: Bool) -> ET {
        var sum: ET = 0

        let range = vertices.indices

        range.forEach { i in
            range.forEach({ j in
                if undirected && j >= i {
                    return
                }

                guard let edge = edges[i][j] else {
                    return
                }

                sum += edge
            })
        }

        return sum
    }
}

extension Graph where ET: UnsignedInteger {
    func dijkstra(from startVertex: VT, maxDistance: ET) -> [VT: [VT]] {
        guard let startIndex = indices[startVertex] else {
            return [:]
        }

        var distances: [Int: ET] = [:]
        var paths: [Int: [VT]] = [:]

        paths[startIndex] = [startVertex]

        var vertexIndices = Set(vertices.indices)

        var currentIndex: Int? = startIndex

        while let vertexIndex = currentIndex {
            vertexIndices.remove(vertexIndex)

            for (index, edge) in edges[vertexIndex].enumerated() {
                guard let edge = edge, vertexIndices.contains(index) else {
                    continue
                }

                let newDistance = (distances[vertexIndex] ?? 0) + edge
                let currentDistance = distances[index] ?? maxDistance

                if newDistance < currentDistance {
                    distances[index] = newDistance
                    paths[index] = (paths[vertexIndex] ?? []) + [vertices[index]]
                }
            }

            currentIndex = vertexIndices.min(by: {
                distances[$0] ?? maxDistance < distances[$1] ?? maxDistance
            })
        }

        return paths.reduce(into: [VT: [VT]]()) {
            $0[vertices[$1.key]] = $1.value
        }
    }

    func prim(from startVertex: VT, maxDistance: ET) -> Graph<VT, ET>? {
        guard let startIndex = indices[startVertex] else {
            return nil
        }

        let newGraph = Graph(vertices: vertices)

        do {
            var visited: Set<Int> = [startIndex]

            while true {
                var min: (ET, Int, Int)?

                visited.forEach { i in
                    edges[i].enumerated().forEach({ (j, edge) in
                        guard let edge = edge else {
                            return
                        }

                        if edge < min?.0 ?? maxDistance, !visited.contains(j) {
                            min = (edge, i, j)
                        }
                    })
                }

                if let m = min {
                    newGraph.add(edge: m.0, from: vertices[m.1], to: vertices[m.2], backToo: true)

                    visited.insert(m.2)
                } else {
                    break
                }
            }
        }

        return newGraph
    }
}

extension Graph: CustomStringConvertible where VT: CustomStringConvertible, ET: CustomStringConvertible {
    var description: String {
        var maxLength: Int = 0
        var vertexStrings: [String] = []
        var edgeStrings: [[String]] = []

        vertices.forEach {
            let string = $0.description

            if string.count > maxLength {
                maxLength = string.count
            }

            vertexStrings.append(string)
        }

        edges.forEach { row in
            var strings: [String] = []

            row.forEach { edge in
                let string = edge.flatMap({ $0.description }) ?? "-"

                if string.count > maxLength {
                    maxLength = string.count
                }

                strings.append(string)
            }

            edgeStrings.append(strings)
        }

        var result = ""

        let append = { (string: String) in
            result.append(String(repeating: " ", count: maxLength - string.count + 2))
            result.append(string)
        }

        append("")

        vertexStrings.forEach(append)

        result.append("\n")

        vertexStrings.enumerated().forEach { (index, vertexString) in
            append(vertexString)

            edgeStrings[index].forEach({ edgeString in
                append(edgeString)
            })

            result.append("\n")
        }

        return result
    }
}
