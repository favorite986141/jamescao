查閱表CSV
===
說明:

    CSV 尋找將事件中的欄位值與 CSV 檔案表示的靜態表中的欄位值進行比對。

    然後，他們將該表中的相應欄位值輸出到您的事件。

    它們也稱為“靜態查找”。 

    CSV 內聯查找表檔案和使用 CSV 檔案的內聯查找定義都是資料集類型。

查閱表CSV限制:

    CSV 檔案所表示的表格必須至少有兩列。其中一列應代表一個具有一組值的字段，其中包括屬於事件中某個字段的值。該列不必與事件欄位具有相同的名稱。任何欄位都可以有相同值的多個實例，因為這表示多值欄位。    

    CSV 檔案不能包含非 utf-8 字元。支援純 ascii 文本，以及任何有效的 utf-8 字元集。

    以下是不支援的：
    具有 OS X 之前版本（OS 9 或更早版本）Macintosh 樣式行結尾的 CSV 檔案（僅限回車符 (“\r”)）
    標題行超過 4096 個字元的 CSV 檔案。

範例:
<img width="928" alt="image" src="https://github.com/favorite986141/jamescao/assets/125249893/587a1583-4195-467e-96c4-1f28aa3d3dc1">
