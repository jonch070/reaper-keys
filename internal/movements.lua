local utils = require "movement_utils"
local actions = {}

-- Track accumulator registers for building multi-track selections with 'x<register>'
-- Stored in project extended state to persist across script reloads
-- Each register stores a list of track indices that persist across navigation
-- Example: accumulated_tracks['a'] = {0, 2, 5} means tracks 0, 2, 5 are in register 'a'

local serpent = require 'serpent'

local function getAccumulatorRegister(register)
    -- Normalize to lowercase
    register = string.lower(register)
    local ok, value = reaper.GetProjExtState(0, "track_accumulators", register)
    if not ok or not value or value == "" then return {} end
    local track_list
    ok, track_list = serpent.load(value)
    if not ok or not track_list then return {} end
    return track_list
end

local function setAccumulatorRegister(register, track_list)
    -- Normalize to lowercase
    register = string.lower(register)
    reaper.SetProjExtState(0, "track_accumulators", register, serpent.block(track_list, { comment = false }))
end

local function getAllAccumulatorRegisters()
    local all_registers = {}
    for i = 0, 5000 do
        local ok, register, value = reaper.EnumProjExtState(0, "track_accumulators", i)
        if not ok then break end
        local track_list
        ok, track_list = serpent.load(value)
        if ok and track_list then
            all_registers[register] = track_list
        end
    end
    return all_registers
end

function actions.projectStart() reaper.SetEditCurPos(0, true, false) end

function actions.projectEnd() reaper.SetEditCurPos(reaper.GetProjectLength(0), true, false) end

function actions.firstItemStart()
    local len = reaper.GetProjectLength(0)
    local start = len
    for i = 0, reaper.CountSelectedTracks() - 1 do
        local item = reaper.GetTrackMediaItem(reaper.GetSelectedTrack(0, i), 0)
        if not item then goto next_track end
        local pos = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
        if pos < start then start = pos end
        ::next_track::
    end
    if start < len then reaper.SetEditCurPos(start, true, false) end
end

function actions.lastItemEnd()
    local last_end = 0
    for i = 0, reaper.CountSelectedTracks() - 1 do
        local track = reaper.GetSelectedTrack(0, i)
        local items = reaper.GetTrackNumMediaItems(track)
        if items == 0 then goto next_track end
        local item = reaper.GetTrackMediaItem(track, items - 1)
        local pos = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
            + reaper.GetMediaItemInfo_Value(item, "D_LENGTH")
        if pos > last_end then last_end = pos end
        ::next_track::
    end
    if last_end > 0 then reaper.SetEditCurPos(last_end, true, false) end
end

function actions.prevItemStart()
    local cur = reaper.GetCursorPosition()
    local start = -1
    for i = 0, reaper.CountSelectedTracks() - 1 do
        local track = reaper.GetSelectedTrack(0, i)
        for j = 0, reaper.GetTrackNumMediaItems(track) - 1 do
            local item = reaper.GetTrackMediaItem(track, j)
            local pos = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
            local len = reaper.GetMediaItemInfo_Value(item, "D_LENGTH")
            if cur > pos and cur <= len then return reaper.SetEditCurPos(pos, true, false) end
            if cur <= pos then goto next_track end
            if pos > start then start = pos end
        end
        ::next_track::
    end
    if start > -1 then reaper.SetEditCurPos(start, true, false) end
end

---@param to_end integer
local function nextItem(to_end)
    local cur = reaper.GetCursorPosition()
    local proj_end = reaper.GetProjectLength(0)
    local next_pos = proj_end + 1
    for i = 0, reaper.CountSelectedTracks() - 1 do
        local track = reaper.GetSelectedTrack(0, i)
        for j = 0, reaper.GetTrackNumMediaItems(track) - 1 do
            local item = reaper.GetTrackMediaItem(track, j)
            local pos = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
            local len = reaper.GetMediaItemInfo_Value(item, "D_LENGTH")
            if to_end == 1 and cur >= pos and cur < len then return reaper.SetEditCurPos(pos + len, true, false) end
            pos = pos + to_end * len
            if cur < pos and pos < next_pos then next_pos = pos end
        end
    end
    if next_pos < proj_end + 1 then reaper.SetEditCurPos(next_pos, true, false) end
end

function actions.nextItemStart() nextItem(0) end

function actions.nextItemEnd() nextItem(1) end

