
build_post()
{
  for row in $json; do
      _jq() {
          echo ${row} | base64 --decode | jq -r ${1}
      }
      rake gen:post DIST=$dist TITLE=$(_jq '.title') D=$(_jq '.date') TAGS=$(_jq '.tags') TAGLINE=$(_jq '.tagline') LINK=$(_jq '.link') COVER=$(_jq '.cover') 
      echo $(_jq '.title')
  done
}

build_post_design()
{
  json=$(cat ./_data/projects.json | jq -r '.[]| @base64' )
  dist="../journal/design/_posts"
  rm -rf ./design/_posts/*.*
  build_post
}

build_post_art()
{
  json=$(cat ./_data/projects-art.json | jq -r '.[]| @base64' )
  dist="../artwork/_posts"
  rm -rf ./artwork/_posts/*.*
  build_post
}


PS3='Please enter your choice: '
options=("Build Work" "Build All Projects" "Build Design Projects" "Build Art Projects" "Delete All Projects" "Exit")
select opt in "${options[@]}"
do
    case $opt in
        "Build Work")
          sh ./__utils/build-work.sh   
        ;;
        "Build All Projects")
          build_post_art
          build_post_design    
        ;;
        "Build Design Projects")
          build_post_design    
        ;;
        "Build Art Projects")
          build_post_art
        ;;
        "Delete All Projects")
          rm -rf ./art/_posts/*.*
          rm -rf ./design/_posts/*.*
        ;;
        "Exit")
            break
        ;;
        *) echo "invalid option $REPLY"
        ;;
    esac
done



