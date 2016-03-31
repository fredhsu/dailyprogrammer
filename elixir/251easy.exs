defmodule Easy do
  def read_file(filename) do
    input_file = File.open!(filename, [:read, :utf8])
    read_lines(input_file, [], [])
  end

  def read_lines(input_file, lines, columns) do
    row = IO.read(input_file, :line)
    if (row != :eof) do
      read_lines(input_file, [row | lines], columns)
    else
      Enum.reverse(lines)
    end
  end

  def get_rows(lines) do
    Enum.map(lines, &(String.split(&1)))
  end

  def to_cols(line) do
    Enum.map(line, &([&1]))
  end

  def join_cols([], []) do
    []
  end
  def join_cols([x|xs], [y|ys]) do
    [x ++ y | join_cols(xs, ys)]
  end

  def cols(rows) do
    Enum.map(rows, &to_cols(&1))
    |> Enum.reduce(fn(x, acc) -> Easy.join_cols(acc, x) end)
    |> Enum.map(&(Enum.reverse(&1)))
  end

  def to_num(line) do
    String.codepoints(line)
    |> Enum.drop(-1)
    |> Enum.map(&count_star(&1))
  end

  def count_star("*") do
    1
  end
  def count_star(_) do
    0
  end

  def get_counts(line) do
    Enum.chunk_by(line, &(&1 == 1))
    |> Enum.map(&Enum.sum(&1))
    |> Enum.filter(&(&1 > 0))
  end
  def printcols(cols) do
    max = Enum.count(Enum.max_by(cols, &Enum.count(&1)))
    Enum.map(cols, &Enum.reverse(&1))
    |> Enum.map(&pad(&1, max))
    |> printcol([])
  end
  def printcol([], new) do
    IO.write("\n")
    printcol(Enum.reverse(new), [])
  end
  def printcol([[]|_], new) do
    IO.write("\n" )
  end
  def printcol([[hd|tail]|rest], new) do
    if hd == 0 do
      IO.write "   "
    else
      String.rjust(to_string(hd), 3)
      |> IO.write
    end
    printcol(rest, [tail | new])
  end


  def printrows(rows) do
    max = Enum.count(Enum.max_by(rows, &Enum.count(&1)))
    Enum.map(rows, &pad(&1, max))
    |> Enum.map(&line_to_string(&1))
    |> Enum.each(&IO.puts(&1))
  end

  def line_to_string([]) do
    ""
  end

  def line_to_string([x]) do
    to_string(x)
  end
  def line_to_string([hd|tail]) do
    if hd == 0 do
      " " <> line_to_string(tail)
    else
      to_string(hd) <> line_to_string(tail)
    end
  end
  def pad(line, max) when length(line) >= max do
    line
  end
  def pad(line, max) when length(line) < max do
    pad([0|line], max)
  end

  def run() do
    x = Easy.read_file("test3.txt")
    get_rows(x)
    rows = Enum.map(x, &to_num(&1))
    IO.puts "Rows:"
    Enum.map(rows, &get_counts(&1))
    |> printrows()
    |> IO.inspect
    IO.puts "Columns:"
    cols = cols(rows)
    Enum.map(cols, &get_counts(&1))
    |> printcols()
    #|> Enum.each(&IO.puts(&1))
    |> IO.inspect
  end
end
