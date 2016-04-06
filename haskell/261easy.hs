import           Data.List
import           Data.List.Split

first = [8, 1, 6, 3, 5, 7, 4, 9, 2]
second = [2, 7, 6, 9, 5, 1, 4, 3, 8]
third = [3, 5, 7, 8, 1, 6, 4, 9, 2]
fourth = [8, 1, 6, 7, 5, 3, 4, 9, 2]

rows x = chunksOf (rowLen x) x
sumrows x = map sum (rows x)
cols x = transpose (rows x)
sumcols x = map sum (cols x)

diag1 x = zipWith (!!) (rows x) [0..]
diag2 x = zipWith (!!) (rows x) [(i - 1),(i - 2)..0]
    where i = rowLen x

sumdiags x = [sum (diag1 x), sum (diag2 x)]

sumall x = map sum (rows x ++ cols x ++ [diag1 x] ++ [diag2 x])

run xs = all (\x -> x == (head s)) s where s = sumall xs

rowLen :: [a] -> Int
rowLen x = round(sqrt(fromIntegral(length(x))))
