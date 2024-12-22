-- import XMonad.Layout.Gaps

-- {-# OPTIONS_GHC -fno-warn-missing-signatures #-}
-- import XMonad.Layout.LayoutModifier

-- import XMonad.StackSet

-- import Numeric.Natural (Natural)
-- import XMonad.Layout.Magnifier
-- import qualified XMonad.Layout.Magnifier as Mag

import Control.Arrow ((>>>))
import Control.Monad.RWS (MonadWriter (pass))
import Data.Function ((&))
import XMonad
import XMonad.Actions.CycleRecentWS
import XMonad.Actions.Promote
import XMonad.Actions.SpawnOn
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Layout.FixedColumn (FixedColumn (FixedColumn))
import XMonad.Layout.LimitWindows (limitWindows)
import XMonad.Layout.Magnifier (magnifiercz')
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle as MT (Toggle (..))
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed (Rename (Replace), renamed)
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing
import XMonad.Layout.ThreeColumns
import XMonad.StackSet qualified as W
import XMonad.Util.EZConfig
import XMonad.Util.Loggers

-- import XMonad.Util.Ungrab
import XMonad.Operations -- for using "unGrab"

import XMonad.Layout.Magnifier qualified as Mag
import XMonad.ManageHook (composeAll)

------------------------------------------------------------------------
-- Colors

grey1, grey2, grey3, grey4, cyan, orange :: String
grey1 = "#2B2E37"
grey2 = "#555E70"
grey3 = "#697180"
grey4 = "#8691A8"
cyan = "#8BABF0"
orange = "#C45500"

-- Using "additionalKeysP" syntax, rather than "additionalKeys"
myKeys :: [(String, X ())]
myKeys =
    -- XMonad
    [ ("M-S-r", spawn "xmonad --restart")
    , ("M-S-q", kill)
    , -- MOVE THESET TO sxhkd
      ("<XF86MonBrightnessUp>", spawn "brillo -q -A 10")
    , ("<XF86MonBrightnessDown>", spawn "brillo -q -U 10")
    , ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
    , ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
    , ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
    , ("M-<Tab>", sendMessage NextLayout)
    , ("M-S-s", spawn "flameshot gui")
    , -- , ("M-<KP_Page_Up>", sendMessage MirrorExpand)
      -- , ("M-<KP_Page_Down>", sendMessage MirrorShrink)
      ("M-<Page_Up>", sendMessage MirrorExpand)
    , ("M-<Page_Down>", sendMessage MirrorShrink)
    , ("M-f", sendMessage (Toggle FULL))
    , ("M-b", toggleRecentWS)
    , -- , (workspace remappings)
      ("M-S-1", windows $ shiftThenView "1")
    , ("M-S-2", windows $ shiftThenView "2")
    , ("M-S-3", windows $ shiftThenView "3")
    , ("M-S-4", windows $ shiftThenView "4")
    , ("M-S-5", windows $ shiftThenView "5")
    , ("M-S-6", windows $ shiftThenView "6")
    , ("M-S-7", windows $ shiftThenView "7")
    , ("M-S-8", windows $ shiftThenView "8")
    , ("M-S-9", windows $ shiftThenView "9")
    , -- messing with defaults
      ("M-S-m", promote)
    , -- ("M-S-m", windows W.shiftMaster), -- Alternate, keeps focus on moved window
      ("M-<Return>", spawn myTerminal)
    , -- Should be moved to external keybinder:
      -- DON'T NEED TO WRITE FONT, added it to config.rasi
      -- , ("M-d", spawn "rofi -show drun -font 'Nimbus Sans 16'")
      -- , ("M-s", spawn "rofi -show file-browser-extended -font 'Nimbus Sans 16'")
      ("M-d", spawn "rofi -show drun")
    , -- , ("M-s", spawn "rofi -show file-browser-extended")
      ("M-s", spawn "rofi -show file-browser-extended -file-browser-dir Documents -file-browser-depth 0")
    , ("M-c", spawn "rofi -show calc")
    , ("M-0", spawn "rofi -show p -modi p:rofi-power-menu")
    , ("M-e", spawn "rofi modi emoji -show emoji -kb-custom1 Ctrl+c -emoji-mode insert_no_copy")
    , ("M-o", spawn "firefox")
    ]

-- myTerminal = "kitty"
myTerminal = "wezterm"

myRemovedKeys =
    [ "M-<Space>" -- Mapped to switching keyboardlayout instead
    , "M-q" -- Mapped to M-S-r instead
    , "M-S-<Return>" -- Mapped to new terminal in same directory
    ]

shiftThenView i = W.shift i >>> W.greedyView i

myFocusFollowsMouse = False

myClickJustFocuses = False

--
-- maximizeTest :: l a -> ModifiedLayout Mag.Magnifier l a
-- maximizeTest = ModifiedLayout (Mag (1,1000) Off (AllWins 1))

-- myLayout = tiled ||| Mirror tiled ||| Full ||| threeCol
-- myLayout = smartBorders $ magnifiercz' 1.3 tiled ||| Full
-- myLayout = smartBorders $ magnifiercz' 1.3 tiled ||| Full
--
--
--
--
--
--
--
--

-- myLayout = (Mag.magnifyxy 1 10.0 (Mag.NoMaster 1) True tiled) ||| threeCol ||| Full
-- myLayout = (Mag.magnifyxy 1 1.5 (Mag.NoMaster 1) True tiled) ||| threeCol ||| Full
myLayout = smartBorders $ mkToggle (single FULL) (tiled ||| threeCol)
  where
    threeCol = ThreeColMid nmaster delta ratio
    tiled = Tall nmaster delta ratio
    nmaster = 1 -- Default number of windows in the master pane
    delta = 3 / 100 -- Percent of screen to increment by when resizing panes
    ratio = 1 / 2 -- Default proportion of screen occupied by master pane

-- myLayout =
--   smartBorders $
--     -- magnifiercz' 1.2 $
--     spacingRaw False (Border 5 0 5 0) True (Border 0 5 0 5) True $
--       -- toggleLayouts (coding ||| Mirror coding) Full
--
--
--       -- V Old one, have to refactor this shitttt
--       -- mkToggle (single FULL) (coding ||| Mirror coding)
--       mkToggle (single FULL) (coding ||| noBorders coding)
--   where
--     coding = ResizableTall nmaster delta ratio slaves
--     nmaster = 1 -- number of master windows
--     delta = 1 / 9 -- shrink/grow ammount
--     ratio = 1 / 2 -- Master width
--     slaves = [1] -- list of slaves height multipliers

-- myStartupHook :: X ()
-- myStartupHook = do
--     sendMessage $ Toggle "coding"

myWorkspaces :: [String]
myWorkspaces = ["1: dev", "2: www", "3: doc", "4: read", "5", "6", "7: video", "8: music"]
myXmobarPP :: PP
myXmobarPP =
    def
        { ppSep = "" -- ppSep = magenta " • "
        , ppWsSep = " "
        , ppTitleSanitize = xmobarStrip
        , -- , ppCurrent = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2
          ppCurrent = xmobarColor cyan "" -- . clickable wsIconFull
        , ppVisible = xmobarColor grey4 "" -- . clickable wsIconFull
        , ppVisibleNoWindows = Just (xmobarColor grey4 "") -- . clickable wsIconFull
        , ppHidden = xmobarColor "#FFFFFF" ""
        , ppHiddenNoWindows = xmobarColor grey2 ""
        , -- , ppHidden = white . wrap " " ""
          -- , ppHiddenNoWindows = lowWhite . wrap " " ""
          -- ppUrgent = red . wrap (yellow "!") (yellow "!")
          ppUrgent = xmobarColor orange "" . wrap (yellow "!") (yellow "!")
        , ppOrder = \[ws, l, _, wins] -> [ws, l, wins]
        , ppExtras = [logTitles formatFocused formatUnfocused]
        }
  where
    formatFocused = wrap (white "[") (white "]") . magenta . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue . ppWindow
    -- \| Windows should have *some* title, which should not not exceed a
    -- sane length.
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 20

    blue, lowWhite, magenta, red, white, yellow :: String -> String
    magenta = xmobarColor "#ff79c6" ""
    blue = xmobarColor "#bd93f9" ""
    white = xmobarColor "#f8f8f2" ""
    yellow = xmobarColor "#f1fa8c" ""
    red = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#bbbbbb" ""

-- TODO, see https://xmonad.org/TUTORIAL.html

myManageHook =
    composeAll
        [ className =? "VirtualBox Machine" --> doShift (myWorkspaces !! 8)
        , title =? "Oracle VM VirtualBox Manager" --> doCenterFloat
        , return True --> doF W.swapDown
        ]

-- No type signature, but I should probably just remove this unecessary
-- abstraction
myConfig =
    def
        { modMask = mod4Mask -- Rebind Mod to the Super Key
        , layoutHook = myLayout
        , terminal = myTerminal
        , borderWidth = 3
        , normalBorderColor = grey2
        , focusedBorderColor = cyan
        , -- , focusedBorderColor = "#ff9933"
          -- , workspaces = myWorkspaces
          focusFollowsMouse = myFocusFollowsMouse
        , clickJustFocuses = myClickJustFocuses
        , manageHook = myManageHook <+> manageDocks
        -- , startupHook = myStartupHook
        -- manageHook =
        --   composeOne
        --       [ checkDock -?> doIgnore -- equivalent to manageDocks
        --       , isDialog -?> doFloat
        --       , (className =? "albert") -?> doFloat
        --       , -- , (className =? "VirtualBox Machine") -?> doShift "5"
        --         return True -?> doF W.swapDown
        --       ]
        }
        `additionalKeysP` myKeys
        `removeKeysP` myRemovedKeys -- Remove certain defaults not needed.

-- \^ putting this below, because if I was removing something I had rebound,
-- then it should be removed from "myRemovedKeys"

-- Apply the stuff
main :: IO ()
main =
    xmonad
        -- . ewmhFullscreen
        . ewmh
        . withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) toggleStrutsKey
        $ myConfig
  where
    -- For this, use "withEasySB" instead
    toggleStrutsKey :: XConfig Layout -> (KeyMask, KeySym)
    -- v for now mod + W, find out how to disable
    toggleStrutsKey XConfig{modMask = m} = (m, xK_w)