function actions.prevBigItemStart()
    local item_positions = utils.getBigItemPositionsOnSelectedTracks()
    local pos = reaper.GetCursorPosition()
    local next_position = nil
    for i, item in pairs(item_positions) do
        if not next_position and item.left < pos and item.right >= pos then
            next_position = item.left
        end

        if next_position and item.left > next_position and item.right >= next_position then
            next_position = item.left
        end

        local next_item = item_positions[i + 1]
        if not next_item or next_item.left >= pos then
            next_position = item.left
            break
        end
    end

    if next_position then reaper.SetEditCurPos(next_position, true, false) end
end

function actions.nextBigItemStart()
    local item_positions = utils.getBigItemPositionsOnSelectedTracks()
    local pos = reaper.GetCursorPosition()
    local next_position = nil
    for _, item_position in pairs(item_positions) do
        if not next_position and pos < item_position.left then
            next_position = item_position.left
        end
        if next_position and item_position.left < next_position then
            next_position = item_position.left
        end
    end
    if next_position then reaper.SetEditCurPos(next_position, true, false) end
end

function actions.nextBigItemEnd()
    local item_positions = utils.getBigItemPositionsOnSelectedTracks()
    local current_position = reaper.GetCursorPosition()
    local next_position = nil
    local tolerance = .002
    for _, item_position in pairs(item_positions) do
        if not next_position and item_position.right - tolerance > current_position then
            next_position = item_position.right
        elseif next_position and item_position.right < next_position and item_position.right > current_position then
            next_position = item_position.right
        end
    end
    if next_position then
        reaper.SetEditCurPos(next_position, true, false)
    end
end

function actions.firstTrack()
    local track = reaper.GetTrack(0, 0)
    if track then reaper.SetOnlyTrackSelected(track) end
end

function actions.lastTrack()
    local num = reaper.GetNumTracks()
    if num ~= 0 then reaper.SetOnlyTrackSelected(reaper.GetTrack(0, num - 1)) end
end

function actions.toTrack(num)
    if num == 0 then return end
    local track = reaper.GetTrack(0, num - 1)
    if track then reaper.SetOnlyTrackSelected(track) end
end

function actions.trackWithNumber()
    local ok, str = reaper.GetUserInputs("Match Forward", 1, "Track Number", "")
    if not ok then return end
    local num = tonumber(str)
    if num < 1 then return end
    local track = reaper.GetTrack(0, num - 1)
    if track then reaper.SetOnlyTrackSelected(track) end
end

function actions.firstTrackWithItem()
    for i = 0, reaper.GetNumTracks() - 1 do
        local track = reaper.GetTrack(0, i)
        if reaper.GetTrackNumMediaItems(track) > 0 then
            return reaper.SetOnlyTrackSelected(track)
        end
    end
end

function actions.snap()
    local pos = reaper.GetCursorPosition()
    local snapped_pos = reaper.SnapToGrid(0, pos)
    reaper.SetEditCurPos(snapped_pos, false, false)
end

function actions.innerProjectTimeline()
    local len = reaper.GetProjectLength(0)
    reaper.GetSet_LoopTimeRange(true, false, 0, len, false)
end

function actions.innerItem()
    local item_positions = utils.getItemPositionsOnSelectedTracks()
    local cur = reaper.GetCursorPosition()
    for i = #item_positions, 1, -1 do
        local item = item_positions[i]
        if item.left <= cur and item.right >= cur then
            return reaper.GetSet_LoopTimeRange(true, false, item.left, item.right, false)
        end
    end
end

function actions.innerBigItem()
    local item_positions = utils.getBigItemPositionsOnSelectedTracks()
    local current_position = reaper.GetCursorPosition()
    for i = #item_positions, 1, -1 do
        local item = item_positions[i]
        if item.left <= current_position and item.right >= current_position then
            reaper.GetSet_LoopTimeRange(true, false, item.left, item.right, false)
            break
        end
    end
end

function actions.onlyCurrentTrack()
    local track = reaper.GetSelectedTrack(0, 0)
    if track then reaper.SetOnlyTrackSelected(track) end
end

