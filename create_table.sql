-- 用户弹幕设置
drop table if exists `user_barrage_option`;
create table `user_barrage_option`(
	`id`  INT not null PRIMARY KEY AUTO_INCREMENT,
	`user_id`    INT not null,    -- 用户id
	`font_size`  TINYINT not null DEFAULT(1),  -- 字体大小
	`transparency` TINYINT not null DEFAULT(1), -- 透明度
	`region`     TINYINT not null DEFAULT(1),  -- 显示区域(region)
	`speed`      TINYINT not null DEFAULT(1),-- 弹幕滚动速度(speed)
	KEY `user_index` (`user_id`)
)engine=INNODB charset=utf8mb4;
commit;


-- 视频集合  索引
drop table if exists `video_collection`;
create table `video_collection`(
	`id` INT not null PRIMARY KEY AUTO_INCREMENT,-- 集合名(collection_name)
	`user_id` INT not null, -- 用户ID(user_id)
	`cover_path` VARCHAR(255) not null DEFAULT(''),-- 封面路径(cross_path) 
	KEY `user_index` (`user_id`)
)engine=INNODB charset=utf8mb4;
commit;


-- 视频元数据
drop table if exists `video_meta`;
create table `video_meta`(
	`id` INT not null PRIMARY KEY AUTO_INCREMENT,-- 视频id
	`user_id` INT not null DEFAULT(0),-- 上传用户ID(upload_user)
	`video_collection_id` INT not null DEFAULT(0),-- 从属集合(video_collection_id)
	`upload_time` TIMESTAMP not null DEFAULT(CURRENT_TIMESTAMP),-- 上传时间(upload_time)    默认当前时间
	`duration` TIMESTAMP not null,-- 视频时长(video_duration)
	`max_quality` TINYINT not null DEFAULT(1),-- 最高画质(max_quality)
	`video_path` varchar(255) not null,-- 视频存储路径(video_path)
	`cover_path` varchar(255) not null,-- 封面存储路径(cover_path)
	`level` TINYINT not null DEFAULT(1),-- 视频等级(video_level)<--推荐
	`pass_state` BIT not null DEFAULT(0), -- 审核状态
	`suffix` varchar(20) not null DEFAULT(''),-- 格式(video_suffix)
	KEY `user_collection_index` (`user_id`,`video_collection_id`),
	KEY `upload_time_index` (`upload_time`)
)engine=INNODB charset=utf8mb4;
commit;

-- 视频附加数据
drop table if exists `video_data`;
create table `video_data`(
	`id` INT not null PRIMARY KEY AUTO_INCREMENT, -- id
	`video_id` INT not null,-- 视频id
	`comment_count` INT not null DEFAULT(0),-- 评论数量(comment_count)
	`barrage_count` INT not null DEFAULT(0),-- 弹幕数量(barrage_count)
	`like_count` INT not null DEFAULT(0),-- 点赞数(like_count)
	`dislike_count` INT not null DEFAULT(0),-- 点踩数(dislike_count)
	`collect_count` INT not null DEFAULT(0),-- 收藏数(collect_count)
	`forward_count` INT not null DEFAULT(0),-- 转发数(forward_count)
	`browse_count` INT not null DEFAULT(0),-- 浏览数(browse_count)
	KEY `video_index` (`video_id`),
	KEY `comment_like_collect_forward_browse_index` (`comment_count`,`like_count`,`collect_count`,`forward_count`,`browse_count`)
)engine=INNODB charset=utf8mb4;
commit;


-- 视频评论
drop table if exists `video_comment`;
create table `video_comment`(
	`id`  INT not null PRIMARY KEY AUTO_INCREMENT,-- 	评论ID comment_id
	`user_id` INT not null,-- 	评论用户ID(user_id)
	`video_id` INT not null,-- 	视频ID(video_id)
	`content` text not null DEFAULT(''),-- 	评论内容(content)
	`create_time` TIMESTAMP not null DEFAULT(CURRENT_TIMESTAMP),  -- 发表日期(create_time)
	KEY `user_video_index` (`user_id`,`video_id`)
)engine=INNODB charset=utf8mb4;
commit;


-- 弹幕元数据
drop table if exists `barrage_meta`;
create table `barrage_meta`(
	`id`  INT not null PRIMARY KEY AUTO_INCREMENT,-- 弹幕id
	`video_id` INT not null,-- 	视频ID(video_id)
	`sender_id` INT not null,-- 	发送者ID(sender_id)
	`create_time` TIMESTAMP not null DEFAULT(CURRENT_TIMESTAMP),-- 	创建时间(create_time)
	`content` varchar(200) not null DEFAULT(''),-- 	弹幕内容(content)
	KEY `video_sender_index` (`video_id`,`sender_id`)
)engine=INNODB charset=utf8mb4;
commit;


-- 弹幕附加数据
drop table if exists `barrage_data`;
create table `barrage_data`(
	`id`  INT not null PRIMARY KEY AUTO_INCREMENT,-- 弹幕id
	`like_count` SMALLINT not null DEFAULT(0),-- 点赞数(like_count)
	`report_count` SMALLINT not null DEFAULT(0),-- 举报数(report_count)
	KEY `like_report_index` (`like_count`,`report_count`)
)engine=INNODB charset=utf8mb4;
commit;


-- 用户视频一对一关系
drop table if exists `user_video_state`;
create table `user_video_state`(
	`id` INT not null PRIMARY KEY AUTO_INCREMENT,
	`user_id` INT not null,-- 用户ID(user_id)
	`video_id` INT not null,-- 视频ID(video_id)
	`like_state` BIT not null DEFAULT(0),-- 是否点过赞(like_state)
	`forward_state` BIT not null DEFAULT(0),-- 是否转发过(forward_state)
	`collect_state` BIT not null DEFAULT(0),-- 是否收藏过(collect_state)
	KEY `user_video_index` (`user_id`,`video_id`)
)engine=INNODB charset=utf8mb4;
commit;


-- 用户弹幕一对一关系
drop table if exists `user_barrage_state`;
create table `user_barrage_state`(
	`id` INT not null PRIMARY KEY AUTO_INCREMENT,
	`user_id` INT not null,-- 用户ID(user_id)
	`video_id` INT not null,
	`barrage_id` INT not null,-- 弹幕ID(barrage_id)
	`like_state` BIT not null DEFAULT(0),-- 是否点过赞(like_state)
	KEY `user_video_barrage_index` (`user_id`,`video_id`,`barrage_id`)
)engine=INNODB charset=utf8mb4;
commit;
