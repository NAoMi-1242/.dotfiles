# 初期セットアップ (WSL)
```bash
chmod +x .../snc
mkdir -p ~/.local/bin
ln -s "/mnt/c/Users/<Windowsのユーザ名>/.dotfiles/snc" ~/.local/bin/snc
```

# シンボリックリンクの作成方法
```pwsh
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\<リンクするパス>" -Value "$env:USERPROFILE\.dotfiles\<ソースのパス>"
```
```bash
ln -s "/mnt/c/Users/<Windowsのユーザ名>/.dotfiles/<ソースのパス>" ~/<リンクするパス>
```