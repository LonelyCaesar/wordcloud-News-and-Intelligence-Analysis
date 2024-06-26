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
