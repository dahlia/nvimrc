
install: download
	if [ -f $$HOME/.vimrc ]; then \
		echo; \
	else \
		ln -s `pwd`/vimrc $$HOME/.vimrc; \
	fi
	if [ -d $$HOME/.vim ]; then \
		echo; \
	else \
		ln -s `pwd`/vim $$HOME/.vim; \
	fi

download: download_colors download_syntax download_autoload

download_colors:
	mkdir -p vim/colors/; \
	cd vim/colors/; \
	curl -L http://www.vim.org/scripts/download_script.php?src_id=11274 \
	     -o Mustang.vim

download_syntax:
	mkdir -p vim/syntax/; \
	cd vim/syntax/; \
	curl -L \
	     http://www.vim.org/scripts/download_script.php?src_id=10630 \
	     -o mkd.vim \
	     http://www.vim.org/scripts/download_script.php?src_id=8666 \
	     -o jinja.vim \
	     http://www.vim.org/scripts/download_script.php?src_id=6961 \
		 -o htmljinja.vim \
		 http://www.vim.org/scripts/download_script.php?src_id=8461 \
		 -o haml.vim \
		 http://www.vim.org/scripts/download_script.php?src_id=7447 \
		 -o sass.vim \
		 -O http://leafo.net/lessphp/vim/less.vim \
		 https://gist.github.com/raw/256840/html5.vim -o html.vim

download_after_syntax:
	mkdir -p vim/after/syntax/; \
	cd vim/after/syntax/; \
	curl -L http://www.vim.org/scripts/download_script.php?src_id=8846 \
	     -o css.vim; \
	if [ -f `pwd`/less.vim ]; then \
		echo; \
	else \
		ln -s `pwd`/css.vim `pwd`/less.vim; \
	fi

download_autoload:
	mkdir -p vim/autoload/; \
	cd vim/autoload/; \
	curl -L http://www.vim.org/scripts/download_script.php?src_id=15192 \
		 -o pathogen.vim

