return {
  track_motion = {
    ["G"] = "LastTrack",
    ["gg"] = "FirstTrack",
    ["J"] = "NextFolderNear",
    ["K"] = "PrevFolderNear",
    ["j"] = "NextTrack",
    ["k"] = "PrevTrack",
    ["<C-b>"] = "Prev10Track",
    ["<C-f>"] = "Next10Track",
    ["<C-d>"] = "Next5Track",
    ["<C-u>"] = "Prev5Track",
  },
  visual_track_command = {
    ["o"] = "SwitchTrackSelectionSide",
    ["V"] = "SetModeNormal",
  },
  track_selector = {
    ["s"] = "Selection",
    ["i"] = {"+inner", {
               ["f"] = "InnerFolder",
               ["F"] = "InnerFolderAndParent",
               ["g"] = "AllTracks",
    }},
    ["F"] = "SelectFolderParent",
  },
  track_operator = {
      ["z"] = "ZoomSelVertical",
      ["f"] = "MakeFolder",
      ["d"] = "CutTrack",
      ["a"] = "ArmToggle",
      ["s"] = "SelectTracks",
      ["S"] = "ToggleSolo",
      ["m"] = "ToggleMute",
      ["y"] = "CopyTrack",
      ["<M-C>"] = "ColorTrackGradient",
      ["<M-c>"] = "ColorTrack",
  },
  timeline_operator = {
    ["s"] = "SelectItems",
    ["d"] = "CutItems",
    ["y"] = "CopyItems",
    ["r"] = "InsertRegion",
    ["<M-s>"] = "SelectEnvelopePoints",
    ["<M-d>"] = "CutEnvelopePoints",
    ["<M-y>"] = "CopyEnvelopePoints",
    ["<M-r>"] = "InsertAutomationItem",
    ["g"] = "GlueItems",
    [">"] = "GrowItemRight",
    ["<"] = "GrowItemLeft",
    ["%"] = "HealSplits",
    ["#"] = "SetItemFadeBoundaries",
    ["i"] = {"+item selection", {
            ["f"] = "FitByLoopingNoShift",
            ["l"] = "FitByLooping",
            ["p"] = "FitByPadding",
            ["y"] = "CopyAndFitByLooping",
            ["s"] = "FitByStretching",
    }},
    ["i<M-s>"] = "FitEnvelopePoints",
  },
  timeline_selector = {
    ["s"] = "SelectedItems",
    ["<M-s>"] = "AutomationItem",
  },
  timeline_motion = {
    ["B"] = "PrevBigItemStart",
    ["E"] = "NextBigItemEnd",
    ["W"] = "NextBigItemStart",
    ["b"] = "PrevItemStart",
    ["<M-b>"] = "PrevEnvelopePoint",
    ["e"] = "NextItemEnd",
    ["w"] = "NextItemStart",
    ["<M-w>"] = "NextEnvelopePoint",
    ["<C-a>"] = "FirstItemStart",
    ["$"] = "LastItemEnd",
    ["g$"] = "ProjectEnd",
  },
  command = {
    ["<TAB>"] = "CycleFolderCollapsedState",
    ["<S-TAB>"] = "CycleFolderState",
    ["Z"] = "ZoomSel",
    ["S"] = "UnselectItems",
    ["<M-S>"] = "UnselectEnvelopePoints",
    ["D"] = "CutSelectedItems",
    ["Y"] = "CopySelectedItems",
    ["V"] = "SetModeVisualTrack",
    ["<M-j>"] = "NextEnvelope",
    ["<M-k>"] = "PrevEnvelope",
    ["<C-+>"] = "ZoomInHoriz",
    ["<C-->"] = "ZoomOutHoriz",
    ["+"] = "ZoomInVert",
    ["-"] = "ZoomOutVert",
    ["<C-m>"] = "TapTempo",
    ["<C-s>"] = "FxToggleShow",
    ["<C-S>"] = "FxClose",
    ["<C-n>"] = "FxShowNextSel",
    ["<C-N>"] = "FxShowPrevSel",
    ["<C-p>"] = "FxShowPrevSel",
    ["dd"] = "CutTrack",
    ["aa"] = "ArmToggle",
    ["O"] = "EnterTrackAbove",
    ["o"] = "EnterTrackBelow",
    ["p"] = "Paste",
    ["P"] = "PasteAbove",
    ["yy"] = "CopyTrack",
    ["zt"] = "ScrollToPlayPosition",
  },
}
