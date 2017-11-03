module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Decode
import Random
import Navigation
import String

main =
  Navigation.program UrlChange
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODELS


type alias Model =
    { posts : List String
    , history : List Navigation.Location
    , location : Navigation.Location
    }


init: Navigation.Location -> (Model, Cmd Msg)
init location = (Model [] [location] location, Cmd.none)


-- UPDATE


type Msg =
  RequestNewPosts
  | UrlChange Navigation.Location
  | NoOp


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    RequestNewPosts ->
      (model, Cmd.none)
    UrlChange location ->
      ( { model | history = location :: model.history, location = location }
      , Cmd.none
      )
    NoOp ->
      (model, Cmd.none)


getPage : String -> Page
getPage hash =
    -- Example basic routing impl
    if String.startsWith "#articles/" hash then
        SingleArticle 1
    else
        Homepage

-- VIEW

type Page = Homepage | SingleArticle Int


commentView : String -> Html Msg
commentView s =
  li []
    [b [] [text (s ++ ": ")]
    , text s]


view : Model -> Html Msg
view model =
  let content =
    case (getPage model.location.hash) of
        SingleArticle articleId ->
                let article = ""
                in
                    [ h1 [] [text "Article:"]]
        Homepage ->
                [ h1 [] [text "Homepage"]]
  in
    -- Base template
    div [style [ ("min-height", "100vh"), ("padding", "20px 40px"), ("background-color", "#eee") ]] content




-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- HTTP
