CREATE DATABASE IF NOT EXISTS pixiv DEFAULT CHARSET utf8;

DROP TABLE IF EXISTS `pixiv_user`;
create table pixiv_user
(
	id bigint auto_increment PRIMARY KEY comment 'P站用户id',
	name varchar(50) default '' not null comment '用户昵称',
	account varchar(50) default '' not null comment '账户名',
	comment varchar(255) default '' not null,
	is_followed boolean default false not null,
	webpage text null,
	gender varchar(20) null,
	birth date null,
	region varchar(20) null,
	address_id int null,
	country_code varchar(20) null,
	job varchar(100) null,
	job_id int null,
	total_follow_users int default 0 not null,
	total_mypixiv_users int default 0 not null,
	total_illusts int default 0 not null,
	total_manga int default 0 not null,
	total_novels int default 0 not null,
	total_illust_bookmarks_public int default 0 not null,
	total_illust_series int default 0 not null,
	total_novel_series int default 0 not null,
	background_image_url varchar(255) null,
	twitter_account varchar(255) default '' not null,
	twitter_url varchar(255) null,
	pawoo_url varchar(255) null,
	is_premium boolean default false not null,
	is_using_custom_profile_image boolean default false null,
    tag varchar(64)  default '' not null comment '手动标记的tag',
	created_at timestamp default current_timestamp not null,
	updated_at timestamp default current_timestamp not null,
	UNIQUE KEY `account` (`account`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 comment 'P站用户信息';


DROP TABLE IF EXISTS `illustration`;
create table illustration
(
    id                      bigint auto_increment comment 'P站插画id'  primary key,
    user_id                 bigint                                 not null comment '创建者P站用户id',
    title                   varchar(255) default ''                not null comment '插画标题',
    type                    varchar(50)  default ''                not null comment '插画类型：illust, animate',
    caption                 text                                   null comment '插画描述',
    `restrict`              int          default 0                 not null,
    create_date             varchar(40)  default ''                not null comment '创建日期',
    page_count              int          default 0                 not null comment '图片页数',
    width                   int          default 0                 not null comment '图片宽度',
    height                  int          default 0                 not null comment '图片高度',
    sanity_level            int          default 0                 not null comment '完整程度',
    x_restrict              int          default 0                 not null,
    total_view              int          default 0                 not null comment '查看总数',
    total_bookmarks         int          default 0                 not null comment '收藏总数',
    is_bookmarked           tinyint(1)   default 0                 not null,
    visible                 tinyint(1)   default 0                 not null comment '是否可见',
    is_muted                tinyint(1)   default 0                 not null,
    r_18                    tinyint(1)   default 0                 not null comment '是否成人（18禁）',
    score                   tinyint(1)   default 0                 not null comment '自己评分，数字越大评分越高，有评分的都是下载过校验过的',
    tag                     varchar(64)  default ''                not null comment '手动标记的tag',
    total_comments          int          default 0                 not null comment '总评论数',
    tools                   varchar(100) default ''                not null comment '使用的绘制工具',
    image_url_square_medium varchar(255) default ''                not null comment '小图片地址',
    image_url_medium        varchar(255) default ''                not null comment '中等图片地址',
    image_url_large         varchar(255) default ''                not null comment '大图片地址',
    image_url_origin        varchar(255) default ''                not null comment '原始图片地址',
    created_at              timestamp    default CURRENT_TIMESTAMP not null,
    updated_at              timestamp    default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    index `index_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='插画信息表';


DROP TABLE IF EXISTS `illustration_tag`;
create table illustration_tag
(
    id              bigint auto_increment primary key,
    user_id         bigint                                not null comment '用户id',
    illust_id       bigint                                not null comment '插画id',
    name            varchar(225) default ''               not null comment '标签名称',
    translated_name varchar(225) default ''               not null,
    created_at      timestamp   default CURRENT_TIMESTAMP not null,
    updated_at      timestamp   default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    index `index_user_id` (`user_id`),
    index `index_illust_id` (`illust_id`),
    unique index `uk_illust_id_name` (`illust_id`, `name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='插画标签表';


DROP TABLE IF EXISTS `illustration_image`;
create table illustration_image
(
    id                      bigint auto_increment primary key,
    user_id                 bigint                                 not null comment '创建者P站用户id',
    illust_id               bigint                                 not null comment 'P站插画id',
    title                   varchar(255) default ''                not null comment '插画标题',
    page_index              int          default 1                 not null comment '编号，用于标识第几页',
    image_url_square_medium varchar(255) default ''                not null comment '小图片地址',
    image_url_medium        varchar(255) default ''                not null comment '中等图片地址',
    image_url_large         varchar(255) default ''                null comment '大图片地址',
    image_url_origin        varchar(255) default ''                not null comment '原始图片地址，用于多页插画的每一页',
    process                 varchar(64)  default ''                not null comment '处理情况，如已下载',
    created_at              timestamp    default CURRENT_TIMESTAMP not null comment '记录创建时间',
    updated_at              timestamp    default CURRENT_TIMESTAMP not null comment '记录更新时间',
	index `index_user_id` (`user_id`),
	index `index_illust_id` (`illust_id`),
	unique index `uk_image_url_large` (`image_url_large`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='插画下载地址信息';