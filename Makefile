
install: download
	ln -s `pwd`/vimrc $$HOME/.vimrc
	ln -s `pwd`/vim $$HOME/.vim

download: download_colors download_syntax

download_colors:
	mkdir -p vim/colors/; \
	cd vim/colors/; \
	curl -O http://blog.toddwerth.com/entry_files/8/ir_black.vim

download_syntax:
	mkdir -p vim/syntax/; \
	cd vim/syntax/; \
	curl http://www.vim.org/scripts/download_script.php?src_id=10630 \
	     -o mkd.vim \
	     http://www.vim.org/scripts/download_script.php?src_id=8666 \
	     -o jinja.vim \
	     http://www.vim.org/scripts/download_script.php?src_id=6961 \
		 -o htmljinja.vim \
		 http://www.vim.org/scripts/download_script.php?src_id=8461 \
		 -o haml.vim \
		 http://www.vim.org/scripts/download_script.php?src_id=7447 \
		 -o sass.vim

