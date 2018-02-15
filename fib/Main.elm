import Html exposing (text)
import List
import Tuple

cache : List (Int, Int)
cache = []

inCache : Int -> Bool
inCache num =
  List.unzip cache
  |> Tuple.first
  |> List.member num

toInt : Maybe Int -> Int
toInt num =
  case num of
    Nothing -> 0
    Just num -> num

getValue : Int -> Int
getValue num =
  List.filter (\(key, val) -> key == num) cache
  |> List.head
  |> Maybe.map Tuple.second
  |> toInt

save : (Int, Int) -> List (Int, Int)
save (key, val) = (key, val) :: cache

fib : Int -> Int
fib num =
  case num of
    0 -> 1
    1 -> 1
    _ ->
      if inCache num then
        getValue num
      else
        save (num, fib (num - 1) + fib (num - 2))
        |> List.head
        |> Maybe.map Tuple.second
        |> toInt

main =
  fib 40
  |> toString
  |> text
