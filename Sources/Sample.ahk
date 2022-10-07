#NoEnv
#Include LV_EX.ahk
; ----------------------------------------------------------------------------------------------------------------------
   ; From the help file:
   HIML := IL_Create(10)  ; Create an ImageList to hold 10 small icons.
   Loop 10  ; Load the ImageList with a series of icons from the DLL.
       IL_Add(HIML, "shell32.dll", A_Index)  ; Omits the DLL's path so that it works on Windows 9x too.
   BkgImages := []
   Loop, %A_WinDir%\Web\Wallpaper\*.jpg, 0, 1
      BkgImages.Insert(A_LoopFileFullPath)
   Rows := 20
   Gui, Margin, 20, 20
   Gui, Add, Button, ym gOrder123, Order 1, 2, 3, 4
   Gui, Add, Button, ym gOrder321, Order 3, 2, 1, 4
   Gui, Add, Button, ym gRemoveImage, Remove BkImage
   Gui, Add, Button, ym gNewImage, New BkImage
   Gui, Add, Text, xm Section h20, First visible row:
   Gui, Add, Text, hp y+0, Is row 20 visible?
   Gui, Add, Text, hp y+0, Number of visible rows:
   Gui, Add, Text, ys hp vFVR, 00
   Gui, Add, Text, hp y+0 vIRV, 00
   Gui, Add, Text, hp y+0 vNOVR, 00
   Gui, Add, Button, ys gCheck, New Check
   Gui, Add, Listview, xm w500 r10 Grid cWhite hwndHLV vVLV, Col 1|Col 2|Col 3|Icon ; add -LV0x20 on Win XP
   LV_SetImageList(HIML)
   Loop, %Rows% {
      Zeroes := SubStr("000", 1, 3 - StrLen(A_Index))
      LV_Add("Icon0", "A" . Zeroes . A_Index, "B" . Zeroes . A_Index, "C" . Zeroes . A_Index)
   }
   Loop, %Rows%   ; put a random icon into column 4
      LV_EX_SetSubitemImage(HLV, A_Index, 4, Mod(A_Index, 10) + 1)
   Columns := LV_GetCount("Column")
   Loop, % Columns
      LV_ModifyCol(A_Index, "AutoHdr")
   Random, Index, 1, % BkgImages.MaxIndex()
   LV_EX_SetBkImage(HLV, BkgImages[Index])
   GoSub, Check
   Gui, Show, , LV_EX sample
Return
; ----------------------------------------------------------------------------------------------------------------------
Order123:
   GuiControl, -ReDraw, %HLV%
   ColArr := []
   Loop, % LV_GetCount("Col")
      ColArr[A_Index] := A_Index
   LV_EX_SetColumnOrder(HLV, ColArr)
   ColArr := LV_EX_GetColumnOrder(HLV)
   For Each, C In ColArr
      LV_ModifyCol(C, "AutoHdr")
   GuiControl, +ReDraw, %HLV%
Return
; ----------------------------------------------------------------------------------------------------------------------
Order321:
   GuiControl, -ReDraw, %HLV%
   ColArr := [3, 2, 1]
   Loop, % LV_GetCount("Col")
      If (A_Index > 3)
         ColArr[A_Index] := A_Index
   LV_EX_SetColumnOrder(HLV, ColArr)
   ColArr := LV_EX_GetColumnOrder(HLV)
   For Each, C In ColArr
      LV_ModifyCol(C, "AutoHdr")
   GuiControl, +ReDraw, %HLV%
Return
; ----------------------------------------------------------------------------------------------------------------------
Check:
   GuiControl, , FVR,  % LV_EX_GetTopIndex(HLV)
   GuiControl, , IRV,  % LV_EX_IsRowVisible(HLV, 20)
   GuiControl, , NOVR, % LV_EX_GetRowsPerPage(HLV)
Return
; ----------------------------------------------------------------------------------------------------------------------
NewImage:
   GuiControl, -ReDraw, %HLV%
   Random, Index, 1, % BkgImages.MaxIndex()
   LV_EX_SetBkImage(HLV, BkgImages[Index])
   GuiControl, +ReDraw, %HLV%
   GuiControl, Focus, %HLV%
Return
; ----------------------------------------------------------------------------------------------------------------------
RemoveImage:
   GuiControl, -ReDraw, %HLV%
   LV_EX_SetBkImage(HLV, "")
   GuiControl, +ReDraw, %HLV%
   GuiControl, Focus, %HLV%
Return
; ----------------------------------------------------------------------------------------------------------------------
GuiClose:
ExitApp
