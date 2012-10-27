from contextlib import closing
try:
    from ctypes import windll
except ImportError:
    windll = None
from os import environ, getcwd, mkdir, remove
try:
    from os import symlink
except ImportError:
    symlink = None
from os.path import abspath, isdir, isfile, islink, join, split
from shutil import copyfile, rmtree
from StringIO import StringIO
from sys import argv, platform, stderr
from urllib2 import urlopen
from zipfile import ZipFile


INSTALLED_VIMRC = abspath(join(getcwd(), 'vimrc'))
INSTALLED_VIMRUNTIME = abspath(join(getcwd(), 'vim'))


if platform == 'win32':
    VIMRC = abspath(join(environ['USERPROFILE'], '_vimrc'))

    def ensure_shown(path):
        path = unicode(path)
        attrs = windll.kernel32.GetFileAttributesW(path)
        if attrs >= 0 and attrs & 2:
            windll.kernel32.SetFileAttributesW(path, attrs ^ 2)

    def make_hidden(path):
        path = unicode(path)
        attrs = windll.kernel32.GetFileAttributesW(path)
        windll.kernel32.SetFileAttributesW(path, attrs | 2)

    def install():
        download_all()
        ensure_shown(VIMRC)
        with open(VIMRC, 'w') as vimrc:
            print >> vimrc, 'let &runtimepath =',
            print >> vimrc, " '{0},'.&runtimepath".format(INSTALLED_VIMRUNTIME)
            print >> vimrc, 'source', INSTALLED_VIMRC
        make_hidden(VIMRC)

    def uninstall():
        remove(VIMRC)
else:
    VIMRC = abspath(join(environ['HOME'], '.vimrc'))
    VIMRUNTIME = abspath(join(environ['HOME'], '.vim'))

    def install():
        download_all()
        if isfile(VIMRC):
            remove(VIMRC)
        symlink(INSTALLED_VIMRC, VIMRC)
        if islink(VIMRUNTIME):
            remove(VIMRUNTIME)
        elif isdir(VIMRUNTIME):
            rmtree(VIMRUNTIME)
        symlink(INSTALLED_VIMRUNTIME, VIMRUNTIME)

    def uninstall():
        remove(VIMRC)
        remove(INSTALLED_VIMRUNTIME)


def download_all():
    download_colors()
    download_syntax()
    download_autoload()
    download_plugin()


def split_path(path):
    retval = []
    while True:
        path, tail = split(path)
        retval.insert(0, tail)
        if not path:
            break
    return retval


def download(url, filename):
    filename = join(*split_path(filename))
    with closing(urlopen(url)) as u:
        with open(filename, 'w') as f:
            while True:
                chunk = u.read(4096)
                if chunk:
                    f.write(chunk)
                else:
                    break


def download_script(src_id, filename, zip=False, only=None):
    url_format = 'http://www.vim.org/scripts/download_script.php?src_id={0}'
    url = url_format.format(src_id)
    filename = join(*split_path(filename))
    if zip:
        bytes_ = StringIO()
        with closing(urlopen(url)) as u:
            while True:
                chunk = u.read(4096)
                if chunk:
                    bytes_.write(chunk)
                else:
                    break
        bytes_.seek(0)
        with ZipFile(bytes_) as zipfile:
            names = zipfile.namelist()
            if any(name.startswith('/') or '..' in name for name in names):
                raise IOError()
            if only is not None:
                names = [name for name in names if name.startswith(only)]
            zipfile.extractall(filename, names)
        bytes_.close()
    else:
        download(url, filename)


def ensure_dir(path):
    names = split_path(path)
    for i in xrange(len(names)):
        subpath = join(*names[:i + 1])
        if isdir(subpath):
            continue
        mkdir(subpath)


def download_colors():
    ensure_dir('vim/colors')
    download_script(11274, 'vim/colors/Mustang.vim')
    download('https://raw.github.com/altercation/vim-colors-solarized/master'
             '/colors/solarized.vim',
            'vim/colors/solarized.vim')


def download_syntax():
    ensure_dir('vim/syntax')
    download_script(10630, 'vim/syntax/mkd.vim')
    download_script(8666, 'vim/syntax/jinja.vim')
    download_script(6961, 'vim/syntax/htmljinja.vim')
    download_script(8461, 'vim/syntax/haml.vim')
    download_script(7447, 'vim/syntax/sass.vim')
    download('http://leafo.net/lessphp/vim/less.vim', 'vim/syntax/less.vim')
    download('https://gist.github.com/raw/256840/html5.vim',
             'vim/syntax/html.vim')


def download_after_syntax():
    ensure_dir('vim/after/syntax')
    download_script(8846, 'vim/after/syntax/css.vim')
    copyfile('vim/after/syntax/css.vim', 'vim/after/syntax/less.vim')
    download(
        'https://raw.github.com/cakebaker/scss-syntax.vim'
        '/master/syntax/scss.vim',
        'vim/syntax/scss.vim'
    )


def download_autoload():
    ensure_dir('vim/autoload')
    download_script(15192, 'vim/autoload/pathogen.vim')


def download_plugin():
    download_ftplugin()
    download_script(17123, 'vim/', zip=True)  # nerdtree


def download_ftplugin():
    download_script(14403, 'vim/', zip=True, only='ftplugin/')  # pyflakes-vim
    download_script(17125, 'vim/', zip=True)  # vimclojure


def main():
    command = 'install' if len(argv) < 2 else argv[1]
    try:
        func = globals()[command]
    except KeyError:
        print >> stderr, 'unknown command:', command
    else:
        func()


if __name__ == '__main__':
    main()

