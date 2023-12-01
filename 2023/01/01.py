
# --- Day 1: Trebuchet?! ---
class Trebuchet:

  def __init__(self: 'Trebuchet', path: str) -> None:
    file = open(path, 'r')
    self.lines = file.readlines()
    file.close()

  @staticmethod
  def calibration(line: str) -> int:
    first = -1
    last = -1
    for char in line:
      if char.isnumeric():
        if first == -1:
          first = int(char)
        last = int(char)
    return first * 10 + last

  def calibrations_sum(self) -> int:
    return sum(map(self.calibration, self.lines))


print(Trebuchet('./input.txt').calibrations_sum())

class Trebuchet2:

  def __init__(self: 'Trebuchet2', path: str) -> None:
    file = open(path, 'r')
    self.lines = file.readlines()
    file.close()

  @staticmethod
  def calibration(line: str) -> int:
    first = -1
    last = -1
    for i, char in enumerate(line):
      num = -1
      if char.isnumeric():
        num = int(char)
      else:
        substr = line[:i+1]
        if substr.endswith('zero'):
          num = 0
        elif substr.endswith('one'):
          num = 1
        elif substr.endswith('two'):
          num = 2
        elif substr.endswith('three'):
          num = 3
        elif substr.endswith('four'):
          num = 4
        elif substr.endswith('five'):
          num = 5
        elif substr.endswith('six'):
          num = 6
        elif substr.endswith('seven'):
          num = 7
        elif substr.endswith('eight'):
          num = 8
        elif substr.endswith('nine'):
          num = 9
      if num != -1:
        if first == -1:
          first = num
        last = num
    return first * 10 + last

  def calibrations_sum(self) -> int:
    return sum(map(self.calibration, self.lines))


print(Trebuchet2('./input.txt').calibrations_sum())
