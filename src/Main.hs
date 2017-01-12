module Main where

import Internal

import Control.Monad.IO.Class
import Language.Haskell.Interpreter

say = liftIO . putStrLn

compile :: String -> IO (Either InterpreterError (Int -> Int))
compile b = runInterpreter $ do
    say "Loading modules."
    loadModules ["Internal"]
    say "Setting imports."
    setImports ["Prelude"
               ,"Internal"
               ]
    say "Interpreting."
    interpret b id

main :: IO ()
main = do
    r <- compile "\\i -> f i"
    case r of
      Left e -> print e
      Right _ -> putStrLn "OK"
