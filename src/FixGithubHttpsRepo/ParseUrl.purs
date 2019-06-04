module FixGithubHttpsRepo.ParseUrl where

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
import FixGithubHttpsRepo.Types (Url(..))

-- TODO: https://github.com/purescript/purescript/issues/888
parseUrl :: String -> Maybe Url
parseUrl url =
  let
    http'          = {-- spy "matchHttp"           $ --} match (unsafeRegex "^https?://([^/]+)/([^/]+)/([^/]+)$" (parseFlags "i")) url --}
    sshWithPort    = {-- spy "matchSshWithPort"    $ --} match (unsafeRegex "(ssh://)?git@([^/]+):([0-9]+)/([^/]+)/([^/]+).git" (parseFlags "i")) url
    sshWithoutPort = {-- spy "matchSshWithoutPort" $ --} match (unsafeRegex "(ssh://)?git@([^/]+)[:/]([^/]+)/([^/]+).git" (parseFlags "i")) url
   in case unit of
    _ | isJust http' -> do
        matches <- http'
        host <- join $ matches !! 1
        username <- join $ matches !! 2
        repo <- join $ matches !! 3
        Just (Url { host: host, username: username, repo: repo, port: Nothing })
    _ | isJust sshWithPort -> do
        matches <- sshWithPort
        host <- join $ matches !! 2
        port <- join $ matches !! 3
        portInt <- fromString port
        username <- join $ matches !! 4
        repo <- join $ matches !! 5
        Just (Url { host: host, username: username, repo: repo, port: Just portInt })
    _ | isJust sshWithoutPort -> do
        matches <- sshWithoutPort
        host <- join $ matches !! 2
        username <- join $ matches !! 3
        repo <- join $ matches !! 4
        Just (Url { host: host, username: username, repo: repo, port: Nothing })
    _ | otherwise -> Nothing
