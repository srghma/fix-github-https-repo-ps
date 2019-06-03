module FixGithubHttpsRepo.ParseUrl.Test where

import Prelude

import Control.Monad.Error.Class (class MonadThrow)
import Data.Maybe (Maybe(..))
import Effect.Exception (Error)
import FixGithubHttpsRepo.ParseUrl (Url(..), parseUrl)
import Test.Spec (class Example, SpecT(..), describe, it)
import Test.Spec.Assertions (shouldEqual)

parsedShouldEqual :: ∀ t3 t6. Monad t6 ⇒ MonadThrow Error t3 ⇒ String → Maybe Url → SpecT t3 Unit t6 Unit
parsedShouldEqual url expected = it
  url
  (parseUrl url `shouldEqual` expected)

testParseUrl :: ∀ t3 t4. Monad t4 ⇒ MonadThrow Error t3 ⇒ SpecT t3 Unit t4 Unit
testParseUrl = describe "parseUrl" do
  parsedShouldEqual "https://github.com/myusername/myproject" (
      Just (
      Url {
          host:     "github.com"
        , port:     Nothing
        , username: "myusername"
        , repo:     "myproject"
        }
      )
    )
  parsedShouldEqual
    "https://gitlab.mycompany.com/myusername/myproject"
    (Just (Url
    { host     : "gitlab.mycompany.com"
    , port     : Nothing
    , username : "myusername"
    , repo     : "myproject"
    })
    )
  parsedShouldEqual
    "ssh://git@gitlab.mycompany.com:4242/myusername/myproject.git"
    (Just (Url
    { host     : "gitlab.mycompany.com"
    , port     : Just 4242
    , username : "myusername"
    , repo     : "myproject"
    }
  ))
  parsedShouldEqual
    "git@github.com:myusername/myproject.git"
    (Just (Url
    { host     : "github.com"
    , port     : Nothing
    , username : "myusername"
    , repo     : "myproject"
    })
    )
  {-- parsedShouldEqual --}
  {--   "git@gitlab.mycompany.com:4242/myusername/myproject.git" --}
  {--   (Just (Url --}
  {--   { host     : "gitlab.mycompany.com" --}
  {--   , port     : Just 4242 --}
  {--   , username : "myusername" --}
  {--   , repo     : "myproject" --}
  {--   }) --}
  {--   ) --}
