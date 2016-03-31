open Core.Std
      
let n = 10
let pairs = [(3,6);(0,4);(7,3);(9,9)]
let rec create_switches list =
    match list with
    | [] -> []
    | hd :: tl -> 0 :: create_switches tl

let () =
    printf "%D" (list.length(create_switches(pairs)))
