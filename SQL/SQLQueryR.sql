EXEC sp_execute_external_script
  @language = N'R',
  @script = N'
library(tm)
library(jiebaR)
library(wordcloud)
library(RColorBrewer)

par(family = "SourceHanSansTW-Regular.ttf")
    
# �פJ�s�D�奻
file_path <- "C://SQL0//house_1.txt"
chinese_text <- readLines(file_path, encoding = "UTF-8")

# �_���B�z
cutter <- worker(user="C://SQL0//dict.txt.big.txt", stop_word = "C://SQL0//dict.txt.big.txt")
chinese_text <- gsub("[0-9a-zA-Z]+?", "", chinese_text) # �R���Ʀr�M�r��
chinese_text <- cutter[chinese_text] # �_��

# �p��r�W
freq_ch <- sort(table(chinese_text), decreasing = TRUE)
freq_ch <- as.data.frame(freq_ch)
colnames(freq_ch) <- c("Words", "Freq") # �r�W��

# �]�w�ۭq�C��
customed_colors <- c("#000080", "#ffff00", "#6495ed", "#00bfff", "#87cefa", "#db7093", "#ba55d3", "#b22222", "#008080", "#ff8c00", "#6b8e23")
# �ͦ��Ĥ@�N��r��
#wordcloud(freq_ch$Words, freq_ch$Freq, min.freq = 2, random.order = FALSE, ordered.colors = FALSE, colors = customed_colors)

# �O�s��r������
png("C://SQL0//wordcloud_output.png", width = 800, height = 800)
wordcloud(freq_ch$Words, freq_ch$Freq, scale = c(13, 5), min.freq = 2, random.order = FALSE, ordered.colors = FALSE, colors = customed_colors)
dev.off()
'