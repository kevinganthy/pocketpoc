PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE `_migrations` (file VARCHAR(255) PRIMARY KEY NOT NULL, applied INTEGER NOT NULL);
INSERT INTO _migrations VALUES('1640988000_init.go',1731957458482997);
INSERT INTO _migrations VALUES('1673167670_multi_match_migrate.go',1731957458483465);
INSERT INTO _migrations VALUES('1677152688_rename_authentik_to_oidc.go',1731957458483641);
INSERT INTO _migrations VALUES('1679943780_normalize_single_multiple_values.go',1731957458483959);
INSERT INTO _migrations VALUES('1679943781_add_indexes_column.go',1731957458484480);
INSERT INTO _migrations VALUES('1685164450_check_fk.go',1731957458484619);
INSERT INTO _migrations VALUES('1689579878_renormalize_single_multiple_values.go',1731957458484906);
INSERT INTO _migrations VALUES('1690319366_reset_null_values.go',1731957458485222);
INSERT INTO _migrations VALUES('1690454337_transform_relations_to_views.go',1731957458485397);
INSERT INTO _migrations VALUES('1691747913_resave_views.go',1731957458485564);
INSERT INTO _migrations VALUES('1692609521_copy_display_fields.go',1731957458485772);
INSERT INTO _migrations VALUES('1701496825_allow_single_oauth2_provider_in_multiple_auth_collections.go',1731957458485894);
INSERT INTO _migrations VALUES('1702134272_set_default_json_max_size.go',1731957458486089);
INSERT INTO _migrations VALUES('1718706525_add_login_alert_column.go',1731957458486827);
CREATE TABLE `_admins` (
				`id`              TEXT PRIMARY KEY NOT NULL,
				`avatar`          INTEGER DEFAULT 0 NOT NULL,
				`email`           TEXT UNIQUE NOT NULL,
				`tokenKey`        TEXT UNIQUE NOT NULL,
				`passwordHash`    TEXT NOT NULL,
				`lastResetSentAt` TEXT DEFAULT "" NOT NULL,
				`created`         TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%fZ')) NOT NULL,
				`updated`         TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%fZ')) NOT NULL
			);
INSERT INTO _admins VALUES('lisg2rkmfwkp56x',0,'kevin@gnth.io','mtU5b44s19iRtBH7vK8zHq5x8N4BnVDKDZ8sayDWMFg0T6lAZW','$2a$12$zJFzaCgYb6ShVEnWQh7.Oe/8zJQ2v4v7280BstD5HMZcHVumx68jG','','2024-11-18 19:17:55.680Z','2024-11-18 19:17:55.680Z');
CREATE TABLE `_collections` (
				`id`         TEXT PRIMARY KEY NOT NULL,
				`system`     BOOLEAN DEFAULT FALSE NOT NULL,
				`type`       TEXT DEFAULT "base" NOT NULL,
				`name`       TEXT UNIQUE NOT NULL,
				`schema`     JSON DEFAULT "[]" NOT NULL,
				`indexes`    JSON DEFAULT "[]" NOT NULL,
				`listRule`   TEXT DEFAULT NULL,
				`viewRule`   TEXT DEFAULT NULL,
				`createRule` TEXT DEFAULT NULL,
				`updateRule` TEXT DEFAULT NULL,
				`deleteRule` TEXT DEFAULT NULL,
				`options`    JSON DEFAULT "{}" NOT NULL,
				`created`    TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%fZ')) NOT NULL,
				`updated`    TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%fZ')) NOT NULL
			);
