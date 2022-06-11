#include CSV.ahk
#include Lib\Utils.ahk

CSV_FILE := A_ScriptDir . "\Tujen_Results.csv"



; --- Window_Id;Item_Name;Additional_Item_Info;Item_Amount;Item_Chaos_Value;Price_Amount;Price_Type;Price_Chaos;Price_Initial_Offer;Price_Subsequent_Offers;Date_Time

T_Csv_NewWindow() {
    global CSV_FILE, dataCSV_TotalCols
    CSV_Load(CSV_FILE, "data")
    dataCSV_TotalCols := 11
    return Generate_Id()
}

T_Csv_Encapsulate(str) {
    return str
    return """" str """"
}

T_Csv_AddEntry(Window_Id, Item_Name, Additional_Item_Info, Item_Amount, Item_Chaos_Value, Price_Amount, Price_Type, Price_Chaos, Price_Initial_Offer, Price_Subsequent_Offers, Date_Time) {
    Window_Id := T_Csv_Encapsulate(Window_Id)
    Item_Name := T_Csv_Encapsulate(Item_Name)
    Additional_Item_Info := T_Csv_Encapsulate(Additional_Item_Info)
    Item_Amount := T_Csv_Encapsulate(Item_Amount)
    Item_Chaos_Value := T_Csv_Encapsulate(Round(Item_Chaos_Value, 1))
    Price_Amount := T_Csv_Encapsulate(Price_Amount)
    Price_Type := T_Csv_Encapsulate(Price_Type)
    Price_Chaos := T_Csv_Encapsulate(Round(Price_Chaos, 1))
    Price_Initial_Offer := T_Csv_Encapsulate(Price_Initial_Offer)
    Price_Subsequent_Offers := T_Csv_Encapsulate(Price_Subsequent_Offers)
    Date_Time := T_Csv_Encapsulate(Date_Time)
    str := Window_Id "," Item_Name "," Additional_Item_Info "," Item_Amount "," Item_Chaos_Value "," Price_Amount "," Price_Type "," Price_Chaos "," Price_Initial_Offer "," Price_Subsequent_Offers "," Date_Time
    CSV_AddRow("data", str)
    return
}

T_Csv_Save() {
    global CSV_FILE
    CSV_Save(CSV_FILE, "data", 1)
    return
}