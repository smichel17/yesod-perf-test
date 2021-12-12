{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.TestQQ where

import Import

getTestQQR :: Handler Html
getTestQQR = defaultLayout $ do
    setTitle "Testing QuasiQuotes"
    [whamlet|
<h1>Hello World!
|]
