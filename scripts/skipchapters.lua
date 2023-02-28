require 'mp.options'
local o = {
    active = true,
    patterns = {
        "OP","[Oo]pening$", "^[Oo]pening:", "[Oo]pening [Cc]redits",
        "ED","[Ee]nding$", "^[Ee]nding:", "[Ee]nding [Cc]redits",
        "[Pp]review$",
        -- "[Ii]ntro", "[Oo]utro",
    },
}
read_options(o)

function check_chapter(_, chapter)
    if not o.active or not chapter then
        return
    end
    for _, p in pairs(o.patterns) do
        if string.match(chapter, p) then
            print("Skipping chapter:", chapter)
            mp.command("no-osd add chapter 1")
            return
        end
    end
end

function toggle()
    if o.active then
        o.active = false
        mp.osd_message("skip chapters OFF", 1)
    else
        o.active = true
        mp.osd_message("skip chapters ON", 1)
    end
end

mp.observe_property("chapter-metadata/by-key/title", "string", check_chapter)

mp.add_forced_key_binding('alt+c', 'toggle', toggle)
