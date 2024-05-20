# wordcloud-News-and-Intelligence-Analysis
# 一、說明
本專題要使用（Word Cloud）製作文字雲並進行新聞情感分析是一個非常有趣且實用的專題。以下是使用Python和R來連接SQL Server並製作文字雲的詳細步驟說明。
首先，需要確保您的開發環境已經安裝好必要的軟件和庫：
1.	Python：安裝Anaconda3.8（推薦）或直接安裝Python。
2.	R：安裝R4.3.2和RStudio。
3.	SQL Server：確保已經安裝並運行SQL Server2019，並且有權限訪問相關數據庫。
4.	將複製下來的新聞文字貼在記事本.txt上面然後存檔，存檔時編碼請選utf-8，這樣就不會出現亂碼。
5.	需要有dict.txt.big.txt、中文字型就能夠執行出成果。
# 二、相關文章
根據文字雲的作用(而非樣式)，在應用中可以將其分成三大類。

第一類文字雲：每一個條目都有自己獨立的文字雲，標籤字體越大，此條目中用戶使用過這個標籤的次數就越多，在頁面公開統計點擊且不要求精準數據的情況下十分適用。

第二類文字雲：網站一般會有一個超大型文字雲，標籤字體越大，網站裡使用過這個標籤的條目數就越多。第二類文字雲可以顯示出標籤的熱門程度，在實際應用中更為常見。

第三類文字雲：在此類中，標籤作為一個數據項目的工具，用於表示在整個集合中里各個項目的數據量的大小。

![image](https://github.com/LonelyCaesar/wordcloud-News-and-Intelligence-Analysis/assets/101235367/eb3d310d-a42e-4e15-a494-61f7dc281924)

從廣義來說，相似的可視化技術並不限於用於文字雲。
# 三、實作
針對已經貼好的新聞文字及命名的.txt作執行。
![image](https://github.com/LonelyCaesar/wordcloud-News-and-Intelligence-Analysis/assets/101235367/6982fc9a-a38e-4288-afb5-8d6dc3616aa6)
### 一、	使用R語言繪製文字雲：
使用R軟體文字斷詞、分詞及繪製成文字雲圖，執行手動另存為圖片。
### 在R或Rstudio軟體執行套件
```
install.packages("jiebaR")
install.packages("wordcloud")
install.packages("wordcloud2")
install.packages("RColorBrewer")
```
### 程式碼
``` R
library(jiebaR)
library(wordcloud) # 第一代文字雲
library(wordcloud2) # 第二代文字雲
library(RColorBrewer)

# 設定字體
par(family="SourceHanSansTW-Regular")

# 匯入新聞文本
ch_news <- readLines("財經_房地產_1.txt", encoding = "UTF-8")

# 定義字典、斷詞和停用詞
cutter <- worker(user='dict.txt.big.txt', stop_word = 'dict.txt.big.txt')
ch_news <- gsub("[0-9a-zA-Z]+?", "", ch_news) # 刪除數字和字母
ch_news <- cutter[ch_news] # 斷詞

# 計算字頻
freq_ch <- sort(table(ch_news), decreasing = TRUE)
freq_ch <- as.data.frame(freq_ch)
colnames(freq_ch) <- c("Words", "Freq") # 字頻表

# 設定自訂顏色
customed_colors <- c("#000080", "#ffff00", "#6495ed", "#00bfff", "#87cefa", "#db7093", "#ba55d3", "#b22222", "#008080", "#ff8c00", "#6b8e23")

# 生成第一代文字雲
ch_wordcloud <- wordcloud(freq_ch$Words, freq_ch$Freq, min.freq = 2, random.order = FALSE, ordered.colors = FALSE, colors = customed_colors)
ch_wordcloud
# 生成第二代文字雲
ch_wordcloud2 <- wordcloud2(freq_ch, size = 1, color = customed_colors, backgroundColor="white")
ch_wordcloud2
# 使用letterCloud函數生成字母文字雲
letterCloud(freq_ch, 'OK', size = 0.5)
letterCloud(freq_ch, 'R', size = 0.5)
wordcloud2(freq_ch, size = 0.4,shape = 'star')
```
