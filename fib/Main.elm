import Html exposing (Html, h2, div, input, text)
import Html.Attributes exposing (type_, placeholder)
import Html.Events exposing (onInput, onClick)
import Fibonacci

type alias Model = {
  cache: List (Int, Int),
  target: Int,
  result: Int
}

type Msg = TargetChange String | Start | Result Int

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Start ->
      (Model model.cache model.target (Fibonacci.fib model.target), Cmd.none)

    TargetChange target ->
      (Model model.cache (Fibonacci.toInt target) 0, Cmd.none)

    Result result ->
      (model, Cmd.none)

init : (Model, Cmd Msg)
init =
  (Model [] 0 0, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

view : Model -> Html Msg
view model =
  div []
      [
        input [ type_ "text", placeholder "Target", onInput TargetChange ] [],
        input [ type_ "submit", placeholder "Calculate", onClick Start] [],
        h2 [] [ text (toString model.result) ]
      ]

main =
  Html.program
  {
    init = init,
    update = update,
    view = view,
    subscriptions = subscriptions
  }
