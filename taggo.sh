# ctagsとcscope用のtagファイルを作成する

# 除外するキーワードを設定する
if [ $# -eq 0 ]; then
    EXCLUDEFILE="test|mock|bak_IP10|Work"
elif [ "$1" = "all" ]; then
    EXCLUDEFILE=""
else
    EXCLUDEFILE=$1
fi
    
echo "$EXCLUDEFILE を除外する"

# 確認
read -p "$PWDでtagファイルを作成する。Y/N:" result

if [ $result = "Y" ]; then
    : #何もせず
elif [ $result = "N" ]; then
    echo "終了しました。"
    exit
else
    echo "無効値です！"
    exit
fi

# taglist

# remove tag.file first
if [ -e tag.file ]; then
    #存在する場合
    rm -f tag.file
    echo "tag.file deleted"
fi

# create new tag.file
find . -type f -print | grep -E '\.(c(pp)?|h|java|kt|xml)$' | grep -v -E ${EXCLUDEFILE} > tag.file
echo "tag.file created"

# cscope
cscope -b -i tag.file
echo "cscope tag created"

# ctaggo
ctags -L tag.file
echo "ctags tag created"

