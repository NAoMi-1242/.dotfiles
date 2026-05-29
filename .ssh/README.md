# Windows-WSLで.sshを管理する方法
## 初期設定
### WSLの権限管理（メタデータ）を有効にする
- WSLのターミナルで設定ファイルに２行追記する
    ```bash
    sudo nano /etc/wsl.conf
    ```    
    ```toml
    [automount]
    options = "metadata"
    ```
- **Windows側のPowerShell**を開き、WSLを再起動して設定を適用する
    
    ```powershell
    wsl --shutdown
    ```
### 既存の`.ssh`の削除・バックアップ
```bash
mv ~/.ssh ~/.ssh-backup
mv /mnt/c/Users/<Windowsユーザー名>/.ssh /mnt/c/Users/<Windowsユーザー名>/.ssh-backup
```
### クローンしてWSLへリンクする
- **WSL**を開き、Windows側に .ssh ディレクトリをクローンする
    ```bash
    cd /mnt/c/Users/<Windowsユーザー名>
    git clone https://github.com/NAoMi-1242/.ssh.git
    ```
- WSL側からWindowsの .ssh へシンボリックリンクを張る
    ```bash
    ln -s /mnt/c/Users/<Windowsユーザー名>/.ssh ~/.ssh
    ```

## SSH鍵の追加
### ディレクトリを作成
```bash
mkdir -p ~/.ssh/conf.d/___
mkdir -p ~/.ssh/keys/___
```
### 鍵の生成
```bash
ssh-keygen -t ed25519 -f ~/.ssh/keys/___/<keys以降のファイルパス>_ed25519
```
### 設定ファイルの作成
```bash
nano ~/.ssh/conf.d/___/___.conf
```
```
Host 「ssh ~~~」で呼び出す名前
    HostName IPアドレスなど
    User ユーザ名
    IdentityFile 秘密鍵までのパス（鍵生成時の-fと一緒）
```
### 権限の一括設定
-  ディレクトリはすべて 700（自分のみ読み書き実行可能）
    ```bash
    chmod 700 ~/.ssh
    find ~/.ssh/conf.d -type d -exec chmod 700 {} +
    find ~/.ssh/keys -type d -exec chmod 700 {} +
    ```
-  秘密鍵は 600（自分のみ読み書き可能）
    ```bash
    find ~/.ssh/keys -name "*_ed25519" -exec chmod 600 {} +
    ```
-  公開鍵と設定ファイルは 644（他人も読めるが書き込めない）
    ```bash
    find ~/.ssh/keys -name "*.pub" -exec chmod 644 {} +
    chmod 644 ~/.ssh/config
    find ~/.ssh/conf.d -name "*.conf" -exec chmod 644 {} +
    ```
### 公開鍵の登録
## コマンドで一発
```
ssh-copy-id -i ~/.ssh/___/<keys以降のファイルパス>_ed25519.pub ユーザ名@リモートホストIP
```

## 手動設定
- **公開鍵**（.pubがあるやつ）をコピー
    ```bash
    cat ~/.ssh/keys/___/<keys以降のファイルパス>_ed25519.pub
    ```
- 一旦パスワードでログイン
    ```bash
    ssh ユーザー名@IPアドレス
    ```
- 公開鍵の登録（**`>`だと上書きされるから`>>`で追記する**）
    ```bash
    mkdir -p ~/.ssh
    echo "コピーした公開鍵" >> ~/.ssh/authorized_keys
    ```
    <br/>
- 権限の変更（初回のみ）
    ```bash
    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/authorized_keys
    ```
