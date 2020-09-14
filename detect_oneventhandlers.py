import csv
import os
import chardet
from bs4 import BeautifulSoup

rootdir = 'D:\Research\IoT_Mobile_Project\iot_companion_appset\cordova_apps'
list_of_eventhandlers = ['onabort',
                         'onafterprint', 'onclick',
                         'onanimationend',
                         'onanimationiteration',
                         'onanimationstart',
                         'onbeforeprint',
                         'onbeforeunload',
                         'onblur',
                         'oncanplay',
                         'oncanplaythrough',
                         'onchange',
                         'oncontextmenu',
                         'oncopy',
                         'oncut',
                         'ondblclick',
                         'ondrag',
                         'ondragend',
                         'ondragenter',
                         'ondragleave',
                         'ondragover',
                         'ondragstart',
                         'ondrop',
                         'ondurationchange',
                         'onended',
                         'onerror',
                         'onfocus',
                         'onfocusin',
                         'onfocusout',
                         'onfullscreenchange',
                         'onfullscreenerror',
                         'onhashchange',
                         'oninput',
                         'oninvalid',
                         'onkeydown',
                         'onkeypress',
                         'onkeyup',
                         'onload',
                         'onloadeddata',
                         'onloadedmetadata',
                         'onloadstart',
                         'onmessage',
                         'onmousedown',
                         'onmouseenter',
                         'onmouseleave',
                         'onmousemove',
                         'onmouseover',
                         'onmouseout',
                         'onmouseup',
                         'onmousewheel',
                         'onoffline',
                         'ononline',
                         'onopen',
                         'onpagehide',
                         'onpageshow',
                         'onpaste',
                         'onpause',
                         'onplay',
                         'onplaying',
                         'onpopstate',
                         'onprogress',
                         'onratechange',
                         'onresize',
                         'onreset',
                         'onscroll',
                         'onsearch',
                         'onseeked',
                         'onseeking',
                         'onselect',
                         'onshow',
                         'onstalled',
                         'onstorage',
                         'onsubmit',
                         'onsuspend',
                         'ontimeupdate',
                         'ontoggle',
                         'ontouchcancel',
                         'ontouchend',
                         'ontouchmove',
                         'ontouchstart',
                         'ontransitionend',
                         'onunload',
                         'onvolumechange',
                         'onwaiting',
                         'onwheel']


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
        for html_file in get_files(dirs, '.html'):
            raw_content = get_content(html_file)
            html = BeautifulSoup(raw_content, 'html.parser')
            for event in list_of_eventhandlers:
                scripts = html.select(f'[{event}]')
                if len(scripts) is not 0:
                    with open('eventhandler_count.csv', 'a+', newline='') as file:
                        writer = csv.writer(file)
                        writer.writerow([html_file, "-", dirs, "-", event, "-", len(scripts)])

                else:
                    continue


find_script()