INSERT INTO _collections VALUES('_pb_users_auth_',0,'auth','users','[{"system":false,"id":"users_name","name":"name","type":"text","required":false,"presentable":false,"unique":false,"options":{"min":null,"max":null,"pattern":""}},{"system":false,"id":"users_avatar","name":"avatar","type":"file","required":false,"presentable":false,"unique":false,"options":{"mimeTypes":["image/jpeg","image/png","image/svg+xml","image/gif","image/webp"],"thumbs":null,"maxSelect":1,"maxSize":5242880,"protected":false}}]','[]','id = @request.auth.id','id = @request.auth.id','','id = @request.auth.id','id = @request.auth.id','{"allowEmailAuth":true,"allowOAuth2Auth":true,"allowUsernameAuth":true,"exceptEmailDomains":null,"manageRule":null,"minPasswordLength":8,"onlyEmailDomains":null,"onlyVerified":false,"requireEmail":false}','2024-11-18 19:17:38.482Z','2024-11-18 19:17:38.483Z');
CREATE TABLE `_params` (
				`id`      TEXT PRIMARY KEY NOT NULL,
				`key`     TEXT UNIQUE NOT NULL,
				`value`   JSON DEFAULT NULL,
				`created` TEXT DEFAULT "" NOT NULL,
				`updated` TEXT DEFAULT "" NOT NULL
			);
