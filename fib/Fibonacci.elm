module Fibonacci exposing(..)

import String exposing (toInt)
import List exposing (take, sum, reverse)

strToInt : String -> Int
strToInt str =
  case toInt str of
    Ok int ->
      int
    Err e ->
      0

parseInt : Maybe Int -> Int
parseInt num =
  case num of
    Just (n) -> n
    _ -> 0

-- can also be represented as (List.take 2 >> List.sum) <list>
sumOfFirst2 : List Int -> Int
sumOfFirst2 list =
  list
  |> List.take 2
  |> List.sum

fib : Int -> Int
fib target =
  let
    fibonacci target acc =
      if target < 2 then
        acc
      else
        fibonacci (target - 1) <| sumOfFirst2 acc :: acc
  in fibonacci target [1,0]
    |> List.head
    |> parseInt
