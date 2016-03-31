open Core.Std
open Printf
open Csv

(*let years = List.range 1732 2016 
 * List.map ~f:(fun x -> Printf.sprintf "%d-01-01" x) years
let prez = Csv.load "presidents.csv"
Date.of_string("2016-03-07")
Date.between date start stop
["Richard Nixon"; "Jan 9 1913"; "Yorba Linda Cal."; "Apr 22 1994";
"New York New York"]
String.split ~on:' ' "18 Jan 2101";;
Printf.sprintf "%02d" 3
*)

let pad_day s = 
    Printf.sprintf "%02d" (int_of_string(s));;

let parse_date (date:string) = 
    let parts = String.split ~on:' ' date in
    match parts with
    | "Jan"::d::y::_ -> String.concat ~sep:"-" [y;"01";(pad_day d)]
    | "Feb"::d::y::_ -> String.concat ~sep:"-" [y;"02";(pad_day d)]
    | "Mar"::d::y::_ -> String.concat ~sep:"-" [y;"03";(pad_day d)]
    | "Apr"::d::y::_ -> String.concat ~sep:"-" [y;"04";(pad_day d)]
    | "May"::d::y::_ -> String.concat ~sep:"-" [y;"05";(pad_day d)]
    | "June"::d::y::_ -> String.concat ~sep:"-" [y;"06";(pad_day d)]
    | "July"::d::y::_ -> String.concat ~sep:"-" [y;"07";(pad_day d)]
    | "Aug"::d::y::_ -> String.concat ~sep:"-" [y;"08";(pad_day d)]
    | "Sep"::d::y::_ -> String.concat ~sep:"-" [y;"09";(pad_day d)]
    | "Oct"::d::y::_ -> String.concat ~sep:"-" [y;"10";(pad_day d)]
    | "Nov"::d::y::_ -> String.concat ~sep:"-" [y;"11";(pad_day d)]
    | "Dec"::d::y::_ -> String.concat ~sep:"-" [y;"12";(pad_day d)]
    | _ -> "2016-03-20"


let get_dates lst = 
    match lst with
    | _::birth::_::death::_ -> ((Date.of_string (parse_date
    birth)),(Date.of_string (parse_date death)))
    | _ -> (Date.today(), Date.today())

let alive year pres = Date.between year ~low:(fst(pres))
~high:(snd(pres))

let years = 
    List.range 1732 2017
    |> List.map ~f:(fun x -> Date.of_string(Printf.sprintf "%d-01-01" x))

let presidents = Csv.load "presidents.csv"
let testyear = Date.of_string("1990-01-01")
let run = 
    let dates = List.map ~f:(get_dates) presidents in
    List.map ~f:(fun x -> 
        (List.map ~f:(alive x) dates) |> List.filter ~f:(fun x -> x) |>
        List.length) years
let final =
    let o = List.zip run years in
    match o with
    |Some x -> List.sort ~cmp:(fun x y -> fst(y) - fst(x)) x
    (*List.map ~f:(alive testyear) dates
    |> List.filter ~f:(fun x -> x)
    |> List.length*)
    (*let prez = Csv.load "presidents.csv"*)
