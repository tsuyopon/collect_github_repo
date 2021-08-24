# collect_github_repo
This repository populate github resouces


# usage
conf/settings.json に指定したgithubのresouceを取得する。
ディレクトリが既に存在する場合には、git cloneされたものとみなして、git pullする


# 設定ファイルサンプル
```
{
    "projectName": "Collect Repository",
    "repositories": [
        {   
            "repo": "git@github.com:githubtraining/hellogitworld.git"
        },  
        {   
            "repo": "git@github.com:tsuyopon/utils.git",
            "branch": "main",
            "dirname": "myutils"
        }   
    ]   
}
```

- projectName: 何も見ていません。なくても動きます
- repositories: 必須。この中にレポジトリ設定を追加する
- repo: 取得したいレポジトリパス。それぞれの連想配列に必ず必要
- branch: 取得したいブランチ名。省略された場合にはgit clone時にbオプションを指定しない
- dirname: 取得したレポジトリを配置するディレクトリ名
