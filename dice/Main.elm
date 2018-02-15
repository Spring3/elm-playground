import Html exposing (Html, div, button, h1, text)
import Html.Events exposing (onClick)
import Random

type alias Model =
  {
    firstDie : Int,
    secondDie : Int
  }

type Msg = Roll | NewFace (Int, Int)

update : Msg -> Model -> (Model, Cmd Msg) 
update msg model =
  case msg of
    Roll ->
      (model, Random.generate NewFace (Random.pair (Random.int 1 6) (Random.int 1 6)))

    NewFace (first, second) ->
      (Model first second, Cmd.none)

init : (Model, Cmd Msg)
init =
  (Model 0 0, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

view : Model -> Html Msg
view model =
  div []
      [
        h1 [] [ text (toString model.firstDie) ],
        h1 [] [ text (toString model.secondDie) ],
        button [ onClick Roll ] [ text "Roll" ]
      ]

main =
  Html.program {
    init = init,
    update = update,
    view = view,
    subscriptions = subscriptions
  }