-- Custom track navigation that preserves accumulated selections
function actions.nextTrackPreservingAccumulators()
    -- Get currently selected track
    local current_track = reaper.GetSelectedTrack(0, 0)
    if not current_track then return end

    local current_idx = reaper.GetMediaTrackInfo_Value(current_track, "IP_TRACKNUMBER") - 1
    local next_idx = current_idx + 1
    local next_track = reaper.GetTrack(0, next_idx)

    if next_track then
        -- Clear all selections first, then select only the next track
        -- This ensures GetSelectedTrack(0, 0) returns the new track
        reaper.Main_OnCommand(40297, 0) -- UnselectAllTracks
        reaper.SetTrackSelected(next_track, true)
        reaper.Main_OnCommand(40913, 0) -- ScrollToSelectedTracks

        -- Restore all accumulators (deferred so it happens after selection is stable)
        actions.restoreAllAccumulators()
    end
end

function actions.prevTrackPreservingAccumulators()
    -- Get currently selected track
    local current_track = reaper.GetSelectedTrack(0, 0)
    if not current_track then return end

    local current_idx = reaper.GetMediaTrackInfo_Value(current_track, "IP_TRACKNUMBER") - 1
    local prev_idx = current_idx - 1

    if prev_idx >= 0 then
        local prev_track = reaper.GetTrack(0, prev_idx)
        if prev_track then
            -- Clear all selections first, then select only the prev track
            -- This ensures GetSelectedTrack(0, 0) returns the new track
            reaper.Main_OnCommand(40297, 0) -- UnselectAllTracks
            reaper.SetTrackSelected(prev_track, true)
            reaper.Main_OnCommand(40913, 0) -- ScrollToSelectedTracks

            -- Restore all accumulators (deferred so it happens after selection is stable)
            actions.restoreAllAccumulators()
        end
    end
end

---@param register string
function actions.toggleAccumulatorRegister(register)
    -- Normalize register to lowercase for consistency
    register = string.lower(register)

    -- Get the current track (first in selection after navigation)
    local current_track = reaper.GetSelectedTrack(0, 0)
    if not current_track then
        reaper.ShowConsoleMsg("toggleAccumulatorRegister: No track selected\n")
        return
    end

    -- Get current track index
    local current_idx = reaper.GetMediaTrackInfo_Value(current_track, "IP_TRACKNUMBER") - 1

    -- Load register from project state
    local track_list = getAccumulatorRegister(register)

    -- Debug: show what's in the register before we modify it
    if #track_list > 0 then
        local before_str = table.concat(track_list, ", ")
        reaper.ShowConsoleMsg(string.format("Before toggle - Register '%s': [%s]\n", register, before_str))
    else
        reaper.ShowConsoleMsg(string.format("Before toggle - Register '%s' is empty\n", register))
    end

    -- Check if track is in this register's accumulator
    local is_accumulated = false
    local accumulated_idx = nil
    for i, idx in ipairs(track_list) do
        if idx == current_idx then
            is_accumulated = true
            accumulated_idx = i
            break
        end
    end

    if is_accumulated then
        -- Remove from this register's accumulator
        table.remove(track_list, accumulated_idx)
        reaper.ShowConsoleMsg(string.format("Removed track %d from register '%s'\n", current_idx, register))
    else
        -- Add to this register's accumulator
        table.insert(track_list, current_idx)
        reaper.ShowConsoleMsg(string.format("Added track %d to register '%s'\n", current_idx, register))
    end

    -- Save register back to project state
    setAccumulatorRegister(register, track_list)

    -- Debug: show all registers
    reaper.ShowConsoleMsg("Current accumulators:\n")
    local all_registers = getAllAccumulatorRegisters()
    for reg, tracks in pairs(all_registers) do
        local track_str = table.concat(tracks, ", ")
        -- Normalize register name for display
        reaper.ShowConsoleMsg(string.format("  Register '%s': [%s]\n", string.lower(reg), track_str))
    end

    -- Restore all accumulated tracks from all registers
    actions.restoreAllAccumulators()
end

