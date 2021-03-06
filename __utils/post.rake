
namespace :gen do
  desc "Create an empty post in /_posts, e.g., rake gen:post TITLE='This is a Sample Title'"
  task :post do
    err_mes = "Must specificy post TITLE, e.g., rake gen:post TITLE='This is a Sample Title'"
    raise err_mes unless ENV.has_key?('TITLE')
    post_title = ENV['TITLE']
    post_slug = ENV['SLUG']
    post_category = ENV['CATEGORY'].camelize
    post_tagline = ENV['TAGLINE'].camelize
    post_description = ENV['DESCRIPTION']
    post_link = ENV['LINK']
    post_cover = ENV['COVER']
    date = ENV['D'] || Date.today.to_s
    base_filename = ENV['FN'] || ENV['TITLE'].downcase.gsub(/\s+/, "-")
    post_filename = date + "-" + base_filename + ".md"
    post_dist=ENV['DIST']
    post_path = APP_ROOT.join(post_dist, post_filename)
    file_exists_mes = "ERROR: post file '#{post_path}' already exists"
    tags = ENV['TAGS'] || "software engineering"
    tag_str = ""
    tags = tags.split(",").each { |tag| tag_str << '- ' + tag + "\n" }
    tag_str.chomp!
 
    raise file_exists_mes if File.exist?(post_path)
 
    puts "Created #{post_path}"
    File.open(post_path, 'w+') do |f|
      f.write(<<-EOF.strip_heredoc)
---
layout: "site/post"
script: about
slug: "#{post_slug}"
category: "#{post_category}"
title: "#{post_title}"
link: "#{post_link}"
cover: "#{post_cover}"
date: #{date}
author: "Diogo Russo"
description: "#{post_description}"
tags:
#{tag_str}
---
 
Sample content goes here. This is the first paragraph that you should replace with your content for #{post_title}.
 
Now, go write something awesome...
EOF
    end
  end
end