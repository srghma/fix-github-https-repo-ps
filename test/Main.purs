module Test.Main where

import Prelude

import FixGithubHttpsRepo.ParseUrl.Test (testParseUrl)
import FixGithubHttpsRepo.NormalizeUrl.Test (testNormalizeUrl)

import Effect (Effect)
import Effect.Aff (launchAff_)
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec.Runner (runSpec)

main :: Effect Unit
main = launchAff_ $ runSpec [consoleReporter] do
  testParseUrl
  testNormalizeUrl
