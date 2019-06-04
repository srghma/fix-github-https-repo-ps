module FixGithubHttpsRepo.NormalizeUrl.Test where

import Prelude

import Control.Monad.Error.Class (class MonadThrow)
import Data.Maybe (Maybe(..))
import Effect.Exception (Error)
import FixGithubHttpsRepo.NormalizeUrl (normalizeUrl)
import FixGithubHttpsRepo.Types (Url(..))
import Test.Spec (SpecT, describe, it)
import Test.Spec.Assertions (shouldEqual)

normalizedShouldEqual :: ∀ t3 t6. Monad t6 ⇒ MonadThrow Error t3 ⇒ Url → String → SpecT t3 Unit t6 Unit
normalizedShouldEqual url expected = it
  expected
  (normalizeUrl url `shouldEqual` expected)

testNormalizeUrl :: ∀ t3 t4. Monad t4 ⇒ MonadThrow Error t3 ⇒ SpecT t3 Unit t4 Unit
testNormalizeUrl = describe "normalizeUrl" do
  normalizedShouldEqual
    (Url
      { host: "github.com"
      , port: Nothing
      , username: "myusername"
      , repo: "myproject"
      }
    )
    "ssh://git@github.com/myusername/myproject.git"
  normalizedShouldEqual
    (Url
      { host: "github.com"
      , port: Just 4242
      , username: "myusername"
      , repo: "myproject"
      }
    )
    "ssh://git@github.com:4242/myusername/myproject.git"

