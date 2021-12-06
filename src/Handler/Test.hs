{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Test where

import Import

getTestR :: Handler Html
getTestR = defaultLayout $ do
    setTitle "Test Page"
    $(widgetFile "test")
