import StartApp.Simple exposing (start)
import Html exposing (..)
import Html.Attributes exposing (..)

type alias Todo =
  { title     : String
  , completed : Bool
  , editing   : Bool
  }

-- We have a list of todos
type Todos = List Todo

-- We have the filter state for the application
type FilterState = All | Active | Completed

-- We have the entire application state's model
type alias Model =
  { todos  : List Todo
  , todo   : Todo
  , filter : FilterState
  }

-- We have the actions that can occur
type Action
  = NoOp
  | Add Todo
  | Complete Todo
  | Delete Todo
  | Filter FilterState

update : Action -> Model -> Model
update action model =
  model

css : String -> Html
css path =
  node "link" [ rel "stylesheet", href path ] []

todoView : Todo -> Html
todoView todo =
  li [classList [ ("complete", todo.completed) ] ]
  [ div [class "view"]
    [ input [class "toggle", type' "checkbox", checked todo.completed] []
    , label [] [text todo.title]
    , button [class "destroy"] []
    ]
  ]

view : Signal.Address Action -> Model -> Html
view address model =
  div []
  [ css "style.css"
  , section [class "todoapp"]
    [ header [class "header"]
      [ h1 [] [text "todos"]
      , input [class "new-todo", placeholder "What needs to be done?", autofocus True] []
      ]
      , section [class "main"]
      [ ul [class "todo-list"]
        (List.map todoView model.todos)
      ]
    ]
  ]

initialModel =
  { todos =
    [
      { title = "The first todo"
      , completed = False
      , editing = False
      }
    ]
  , todo = { title = ""
           , completed = False
           , editing = False
           }
  , filter = All
  }

main =
  StartApp.Simple.start
    { model = initialModel
    , update = update
    , view = view
    }
