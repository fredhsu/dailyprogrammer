open Core.Std
open Printf
     
let list_to_pair lst =
    match lst with
    | fst::snd::[] -> (fst,snd)
    | _ -> (0,0)
(* Should look into doing this via stdin too *)
let r = In_channel.read_lines "test1.txt";;
(* For each line *)
String.split ~on:' ' "3 6";;
let p = List.map ~f:(int_of_string) (String.split ~on:' ' "3 6");;
list_to_pair(p)
(* Take the list of lines, grab n *)
(*
 * let n = List.hd(lines)
 * let pairs = List.tl(lines)
 *)
let n = 10
let pairs = [(3,6);(0,4);(7,3);(9,9)]
let n2 = 1000
let pairs2 = [(616,293);
(344,942);
(27,524);
(716,291);
(860,284);
(74,928);
(970,594);
(832,772);
(343,301);
(194,882);
(948,912);
(533,654);
(242,792);
(408,34);
(162,249);
(852,693);
(526,365);
(869,303);
(7,992);
(200,487);
(961,885);
(678,828);
(441,152);
(394,453);
]

let rec create_switches n =
    if n <= 0 then [] else false :: create_switches(n-1) 

let run_toggle switches pair =
    match pair with
    | (s, f) when s > f -> toggle s f switches
    | (s, f) -> toggle s f switches

let rec toggle start finish l =
        if start > finish then toggle finish start l 
        else match l with
        | [] -> []
        | hd :: tl when start > 0 -> hd :: toggle (start-1) (finish-1) tl
        | hd :: tl when finish >= 0 -> not hd :: toggle (start-1) (finish-1) tl
        | x -> x
        
let total s = 
    List.fold ~init:0 ~f:(fun l x -> if x then 1 + l else l) s

(* use run_toggle sequentially on a list *)
let s = create_switches n;;
total (List.fold ~init:s ~f:(run_toggle) pairs);;
let s2 = create_switches n2;;
total (List.fold ~init:s2 ~f:(run_toggle) pairs2);;