function actions.restoreAllAccumulators()
    -- Use defer to run after navigation action completes
    reaper.defer(function()
        -- Save the current track (the one selected by navigation)
        local current_track = reaper.GetSelectedTrack(0, 0)

        -- Load all registers from project state
        local all_registers = getAllAccumulatorRegisters()

        -- Collect all unique track indices from all registers
        local all_tracks = {}
        for register, track_list in pairs(all_registers) do
            for _, track_idx in ipairs(track_list) do
                all_tracks[track_idx] = true
            end
        end

        -- Select all accumulated tracks (this preserves the current track if it's accumulated)
        local count = 0
        for track_idx, _ in pairs(all_tracks) do
            local track = reaper.GetTrack(0, track_idx)
            if track then
                reaper.SetTrackSelected(track, true)
                count = count + 1
            end
        end

        -- If current track is not in any accumulator, also select it (for navigation)
        if current_track then
            local current_idx = reaper.GetMediaTrackInfo_Value(current_track, "IP_TRACKNUMBER") - 1
            if not all_tracks[current_idx] then
                reaper.SetTrackSelected(current_track, true)
                count = count + 1
            end
        end

        reaper.ShowConsoleMsg(string.format("restoreAllAccumulators: Selected %d tracks (deferred)\n", count))
    end)
end

---@param register string
function actions.recallAccumulatorRegister(register)
    -- Normalize register to lowercase
    register = string.lower(register)

    local track_list = getAccumulatorRegister(register)
    if #track_list == 0 then return end

    -- Clear current selection and select only tracks from this register
    reaper.Main_OnCommand(40297, 0) -- UnselectTracks
    for _, track_idx in ipairs(track_list) do
        local track = reaper.GetTrack(0, track_idx)
        if track then
            reaper.SetTrackSelected(track, true)
        end
    end
end

---@param register string
function actions.clearAccumulatorRegister(register)
    -- Normalize register to lowercase
    register = string.lower(register)

    setAccumulatorRegister(register, {})
    -- Restore remaining accumulators
    actions.restoreAllAccumulators()
end

function actions.clearAllAccumulators()
    -- Clear all registers from project state
    local all_registers = getAllAccumulatorRegisters()
    for register, _ in pairs(all_registers) do
        setAccumulatorRegister(register, {})
    end
end

function actions.innerRegion()
    local _, region_id = reaper.GetLastMarkerAndCurRegion(0, reaper.GetCursorPosition())
    local ok, is_region, start_pos, end_pos, _, _ = reaper.EnumProjectMarkers(region_id)
    if ok and is_region then reaper.GetSet_LoopTimeRange(true, false, start_pos, end_pos, false) end
end

function actions.clearTimeSelection()
    local pos = reaper.GetCursorPosition()
    reaper.GetSet_LoopTimeRange(true, false, pos, pos, false)
end

local function getUserGridDivisionInput()
    local ok, str = reaper.GetUserInputs("Set Grid Division", 1, "Fraction/Number", "")
    if not ok then return end
    local division = str:match("[0-9.]+")
    local fraction = str:match("/([0-9.]+)")
    if division and fraction and fraction ~= 0 then return division / fraction end
    if division and not fraction then return division end
    reaper.MB("Could not parse specified grid division " .. str, "Error", 0)
    return nil
end

function actions.setMidiGridDivision()
    local division = getUserGridDivisionInput()
    if division then reaper.SetMIDIEditorGrid(0, division) end
end

function actions.setGridDivision()
    local division = getUserGridDivisionInput()
    if division then reaper.SetProjectGrid(0, division) end
end

function actions.clearSelectedTimeline()
    local pos = reaper.GetCursorPosition()
    reaper.GetSet_LoopTimeRange(true, false, pos, pos, false)
end

-- this one avoids splitting all items across tracks in time selection, if no items are selected
function actions.splitItemsAtTimeSelection()
    if reaper.CountSelectedMediaItems(0) == 0 then return end
    reaper.Main_OnCommand(40061, 0) -- split at time selection
end

---@type integer
local paste = reaper.NamedCommandLookup("_SWS_AWPASTE")
-- Paste selected track-wise, skipping empty tracks.
-- SWS pastes on last touched track which is usually the bottom selected one
function actions.paste()
    local num = reaper.CountSelectedTracks()
    if num < 2 then return reaper.Main_OnCommand(paste, 0) end
    local selected = {}
    local first = nil
    for i = 0, num - 1 do
        local track = reaper.GetSelectedTrack(0, i)
        selected[i + 1] = track
        if not first and reaper.GetTrackNumMediaItems(track) > 0 then first = track end
    end
    if first then reaper.SetOnlyTrackSelected(first) end
    reaper.Main_OnCommand(paste, 0)
    for _, track in ipairs(selected) do reaper.SetTrackSelected(track, true) end
end

return actions
