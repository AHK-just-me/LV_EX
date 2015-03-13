#NoEnv
#Include LV_EX.ahk
Gui, Add, Listview, xm w500 r10 Grid hwndHLV vVLV, Col 1|Col 2|Col 3
Loop, 10 {
   Zeroes := SubStr("000", 1, 3 - StrLen(A_Index))
   LV_Add("", "A" . Zeroes . A_Index, "B" . Zeroes . A_Index, "C" . Zeroes . A_Index)
}
Loop, % LV_GetCount("Column")
   LV_ModifyCol(A_Index, "AutoHdr")
LV_EX_GroupInsert(HLV, 10, "Group 1")
; MsgBox, 0, LV_EX_GroupInsert, % LV_EX_GroupInsert(HLV, 40, "Group 1") ; , , 12)
LV_EX_GroupInsert(HLV, 20, "Group 2", 2, 9999)
; MsgBox, 0, LV_EX_GroupInsert, % LV_EX_GroupInsert(HLV, 10, "Group 2", 2, 9999)
Loop, 5
   LV_EX_SetGroup(HLV, A_Index, 10)
Loop, 5
   LV_EX_SetGroup(HLV, A_Index + 5, 20)
LV_EX_GroupSetState(HLV, 10, "Collapsible")
LV_EX_GroupSetState(HLV, 20, "Collapsible")
LV_EX_EnableGroupView(HLV)
; MsgBox, 0, LV_EX_EnableGroupView, % LV_EX_EnableGroupView(HLV)
Gui, Add, CheckBox, Checked vCBGV gGroupView, GroupView
Gui, Show, , LV_EX Groups Sample
; MsgBox, 0, HasGroup, % "GoupID 10 = " . LV_EX_HasGroup(HLV, 10)
MsgBox, 0, GetGroup, % "Row 2 = " . LV_EX_GetGroup(HLV, 2)
Return
; ----------------------------------------------------------------------------------------------------------------------
GuiClose:
ExitApp
; ----------------------------------------------------------------------------------------------------------------------
GroupView:
GuiControlGet, CBGV
LV_EX_EnableGroupView(HLV, CBGV)
Return