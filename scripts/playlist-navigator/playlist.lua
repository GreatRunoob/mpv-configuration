-- exports a playlist manager "object"
-- 导出播放列表管理器对象

-- handles:
-- iterating over the playlist of files
-- 遍历播放列表中的文件
-- formatting either a regular list or circular buffer depending on how long
-- the list is
-- 根据列表长度格式化常规列表或者循环缓存
-- filtering the list by search
-- does not handle the OSD
-- 通过搜索过滤的列表不会涉及处理 OSD （方面的任何内容）

local utils = require("mp.utils")

local settings = {
    -- number of lines displayed
	-- 显示行的数量
    num_lines = 10,

    -- display line prefixes
	-- 显示行的前缀字符串标识（自定义）
    playing_str = "▶",	-- 当前正在播放
    cursor_str = "◉",	-- 当前光标选项
	unchecked_str = "⭕"	-- 当前未选中
}

-- this object is exported
-- 这个对象会被导出
local playlist = {
    -- index in playlist of currently playing video
	-- 当前正在播放的播放列表中的索引
    -- assume this is updated before display, including scrolling
	-- 假定这一项在显示前已经被更新了，包括滚动
    pos = 0,
    -- playlist length
	-- 播放列表长度
    len = 0,
    -- cursor iterates through playlist - bidirectional
	-- 光标遍历整个播放列表（双向的）
    cursor = 0,
    -- active manager - ie don't reset cursor
	-- 活动管理器（不重置光标）
    active = false,
    -- the actual playlist
	-- 实际的播放列表
    files = {}
}

-- 播放列表初始化
function playlist:init()
    self:update()
    self.files = self:get_playlist()
end

-- sync member variables to the values of their mirrored properties
-- 将成员变量同步大它们各自的镜像属性值中去
function playlist:update()
    self.pos = mp.get_property_number('playlist-pos', 0)
    self.len = mp.get_property_number('playlist-count', 0)
end

-- cursor movements
-- 光标移动：向上递增
function playlist:increment()
    self.cursor = (self.cursor + 1) % self.len
end

-- 光标移动：向下递减
function playlist:decrement()
    self.cursor = self.cursor - 1
    if self.cursor == -1 then
        self.cursor = self.len - 1
    end
end

-- 打印播放列表中的内容
function playlist:print()
    print(string.format("playlist: pos=%s, len=%s, cursor=%s",
            self.pos, self.len, self.cursor))
end

-- get the actual playlist from mpv as an array - 0-based
-- 从mpv中以数组的形式获取实际播放列表（基于0索引计数）
function playlist:get_playlist()
    local pl = {}
    for i=0, self.len-1, 1
    do
        local l_path, l_file = utils.split_path(mp.get_property('playlist/'..i..'/filename'))
        pl[i] = l_file
    end
    return pl
end

-- functions to prepare output
-- note - the playlist array is 0-based, but lua arrays are usually 1-based
-- 注意，播放列表数组是基于0索引计数的，但是lua数组通常是基于1开始计数的
-- so my display arrays are 1-based
-- 所以我的显示数组是基于1计数的

-- returns array of strings
-- 返回字符串数组
function playlist:short_list_display_lines(_playlist)
    local display_files = {}
    for i = 0, #_playlist do
        display_files[i+1] = _playlist[i]
		-- 对下列 if 逻辑进行了调整，现改为 if-elseif-else 增加了对当前未选中曲目的图标
		-- 个人不太喜欢原先允许图标重叠的样式，现在每种状态的列表文件仅对应一种图标
		-- 例如当前播放的文件会优先显示播放图标，若选中则不会额外显示选中图标
		-- 图标显示的优先级为: 播放▶ > 选中◉ > 未选中⭕
        if i == self.pos then
            display_files[i+1] = settings.playing_str..display_files[i+1]	-- 当前正在播放的文件
        elseif i == self.cursor then
            display_files[i+1] = settings.cursor_str..display_files[i+1]	-- 当前选中的文件
		else
			display_files[i+1] = settings.unchecked_str..display_files[i+1]	-- 当前未选中的文件
        end
    end
    return display_files
end

-- handles circular buffer display
-- 处理循环缓存的显示
-- returns array of strings
function playlist:long_list_display_lines(_playlist)
    local display_files = {}
    local first = self.cursor - settings.num_lines / 2
    if settings.num_lines % 2 == 0 then
        first = first + 1
    end
    local index = 0
    for i = first, first + settings.num_lines - 1 do
        if i < 0 then
            index = #_playlist + 1 + i
        elseif i > #_playlist then
            index = i - (#_playlist + 1)
        else
            index = i
        end
        display_files[#display_files+1] = _playlist[index]
		-- 同理，此处也做了和上文一样的改动
        if index == self.pos then
            display_files[#display_files] = settings.playing_str..display_files[#display_files]
        elseif index == self.cursor then
            display_files[#display_files] = settings.cursor_str..display_files[#display_files]
		else
			display_files[#display_files] = settings.unchecked_str..display_files[#display_files]
        end
    end
    return display_files
end

-- returns multiline string
-- 返回多行形式的字符串
function playlist:format_lines(_playlist)
    local display_files = {}
    if self.len <= settings.num_lines then
        display_files = self:short_list_display_lines(_playlist)
    else
        display_files = self:long_list_display_lines(_playlist)
    end
    local output = display_files[1]
    for i = 2, #display_files do
        output = output.."\n"..display_files[i]
    end
    return output
end

-- Convert to case insensitive pattern for searching
-- 转换为不区分大小模式进行搜索
-- "xyz = %d+ or %% end" --> "[xX][yY][zZ] = %d+ [oO][rR] %% [eE][nN][dD]"
-- not sure if it can handle all corner cases of patterns
-- 不能保证它能够处理所有极端模式的情况
-- https://stackoverflow.com/questions/11401890/case-insensitive-lua-pattern-matching
function case_insensitive_pattern(pattern)

    -- find an optional '%' (group 1) followed by any character (group 2)
    local p = pattern:gsub("(%%?)(.)", function(percent, letter)

        if percent ~= "" or not letter:match("%a") then
            -- if the '%' matched, or `letter` is not a letter, return "as is"
			-- 如果匹配到%或者非字母，则按原样返回
            return percent .. letter
        else
            -- else, return a case-insensitive character class of the matched letter
			-- 否则返回一个不区分大小写的且匹配原字母的字符类
            return string.format("[%s%s]", letter:lower(), letter:upper())
        end

    end)

    return p
end

-- returns 0-based array of {index, filepath} for each file in the playlist
-- 为播放列表中的每个文件项，返回基于0索引计数的 {索引, 文件路径} 数组
-- where index is the index of the filepath in the playlist
-- 这里的索引是指在播放列表中文件路径的索引
-- search_term - a lua pattern - not quite regexp, but ., *, +, and ? work the same
-- 搜索词，在lua模式中并不是真正的正则，但是 . * + ? 效果（与正则相比）是一样的
-- escape with % rather than \
-- 用 % 进行转义而不是 \
-- matches are case-insensitive
-- 匹配结果是不区分大小写的
function playlist:filtered_playlist(search_term)
    case_insensitive_term = case_insensitive_pattern(search_term)
    filtered = {}
    f_index = 0
    for i=0, #self.files do
        local filename = self.files[i]
        m = string.match(filename, case_insensitive_term)
        if m and #m > 0 then
            local row = {i, filename}
            filtered[f_index] = row
            f_index = f_index + 1
        end
    end
    return filtered
end

return playlist
