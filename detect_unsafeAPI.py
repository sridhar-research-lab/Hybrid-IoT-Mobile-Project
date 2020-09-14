import csv
import os
import chardet
import re
from bs4 import BeautifulSoup

rootdir = 'D:\Research\IoT_Mobile_Project\iot_companion_appset\cordova_apps'
list_of_unsafeapi = ["document.write()", "document.writeln()", "innerHTML", "outerHTML", "html()",
                     'append()', 'prepend()', 'before()', 'after()', 'replaceAll()', "replaceWith()"]


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


def find_script():
    for dirs in os.listdir(rootdir):
        for js_file in get_files(dirs, '.html'):
            raw_content = get_content(js_file)
            if len(raw_content) is not 0:
                for api in list_of_unsafeapi:
                    if re.findall(r"(?i)" + api, raw_content):
                        with open('unsafe_html_count.csv', 'a+', newline='') as file:
                            writer = csv.writer(file)
                            writer.writerow([js_file,  api,  len(re.findall(r"(?i)" + api, raw_content))])

            else:
                continue


find_script()
