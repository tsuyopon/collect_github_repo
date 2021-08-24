#!/usr/bin/ruby 

require "json"

# json設定の読み込み
data = nil
$conffile = "conf/settings.json"
File.open($conffile) do |f|
  data = JSON.load(f)
  p data
end


# jsonのvalidation処理
cont = true
data["repositories"].each do |repodata, vv|
  repodata.each do |k, v|
    printf("key=%s, value=%s\n", k, v)
    if k == "repo"
      cont = true
    end
  end

  # 1つのレポジトリ設定内に"repo"キーが指定されていなければエラーとする
  if cont == true
     cont = false
  else
     puts "Error because of repo is not set"
     exit
  end

end


# cloneの取得
currentdir = Dir.pwd
data["repositories"].each do |repodata, vv|

    dirname = nil
    branch = nil

    # repoの取得
    repo = repodata["repo"]

    # dirnameの取得
    if repodata["dirname"] != nil && repodata["dirname"] != ""
      # dirnameが指定されていれば、その値をディレクトリとする
      dirname = repodata["dirname"]
    else
      # dirnameが指定されていなければ、xxxx.gitのxxxxをディレクトリ名として抽出する
      matchstr = repodata["repo"].match(/\/(.+).git$/)
      dirname = matchstr[1]
    end

    # branchの取得
    if repodata["branch"] != nil && repodata["branch"] != ""
      branch = repodata["branch"]
    end


    # ディレクトリが存在したらすでにgit clone済みとしてgit pullを実行、
    # ディレクトリが存在しなければgit cloneから行う
    if Dir.exists?(dirname)
      p "Exists #{dirname}"
      Dir.chdir(dirname)
      cmd = "git pull"
      p "Executing #{cmd}"
      system(cmd)
      Dir.chdir(currentdir)
    else
      if branch == nil
        cmd = "git clone #{repo} #{dirname}"
      else
        cmd = "git clone -b #{branch} #{repo} #{dirname}"
      end
      p "Executing #{cmd}"
      system(cmd)
    end
    
end
