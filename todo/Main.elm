module Main exposing (..)

import Html exposing (Html, text, div, input, button, ul, li, span, a)
import Html.Attributes exposing (type_, placeholder, style, attribute, href)
import Html.Events exposing (onClick, onInput)
import Array exposing (Array)

type alias Todo = {
  text: String,
  checked: Bool,
  id: Int
}

type alias Model = {
  todos: Array Todo,
  tempTodoMessage: String
}

type Msg = Add | Remove Todo | TempTodoChanged String | Toggle Todo

init : (Model, Cmd Msg)
init = ({ todos = Array.fromList [], tempTodoMessage = "" }, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

createTodo : String -> Int -> Todo
createTodo val id =
  { text = val, checked = False, id = id }

displayTodo : Todo -> Html Msg
displayTodo todo =
  let
    (color, decoration) =
      case todo.checked of
        True -> ("grey", "line-through")
        False -> ("black", "none")
  in
    li []
      [
        input [ type_ "checkbox", onClick (Toggle todo) ] []
        , span [ style [("color", color), ("text-decoration", decoration)] ] [ text todo.text ]
        , a [ href "#/", onClick (Remove todo), style [("color", "red")]] [ text " x" ]
      ]


update : Msg -> Model -> (Model, Cmd Msg)
update message model =
  case message of
    Add ->
      let
        id = Array.length model.todos
        todo = createTodo model.tempTodoMessage id
        newTodos = Array.push todo model.todos
        newModel = { model | todos = newTodos }
      in
      (newModel, Cmd.none)
    TempTodoChanged val ->
      ({ model | tempTodoMessage = val }, Cmd.none)
    Toggle todo ->
      let
        newTodos = Array.set todo.id { todo | checked = not todo.checked } model.todos
        newModel  = { model | todos = newTodos }
      in
        (newModel, Cmd.none)

    Remove todo ->
        ({ model | todos = Array.filter (\item -> todo.id /= item.id) model.todos }, Cmd.none)
          

view : Model -> Html Msg
view model =
  div []
      [
        input [ type_ "text", placeholder "Todo", onInput TempTodoChanged ] [ ]
        , button [ onClick Add ] [ text "Add" ]
        , ul [] (model.todos |> Array.toList |> List.map displayTodo)
      ]


main =
  Html.program {
    init = init,
    update = update,
    view = view,
    subscriptions = subscriptions
  }
