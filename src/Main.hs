module Main where

import Internal

import Language.Haskell.Interpreter

compile :: String -> IO (Either InterpreterError (Int -> Int))
compile b = runInterpreter $ do
    loadModules ["Internal"]
    setImports ["Prelude"
               ,"Internal"
               ]
    interpret b id

main :: IO ()
main = do
    r <- compile "\\i -> f i"
    case r of
      Left e -> print e
      Right _ -> putStrLn "OK"
