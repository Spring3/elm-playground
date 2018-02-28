port module Main exposing (..)

import Html exposing (Html, div, input, text, h3)
import Html.Attributes exposing (type_)
import Html.Events exposing (onInput)

port onStateChange : String -> Cmd msg

port newState : (String -> msg) -> Sub msg

type alias Model = {
  req: String,
  res: String
}

type Msg = ReceiveNewModel String | SendMessage String

subscriptions model = newState ReceiveNewModel

update msg model =
  case msg of
    ReceiveNewModel res ->
      ({ model | res = res }, Cmd.none)
    
    SendMessage req ->
      ({ model | req = req }, onStateChange req)


init : (Model, Cmd msg)
init =
  ({ req = "", res = "" }, Cmd.none)

view model =
  div []
      [
        input [ type_ "text", onInput SendMessage ] []
        , h3 [] [text ("Title: " ++ model.res)]
      ]

main =
  Html.program {
    init = init,
    update = update,
    subscriptions = subscriptions,
    view = view
  }
