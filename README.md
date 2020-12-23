# README

## usersテーブル
｜ Column             | Type   | Option                    |
｜ ------------------ | ------ | ------------------------- |
｜ nickname           | string | null: false               |
｜ email              | string | null: false, unique: true |
｜ encrypted_password | string | null: false               |
｜ family_name        | string | null: false               |
｜ first_name         | string | null: false               |
｜ family_name_kana   | string | null: false               |
｜ first_name_kana    | string | null: false               |
｜ birth_day          | date   | null: false               |

### Association
- has_many :items
- has_many :buy_logs

## itemsテーブル
｜ Column        | Type        | Option                         |
｜-------------- | ----------- | ------------------------------ |
｜ name          | string      | null false                     |
｜ message       | text        | null false                     |
｜ category_id   | integer     | null false                     |
｜ status_id     | integer     | null false                     |
| charge_id      | integer     | null false                     |
｜ schedule_id   | integer     | null false                     |
｜ prefecture_id | integer     | null false                     |
｜ price         | integer     | null false                     |
｜ user          | references  | null: false, foreign_key: true |

### Association
- has_one :buy_log
- belongs_to :user

## buy_logsテーブル
｜ Column | Type       | Option                        |
｜ ------ | ---------- | ----------------------------- |
｜ user   | references | null false, foreign key :true |
｜ item   | references | null false, foreign key :true |

### Association 
- belongs_to :user
- belongs_to item
- has_one :customer_address

## customer_addressesテーブル
｜ Column         | Type       | Option                        |
｜ -------------- | ---------- | ----------------------------- |
｜ postal_code    | string     | null false                    |
｜ prefecture_id  | integer    | null false                    |
｜ city           | string     | null false                    |
｜ address        | string     | null false                    |
｜ build          | string     |                               |
| phone_number    | string    | null false                    |
｜ buy_log        | references | null false, foreign key :true |

### Association 
- belongs_to :buy_log
