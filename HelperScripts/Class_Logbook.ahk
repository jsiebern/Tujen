AREA_ORDER := "Dried Riverbed,Volcanic Island,Karui Wargraves,Battleground Graves,Bluffs,Mountainside,Shipwreck Reef,Karui Wargraves,Scrublands,Desert Ruins,Vaal Temple,Cemetery,Forest Ruins,Utzaal Outskirts,Sarn Slums,Rotting Temple"
FACTION_ORDER := "Knights of the Sun,Black Scythe Mercenaries,Druids of the Broken Circle,Order of the Chalice"
MOD_ORDER := "O)(?<value>[0-9]{1,2})\((?<min>[0-9]{1,2})-(?<max>[0-9]{1,2})\)% increased number of Explosives|O)(?<value>[0-9]{1,2})\((?<min>[0-9]{1,2})-(?<max>[0-9]{1,2})\)% increased Explosive Placement Range|O)Area contains (?<value>[0-9]{1,2})\((?<min>[0-9]{1,2})-(?<max>[0-9]{1,2})\) additional Chest Markers|O)(?<value>[0-9]{1,2})\((?<min>[0-9]{1,2})-(?<max>[0-9]{1,2})\)% increased quantity of Artifacts dropped by Monsters|O)(?<value>[0-9]{1,2})\((?<min>[0-9]{1,2})-(?<max>[0-9]{1,2})\)% increased Explosive Radius|O)Area contains (?<value>[0-9]{1,2})\((?<min>[0-9]{1,2})-(?<max>[0-9]{1,2})\)% increased number of Monster Markers,O)Area contains (?<value>[0-9]{1,2})\((?<min>[0-9]{1,2})-(?<max>[0-9]{1,2})\)% increased number of Remnants"

AREA_ORDER := StrSplit(AREA_ORDER, ",")
FACTION_ORDER := StrSplit(FACTION_ORDER, ",")
MOD_ORDER := StrSplit(MOD_ORDER, "|")

class LogbookAreaModifier {
    T := 0
    Value := 0
    Min := 0
    Max := 0

    __New(T, Value, Min, Max)
    {
        this.T := T
        this.Value := Value
        this.Min := Min
        this.Max := Max
    }
}

class LogbookArea {
    Name := ""
    Faction := ""
    Score := 0
    Modifiers := []

    __New(SectionText)
    {
        areaScore := this.GetName(SectionText)
        factionScore := this.GetFaction(SectionText)
        this.GetModifiers(SectionText)

        this.Score := (factionScore * 100) + areaScore
    }

    GetName(SectionText)
    {
        global AREA_ORDER
        
        For x, Area in AREA_ORDER {
            if (InStr(SectionText, Area) > 0) {
                this.Name := Area
                return x
            }
        }
    }

    GetFaction(SectionText)
    {
        global FACTION_ORDER

        For x, Faction in FACTION_ORDER {
            if (InStr(SectionText, Faction) > 0) {
                this.Faction := Faction
                return x
            }
        }
    }

    GetModifiers(SectionText)
    {
        global MOD_ORDER

        this.Modifiers := []
        For x, ModPattern in MOD_ORDER {
            RegExMatch(SectionText, ModPattern, SubPat)
            if (SubPat["value"] > 0) {
                this.Modifiers.Push(new LogbookAreaModifier(ModPattern, SubPat["value"], SubPat["min"], SubPat["max"]))
            }
        }
    }
}

class Logbook {
    Rarity := ""
    Quantity := 0
    Areas := []

    __New(info)
    {
        this.Refresh(info)
    }

    GetBestArea()
    {
        BestArea := this.Areas[1]
        For i, A in this.Areas {
            if (A.Score < BestArea.Score) {
                BestArea := A
            }
        }
        return BestArea
    }

    Refresh(info)
    {
        Has := InStr(info, "Expedition Logbook")
        if (Has <= 0) {
            return false
        }
        RegExMatch(info, "O)Rarity: (?<rarity>Rare|Magic|Normal)", SubPat)
        if (SubPat["rarity"] == "") {
            return false
        }
        this.Rarity := SubPat["rarity"]
        RegExMatch(info, "O)Item Quantity: \+(?<nr>[0-9]{1,3})%", SubPat)
        if (!SubPat["nr"]) {
            this.Quantity := 0
        }
        else {
            this.Quantity := SubPat["nr"]
        }
        this.ParseAreas(info)
    }

    ParseAreas(info)
    {
        global AREA_ORDER

        this.Areas := []
        Sections := StrSplit(info, "--------")
        For i, SectionText in Sections {
            For x, Area in AREA_ORDER {
                if (InStr(SectionText, Area) > 0) {
                    this.Areas.Push(new LogbookArea(SectionText))
                    break
                }
            }
        }
    }
}