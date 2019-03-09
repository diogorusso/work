build_work()
{
  json=$(cat ./_data/projects.json | jq -r '.[]| @base64' )
  dist="../work/_posts"
  rm -rf ./work/_posts/*.*
  for row in $json; do
      _jq() {
          echo ${row} | base64 --decode | jq -r ${1}
      }
      mundo="$(_jq '.title')"
      string=$mundo 
      echo $string
      # hello= $mundo
      rake gen:post DIST=$dist TITLE="$(_jq '.title')" CATEGORY="$(_jq '.category')" D="$(_jq '.date')" TAGS="$(_jq '.tags')" TAGLINE="$(_jq '.tagline')" LINK="$(_jq '.link')" SLUG="$(_jq '.slug')" DESCRIPTION="$(_jq '.description_EN')" 
      # echo $(_jq '.title')
  done
}

build_work