## はじめに
デプロイ手順の記載をします。
以下のqiitaの記事用です。
https://qiita.com/Snooze1229/items/7c1cd6cc7fc0efebef14

```
１,Auroraのデプロイ  
cd ~/auto-maintenance/database  
terraform init  
terraform plan  
terraform apply  
```

```
2,SecretsManagerのデプロイ  
cd ~/auto-maintenance/secret-manager  
terraform init  
terraform plan  
terraform apply  
```