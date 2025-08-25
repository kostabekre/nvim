read_globals = {
	"vim",
}

-- founded at https://github.com/neovim/neovim/blob/e3fd906b614c9ef0fdca3e456b75eae34086555b/.luacheckrc
ignore = {
	"121", -- setting read-only global variable 'vim'
	"122", -- setting read-only field of global variable 'vim'
}
