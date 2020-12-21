# README

<<<<<<< HEAD
## usersテーブル
｜ Column            | Type   | Option      |
｜------------------ | ------ | ----------- |
｜ nickname          | string | null: false |
｜ email             | string | null: false |
｜ password          | string | null: false |
｜ family_name       | string | null: false |
｜ first_name        | string | null: false |
｜ family_name(kana) | string | null: false |
｜ first_name(kana)  | string | null: false |
｜ birth_day         | string | null: false |

### Association
- has_many :items
- has_many :buy_log

## itemsテーブル
｜ Column    | Type       | Option                         |
｜---------- | ---------- | ------------------------------ |
｜ image     | references | null false, foreign key :true  |
｜ item_name | string     | null false                     |
｜ message   | text       | null false                     |
｜ category  | string     | null false                     |
｜ schedule  | string     | null false                     |
｜ area      | string     | null false                     |
｜ day       | string     | null false                     |
｜ price     | string     | null false                     |
｜ user      | references | null: false, foreign_key: true |

### Association
- has_one buy_log
- belongs_to user

## buy_logsテーブル
｜ Column | Type       | Option                        |
｜ ------ | ---------- | ----------------------------  |
｜ user   | references | null false, foreign key :true |
｜ item   | references | null false, foreign key :true |

### Association 
- belongs_to :user
- belongs_to item

## customer_addressesテーブル
｜ Column      | Type       | Option                        |
｜ ----------- | ---------- | ----------------------------- |
｜ postal code | string     | null false                    |
｜ prefecture  | string     | null false                    |
｜ city        | string     |null false                     |
｜ address     | string     | null false                    |
｜ build       | string     |                               |
｜ user        | references | null false, foreign key :true |
｜ item        | references | null false, foreign key :true |
｜ buy_log     | references | null false, foreign key :true |

### Association 
- belongs_to buy_log
=======
This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
>>>>>>> parent of 31d38f8... Revert "Revert "first commit && data-base ready""
