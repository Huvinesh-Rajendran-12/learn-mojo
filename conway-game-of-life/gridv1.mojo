import random

@fieldwise_init
struct Grid(Copyable, Movable, Stringable):
    var rows: Int
    var cols: Int
    var data: List[List[Int]]

    fn __str__(self) -> String:
        str = String()
        for row in range(self.rows):
            for col in range(self.cols):
                if self[row, col] == 1:
                    str += "*"
                else:
                    str += " "
            str += "\n"
        return str

    fn __getitem__(self, row: Int, col: Int) -> Int:
        return self.data[row][col]

    fn __setitem__(mut self, row: Int, col: Int, value: Int) -> None:
        self.data[row][col] = value

    @staticmethod
    fn random(rows: Int, cols: Int) -> Self:
        random.seed()

        var data: List[List[Int]] = []
        for _ in range(rows):
            data.append([Int(random.random_si64(0, 1)) for _ in range(cols)])

        return Self(rows, cols, data^)

    fn evolve(self) -> Self:
        var next_generation: List[List[Int]] = []
        for row in range(self.rows):
            row_data = List[Int]()
            row_above = (row - 1) % self.rows
            row_below = (row + 1) % self.rows

            for col in range(self.cols):
                col_left = (col - 1) % self.cols
                col_right = (col + 1) % self.cols
                num_neighbors = (
                    self[row_above, col_left] +
                    self[row_above, col] +
                    self[row_above, col_right] +
                    self[row, col_left] +
                    self[row, col_right] +
                    self[row_below, col_left] +
                    self[row_below, col] +
                    self[row_below, col_right]
                )
                if self[row, col] == 1:
                    if neighbors < 2 or neighbors > 3:
                        next_generation[row][col] = 0
                    else:
                        next_generation[row][col] = 1
                else:
                    if neighbors == 3:
                        next_generation[row][col] = 1
        return Self(self.rows, self.cols, next_generation^)
