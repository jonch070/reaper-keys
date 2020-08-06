-- provides functions which are specific to reaper-keys, such as macros
local lib = require('library')
-- provides custom functions which make use of the reaper api
local custom = require('custom_actions')

-- naming conventions:
-- a noun implies an action which selects the noun, or a movement to it's position
-- simple verbs are usually operators on selections, such as 'change'

return {
      ActivateNextMidiItem = {40833, midiCommand=true},
      ActivatePrevMidiItem = {40834, midiCommand=true},
      AddFx = "_S&M_CONSOLE_ADDFx",
      AddNextNoteToSelection = {40422, midiCommand=true},
      AddPrevNoteToSelection = {40421, midiCommand=true},
      AddTrackVirtualInstrument = 40701,
      AllTrackItems = {"SaveItemSelection", "SelectItemsOnTrack", "SelectedItems", "RestoreItemSelection"},
      AllTracks = 40296,
      ArmAllEnvelopes = "_S&M_ARMALLENVS",
      ArmSelectedTracks = "_XENAKIOS_SELTRAX_RECARMED",
      ArmTracks = 9,
      AutomationItem = 42197,
      BigItem = custom.select.innerBigItem,
      CleanProjectDirectory = 40098,
      ClearAllEnvelope = "_S&M_REMOVE_ALLENVS",
      ClearAllRecordArm = 40491,
      ClearEnvelope = 40065,
      ClearNoteSelection = {40214, midiCommand=true},
      ClearTimeSelection = custom.clearTimeSelection,
      CloseAllFxChainsAndWindows = {"CloseAllFx", "CloseAllFxChain"},
      CloseAllFxChain = "_S&M_WNCLS4",
      CloseAllFx = "_S&M_WNCLS3",
      CloseFloatingFxWindows = "_S&M_WNCLS3",
      CloseFx = "_S&M_WNCLS5",
      CloseProject = 40860,
      CloseWindow = {2, midiCommand=true},
      ColorTrack = {40360, prefixRepetitionCount=true},
      ColorTrackGradient = "_SWS_TRACKGRAD",
      ColorTrackWithTrackAbove = "_SWS_COLTRACKPREV",
      ColorTrackWithTrackBelow = "_SWS_COLTRACKNEXT",
      CopyAndFitByLooping = 41319,
      CopyEnvelope = 40035,
      CopyEnvelopePoints = 40324,
      CopyFxChain = "_S&M_SMART_CPY_FxCHAIN",
      CopyItems = {"SaveItemSelection", "OnlySelectItemsCrossingTimeAndTrackSelection", "CopySelectedAreaOfItems", "RestoreItemSelection"},
      CopyNotes = {"SelectNotes", "CopySelectedEvents"},
      CopySelectedAreaOfItems = 40060,
      CopySelectedEvents = {40733, midiCommand=true},
      CopySelectedItems = 40698,
      CopyTrack = 40210,
      CropToActiveTake = 40131,
      CutEnvelopePoints = 40325,
      CutFxChainInput = "_S&M_CUT_INFxCHAIN",
      CutFxChain = "_S&M_COPYFxCHAIN6",
      CutItems = {"SaveItemSelection", "SelectItemsAndSplit", "CutSelectedItems", "RestoreItemSelection"},
      CutNotes = {"SelectNotes", "CutSelectedEvents"},
      CutSelectedEvents = {40012, midiCommand=true},
      CutSelectedItems = 40699,
      CutTrack = {"CopyTrack", "RemoveTrack", "SelectLastTouchedTrack"},
      CycleFolderCollapsedState = 1042,
      CycleFolderState = 1041,
      CycleItemFadeInShape = {41520, prefixRepetitionCount=true},
      CycleItemFadeOutShape = {41527, prefixRepetitionCount=true},
      CycleRecordMonitor = 40495,
      CycleRippleEditMode = 1155,
      DeleteActiveTake = {40129, prefixRepetitionCount=true},
      DeleteEnvelope = 40333,
      DeleteItem = 40006,
      DeleteMark = {lib.marks.delete, registerAction=true},
      DeleteNote = {40002, midiCommand=true},
      DeleteTimeline = 40201,
      EnterTrackAbove = {"InsertTrackAbove", "ColorTrackWithTrackBelow", "RenameTrack"},
      EnterTrackBelow = {"InsertTrackBelow", "ColorTrackWithTrackAbove", "RenameTrack"},
      EventSelectionEnd = {40639, midiCommand=true},
      EventSelectionStart = {40440, midiCommand=true},
      FirstItemStart = custom.move.firstItemStart,
      FirstTrack = {custom.move.firstTrack, "ScrollToSelectedTracks"},
      FitByLoopingNoShift = {"OnlySelectItemsCrossingTimeAndTrackSelection", "FitItemsByLoopingNoShift"},
      FitByLooping = {"OnlySelectItemsCrossingTimeAndTrackSelection", "FitItemsByLooping"},
      FitByPadding = {"OnlySelectItemsCrossingTimeAndTrackSelection", "FitItemsByPadding"},
      FitByStretching = {"OnlySelectItemsCrossingTimeAndTrackSelection", "FitItemsByStretching"},
      FitEnvelopePoints = "_BR_FIT_ENV_POINTS_TO_TIMESEL",
      FitItemsByLooping = 41320,
      FitItemsByLoopingNoShift = 41386,
      FitItemsByPadding = 41385,
      FitItemsByStretching = 41206,
      FitNotes = {40754, midiCommand=true},
      FocusMain = "_S&M_WNMAIN",
      FolderChildren = {"SelectFolderChildren", "ScrollToSelectedTracks"},
      FolderParent = {"SelectFolderParent", "ScrollToSelectedTracks"},
      Folder = {"SelectFolder", "ScrollToSelectedTracks"},
      FreezeTrack = 41223,
      GlueItemIgnoringTimeSelection = 40362,
      GlueItems = {"SaveItemSelection", "SelectItems", "GlueSelectedItemsInTimeSelection", "RestoreItemSelection"},
      GlueSelectedItemsInTimeSelection = 41588,
      GoToEnd = {40037, midiCommand=true},
      GoToStart = {40036, midiCommand=true},
      GroupItems = 40032,
      GrowItemLeft = {"TimeSelectionEnd", "SelectItemsUnderEditCursor", "TimeSelectionStart", "TrimSelectedItemLeftEdgeToEditCursor"},
      GrowItemRight = {"TimeSelectionStart", "SelectItemsUnderEditCursor", "TimeSelectionEnd", "TrimSelectedItemRightEdgeToEditCursor"},
      HealSelectedItemsSplits = 40548,
      HealSplits = {"SaveItemSelection", "OnlySelectItemsCrossingTimeAndTrackSelection", "HealSelectedItemsSplits", "RestoreItemSelection"},
      InnerFolderAndParent = {"FolderParent", "SelectFolder"},
      InnerFolder = {"FolderParent", "SelectOnlyFoldersChildren"},
      InsertAutomationItem = 42082,
      InsertDefaultSizeNote = {40051, midiCommand=true},
      InsertNote = {"MidiTimeSelectionStart", "InsertDefaultSizeNote", "MidiTimeSelectionStart", "SelectNearestNote", "FitNotes"},
      InsertOrExtendMidiItem = 42069,
      InsertTrackAbove = '_SWS_INSRTTRKABOVE',
      InsertTrackBelow = 40001,
      InvertVoicingDownwards = {40910, midiCommand=true, prefixRepetitionCount=true},
      InvertVoicingUpwards = {40909, midiCommand=true, prefixRepetitionCount=true},
      ItemApplyFx = 40209,
      Item = custom.select.innerItem,
      ItemNormalize = 40108,
      ItemSplitSelRight = "_SWS_AWSPLITXFADELEFT",
      JoinNotes = {"SelectNotes", "JoinSelectedNotes"},
      JoinSelectedNotes = {40456, midiCommand=true},
      LastItemEnd = custom.move.lastItemEnd,
      LastTrack = {custom.move.lastTrack, "ScrollToSelectedTracks"},
      Left10Pix = {"_XENAKIOS_MOVECUR10PIX_LEFT", prefixRepetitionCount=true},
      Left40Pix = {"Left10Pix", repetitions=4, prefixRepetitionCount=true},
      LeftGridDivision = {40646, prefixRepetitionCount=true},
      LeftMidiGridDivision = {40047, midiCommand=true, prefixRepetitionCount=true},
      LoopEnd = 40633,
      LoopSelection = "SetTimeSelectionToLoopSelection",
      LoopStart = 40632,
      MakeFolder = "_SWS_MAKEFOLDER",
      MarkedRegion = {lib.marks.recallMarkedRegion, registerAction=true},
      MarkedTimelinePosition = {lib.marks.recallMarkedTimelinePosition, registerAction=true},
      MarkedTracks = {lib.marks.recallMarkedTracks, registerAction=true},
      Mark = {lib.marks.save, registerAction=true},
      MatchedTrackBackward = {"MatchTrackNameBackward", "ScrollToSelectedTracks"},
      MatchedTrackForward = {"MatchTrackNameForward", "ScrollToSelectedTracks"},
      MatchTrackNameBackward = lib.matchTrackNameBackward,
      MatchTrackNameForward = lib.matchTrackNameForward,
      MidiCCMoveLeftByGrid = {40672, prefixRepetitionCount=true},
      MidiCCMoveLeftByPixel = {40674, prefixRepetitionCount=true},
      MidiCCMoveRightByGrid = {40673, prefixRepetitionCount=true},
      MidiCCMoveRightByPixel = {40675, prefixRepetitionCount=true},
      MidiExportContent = 40038,
      MidiLearnLastTouchedFxParam = 41144,
      MidiLoadNoteCCNames = 40409,
      MidiOptionAllowAllMediaItemsEditableInNotationView = 41774,
      MidiOptionAllowCCShapeInBankAndLSBLanes = 42100,
      MidiOptionAvoidAutomaticallySettingMIDIItemsFromOtherTracksEditable = 40901,
      MidiOptionEnableExtendingParentMediaItem = 40817,
      MidiOptionToggleAlwaysSnapNotesToTheLeftItSnap = 40748,
      MidiPaste = {40011, midiCommand=true, prefixRepetitionCount=true},
      MidiSaveNoteCCNames = 40410,
      MidiTimeSelectionEnd = {40881, midiCommand=true},
      MidiTimeSelectionStart = {40880, midiCommand=true},
      MidiViewModeDrums = 40043,
      MidiViewModeEvent = 40056,
      MidiViewModeNotes = 40954,
      MidiViewModePiano = 40042,
      MidiViewNoteRowsHideUnused = 40453,
      MidiViewNoteRowsHideUnusedAndUnnamed = 40454,
      MidiViewNoteRowsShowAll = 40452,
      MidiZoomContent = {40466, midiCommand=true},
      MidiZoomInHoriz = {1012, midiCommand=true, prefixRepetitionCount=true},
      MidiZoomInVert = {40111, midiCommand=true, prefixRepetitionCount=true},
      MidiZoomLoopSelection = {40726, midiCommand=true},
      MidiZoomOutHoriz = {1011, midiCommand=true, prefixRepetitionCount=true},
      MidiZoomOutVert = {40112, midiCommand=true, prefixRepetitionCount=true},
      MidiZoomTimeSelection = {"SaveLoopSelection", "SetLoopSelectionToTimeSelection", "MidiZoomLoopSelection", "RestoreLoopSelection"},
      MinimizeTracks = "_SWS_MINTRACKS",
      MixerShowHideChildrenOfSelectedTrack = 41665,
      ModulateLastTouchedFxParam = 41143,
      Mouse = 40514,
      MouseAndSnap = 40513,
      MoveEditCursorToNextTransientInSelectedItems = {40375, prefixRepetitionCount=true},
      MoveEditCursorToPrevTransientInSelectedItems = {40376, prefixRepetitionCount=true},
      MoveNoteDownOctave= {40180, midiCommand=true, prefixRepetitionCount=true},
      MoveNoteDownSemitone = {40178, midiCommand=true, prefixRepetitionCount=true},
      MoveNoteLeft = {40183, midiCommand=true, prefixRepetitionCount=true},
      MoveNoteLeftFine = {40181, midiCommand=true, prefixRepetitionCount=true},
      MoveNoteRight= {40184, midiCommand=true, prefixRepetitionCount=true},
      MoveNoteRightFine = {40182, midiCommand=true, prefixRepetitionCount=true},
      MoveNoteUpOctave= {40179, midiCommand=true, prefixRepetitionCount=true},
      MoveNoteUpSemitone = {40177, midiCommand=true, prefixRepetitionCount=true},
      MoveRedo = {"_SWS_EDITCURREDO", prefixRepetitionCount=true},
      MoveSelectedItemLeftToEditCursor = 41306,
      MoveSelectedItemRightToEditCursor = 41307,
      MoveToFirstItem = {"SelectFirstItemOnSelectedTracks", "MoveToFirstItem"},
      MoveToMouseAndPlay = {"Mouse", "TransportPlay"},
      MoveToMouseAndPlaySnap = {"MouseAndSnap", "TransportPlay"},
      MoveUndo = {"_SWS_EDITCURUNDO", prefixRepetitionCount=true},
      NewProjectTab = 40859,
      Next10Track = {"NextTrack", repetitions=10, prefixRepetitionCount=true},
      Next4Beats = {"NextBeat", repetitions=4, prefixRepetitionCount=true},
      Next4Measures = {"NextMeasure", repetitions=4, prefixRepetitionCount=true},
      Next5Track = {"NextTrack", repetitions=5, prefixRepetitionCount=true},
      NextBeat = 40841,
      NextBigItemEnd = {custom.move.nextBigItemEnd, prefixRepetitionCount=true},
      NextBigItemStart = {custom.move.nextBigItemStart, prefixRepetitionCount=true},
      NextEnvelope = {41864, prefixRepetitionCount=true},
      NextEnvelopePoint = {"_SWS_BRMOVEEDITTONEXTENV", prefixRepetitionCount=true},
      NextFolderNear = {"_SWS_SELNEARESTNEXTFOLDER", "ScrollToSelectedTracks", prefixRepetitionCount=true},
      NextItemEnd = {custom.move.nextItemEnd, prefixRepetitionCount=true},
      NextItemStart = {custom.move.nextItemStart, prefixRepetitionCount=true},
      NextMarker = {40173, prefixRepetitionCount=true},
      NextMeasure = {40839, prefixRepetitionCount=true},
      NextNoteEnd = {"SelectNextNote", "EventSelectionEnd", prefixRepetitionCount=true},
      NextNoteSamePitchEnd = {"SelectNextNoteSamePitch", "EventSelectionEnd", prefixRepetitionCount=true},
      NextNoteSamePitchStart = {"SelectNextNoteSamePitch", "EventSelectionStart", prefixRepetitionCount=true},
      NextNoteStart = {"SelectNextNote", "EventSelectionStart", prefixRepetitionCount=true},
      NextRegion = {"SetLoopRegionToNextRegion", "LoopStart", "SetTimeSelectionToLoopSelection", prefixRepetitionCount=true},
      NextTab = {40861, prefixRepetitionCount=true},
      NextTake = {40125, prefixRepetitionCount=true},
      NextTrack = {40285, prefixRepetitionCount=true},
      NextTrackMatchBackward = {"RepeatTrackNameMatchBackward", "ScrollToSelectedTracks", prefixRepetitionCount=true},
      NextTrackMatchForward = {"RepeatTrackNameMatchForward", "ScrollToSelectedTracks", prefixRepetitionCount=true},
      NextTransientInItem = {"SaveItemSelection", "SelectItemsUnderEditCursor", "MoveEditCursorToNextTransientInSelectedItems", "RestoreItemSelection", prefixRepetitionCount=true},
      NoOp = 65535,
      NudgeTrackPanLeft10Times = {"NudgeTrackPanLeft", repetitions=10, prefixRepetitionCount=true},
      NudgeTrackPanLeft = {40283, prefixRepetitionCount=true},
      NudgeTrackPanRight10Times = {"NudgeTrackPanRight", repetitions=10, prefixRepetitionCount=true},
      NudgeTrackPanRight = {40284, prefixRepetitionCount=true},
      NudgeTrackPanRight = {40284, prefixRepetitionCount=true},
      NudgeTrackVolumeDownBy1 = {"NudgeTrackVolumeDown", repetitions=20, prefixRepetitionCount=true},
      NudgeTrackVolumeDownBy1Tenth = {"NudgeTrackVolumeDown", repetitions=2}, prefixRepetitionCount=true,
      NudgeTrackVolumeUp = {40115, prefixRepetitionCount=true},
      NudgeTrackVolumeUpBy1 = {"NudgeTrackVolumeUp", repetitions=20}, prefixRepetitionCount=true,
      NudgeTrackVolumeUpBy1Tenth = {"NudgeTrackVolumeUp", repetitions=2}, prefixRepetitionCount=true,
      OnlySelectItemsCrossingTimeAndTrackSelection = {"UnselectItems", "SelectItemsCrossingTimeAndTrackSelection"},
      OpenMidiEditor = 40153,
      OpenProject = 40025,
      PasteAbove = {"PrevTrack", "Paste", prefixRepetitionCount=true},
      PasteFxChain = {"_S&M_SMART_PST_FxCHAIN", prefixRepetitionCount=true},
      PasteItem = {40058, prefixRepetitionCount=true},
      Paste = {"_SWS_AWPASTE", prefixRepetitionCount=true},
      PitchDown = {40050, midiCommand=true, prefixRepetitionCount=true},
      PitchDown7 = {"PitchDown", repetitions=7, prefixRepetitionCount=true},
      PitchDownOctave = {40188, midiCommand=true, prefixRepetitionCount=true},
      PitchUp = {40049, midiCommand=true, prefixRepetitionCount=true},
      PitchUp7 = {"PitchUp", repetitions=7, prefixRepetitionCount=true},
      PitchUpOctave = {40187, midiCommand=true, prefixRepetitionCount=true},
      PlayAndLoop = {"SetLoopSelectionToTimeSelection", "SaveEditCursorPosition", "LoopStart", "TransportPlay", "RestoreEditCursorPosition",  setTimeSelection=true},
      PlayFromMouse = "_BR_PLAY_MOUSECURSOR",
      PlayFromTimeSelectionStart = {"SaveEditCursorPosition", "TimeSelectionStart", "TransportPlay", "RestoreEditCursorPosition"},
      PlayMacro = {registerAction=true, metaCommand=true, prefixRepetitionCount=true},
      PlayPosition = 40434,
      PlayPositionAndSnap = {"PlayPosition", "LeftGridDivision"},
      Prev10Track = {"PrevTrack", repetitions=10, prefixRepetitionCount=true},
      Prev4Beats = {"PrevBeat", repetitions=4, prefixRepetitionCount=true},
      Prev4Measures = {"PrevMeasure", repetitions=4, prefixRepetitionCount=true},
      Prev5Track = {"PrevTrack", repetitions=5, prefixRepetitionCount=true},
      PrevBeat = {40842, prefixRepetitionCount=true},
      PrevBigItemStart = {custom.move.prevBigItemStart, prefixRepetitionCount=true},
      PrevEnvelope = {41863, prefixRepetitionCount=true},
      PrevEnvelopePoint = {"_SWS_BRMOVEEDITTOPREVENV", prefixRepetitionCount=true},
      PrevFolderNear = {"_SWS_SELNEARESTPREVFOLDER", "ScrollToSelectedTracks", prefixRepetitionCount=true},
      PrevItemStart = {custom.move.prevItemStart, prefixRepetitionCount=true},
      PrevMarker = {40172, prefixRepetitionCount=true},
      PrevMeasure = {40840, prefixRepetitionCount=true},
      PrevNoteEnd = {"SelectPrevNote", "EventSelectionEnd", prefixRepetitionCount=true},
      PrevNoteSamePitchEnd = {"SelectPrevNoteSamePitch", "EventSelectionEnd", prefixRepetitionCount=true},
      PrevNoteSamePitchStart = {"SelectPrevNoteSamePitch", "EventSelectionStart", prefixRepetitionCount=true},
      PrevNoteStart = {"SelectPrevNote", "EventSelectionStart", prefixRepetitionCount=true},
      PrevRegion = {"SetLoopRegionToPrevRegion", "LoopStart", "SetTimeSelectionToLoopSelection", prefixRepetitionCount=true},
      PrevTab = {40862, prefixRepetitionCount=true},
      PrevTake = {40126, prefixRepetitionCount=true},
      PrevTrack = {40286, prefixRepetitionCount=true},
      PrevTransientInItem = {"SaveItemSelection", "SelectItemsUnderEditCursor", "MoveEditCursorToPrevTransientInSelectedItems", "RestoreItemSelection", prefixRepetitionCount=true},
      ProjectEnd = custom.move.projectEnd,
      ProjectStart = custom.move.projectStart,
      ProjectTimeline = custom.select.innerProjectTimeline,
      Quantize = {40009, midiCommand=true},
      RecallMark = {lib.marks.recall, registerAction=true},
      RecordConditional = {"TransportStop", "ToggleRecordConditional"},
      RecordMacro = {metaCommand=true, registerAction=true, registerOptional=true},
      RecordOrStop = "_SWS_RECTOGGLE",
      Record = {"SaveEditCursorPosition", "TimeSelectionStart", "RecordConditional", "RestoreEditCursorPosition", setTimeSelection=true},
      Redo = {40030, prefixRepetitionCount=true},
      Region = custom.select.innerRegion,
      RegionSelectItems = 40717,
      RemoveMarker = 40613,
      RemoveRegion = 40615,
      RemoveTimeSelection = 40635,
      RemoveTrack = 40005,
      RenameTrack = 40696,
      RenderProject = 40015,
      RenderProjectWithLastSetting = 41824,
      RenderTrack = "_SWS_AWRENDERSTEREOSMART",
      RepeatLastCommand = {metaCommand=true, prefixRepetitionCount=true},
      RepeatTrackNameMatchBackward = lib.repeatTrackNameMatchBackward,
      RepeatTrackNameMatchForward = lib.repeatTrackNameMatchForward,
      ResetAllControlSurfaceDevices = 42348,
      ResetAllMidiDevices = 41175,
      ResetControlDevices = {"ResetAllMidiDevices", "ResetAllControlSurfaceDevices"},
      ResetSelection = {"SelectOnlyCurrentTrack", "UnselectItems", "UnselectEnvelopePoints", "UnselectAllEvents"},
      Reset = {"Stop", "SetModeNormal", "SetRecordModeNormal", "ResetSelection"},
      ResetTrackToNormal = {"UnarmSelectedTracks", "UnarmAllEnvelopes", "SetAutomationModeTrimRead"},
      RestoreEditCursorPosition = "_BR_RESTORE_CURSOR_POS_SLOT_16",
      RestoreItemSelection = "_SWS_RESTALLSELITEMS1",
      RestoreLastItemSelection = "_SWS_RESTLASTSEL",
      RestoreLoopSelection = "_SWS_RESTLOOP5",
      RestoreTimeSelection = "_SWS_RESTTIME5",
      RestoreTrackSelection = "_SWS_TOGSAVESEL",
      Right10Pix = {"_XENAKIOS_MOVECUR10PIX_RIGHT", prefixRepetitionCount=true},
      Right40Pix = {"Right10Pix", repetitions=4, prefixRepetitionCount=true},
      RightGridDivision = {40647, prefixRepetitionCount=true},
      RightMidiGridDivision = {40048, midiCommand=true, prefixRepetitionCount=true},
      SaveEditCursorPosition = "_BR_SAVE_CURSOR_POS_SLOT_16",
      SaveItemSelection = "_SWS_SAVEALLSELITEMS1",
      SaveLoopSelection = "_SWS_SAVELOOP5",
      SaveProject = 40026,
      SaveTimeSelection = "_SWS_SAVETIME5",
      SaveTrackSelection = "_SWS_SAVESEL",
      ScrollToPlayPosition = 40150,
      ScrollToSelectedTracks = 40913,
      SelectAllItems = 40182,
      SelectAllNotesAtPitch = {41746, midiCommand=true},
      SelectAllTracks = 40296,
      SelectedItems = {"RemoveTimeSelection", "_SWS_SAFETIMESEL"},
      SelectedNotes = {40752, midiCommand=true},
      SelectEnvelopePoints = 40330,
      SelectEventsInTimeSelection = {40876, midiCommand=true},
      SelectFirstItemOnSelectedTracks = "_XENAKIOS_SELFIRSTITEMSOFTRACKS",
      SelectFirstOfSelectedTracks = "_XENAKIOS_SELFIRSTOFSELTRAX",
      SelectFolderChildren = "_SWS_SELCHILDREN",
      SelectFolderParent = "_SWS_SELPARENTS",
      SelectFolder = "_SWS_SELCHILDREN2",
      Selection = "NoOp",
      SelectItemsAndSplit = {"OnlySelectItemsCrossingTimeAndTrackSelection", "SplitItemsAtTimeSelection"},
      SelectItemsCrossingTimeAndTrackSelection = 40718,
      SelectItemsInGroups = 40034,
      SelectItemsOnTrack = 40421,
      SelectItems = "SelectItemsCrossingTimeAndTrackSelection",
      SelectItemsUnderEditCursor = "_XENAKIOS_SELITEMSUNDEDCURSELTX",
      SelectLastOfSelectedTracks = "_XENAKIOS_SELLASTOFSELTRAX",
      SelectLastTouchedTrack = 40505,
      SelectNearestNote = {40425, midiCommand=true},
      SelectNextNote = {40413, midiCommand=true},
      SelectNextNoteSamePitch = {40428, midiCommand=true},
      SelectNoteClosestToEditCursor = {40426, midiCommand=true},
      SelectNotes = "SelectNotesStartingInTimeSelection",
      SelectNotesStartingInTimeSelection = {40877, midiCommand=true},
      SelectOnlyCurrentTrack = custom.select.onlyCurrentTrack,
      SelectOnlyFoldersChildren = "_SWS_SELCHILDREN",
      SelectPrevNote = {40414, midiCommand=true},
      SelectPrevNoteSamePitch = {40427, midiCommand=true},
      SelectTracks = {setTrackSelection=true},
      SetAutomationModeLatch = 40404,
      SetAutomationModeLatchAndArm = {"SetAutomationModeLatch", "ArmAllEnvelopes"},
      SetAutomationModeLatchPreview = 42023,
      SetAutomationModeRead = 40401,
      SetAutomationModeTouch = 40402,
      SetAutomationModeTouchAndArm = {"SetAutomationModeTouch", "ArmAllEnvelopes"},
      SetAutomationModeTrimRead = 40400,
      SetAutomationModeWrite = 40403,
      SetEnvelopeShapeBezier = 40683,
      SetEnvelopeShapeFastEnd = 40429,
      SetEnvelopeShapeFastStart = 40428,
      SetEnvelopeShapeLinear = 40189,
      SetEnvelopeShapeSlowStart = 40424,
      SetEnvelopeShapeSquare = 40190,
      SetFirstSelectedTrackAsLastTouchedTrack = 40914,
      SetGlobalAutomationModeLatch = 40881,
      SetGlobalAutomationModeLatchPreview = 42022,
      SetGlobalAutomationModeOff = 40876,
      SetGlobalAutomationModeRead = 40879,
      SetGlobalAutomationModeTouch = 40880,
      SetGlobalAutomationModeTrimRead = 40878,
      SetGlobalAutomationModeWrite = 40882,
      SetGridDivision = custom.setGridDivision,
      SetItemFadeBoundaries = {"SelectItemsCrossingTimeAndTrackSelection", "SetSelectedItemFadeBoundaries"},
      SetItemsTimebaseToBeatsPosLengthAndRate = "_SWS_AWITEMTBASEBEATALL",
      SetItemsTimebaseToBeatsPos = "_SWS_AWITEMTBASEBEATPOS",
      SetItemsTimebaseToDefault = "_SWS_AWITEMTBASEPROJ",
      SetItemsTimebaseToTime = "_SWS_AWITEMTBASETIME",
      SetLoopEnd = 40223,
      SetLoopRegionToNextRegion = "_SWS_SELNEXTREG",
      SetLoopRegionToPrevRegion = "_SWS_SELPREVREG",
      SetLoopSelectionToTimeSelection = 40622,
      SetLoopStart = 40222,
      SetMidiGridDivision = custom.setMidiGridDivision,
      SetModeNormal = lib.state.setModeNormal,
      SetModeVisualTimeline = lib.state.setModeVisualTimeline,
      SetModeVisualTrack = lib.state.setModeVisualTrack,
      SetProjectTimebaseToBeatsPosLengthAndRate = "_SWS_AWTBASEBEATALL",
      SetProjectTimebaseToBeatsPos = "_SWS_AWTBASEBEATPOS",
      SetProjectTimebaseToTime = "_SWS_AWTBASETIME",
      SetRecordInput = 40496,
      SetRecordMidiOutput = 40500,
      SetRecordMidiOverdub = 40503,
      SetRecordMidiReplace = 40504,
      SetRecordMidiTouchReplace = 40852,
      SetRecordModeItemSelectionAutoPunch = 40253,
      SetRecordModeNormal = 40252,
      SetRecordModeTimeSelectionAutoPunch = 40076,
      SetRecordMonitorOnly = 40498,
      SetSelectedItemFadeBoundaries = "_SWS_AWFADESEL",
      SetTimeSelectionEnd = 40626,
      SetTimeSelectionStart = 40625,
      SetTimeSelectionToLoopSelection = 40623,
      SetTrackMidiAllChannels = "_S&M_MIDI_INPUT_ALL_CH",
      ShiftTimeSelectionLeft = 40037,
      ShiftTimeSelectionRight = 40038,
      ShowActionList = 40605,
      ShowNextFx= {"_S&M_WNONLY2", prefixRepetitionCount=true},
      ShowPreferences = 40016,
      ShowPrevFx = {"_S&M_WNONLY1", prefixRepetitionCount=true},
      ShowProjectSettings = 40021,
      ShowReaperKeysHelp = {metaCommand=true},
      ShowRoutingMatrix = 40251,
      ShowTrackFreezeDetails = 41654,
      ShowTrackManager = 40906,
      ShowTrackRouting = 40293,
      ShowWiringDiagram = 42031,
      SnapshotsAddAndName = "_SWSSNAPSHOT_NEWEDIT",
      SnapshotsAddNewAllTracks = "_SWSSNAPSHOT_NEWALL",
      SnapshotsAddNew = "_SWSSNAPSHOT_NEW",
      SnapshotsDeleteCurrent = "_SWSSNAPSHOT_DELCUR",
      SnapshotsOpenWindow = "_SWSSNAPSHOT_OPEN",
      SnapshotsRecallCurrent1 = "_SWSSNAPSHOT_GET",
      SnapshotsRecallCurrent = "_SWSSNAPSHOT_GET",
      SnapshotsRecallNext = "_SWSSNAPSHOT_GET_NEXT",
      SnapshotsRecallPrev = "_SWSSNAPSHOT_GET_PREVIOUS",
      SnapshotsSaveCurrent = "_SWSSNAPSHOT_SAVE",
      SplitAndSelectItemsInRegion = "_S&M_SPLIT11",
      SplitAtTimeSelection = 40061,
      SplitItemsAtEditCursor = {"UnselectItems", "SelectItemsUnderEditCursor", "SplitItemsUnderEditCursor", "UnselectItems"},
      SplitItemsAtTimeSelection = custom.splitItemsAtTimeSelection,
      SplitItemsUnderEditCursor = 40757,
      StartOfSel = {40440, midiCommand=true},
      StartOfSelectedItems = 41173,
      StartStop = 40044,
      Stop = 40667,
      StopRecordMacro = {metaCommand=true},
      SwitchTimelineSelectionSide = lib.state.switchTimelineSelectionSide,
      TapTempo = 1134,
      TimeSelectionEnd = 40631,
      TimeSelection = "NoOp",
      TimeSelectionStart = 40630,
      ToggleArmAllEnvelopes = "_S&M_TGLARMALLENVS",
      ToggleArmEnvelope = 40863,
      ToggleAutoCrossfade = 40041,
      ToggleCountInBeforePlayback = "_SWS_AWCOUNTPLAYTOG",
      ToggleCountInBeforeRec = "_SWS_AWCOUNTRECTOG",
      ToggleEnvelopePointsMoveWithItems = 40070,
      ToggleFloatingWindows = 41074,
      ToggleFxBypass = 8,
      ToggleLoop = 1068,
      ToggleLoopSelectionFollowsTimeSelection = 40621,
      ToggleMetronome = 40364,
      ToggleMidiEditorUsesMainGridDivision = 42010,
      ToggleMidiSnap = {1014, midiCommand=true},
      ToggleMute = 6,
      ToggleMuteItem = 40175,
      TogglePanEnvelope = 40407,
      TogglePlaybackAutoScroll = 40036,
      TogglePlaybackPreroll = 41818,
      ToggleRecord = 1013,
      ToggleRecordConditional = "_SWS_AWRECORDCOND",
      ToggleRecordingAutoScroll = 40262,
      ToggleRecordingPreroll = 41819,
      ToggleRecordToTapeMode = 41186,
      ToggleRegionMarkerManager = 40326,
      ToggleShowAllEnvelope = 41151,
      ToggleShowAllEnvelopeGlobal = 41152,
      ToggleShowFx1 = "_S&M_TOGLFLOATFx1",
      ToggleShowFx2 = "_S&M_TOGLFLOATFx2",
      ToggleShowFx3 = "_S&M_TOGLFLOATFx3",
      ToggleShowFx4 = "_S&M_TOGLFLOATFx4",
      ToggleShowFx5 = "_S&M_TOGLFLOATFx5",
      ToggleShowFx6 = "_S&M_TOGLFLOATFx6",
      ToggleShowFx7 = "_S&M_TOGLFLOATFx7",
      ToggleShowFx8 = "_S&M_TOGLFLOATFx8",
      ToggleShowFxChain = "_S&M_TOGLFxCHAIN",
      ToggleShowFx = "_S&M_WNTGL5",
      ToggleShowSelectedEnvelope = 40884,
      ToggleShowTracksInMixer = 41592,
      ToggleSnap = 1157,
      ToggleSolo = 7,
      ToggleStopAtEndOfTimeSelectionIfNoRepeat = 41834,
      ToggleViewMixer = 40078,
      ToggleVolumeEnvelope = 40406,
      TrackSetInputToMatchFirstSelected = "_SWS_INPUTMATCH",
      TrackToggleSendToParent = "_SWS_TOGMPSEND",
      TrackWithNumber = custom.move.trackWithNumber,
      TransportPause = 1008,
      TransportPlay = 1007,
      TransportStop = 1016,
      TrimSelectedItemLeftEdgeToEditCursor = 41305,
      TrimSelectedItemRightEdgeToEditCursor = 41311,
      TrimSelectedNoteLeftEdgeToEditCursor = 40790,
      TrimSelectedNoteRightEdgeToEditCursor = 40791,
      UnarmAllEnvelopes = 41163,
      UnarmSelectedTracks = "_XENAKIOS_SELTRAX_RECUNARMED",
      UncollapseFolder = "_SWS_UNCOLLAPSE",
      Undo = {40029, prefixRepetitionCount=true},
      UnfreezeTrack = 41644,
      UnmuteAllTracks = 40339,
      UnselectAllEvents = {40214, midiCommand=true},
      UnselectEnvelopePoints = 40331,
      UnselectItems = 40289,
      UnselectTracks = 40297,
      UnsoloAllTracks = 40340,
      VerticalScrollEnd = "_XENAKIOS_TVPAGEEND",
      VerticalScrollStart = "_XENAKIOS_TVPAGEHOME",
      ViewFxChainInputCurrentTrack = 40844,
      ViewFxChainMaster = 40846,
      ZoomAllItems = {"SaveItemSelection", "SelectAllItems", "ZoomItemSelection", "RestoreItemSelection"},
      ZoomAllTracks = {"SaveTrackSelection", "SelectAllTracks", "ZoomTrackSelection", "RestoreTrackSelection"},
      ZoomInHoriz = {1012, prefixRepetitionCount=true},
      ZoomInVert = {40111, prefixRepetitionCount=true},
      ZoomItemSelection = "_SWS_HZOOMITEMS",
      ZoomOutHoriz = {1011, prefixRepetitionCount=true},
      ZoomOutVert = {40112, prefixRepetitionCount=true},
      ZoomProjectTimeline = 40295,
      ZoomProject = {"ZoomAllTracks", "ZoomAllItems"},
      ZoomRedo = {"_SWS_REDOZOOM", prefixRepetitionCount=true},
      ZoomTimeAndTrackSelection = {"ZoomTrackSelection", "ZoomTimeSelection"},
      ZoomTimeSelection = 40031,
      ZoomTrackSelection = "_SWS_VZOOMFITMIN",
      ZoomUndo = {"_SWS_UNDOZOOM", prefixRepetitionCount=true},
      NudgeTrackVolumeDown = 40116, -- 0.05 dB
}
