EXEC sp_execute_external_script  
	@language = N'Python'  
	, @script = N'
from PIL import Image
import matplotlib.pyplot as plt
from wordcloud import WordCloud
import pandas as pd
import jieba
from collections import Counter

# �p�G�ɮפ����@�ǽs�X���~�A�ϥ� errors="ignore" �ө������~
with open("C:\\SQL0\\house_1.txt", encoding="Utf-8", errors="ignore") as f: text = f.read()

# �]�w�ϥ� big5 �_��
jieba.set_dictionary("C:\\SQL0\\dict.txt.big.txt")
wordlist = jieba.cut(text, cut_all=False)
words = " ".join(wordlist)

# �qWindowsŪ������r��
font_path = "C:\Windows\Fonts\kaiu.ttf"

#�I���C��w�]�¦�A�אּ�զ�B�ϥΫ��w�ϧΡB�ϥΫ��w�r��(�@���r��)
wc = WordCloud(font_path=font_path, width=800, height=800, background_color="white").generate(words)

#���͹Ϥ�
wordcloud = wc.generate(words)
wordcloud.to_file("C:\\SQL0\\wordcloud0.png")

#�ˬd�T�w�O�_�����榨�\
print("Word cloud image saved successfully!")
'