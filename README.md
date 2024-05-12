# テーブル設計

## usersテーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| name               | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |

### Association

- has_many :workspace_users
- has_many :workspaces, through: :workspace_users

## workspacesテーブル

| Column      | Type   | Options     |
| ----------- | ------ | ----------- |
| name        | string | null: false |
| explanation | text   |             |

### Association

- has_many :workspace_users
- has_many :users, through: :workspace_users
- has_many :sheets

## workspace_usersテーブル

| Column    | Type       | Options                        |
| --------- | ----       | ------------------------------ |
| workspace | references | null: false, foreign_key: true |
| user      | references | null: false, foreign_key: true |
| role_id   | integer    | null: false                    |

### Association

belongs_to :user
belongs_to :workspace

## sheetsテーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| name        | string     | null: false                    |
| explanation | text       |                                |
| workspace   | references | null: false, foreign_key :true |

### Association

- belongs_to :workspace
- has_many :courses
- has_one :specify_dates

## coursesテーブル

| Column            | Type       | Options                        |
| ----------------- | ---------- | ------------------------------ |
| name              | string     | null: false                    |
| create_load_sheet | boolean    | null: false, default: false    |
| explanation       | text       |                                |
| sheet             | references | null: false, foreign_key: true |

### Association

- belongs_to :sheet
- has_many :addresses

## addressesテーブル

| Column       | Type       | Options        |
| ------------ | ----       | -------------- |
| district     | string     | null: false    |
| address_from | string     | null: false    |
| address_to   | string     | null: false    |
| load_place   | integer    |                |
| name         | string     |                |
| explanation  | text       |                |
| course       | references | optional: true |

### Association

- belongs_to :course

## specify_datesテーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| is_active        | boolean    | null: false, default: false    |
| month_from       | integer    |                                |
| month_to         | integer    |                                |
| day_of_week_from | integer    |                                |
| day_of_week_to   | integer    |                                |
| date_from        | date       |                                |
| date_to          | date       |                                |
| sheet            | references | null: false, foreign_key: true |

### Association

- belongs_to :sheet