from dataclasses import dataclass
from functools import reduce
from typing import List, Optional
import os

# --- Day 3: Gear Ratios ---
class GearRatios:

  def __init__(self, path: str) -> None:
    rel_path = os.path.join(os.path.dirname(__file__), path)
    file = open(rel_path, 'r')
    self.lines = file.readlines()
    for i, line in enumerate(self.lines):
      self.lines[i] = '.' + line[:-1] + '.'
    self.lines.append('.' * len(self.lines[0]))
    self.lines.insert(0, '.' * len(self.lines[0]))
    self.line_len = len(self.lines[0])
    file.close()

  def number_at_coord(self, x: int, y: int) -> Optional[int]:
    if not self.lines[y][x].isdigit():
      return None
    else:
      start = x
      for i in range(x, 0, -1):
        if self.lines[y][i].isdigit():
          start = i
        else:
          break
      end = x
      for i in range(x, self.line_len):
        if self.lines[y][i].isdigit():
          end = i
        else:
          break
    return int(self.lines[y][start:end+1])

  def gear_ratios(self) -> int:
    sum = 0
    for y, line in enumerate(self.lines):
      for x, char in enumerate(line):
        if char == '*':
          part_numbers = [self.number_at_coord(x - 1, y), self.number_at_coord(x + 1, y)]
          top = self.number_at_coord(x, y - 1)
          bottom = self.number_at_coord(x, y + 1)
          if top:
            part_numbers.append(top)
          else:
            part_numbers.append(self.number_at_coord(x - 1, y - 1))
            part_numbers.append(self.number_at_coord(x + 1, y - 1))
          if bottom:
            part_numbers.append(bottom)
          else:
            part_numbers.append(self.number_at_coord(x - 1, y + 1))
            part_numbers.append(self.number_at_coord(x + 1, y + 1))
          valid_part_numbers: List[int] = [a for a in part_numbers if a is not None]
          if len(valid_part_numbers) == 2:
            sum += reduce(lambda x, y: x*y, valid_part_numbers)
    return sum


print(GearRatios('./test_input.txt').gear_ratios())
print(GearRatios('./input.txt').gear_ratios())
