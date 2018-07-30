import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Layout.NoBorders
import System.IO

main = do 
    xmproc <- spawnPipe "xmobar"
    spawnPipe "xscreensaver -no-splash"
    spawnPipe "nm-applet"
    xmonad $ docks $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = smartBorders $ avoidStruts $ layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput  = hPutStrLn xmproc
                        , ppTitle   = xmobarColor "#00aa00" "" . shorten 50
                        -- slightly darker green, otherwise it looks lighter due to larger area 
                        , ppCurrent = xmobarColor "black" "#008800" . wrap " " " "
                        , ppVisible = xmobarColor "black" "orange" . wrap " " " "
                        , ppSep     = " <fc=#888888>|</fc> "
                        , ppOrder = \(ws:_:t:_) -> [ws,t] -- dont show layout
                        }
        , borderWidth        = 2
        , modMask            = mod4Mask
        , focusedBorderColor = "#008800"
        , terminal           = "gnome-terminal"
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_l), spawn "xscreensaver-command -lock")
        , ((mod4Mask .|. shiftMask, xK_p), spawn "scrot")
        , ((mod4Mask .|. shiftMask, xK_b), sendMessage ToggleStruts)
        ]
