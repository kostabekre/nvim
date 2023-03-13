# nvim_windows
Neovim config to work with C# on Windows

1. Run in PowerShell:
`git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"`

2. install [skeeto's wdevkit](https://github.com/skeeto/w64devkit) and add the `bin` folder to the Path

3. enable creating symbolic links for non-admin users (enable ["Developer Mode"](https://www.ghacks.net/2016/12/04/windows-10-creators-update-symlinks-without-elevation)) or refrain from using parsers that use symbolic links in their repos (tree-sitter-typescript, tree-sitter-ocaml). Otherwise tar will fail on extracting those archives on Windows

4. Source lua/main_folder/packer.lua and Run `PackerSync` in nvim
