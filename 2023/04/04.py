from dataclasses import dataclass
from functools import reduce
from typing import List, Optional
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
        self.parsed.append(set(winners.split()) & set(draws.split()))
    return self

  def score(self):
    score = 0
    for matches in self.parsed:
      if len(matches) == 0:
        continue
      score += 2 ** (len(matches) - 1)
    return score


# print(Scratchcards('./test_input.txt').parse_lines().score())
print(Scratchcards('./input.txt').parse_lines().score())
