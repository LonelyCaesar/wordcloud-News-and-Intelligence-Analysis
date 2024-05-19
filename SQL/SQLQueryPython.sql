EXEC sp_execute_external_script  
	@language = N'Python'  
	, @script = N'
from PIL import Image
import matplotlib.pyplot as plt
from wordcloud import WordCloud
import pandas as pd
import jieba
from collections import Counter

# 如果檔案內有一些編碼錯誤，使用 errors="ignore" 來忽略錯誤
with open("C:\\SQL0\\house_1.txt", encoding="Utf-8", errors="ignore") as f: text = f.read()

# 設定使用 big5 斷詞
jieba.set_dictionary("C:\\SQL0\\dict.txt.big.txt")
wordlist = jieba.cut(text, cut_all=False)
words = " ".join(wordlist)

# 從Windows讀取中文字型
font_path = "C:\Windows\Fonts\kaiu.ttf"

#背景顏色預設黑色，改為白色、使用指定圖形、使用指定字體(一般文字雲)
wc = WordCloud(font_path=font_path, width=800, height=800, background_color="white").generate(words)

#產生圖片
wordcloud = wc.generate(words)
wordcloud.to_file("C:\\SQL0\\wordcloud0.png")

#檢查確定是否有執行成功
print("Word cloud image saved successfully!")
'