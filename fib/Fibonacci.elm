module Fibonacci exposing(..)

import String

toInt : String -> Int
toInt str =
  case String.toInt str of
    Ok int ->
      int
    Err e ->
      0 

fib : Int -> Int
fib target =
  case target of
    0 -> 0
    1 -> 1
    _ ->
      fib (target - 1) + fib (target - 2)
