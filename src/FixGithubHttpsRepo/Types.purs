module FixGithubHttpsRepo.Types where

import Prelude

import Data.Array.NonEmpty (NonEmptyArray(..), toArray, (!!))
import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Eq (genericEq)
import Data.Generic.Rep.Show (genericShow)
import Data.Int (fromString)
import Data.Maybe (Maybe(..), isJust)
import Data.String.Regex (match, parseFlags)
import Data.String.Regex.Unsafe (unsafeRegex)
import Debug.Trace (spy, traceM)

data Url = Url
  { host     :: String
  , port     :: Maybe Int
  , username :: String
  , repo     :: String
  }

derive instance genericUrl :: Generic Url _

instance showUrl :: Show Url where show = genericShow
instance eqUrl :: Eq Url where eq = genericEq
