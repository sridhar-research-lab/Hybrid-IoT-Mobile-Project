import os
import chardet
from bs4 import BeautifulSoup

rootdir = 'D:\Research\IoT_Mobile_Project\iot_companion_appset\cordova_apps'


def get_files(base_dir: str, file_extension: str):
    html_dir = f'{rootdir}/{base_dir}/html'
    for file in os.listdir(html_dir):
        if file.endswith(file_extension) is True:
            yield os.path.join(html_dir, file)


def get_content(file_path):
    res = ""
    try:
        res = '\n'.join(open(file_path, 'r', encoding='utf-8').readlines())
    except:
        rawdata = open(file_path, 'rb').read()
        result = chardet.detect(rawdata)
        charenc = result['encoding']
        if charenc is None:
            charenc = 'utf-8'
        res = rawdata.decode(charenc, 'ignore')
    return res


def find_inline_scripts():
    for dirs in os.listdir(rootdir):
        for html_file in get_files(dirs, '.html'):
            raw_content = get_content(html_file)
            html = BeautifulSoup(raw_content, 'html.parser')
            scripts = html.find_all('script', {"src": False})
            if len(scripts) is not 0:
                print(f"{html_file}")


find_inline_scripts()
