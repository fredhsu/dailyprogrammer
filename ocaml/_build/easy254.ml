open Core.Std
open Printf
      
let n = 10
let pairs = [(3,6);(0,4);(7,3);(9,9)]
let rec create_switches n =
    if n <= 0 then [] else false :: create_switches(n-1) 
let rec create_run start finish n =
    if n <= 0 then [] else
        if start > finish then create_run finish start n
        else if start > 0 then
            false :: create_run (start-1) (finish-1) (n-1)
        else if finish >= 0 then
            true :: create_run (start-1) (finish-1) (n-1)
        else
            false :: create_run start finish (n-1)
        
let rec toggle start finish switches =
    if start > finish then toggle finish start switches
    else List.map

let () =
    let sw = create_run 3 6 10 in
    List.iter ~f:(printf "%b ") sw
