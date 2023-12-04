from dataclasses import dataclass
from typing import Set
import os


# --- Day 2: Cube Conundrum ---
class CubeConundrum:
    @dataclass
    class Game:
        id: int
        red: int = 0
        green: int = 0
        blue: int = 0

        def __hash__(self) -> int:
            return hash(self.id)

    def __init__(self: "CubeConundrum", path: str) -> None:
        self.games: Set[CubeConundrum.Game] = set()
        rel_path = os.path.join(os.path.dirname(__file__), path)
        file = open(rel_path, "r")
        self.lines = file.readlines()
        file.close()

    def parse_games(self) -> "CubeConundrum":
        for line in self.lines:
            game, sets = line.split(":")
            game_id = int(game.split(" ")[1])
            game = CubeConundrum.Game(game_id)
            for set in sets.split(";"):
                for count in set.split(","):
                    num, color = count.split()
                    setattr(game, color, max(int(num), getattr(game, color)))
            self.games.add(game)
        return self

    def valid_gaems(self, red: int = 12, green: int = 13, blue: int = 14):
        id_sum = 0
        power_sum = 0
        for game in self.games:
            if not (game.red > red or game.green > green or game.blue > blue):
                id_sum += game.id
            power_sum += game.red * game.green * game.blue
        return id_sum, power_sum


print(CubeConundrum("./input.txt").parse_games().valid_gaems())
