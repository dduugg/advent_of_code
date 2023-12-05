from dataclasses import dataclass
from typing import Set
import os

# --- Day 3: Gear Ratios ---
class GearRatios:

  def __init__(self, path: str) -> None:
    rel_path = os.path.join(os.path.dirname(__file__), path)
    file = open(rel_path, 'r')
    self.lines = file.readlines()
    self.line_len = len(self.lines[0])
    file.close()

  def parse_lines(self):
    part_sum = 0
    for line_num, line in enumerate(self.lines):
      num = -1
      start_coord = -1
      for i, char in enumerate(line):
        if char.isnumeric():
          if num == -1:
            num = int(char)
            start_coord = i
          else:
            num = num * 10 + int(char)
        else:
          if num != -1 and self.is_part_num(line_num, start_coord, i):
            part_sum += num
          num = -1
          start_coord = -1
        if i == len(line) - 1 and num != -1 and self.is_part_num(line_num, start_coord, i):
          part_sum += num
    return part_sum

  def is_symbol(self, x: int, y: int) -> bool:
    if y < 0 or y >= len(self.lines) or x < 0 or x >= self.line_len:
      return False
    char = self.lines[y][x]
    return char != '.' and not char.isnumeric() and char != '\n'

  def is_part_num(self, line_num: int, start_coord: int, end_coord: int) -> bool:
    for i in range(start_coord-1, end_coord + 1):
      if self.is_symbol(i, line_num - 1):
        return True
    for i in range(start_coord-1, end_coord + 1):
      if self.is_symbol(i, line_num + 1):
        return True
    if self.is_symbol(start_coord - 1, line_num):
      return True
    if self.is_symbol(end_coord, line_num):
      return True
    return False
# print(GearRatios('./test_input.txt').parse_lines())
print(GearRatios('./input.txt').parse_lines())
