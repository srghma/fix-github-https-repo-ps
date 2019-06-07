module Main where

import Data.Unit
import Node.Optlicative
import Prelude

import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Eq (genericEq)
import Data.Generic.Rep.Show (genericShow)
import Data.List (length)
import Data.Maybe (Maybe(..), isJust, maybe)
import Data.String (joinWith)
import Data.Validation.Semigroup (unV)
import Debug.Trace (spy, traceM)
import Effect (Effect)
import Effect.Console (log, error)
import Node.Process (exit)

data Config = Config {
    remote :: Maybe String
  , port :: Maybe Int
  , unset_port :: Boolean
  , help :: Boolean
}

derive instance genericConfig :: Generic Config _

instance showConfig :: Show Config where show = genericShow

parseConfig :: Optlicative Config
parseConfig = (\remote port unset_port help -> Config { remote: remote, port: port, unset_port: unset_port, help: help })
  <$> optional (string "remote" Nothing)
  <*> optional (int "port" Nothing)
  <*> flag "unset-port" (Just 'u')
  <*> flag "help" (Just 'h')

-- TODO
-- generate automatically

description :: String
description = "Converts https git remote to ssh (e.g. https://github.com/myusername/myrepo to ssh://git@github.com/myusername/myrepo.git)"

usage :: String
usage = """
Usage: fix-github-https-repo-ps [-r|--remote REMOTE] [-p|--port PORT] [-u|--unset-port]

Available options:
  -h,--help                Show this help text
  -r,--remote REMOTE       The `git remote` you want to convert (default - origin)
  -p,--port PORT           The expected ssh port of new url
  -u,--unset-port          Remote port from new url, cannot be used with --port option
"""

-- NOTE
-- test with
-- spago --verbose build
-- node -e "require('./output/Main/index.js').main()" - --help
main :: Effect Unit
main = do
  { value } <- optlicate {} (defaultPreferences { globalOpts = parseConfig, usage = Just usage })
  traceM value
  unV logErrors
    (\(Config { remote, port, unset_port, help }) -> do
      when help (do
                log description
                log usage
                exit 0
                )

      when (unset_port && isJust port) (do
          error "Error: --port and --unset-port are self-excluding"
          log usage
          exit 1)

      log (show help)
    )
    value
  pure unit
