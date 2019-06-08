module Main where

import Data.Unit
import Options.Applicative
import Prelude

import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Eq (genericEq)
import Data.Generic.Rep.Show (genericShow)
import Data.List (length)
import Data.Maybe (Maybe(..), isJust, maybe, optional)
import Data.String (joinWith)
import Debug.Trace (spy, traceM)
import Effect (Effect)
import Effect.Console (log, error)
import Node.Process (exit)
import Options.Applicative.Builder (fullDesc, strOption)

newtype Config = Config {
    remote :: Maybe String
  , port :: Maybe Int
  , unset_port :: Boolean
}

derive instance genericConfig :: Generic Config _
instance showConfig :: Show Config where show = genericShow

-- TODO: use ado
configParser :: Parser Config
configParser = (\remote port unset_port -> Config { remote, port, unset_port })
  <$> optional (strOption
      ( long "remote"
      <> short 'r'
      <> help "The `git remote` you want to convert (default - origin)"
      ))
  <*> optional (option int
      ( long "port"
      <> short 'p'
      <> help "The expected ssh port of new url"
      ))
  <*> switch
    ( long "unset-port"
    <> short 'u'
    <> help "Remove port from new url, cannot be used with --port option"
    )

opts :: ParserInfo Config
opts = info (configParser <**> helper)
   ( fullDesc
  <> progDesc "Converts https git remote to ssh (e.g. https://github.com/myusername/myrepo to ssh://git@github.com/myusername/myrepo.git)"
  <> header "fix-github-https-repo-ps - program for git" )

-- NOTE
-- test with
-- spago --verbose build
-- node -e "require('./output/Main/index.js').main()" - --help
main :: Effect Unit
main = do
  {-- log "adsf" --}
  options <- execParser opts
  traceM options
  {-- unV logErrors --}
  {--   (\(Config { remote, port, unset_port, help }) -> do --}
  {--     when help (do --}
  {--               log description --}
  {--               log usage --}
  {--               exit 0 --}
  {--               ) --}

  {--     when (unset_port && isJust port) (do --}
  {--         error "Error: --port and --unset-port are self-excluding" --}
  {--         log usage --}
  {--         exit 1) --}

  {--     log (show help) --}
  {--   ) --}
  {--   value --}
  {-- pure unit --}
