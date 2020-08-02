# EmoHori

Emotetに感染しているかを確認するツールです。

### 実行方法

EmoHori.ps1をダウンロードして実行してください。

`powershell.exe .\emohori.ps1`

実行時に`このシステムではスクリプトの実行が無効になっているため、ファイル emohori.ps1 を読み込むことができません。`のようなエラーが出る場合には、

以下で実行ください。

`powershell.exe -ExecutionPolicy Unrestricted .\emohori.ps1`

### 実行結果

実行すると以下のようにレジストリキー毎に判定結果が出ます。
```
#### This is Emotet Infection Check tool 'EmoHori v0.1' ####

Check ->  "C:\Program Files\Windows Defender\MSASCuiL.exe"
Not Emotet

Check ->  C:\Users\admin\AppData\Local\MSAC3ENC\Windows.UI.exe
This RegistryKey is Emotet !
```

`This RegistryKey is Emotet !`と出た場合には該当のパスのexeがEmotetの可能性が高いです。

### ツールの確認ポイント

Emotet感染有無は以下の点で確認します。

1. レジストリキーの以下を確認<br>
　HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run

2. 1.のレジストリキーに登録されているデータが以下のものが存在するかを確認<br>
　C:\Users\<ユーザ名>\AppData\Local\<特定の名前>\<キーの名前>.exe

3. 上記のデータの<特定の名前><キーの名前>が以下のフォルダにexeまたはdllの名前として存在するかを確認<br>
　C:\windows\system32\

4. 上記全てに当てはまる場合、レジストリキーに登録されているexeがEmotetであり、Emotetに感染している可能性が高い

その他、感染の可能性があるサービスの登録については現時点では未対応です。
