import Text.Printf

k = [('1', (0,0)), ('2', (0,1)),('3', (0,2)),('4', (1,0)),('5', (1,1)),('6', (1,2)),('7', (2,0)),('8', (2,1)),('9', (2,2)),('.', (3,0)),('0', (3,1))]

input = "219.45.143.143"

coord x = case x of Just x -> x
                    Nothing -> (0,0)

getx x = fst (coord (lookup x k))

gety y = snd (coord (lookup y k))

side p1 p2 fn = (fn p1 - fn p2)^2

dist p1 p2 = sqrt(side p1 p2 getx + side p1 p2 gety)

calc (x:y:xs) = dist x y + calc (y:xs)
calc _ = 0

result input = printf "%.2fcm\n" (calc input)
