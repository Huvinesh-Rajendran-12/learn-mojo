from gridv1 import Grid

def run_display(var grid: Grid) -> None:
    while True:
        print(String(grid))
        if input("Enter 'q' to quit or just press Enter to continue") == "q":
            break
        grid = grid.evolve()


def main():
    grid_v0 = Grid.random(32, 32)
    run_display(grid_v0^)
