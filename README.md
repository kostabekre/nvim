nvim_windows

Neovim config to work with C# on Windows

    Run in PowerShell: git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"

    install skeeto's wdevkit and add the bin folder to the Path

    enable creating symbolic links for non-admin users (enable "Developer Mode") or refrain from using parsers that use symbolic links in their repos (tree-sitter-typescript, tree-sitter-ocaml). Otherwise tar will fail on extracting those archives on Windows
    
    git clone https://github.com/kostabekre/nvim ~/AppData/Local/nvim

    Source lua/main_folder/packer.lua and Run PackerSync in nvim


