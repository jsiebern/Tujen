class PriceFetch
{
    League := "Sentinel"
    CurrencyOverview := ["Fragment", "Currency"]
    ItemOverview := ["Oil", "Incubator", "Map", "BlightedMap", "UniqueMap", "DeliriumOrb", "Scarab", "Fossil", "Resonator", "Essence", "SkillGem"]
    DataPath := A_ScriptDir . "\Data"
    PriceList := {}

    __NEW()
    {
        if (!FileExist(this.DataPath)) {
            FileCreateDir % this.DataPath
        }
        this.FetchCurrencyPrices()
        this.FetchItemPrices()
        this.ParseCurrencyPrices()
        this.ParseItemPrices()
    }

    InjectPrices(Prices)
    {
        For Name, Price in Prices {
            this.PriceList[Name] := Price
        }
    }

    ParseCurrencyPrices()
    {
        total := this._TotalDownloads()
        For i, Currency in this.CurrencyOverview {
            Load_BarControl(50 + (i/total * 40),"Parsing " i "/" total " (" Currency ")")
            CPath := this.DataPath . "\" . Currency . ".json"
            Ln := this._ReadJsonLines(CPath)
            For x, E in Ln {
                this.PriceList[E.currencyTypeName] := E.chaosEquivalent
            }
        }
    }

    ParseItemPrices()
    {
        total := this._TotalDownloads()
        For i, Item in this.ItemOverview {
            Load_BarControl(50 + ((i + this.CurrencyOverview.Count())/total * 40),"Downloading " i + this.CurrencyOverview.Count() "/" total " (" Item ")")
            IPath := this.DataPath . "\" . Item . ".json"
            Ln := this._ReadJsonLines(IPath)
            For x, E in Ln {
                if (E.gemLevel) {
                    if (E.gemLevel > 1 && E.chaosValue < 15) {
                        continue
                    }
                }
                if (E.mapTier) {
                    if ((E.itemClass == 0 || E.itemClass == 2) && E.mapTier < 16) {
                        E.name := E.name . E.mapTier
                    }
                }
                this.PriceList[E.name] := E.chaosValue
            }
        }
    }

    FetchCurrencyPrices()
    {
        total := this._TotalDownloads()
        For i, Currency in this.CurrencyOverview {
            Load_BarControl(i/total * 50,"Downloading " i "/" total " (" Currency ")")
            Sleep, -1
            CPath := this.DataPath . "\" . Currency . ".json"
            this._EnsureFileIsNotTooOld(CPath)
            if (!FileExist(CPath)) {
                this._DownloadToFile(this.GetCurrencyOverviewURL(Currency), CPath)
            }
        }
    }

    FetchItemPrices()
    {
        total := this._TotalDownloads()
        For i, Item in this.ItemOverview {
            Load_BarControl((i + this.CurrencyOverview.Count())/total * 50,"Downloading " i + this.CurrencyOverview.Count() "/" total " (" Item ")")
            IPath := this.DataPath . "\" . Item . ".json"
            this._EnsureFileIsNotTooOld(IPath)
            if (!FileExist(IPath)) {
                this._DownloadToFile(this.GetItemOverviewURL(Item), IPath)
            }
        }
    }

    _TotalDownloads()
    {
        return this.CurrencyOverview.Count() + this.ItemOverview.Count()
    }

    _ReadJsonLines(Path)
    {
        FileRead, Contents, % Path
	    value := JSON.Load(Contents)
        return value.lines
    }

    _EnsureFileIsNotTooOld(Path)
    {
        FileGetTime, tm, % Path
        if (tm) {
            EnvSub, tm, A_Now, hours
            tm := tm * -1
            if (tm > 12) {
                FileDelete % Path
            }
        }
    }

    _DownloadToFile(Url, Path)
    {
        r := WinHttpRequest(Url, InOutData := "", InOutHeaders := "", "Timeout: 1`nNO_AUTO_REDIRECT")
        file := FileOpen(Path, "w")
        file.Write(InOutData)
        file.Close()
    }

    GetCurrencyOverviewURL(CurrencyType)
    {
        return "https://poe.ninja/api/data/CurrencyOverview?league=" . this.League . "&type=" . CurrencyType .  "&language=en"
    }

    GetItemOverviewURL(ItemType)
    {
        return "https://poe.ninja/api/data/ItemOverview?league=" . this.League . "&type=" . ItemType . "&language=en"
    }
}

PriceFetch_Init() {
    
}