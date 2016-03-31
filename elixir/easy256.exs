defmodule Easy do
input = [[0,1,2,3,4,5],[6,7,8,9,10,11],[12,13,14,15,16,17],[18,19,20,21,22,23],[24,25,26,27,28,29],[30,31,32,33,34,35]]

# Do a map/reduce.. build up the rows
# x = current row
# y = previous row
def merge([x|xs], 0, []) do
  IO.puts "No more previous"
  [[x]]
end
def merge([], index, acc) do
  IO.puts "No more currnet"
  acc
end
def merge([x|xs], 0, [y|ys]) do
  [[y,x] | merge(xs, 0, ys)]
end
# Advance previous row to the index
def merge(list, index, [y|ys]) do
  merge(list, index - 1, ys)
end

def row([], _, acc) do
  acc
end
def row([hd|tail], 0, [acchd|acctail]) do
  [acchd ++ [hd] | row(tail, 0, acctail)]
end
def row([hd|tail], 0, []) do
  [hd]
end 

def row(list, index, [acchd|acctail]) do
  row(list, index - 1, acctail)
end

def printrow([x|xs], index) do
  printrow(xs, x, index)
end

def printrow([x|xs], [], _) do
  printrow(xs, x, length(xs) - 1)
end
def printrow(_, _, index) when index < 0 do
  IO.puts ""
end
def printrow([x|xs], [hd|tail], 0) do
  IO.puts hd
  printrow(xs, x, length(xs) - length(tail))
end
def printrow(matrix, [hd|tail], index) do
  IO.write hd
  printrow(matrix, tail, index - 1)
end

end
