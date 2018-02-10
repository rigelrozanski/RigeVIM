.PHONY: swap_vimrc.sh

install:
	bash install_plugins.sh
	git clone https://github.com/easymotion/vim-easymotion ~/.vim/bundle/vim-easymotion
	git clone https://github.com/terryma/vim-multiple-cursors ~/.vim/bundle/vim-multiple-cursors
	go get golang.org/x/tools/cmd/goimports

	#run update
	bash swap_vimrc.sh push

update: updatevimrc updatebash updategitignore

updatevimrc:
	bash swap_vimrc.sh push

updatebash:
	bash swap_bash_profile.sh push

updategitignore:
	bash swap_gitignore.sh push

pullvimrc:
	bash swap_vimrc.sh pull

pullbash:
	bash swap_bash_profile.sh pull
