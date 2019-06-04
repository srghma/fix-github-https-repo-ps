module FixGithubHttpsRepo.NormalizeUrl where

import Prelude

import Data.Array.NonEmpty (NonEmptyArray(..), toArray, (!!))
import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Eq (genericEq)
import Data.Generic.Rep.Show (genericShow)
import Data.Int (fromString)
import Data.Maybe (Maybe(..), isJust, maybe)
import Data.String.Regex (match, parseFlags)
import Data.String.Regex.Unsafe (unsafeRegex)
import FixGithubHttpsRepo.Types (Url(..))

-- TODO: https://github.com/purescript/purescript/issues/888
normalizeUrl :: Url -> String
normalizeUrl (Url url) = "ssh://git@" <> url.host <> (maybe "" (\portInt -> ":" <> show portInt) url.port) <> "/" <> url.username <> "/" <> url.repo <> ".git"
