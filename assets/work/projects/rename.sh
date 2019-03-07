i=0
for folder in `find . -type d`
do
    for file in $folder/*.jpg; do
        if [ $file != "$folder/cover.jpg" ]
        then
            mv "$file" "$folder/$i".jpg
                i=$((i+1))
        fi
    done
    i=1
done

