EXEC sp_execute_external_script
  @language = N'R',
  @script = N'
library(tm)
library(jiebaR)
library(wordcloud)
library(RColorBrewer)

par(family = "SourceHanSansTW-Regular.ttf")
    
# 匯入新聞文本
file_path <- "C://SQL0//house_1.txt"
chinese_text <- readLines(file_path, encoding = "UTF-8")

# 斷詞處理
cutter <- worker(user="C://SQL0//dict.txt.big.txt", stop_word = "C://SQL0//dict.txt.big.txt")
chinese_text <- gsub("[0-9a-zA-Z]+?", "", chinese_text) # 刪除數字和字母
chinese_text <- cutter[chinese_text] # 斷詞

# 計算字頻
freq_ch <- sort(table(chinese_text), decreasing = TRUE)
freq_ch <- as.data.frame(freq_ch)
colnames(freq_ch) <- c("Words", "Freq") # 字頻表

# 設定自訂顏色
customed_colors <- c("#000080", "#ffff00", "#6495ed", "#00bfff", "#87cefa", "#db7093", "#ba55d3", "#b22222", "#008080", "#ff8c00", "#6b8e23")
# 生成第一代文字雲
#wordcloud(freq_ch$Words, freq_ch$Freq, min.freq = 2, random.order = FALSE, ordered.colors = FALSE, colors = customed_colors)

# 保存文字雲到文件
png("C://SQL0//wordcloud_output.png", width = 800, height = 800)
wordcloud(freq_ch$Words, freq_ch$Freq, scale = c(13, 5), min.freq = 2, random.order = FALSE, ordered.colors = FALSE, colors = customed_colors)
dev.off()
'