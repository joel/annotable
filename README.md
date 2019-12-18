# Commands sheetcheat 

```
export ENGINE_NAME=annotable

rails _6.0.1_ plugin new ${ENGINE_NAME} --mountable --api \
  --database=postgresql \
  --skip-action-mailer \
  --skip-action-mailbox \
  --skip-action-text \
  --skip-active-storage \
  --skip-puma \
  --skip-action-cable \
  --skip-sprockets \
  --skip-javascript \
  --skip-turbolinks \
  --skip-test \
  --dummy-path=spec/dummy
```

```
cd ${ENGINE_NAME}

git init && \
git add . && git commit -m 'Initial Commit'
```

```
git add . && git commit -m 'Unload Unused Rails Dependencies'
```

```
rspec-rails

rails g rspec:install && \
git add . && git commit -m 'Install RSpec'
```
```
bin/rails generate scaffold organization name:string
bin/rails generate request organization name:string
bin/rails generate serializer organization name:string

bin/rails db:drop && \
bin/rails db:create && \
bin/rails db:migrate && \
bin/rails db:migrate RAILS_ENV=test

rake 
```

```
bin/rails generate scaffold user name:string email:string organization:references
bin/rails generate request user name:string email:string
bin/rails generate serializer user name:string email:string

bin/rails db:migrate && \
bin/rails db:migrate RAILS_ENV=test

rake 
```

```
bin/rails generate scaffold report name:string content:text organization:references
bin/rails generate request report name:string content:text
bin/rails generate serializer report name:string content:text

bin/rails db:migrate && \
bin/rails db:migrate RAILS_ENV=test

rake 
```

```
bin/rails db:seed
```
```
cd spec/dummy
bin/rails server
```

```
curl -X GET 'http://localhost:3000/annotable/organizations' | python -mjson.tool
curl -X GET 'http://localhost:3000/annotable/organizations/7f29d033-edf7-4753-ad6a-5a7dcfa438fa/reports' | python -mjson.tool
```