INSERT INTO _params VALUES('rbkbdg3pgajw08k','settings','{"meta":{"appName":"Pocketpoc","appUrl":"http://localhost:8090","hideControls":false,"senderName":"Support","senderAddress":"support@example.com","verificationTemplate":{"body":"\u003cp\u003eHello,\u003c/p\u003e\n\u003cp\u003eThank you for joining us at {APP_NAME}.\u003c/p\u003e\n\u003cp\u003eClick on the button below to verify your email address.\u003c/p\u003e\n\u003cp\u003e\n  \u003ca class=\"btn\" href=\"{ACTION_URL}\" target=\"_blank\" rel=\"noopener\"\u003eVerify\u003c/a\u003e\n\u003c/p\u003e\n\u003cp\u003e\n  Thanks,\u003cbr/\u003e\n  {APP_NAME} team\n\u003c/p\u003e","subject":"Verify your {APP_NAME} email","actionUrl":"{APP_URL}/_/#/auth/confirm-verification/{TOKEN}","hidden":false},"resetPasswordTemplate":{"body":"\u003cp\u003eHello,\u003c/p\u003e\n\u003cp\u003eClick on the button below to reset your password.\u003c/p\u003e\n\u003cp\u003e\n  \u003ca class=\"btn\" href=\"{ACTION_URL}\" target=\"_blank\" rel=\"noopener\"\u003eReset password\u003c/a\u003e\n\u003c/p\u003e\n\u003cp\u003e\u003ci\u003eIf you didn''t ask to reset your password, you can ignore this email.\u003c/i\u003e\u003c/p\u003e\n\u003cp\u003e\n  Thanks,\u003cbr/\u003e\n  {APP_NAME} team\n\u003c/p\u003e","subject":"Reset your {APP_NAME} password","actionUrl":"{APP_URL}/_/#/auth/confirm-password-reset/{TOKEN}","hidden":false},"confirmEmailChangeTemplate":{"body":"\u003cp\u003eHello,\u003c/p\u003e\n\u003cp\u003eClick on the button below to confirm your new email address.\u003c/p\u003e\n\u003cp\u003e\n  \u003ca class=\"btn\" href=\"{ACTION_URL}\" target=\"_blank\" rel=\"noopener\"\u003eConfirm new email\u003c/a\u003e\n\u003c/p\u003e\n\u003cp\u003e\u003ci\u003eIf you didn''t ask to change your email address, you can ignore this email.\u003c/i\u003e\u003c/p\u003e\n\u003cp\u003e\n  Thanks,\u003cbr/\u003e\n  {APP_NAME} team\n\u003c/p\u003e","subject":"Confirm your {APP_NAME} new email address","actionUrl":"{APP_URL}/_/#/auth/confirm-email-change/{TOKEN}","hidden":false}},"logs":{"maxDays":5,"minLevel":0,"logIp":true},"smtp":{"enabled":false,"host":"smtp.example.com","port":587,"username":"","password":"","authMethod":"","tls":false,"localName":""},"s3":{"enabled":false,"bucket":"","region":"","endpoint":"","accessKey":"","secret":"","forcePathStyle":false},"backups":{"cron":"","cronMaxKeep":3,"s3":{"enabled":false,"bucket":"","region":"","endpoint":"","accessKey":"","secret":"","forcePathStyle":false}},"adminAuthToken":{"secret":"0P2h1WRRVDtEz4YeuOIVJx5jzEbvwqxoQdW7THlNkdp87Ejdo8","duration":1209600},"adminPasswordResetToken":{"secret":"yw2NHyX9sXt4SzUtPY0WqPsfbVeCVRQmP4A3zFCvMfM4EQdhaW","duration":1800},"adminFileToken":{"secret":"Z7XVEmeGBJUoCvpNq4EwdzRDpMXijyudKeFljS2ZL2fDmwcgKm","duration":120},"recordAuthToken":{"secret":"iuzwMZMWgUEmop3LTzJkYuEqLgL1I6568plyhiTeGRe43e9dRT","duration":1209600},"recordPasswordResetToken":{"secret":"b7cvLkCh9EEGPzz8BBG1W3cmC47RTr5DHzfXaexnwnErqnTI5E","duration":1800},"recordEmailChangeToken":{"secret":"A1xmVzGqezu4izwIw4ItgPRxdq1v8R75U5QO0kpsWr5Lj8JyyW","duration":1800},"recordVerificationToken":{"secret":"cofhFO5bwocPPIMPhQqRtpOxc7iwXqknxVyGdmNl6wfeEXPmJS","duration":604800},"recordFileToken":{"secret":"HdK8xkf0jv9WLTLQSl6cL1WiwQDYJwKkc0aR2NoXqxiLSTdiao","duration":120},"emailAuth":{"enabled":false,"exceptDomains":null,"onlyDomains":null,"minPasswordLength":0},"googleAuth":{"enabled":false,"clientId":"","clientSecret":"","authUrl":"","tokenUrl":"","userApiUrl":"","displayName":"","pkce":null},"facebookAuth":{"enabled":false,"clientId":"","clientSecret":"","authUrl":"","tokenUrl":"","userApiUrl":"","displayName":"","pkce":null},"githubAuth":{"enabled":false,"clientId":"","clientSecret":"","authUrl":"","tokenUrl":"","userApiUrl":"","displayName":"","pkce":null},"gitlabAuth":{"enabled":false,"clientId":"","clientSecret":"","authUrl":"","tokenUrl":"","userApiUrl":"","displayName":"","pkce":null},"discordAuth":{"enabled":false,"clientId":"","clientSecret":"","authUrl":"","tokenUrl":"","userApiUrl":"","displayName":"","pkce":null},"twitterAuth":{"enabled":false,"clientId":"","clientSecret":"","authUrl":"","tokenUrl":"","userApiUrl":"","displayName":"","pkce":null},"microsoftAuth":{"enabled":false,"clientId":"","clientSecret":"","authUrl":"","tokenUrl":"","userApiUrl":"","displayName":"","pkce":null},"spotifyAuth":{"enabled":false,"clientId":"","clientSecret":"","authUrl":"","tokenUrl":"","userApiUrl":"","displayName":"","pkce":null},"kakaoAuth":{"enabled":false,"clientId":"","clientSecret":"","authUrl":"","tokenUrl":"","userApiUrl":"","displayName":"","pkce":null},"twitchAuth":{"enabled":false,"clientId":"","clientSecret":"","authUrl":"","tokenUrl":"","userApiUrl":"","displayName":"","pkce":null},"stravaAuth":{"enabled":false,"clientId":"","clientSecret":"","authUrl":"","tokenUrl":"","userApiUrl":"","displayName":"","pkce":null},"giteeAuth":{"enabled":false,"clientId":"","clientSecret":"","authUrl":"","tokenUrl":"","userApiUrl":"","displayName":"","pkce":null},"livechatAuth":{"enabled":false,"clientId":"","clientSecret":"","authUrl":"","tokenUrl":"","userApiUrl":"","displayName":"","pkce":null},"giteaAuth":{"enabled":false,"clientId":"","clientSecret":"","authUrl":"","tokenUrl":"","userApiUrl":"","displayName":"","pkce":null},"oidcAuth":{"enabled":false,"clientId":"","clientSecret":"","authUrl":"","tokenUrl":"","userApiUrl":"","displayName":"","pkce":null},"oidc2Auth":{"enabled":false,"clientId":"","clientSecret":"","authUrl":"","tokenUrl":"","userApiUrl":"","displayName":"","pkce":null},"oidc3Auth":{"enabled":false,"clientId":"","clientSecret":"","authUrl":"","tokenUrl":"","userApiUrl":"","displayName":"","pkce":null},"appleAuth":{"enabled":false,"clientId":"","clientSecret":"","authUrl":"","tokenUrl":"","userApiUrl":"","displayName":"","pkce":null},"instagramAuth":{"enabled":false,"clientId":"","clientSecret":"","authUrl":"","tokenUrl":"","userApiUrl":"","displayName":"","pkce":null},"vkAuth":{"enabled":false,"clientId":"","clientSecret":"","authUrl":"","tokenUrl":"","userApiUrl":"","displayName":"","pkce":null},"yandexAuth":{"enabled":false,"clientId":"","clientSecret":"","authUrl":"","tokenUrl":"","userApiUrl":"","displayName":"","pkce":null},"patreonAuth":{"enabled":false,"clientId":"","clientSecret":"","authUrl":"","tokenUrl":"","userApiUrl":"","displayName":"","pkce":null},"mailcowAuth":{"enabled":false,"clientId":"","clientSecret":"","authUrl":"","tokenUrl":"","userApiUrl":"","displayName":"","pkce":null},"bitbucketAuth":{"enabled":false,"clientId":"","clientSecret":"","authUrl":"","tokenUrl":"","userApiUrl":"","displayName":"","pkce":null},"planningcenterAuth":{"enabled":false,"clientId":"","clientSecret":"","authUrl":"","tokenUrl":"","userApiUrl":"","displayName":"","pkce":null}}','2024-11-18 19:17:38.481Z','2024-11-18 19:18:56.162Z');
CREATE TABLE `_externalAuths` (
				`id`           TEXT PRIMARY KEY NOT NULL,
				`collectionId` TEXT NOT NULL,
				`recordId`     TEXT NOT NULL,
				`provider`     TEXT NOT NULL,
				`providerId`   TEXT NOT NULL,
				`created`      TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%fZ')) NOT NULL,
				`updated`      TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%fZ')) NOT NULL,
				---
				FOREIGN KEY (`collectionId`) REFERENCES `_collections` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
			);
