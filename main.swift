/*
Knight's Tour On A Chessboard
You are given a chessboard with rows rows and cols columns and a knight - that moves like in normal chess - located at the start_row-th row and start_col-th column. The knight needs to reach the position at the end_row-th row and end_col-th column.

Find minimum number of moves that knight needs to make to get from starting position to ending position.

start_row, start_col, end_row and end_col are all zero-indexed.

Example
{
"rows": 5,
"cols": 5,
"start_row": 0,
"start_col": 0,
"end_row": 4,
"end_col": 1
}
Output:

3
3 moves to reach from (0, 0) to (4, 1):
(0, 0) → (1, 2) → (3, 3) → (4, 1).

Notes
If it is not possible to reach from starting position to ending position, then return -1.
Constraints:

1 <= rows * cols <= 105
0 <= start_row, end_row < rows
0 <= start_col, end_col < cols
*/

func find_minimum_number_of_moves(rows: Int, cols: Int, start_row: Int, start_col: Int, end_row: Int, end_col: Int) -> Int {
    var visited: [[Bool]] = Array(repeating: Array(repeating: false, count: cols), count: rows)
    var queue: [[Int]] = []
    queue.append([start_row, start_col])
    visited[start_row][start_col] = true
    
    func getNeighbor(_ root: [Int]) -> [[Int]] {
        var neighbors: [[Int]] = []
        let rowAdd = [2, 2, 1, -1, -2, -2, -1, 1]
        let colAdd = [-1, 1, 2, 2, 1, -1, -2, -2]
        
        for i in 0..<8 {
            let row = root[0] + rowAdd[i]
            let col = root[1] + colAdd[i]
            
            if row < 0 || row > rows - 1 || col < 0 || col > cols - 1 {
                continue
            }
            neighbors.append([row, col])
        }
        return neighbors
    }
    
    var level = 0
    
    while queue.count > 0 {
        let count = queue.count - 1
        
        for _ in 0...count {
            let root = queue.removeFirst()
            
            if (root[0], root[1]) == (end_row, end_col) {
                return level
            }
            
            for n in getNeighbor(root) {
                let row = n[0], col = n[1]
                if !visited[row][col] {
                    visited[row][col] = true
                    queue.append(n)
                }
            }
        }
        level += 1
    }
    return -1
}
