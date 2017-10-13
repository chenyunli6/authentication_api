# AUTHENTICATION API

* Ruby version
  2.3.1

* System dependencies
  * rspec-rails
  * factory_girl_rails
  * shoulda_matchers
  * faker
  * database_cleaner
  * jwt
  * bcrypt

* Configuration
  * 关于短信的配置
    ```
    sms:
      company: 云片网
      expires_in: 3600 # second
    ```  

* Database creation
  * sqlite3

* How to run the test suite
  * 在项目目录下 输入 rspec

* 测试参考
  都是 post 方式
  * 获取短信验证码：http://localhost:3000/sms/code
    * 参数：mobile: 'xxx'
    * 一个小时内只能发送三次，超过三次之后的请求都只返回最后有效的验证码
  * 注册 http://localhost:3000/signup
    * 参数：mobile: 'xxx', validate_code: 'xxx'
  * 登录 http://localhost:3000/login
    * 参数：mobile: 'xxx', validate_code: 'xxx'
    * 或者参数：mobile: 'xxx', password: 'xxx'
  * 注册后设置密码 http://localhost:3000/passwords
    * 参数：password: 'xxx', password_confirmation: 'xxx'
    * headers 中需含有 Authorization: 'xxxxxxxxxxxx'