CREATE TABLE `users` (`avatar` TEXT DEFAULT '' NOT NULL, `created` TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%fZ')) NOT NULL, `email` TEXT DEFAULT '' NOT NULL, `emailVisibility` BOOLEAN DEFAULT FALSE NOT NULL, `id` TEXT PRIMARY KEY DEFAULT ('r'||lower(hex(randomblob(7)))) NOT NULL, `lastLoginAlertSentAt` TEXT DEFAULT '' NOT NULL, `lastResetSentAt` TEXT DEFAULT '' NOT NULL, `lastVerificationSentAt` TEXT DEFAULT '' NOT NULL, `name` TEXT DEFAULT '' NOT NULL, `passwordHash` TEXT NOT NULL, `tokenKey` TEXT NOT NULL, `updated` TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%fZ')) NOT NULL, `username` TEXT NOT NULL, `verified` BOOLEAN DEFAULT FALSE NOT NULL);
INSERT INTO users VALUES('','2024-11-18 19:18:31.625Z','kevin.ganthy@gmail.com',0,'6x26v8gpocf4ddo','','','','Kévin Ganthy','$2a$12$.5XekHg6TZ6.jbUjjPvRIO25RyhyZScvuraVasDFPiSz1EhM1RhqC','P3XEURdYvRWSZnfdJVPn2nK2omZ42kSNguJ8iaFiFYEhpd31oM','2024-11-18 19:18:31.625Z','kevin',0);
CREATE UNIQUE INDEX _externalAuths_record_provider_idx on `_externalAuths` (`collectionId`, `recordId`, `provider`);
CREATE UNIQUE INDEX _externalAuths_collection_provider_idx on `_externalAuths` (`collectionId`, `provider`, `providerId`);
CREATE UNIQUE INDEX __pb_users_auth__username_idx ON `users` (`username`);
CREATE UNIQUE INDEX __pb_users_auth__email_idx ON `users` (`email`) WHERE `email` != '';
CREATE UNIQUE INDEX __pb_users_auth__tokenKey_idx ON `users` (`tokenKey`);
COMMIT;
