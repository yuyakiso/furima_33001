# README

## usersテーブル
｜ Column            | Type               | Option      |
｜------------------ | ------------------ | ----------- |
｜ nickname          | string             | null: false |
｜ email             | string             | null: false |
｜ password          | encrypted_password | null: false |
｜ family_name       | string             | null: false |
｜ first_name        | string             | null: false |
｜ family_name(kana) | string             | null: false |
｜ first_name(kana)  | string             | null: false |
｜ date              | string             | null: false |

### Association
- has_many :items
- has_many :buy_logs

## itemsテーブル
｜ Column    | Type       | Option                         |
｜---------- | ---------- | ------------------------------ |
｜ image     | references | null false, foreign key :true  |
｜ item_name | string     | null false                     |
｜ message   | text       | null false                     |
｜ category  | string     | null false                     |
｜ schedule_id  | integer     | null false                     |
｜ area_id      | integer     | null false                     |
｜ day_id       | integer     | null false                     |
｜ price_id     | integer     | null false                     |
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
- has_one :customer_addresses

## customer_addressesテーブル
｜ Column      | Type       | Option                        |
｜ ----------- | ---------- | ----------------------------- |
｜ postal code | string     | null false                    |
｜ prefecture  | string     | null false                    |
｜ city        | string     |null false                     |
｜ address     | string     | null false                    |
｜ build       | string     |                               |
｜ user        | references | null false, foreign key :true |

### Association 
- belongs_to buy_log
