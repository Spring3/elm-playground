import Html exposing (div, input, text)
import Html.Attributes exposing (placeholder, type_)
import Html.Events exposing (onInput, onClick)
import List
import Tuple
import Debug
import String

toInt : Maybe Int -> Int
toInt num =
  case num of
    Just num -> num
    _ -> 0

getValue : Int -> List (Int, Int) -> Maybe Int
getValue num cache =
  List.filter (\(key, value) -> key == num) cache
  |> List.head
  |> Maybe.map Tuple.second


fib : Int -> Model -> Int
fib num model =
  case num of
    0 -> 0
    1 -> 1
    _ ->
      let
        fetchedValue = getValue num model.cache
        value = case fetchedValue of
          Nothing ->
            (num, (fib ((num - 1) model) + fib ((num - 2) model)))::model.cache
            |> List.head
            |> Maybe.map Tuple.second
            |> toInt

          Just val -> val
      in (value)

oldfib : Int -> Int
oldfib num =
  case num of
    0 -> 0
    1 -> 1
    _ -> fib (num - 1) + fib (num - 2)

strToInt : String -> Int
strToInt str =
  case String.toInt str of
    Ok num -> num
    Err e -> 0 

type alias Model = {
  fibNum: Int,
  cache: List (Int, Int),
  result: Int
}
model : Model
model = Model 0 [] 0

type Msg = ValueChange String | Start
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ValueChange newVal ->
      { model | fibNum = strToInt newVal }
    Start ->
      { model |
        result = fib(model.fibNum model)
      }

view : Model -> Html Msg
view model =
  div []
      [
        input [ placeholder "Fibonacci", onInput ValueChange ] [],
        div [] [ text (toString model.result) ],
        input [ type_ "Submit", onClick Start ] []
      ]

subscriptions : Model -> Sub Msg
subscriptions model =


init : (Model, Cmd Msg)
init =



main =
  Html.beginnerProgram
  {
    init = ( model, Cmd.none ),
    model = model,
    update = update,
    view = view,
    subscriptions = subscriptions
  }
  
