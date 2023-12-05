from typing import List
import os
import re

# --- Day 4: Scratchcards ---
class Scratchcards:
  CARD_REGEX = re.compile(r':([\d\s]+)\|([\d\s]+)')

  def __init__(self, path: str) -> None:
    rel_path = os.path.join(os.path.dirname(__file__), path)
    file = open(rel_path, 'r')
    self.lines = file.readlines()
    file.close()

  def parse_lines(self):
    self.parsed = []
    for line in self.lines:
      search_result = self.CARD_REGEX.search(line)
      if search_result:
        winners, draws = search_result.groups()
        self.parsed.append(len(set(winners.split()) & set(draws.split())))
    return self

  def calc_copies(self) -> int:
    self.num_copies: List[int] = [1] * len(self.parsed)
    for i, matches in enumerate(self.parsed):
      for j in range(1, matches + 1):
        self.num_copies[i + j] += self.num_copies[i]
    return sum(self.num_copies)

  def score(self):
    score = 0
    for matches in self.parsed:
      if matches == 0:
        continue
      score += 2 ** (matches - 1)
    return score


print(Scratchcards('./test_input.txt').parse_lines().score())
print(Scratchcards('./input.txt').parse_lines().score())

print(Scratchcards('./test_input.txt').parse_lines().calc_copies())
print(Scratchcards('./input.txt').parse_lines().calc_copies())
