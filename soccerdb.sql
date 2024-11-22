DROP DATABASE soccerdb;
CREATE DATABASE soccerdb;
use soccerdb;
-- 1. Stadium 테이블 생성
CREATE TABLE Stadium (
    StadiumID INT PRIMARY KEY,          -- 경기장 ID, 기본 키
    Name VARCHAR(100) NOT NULL,         -- 경기장 이름
    Capacity INT,                       -- 수용 인원
    Location VARCHAR(100)               -- 위치
);

-- 2. Team 테이블 생성
CREATE TABLE Team (
    TeamID INT PRIMARY KEY,             -- 팀 ID, 기본 키
    Name VARCHAR(100) NOT NULL,         -- 팀 이름
    Strength INT,                       -- 팀 전력
    WinRate FLOAT,                      -- 승률
    Strategy VARCHAR(100),              -- 전술
    Formation VARCHAR(100),  			-- 포메이션
    Coach VARCHAR(100),                 -- 코치
    AvgScore FLOAT,                     -- 평균 득점
    AvgConcede FLOAT                    -- 평균 실점
);

-- 3. Game 테이블 생성
CREATE TABLE Game (
    GameID INT PRIMARY KEY,             -- 경기 ID, 기본 키
    Date DATE NOT NULL,                 -- 경기 날짜
    LocationID INT,                     -- 경기장 ID, 외래 키
    FOREIGN KEY (LocationID) REFERENCES Stadium(StadiumID)
);

-- 4. Game_Participation 테이블 생성 (경기 참여 중간 테이블)
CREATE TABLE Game_Participation (
    GameID INT,                         -- 경기 ID, 외래 키
    TeamID INT,                         -- 팀 ID, 외래 키
    Role ENUM('Home', 'Away') NOT NULL, -- 팀 역할 (Home 또는 Away)
    PRIMARY KEY (GameID, TeamID),       -- 복합 기본 키
    FOREIGN KEY (GameID) REFERENCES Game(GameID),
    FOREIGN KEY (TeamID) REFERENCES Team(TeamID)
);

-- 5. Game_Result 테이블 생성
CREATE TABLE Game_Result (
    GameID INT,                         -- 경기 ID, 외래 키
    TeamID INT,                         -- 팀 ID, 외래 키
    Goals INT DEFAULT 0,                -- 득점 수
    Assists INT DEFAULT 0,              -- 어시스트 수
    Shots INT DEFAULT 0,                -- 슈팅 수
    Fouls INT DEFAULT 0,                -- 파울 수
    YellowCards INT DEFAULT 0,          -- 경고 카드 수
    RedCards INT DEFAULT 0,             -- 퇴장 카드 수
    PRIMARY KEY (GameID, TeamID),       -- 복합 기본 키
    FOREIGN KEY (GameID) REFERENCES Game(GameID),
    FOREIGN KEY (TeamID) REFERENCES Team(TeamID)
);

-- 6. Player 테이블 생성
CREATE TABLE Player (
    PlayerID INT PRIMARY KEY,           -- 선수 ID, 기본 키
    Name VARCHAR(100) NOT NULL,         -- 선수 이름
    Weight FLOAT,                       -- 몸무게
    Height FLOAT,                       -- 키
    Age INT,                            -- 나이
    Position VARCHAR(50),               -- 포지션
    TeamID INT,                         -- 팀 ID, 외래 키
    FOREIGN KEY (TeamID) REFERENCES Team(TeamID)
);

-- 7. Player_Performance 테이블 생성 (선수 경기 성과)
CREATE TABLE Player_Performance (
    PlayerID INT,                       -- 선수 ID, 외래 키
    Goals INT DEFAULT 0,                -- 득점 수
    Assists INT DEFAULT 0,              -- 어시스트 수
    Shots INT DEFAULT 0,                -- 슈팅 수
    Fouls INT DEFAULT 0,                -- 파울 수
    YellowCards INT DEFAULT 0,          -- 경고 카드 수
    RedCards INT DEFAULT 0,             -- 퇴장 카드 수
    FOREIGN KEY (PlayerID) REFERENCES Player(PlayerID)
);


INSERT INTO Stadium (StadiumID, Name, Capacity, Location)
VALUES
    (1, '춘천', 20000, '강원'),
    (2, '광주', 10007, '광주'),
    (3, '대구전', 15000, '대구'),
    (4, '대전w', 50535, '대전'),
    (5, '서울w', 66704, '서울'),
    (6, '수원w', 42542, '수원'),
    (7, '수원', 11808, '수원'), -- Location을 '수원'으로 변경
    (8, '문수', 43554, '울산'),
    (9, '인천', 25000, '인천'),
    (10, '전주w', 36781, '전북'),
    (11, '제주w', 25000, '제주'),
    (12, '포항', 20000, '포항');
    
    INSERT INTO Team (TeamID, Name, Strength, WinRate, Strategy, Formation, Coach, AvgScore, AvgConcede) VALUES
(1, '강원 FC', 70, 0.30, '중앙 압박', '4-3-3', '이영표', 1.21, 1.68),
(2, '광주 FC', 78, 0.47, '중앙 플레이', '4-2-3-1', '이정효', 1.42, 1.42),
(3, '대구 FC', 62, 0.28, '빠른 역습', '3-4-3', '최원권', 1.05, 1.84),
(4, '대전 하나 시티즌', 82, 0.52, '측면 활용', '3-4-3', '이민성', 1.58, 1.42),
(5, 'FC 서울', 85, 0.57, '공격+수비 밸런스', '4-3-3', '안익수', 1.58, 1.34),
(6, '수원 삼성', 65, 0.30, '수비 반격', '4-4-2', '김병수', 1.11, 1.79),
(7, '수원 FC', 68, 0.34, '롱볼 중심', '4-2-3-1', '이병근', 1.26, 1.74),
(8, '울산 현대', 95, 0.71, '공격 중심', '4-2-3-1', '홍명보', 1.94, 1.05),
(9, '인천 유나이티드', 76, 0.45, '수비적인 전술', '5-4-1', '조성환', 1.26, 1.37),
(10, '전북 현대', 88, 0.60, '수비 안정화', '4-4-2', '댄 페트레스쿠', 1.63, 1.18),
(11, '제주 유나이티드', 80, 0.50, '포지셔닝 기반', '4-4-2', '남기일', 1.47, 1.37),
(12, '포항 스틸러스', 90, 0.65, '빠른 역습', '4-1-4-1', '김기동', 1.68, 1.11);


INSERT INTO Game (GameID, Date, LocationID)
VALUES
    (1, '2023-02-25', 8),  -- 문수
    (2, '2023-02-25', 5),  -- 서울w
    (3, '2023-02-25', 6),  -- 수원w
    (4, '2023-02-26', 12), -- 포항
    (5, '2023-02-26', 11), -- 제주w
    (6, '2023-02-26', 4),  -- 대전w
    (7, '2023-03-04', 9),  -- 인천
    (8, '2023-03-04', 7),  -- 수원
    (9, '2023-03-04', 3),  -- 대구전
    (10, '2023-03-05', 10), -- 전주w
    (11, '2023-03-05', 1),  -- 춘천
    (12, '2023-03-05', 2),  -- 광주
    (13, '2023-03-11', 7),  -- 수원
    (14, '2023-03-11', 4),  -- 대전w 
    (15, '2023-03-11', 1),  -- 춘천
    (16, '2023-03-12', 5),  -- 서울w
    (17, '2023-03-12', 10), -- 전주w
    (18, '2023-03-12', 9),  -- 인천
    (19, '2023-03-18', 12), -- 포항
    (20, '2023-03-18', 2),  -- 광주
    (21, '2023-03-18', 11), -- 제주w
    (22, '2023-03-19', 3),  -- 대구전
    (23, '2023-03-19', 6),  -- 수원w
    (24, '2023-03-19', 8),  -- 문수
    (25, '2023-04-01', 10), -- 전주w
    (26, '2023-04-01', 9),  -- 인천
    (27, '2023-04-01', 2),  -- 광주
    (28, '2023-04-01', 4),  -- 대전w
    (29, '2023-04-02', 11), -- 제주w
    (30, '2023-04-02', 7);  -- 수원
    INSERT INTO Game (GameID, Date, LocationID)
VALUES
    (31, '2023-04-08', 8),  -- 문수
    (32, '2023-04-08', 5),  -- 서울w
    (33, '2023-04-08', 12), -- 포항
    (34, '2023-04-09', 10), -- 전주w
    (35, '2023-04-09', 1),  -- 춘천
    (36, '2023-04-09', 7),  -- 수원
    (37, '2023-04-15', 6),  -- 수원w
    (38, '2023-04-15', 12), -- 포항
    (39, '2023-04-15', 7),  -- 수원
    (40, '2023-04-16', 1),  -- 춘천
    (41, '2023-04-16', 4),  -- 대전w
    (42, '2023-04-16', 3),  -- 대구전
    (43, '2023-04-22', 5),  -- 서울w
    (44, '2023-04-22', 8),  -- 문수
    (45, '2023-04-22', 3),  -- 대구전
    (46, '2023-04-22', 9),  -- 인천
    (47, '2023-04-23', 2),  -- 광주
    (48, '2023-04-23', 11), -- 제주w
    (49, '2023-04-25', 12), -- 포항
    (50, '2023-04-25', 9),  -- 인천
    (51, '2023-04-26', 1),  -- 춘천
    (52, '2023-04-26', 2),  -- 광주
    (53, '2023-04-26', 10), -- 전주w
    (54, '2023-04-26', 7),  -- 수원
    (55, '2023-04-29', 7),  -- 수원
    (56, '2023-04-29', 10), -- 전주w
    (57, '2023-04-30', 4),  -- 대전w
    (58, '2023-04-30', 12), -- 포항
    (59, '2023-04-30', 6),  -- 수원w (수정됨)
    (60, '2023-04-30', 8);  -- 문수 (수정됨)
    INSERT INTO Game (GameID, Date, LocationID)
VALUES
    (61, '2023-05-05', 3),  -- 대구전
    (62, '2023-05-05', 5),  -- 서울W
    (63, '2023-05-05', 9),  -- 인천
    (64, '2023-05-06', 11), -- 제주W
    (65, '2023-05-06', 7),  -- 수원
    (66, '2023-05-06', 2),  -- 광주
    (67, '2023-05-09', 8),  -- 문수
    (68, '2023-05-09', 3),  -- 대구전
    (69, '2023-05-09', 5),  -- 서울W
    (70, '2023-05-10', 11), -- 제주W
    (71, '2023-05-10', 6),  -- 수원W
    (72, '2023-05-10', 4),  -- 대전W
    (73, '2023-05-13', 12), -- 포항
    (74, '2023-05-13', 2),  -- 광주
    (75, '2023-05-13', 1),  -- 춘천
    (76, '2023-05-14', 8),  -- 문수
    (77, '2023-05-14', 9),  -- 인천
    (78, '2023-05-14', 7),  -- 수원
    (79, '2023-05-20', 9),  -- 인천
    (80, '2023-05-20', 5),  -- 서울W
    (81, '2023-05-20', 4),  -- 대전W
    (82, '2023-05-21', 1),  -- 춘천
    (83, '2023-05-21', 6),  -- 수원W
    (84, '2023-05-21', 10), -- 전주W
    (85, '2023-05-27', 11), -- 제주W
    (86, '2023-05-27', 3),  -- 대구전
    (87, '2023-05-28', 5),  -- 서울W
    (88, '2023-05-28', 7),  -- 수원
    (89, '2023-05-28', 8),  -- 문수
    (90, '2023-05-29', 12); -- 포항
    INSERT INTO Game (GameID, Date, LocationID)
VALUES
    (91, '2023-06-03', 10), -- 전주W
    (92, '2023-06-03', 6),  -- 수원W
    (93, '2023-06-03', 11), -- 제주W
    (94, '2023-06-03', 2),  -- 광주
    (95, '2023-06-04', 4),  -- 대전W
    (96, '2023-06-04', 3),  -- 대구전
    (97, '2023-06-06', 7),  -- 수원
    (98, '2023-06-06', 12), -- 포항
    (99, '2023-06-07', 10), -- 전주W
    (100, '2023-06-07', 2), -- 광주
    (101, '2023-06-07', 9), -- 인천
    (102, '2023-06-07', 1), -- 춘천
    (103, '2023-06-10', 3), -- 대구전
    (104, '2023-06-10', 8), -- 문수
    (105, '2023-06-10', 4), -- 대전W
    (106, '2023-06-11', 1), -- 춘천
    (107, '2023-06-11', 5), -- 서울W
    (108, '2023-06-11', 6), -- 수원W
    (109, '2023-06-24', 6), -- 수원W
    (110, '2023-06-24', 11), -- 제주W
    (111, '2023-06-24', 2), -- 광주
    (112, '2023-06-24', 8), -- 문수
    (113, '2023-06-25', 9), -- 인천
    (114, '2023-06-25', 7), -- 수원
    (115, '2023-07-01', 10), -- 전주W
    (116, '2023-07-01', 3),  -- 대구전
    (117, '2023-07-01', 5),  -- 서울W
    (118, '2023-07-02', 2),  -- 광주
    (119, '2023-07-02', 12), -- 포항
    (120, '2023-07-02', 9);  -- 인천
INSERT INTO Game (GameID, Date, LocationID)
VALUES
    (121, '2023-07-07', 11), -- 제주W
    (122, '2023-07-07', 1),  -- 춘천
    (123, '2023-07-08', 12), -- 포항
    (124, '2023-07-08', 7),  -- 수원
    (125, '2023-07-08', 10), -- 전주W
    (126, '2023-07-09', 4),  -- 대전W
    (127, '2023-07-11', 3),  -- 대구전
    (128, '2023-07-11', 11), -- 제주W
    (129, '2023-07-12', 8),  -- 문수
    (130, '2023-07-12', 6),  -- 수원W
    (131, '2023-07-12', 4),  -- 대전W
    (132, '2023-07-12', 5),  -- 서울W
    (133, '2023-07-15', 6),  -- 수원W
    (134, '2023-07-15', 1),  -- 춘천
    (135, '2023-07-15', 2),  -- 광주
    (136, '2023-07-16', 10), -- 전주W
    (137, '2023-07-16', 12), -- 포항
    (138, '2023-07-16', 9),  -- 인천
    (139, '2023-07-21', 8),  -- 문수
    (140, '2023-07-21', 12), -- 포항
    (141, '2023-07-22', 7),  -- 수원
    (142, '2023-07-22', 1),  -- 춘천
    (143, '2023-07-22', 5),  -- 서울W
    (144, '2023-07-22', 4),  -- 대전W
    (145, '2023-08-04', 5),  -- 서울W
    (146, '2023-08-04', 2),  -- 광주
    (147, '2023-08-05', 6),  -- 수원W
    (148, '2023-08-05', 3),  -- 대구전
    (149, '2023-08-06', 10), -- 전주W
    (150, '2023-08-06', 11); -- 제주W
INSERT INTO Game (GameID, Date, LocationID)
VALUES
    (151, '2023-08-12', 10), -- 전주W
    (152, '2023-08-12', 1),  -- 춘천
    (153, '2023-08-12', 11), -- 제주W
    (154, '2023-08-13', 4),  -- 대전W
    (155, '2023-08-13', 9),  -- 인천
    (156, '2023-08-13', 12), -- 포항
    (157, '2023-08-18', 6),  -- 수원W
    (158, '2023-08-18', 9),  -- 인천
    (159, '2023-08-19', 8),  -- 문수
    (160, '2023-08-19', 1),  -- 춘천
    (161, '2023-08-19', 5),  -- 서울W
    (162, '2023-08-20', 12), -- 포항
    (163, '2023-08-25', 7),  -- 수원
    (164, '2023-08-25', 10), -- 전주W
    (165, '2023-08-26', 3),  -- 대구전
    (166, '2023-08-26', 1),  -- 춘천
    (167, '2023-08-27', 5),  -- 서울W
    (168, '2023-08-27', 2);  -- 광주
INSERT INTO Game (GameID, Date, LocationID)
VALUES
    (169, '2023-09-01', 4),  -- 대전W
    (170, '2023-09-01', 3),  -- 대구전
    (171, '2023-09-02', 6),  -- 수원W
    (172, '2023-09-02', 9),  -- 인천
    (173, '2023-09-03', 8),  -- 문수
    (174, '2023-09-03', 11), -- 제주W
    (175, '2023-09-16', 10), -- 전주W
    (176, '2023-09-16', 9),  -- 인천
    (177, '2023-09-16', 12), -- 포항
    (178, '2023-09-16', 8),  -- 문수
    (179, '2023-09-17', 5),  -- 서울W
    (180, '2023-09-17', 6),  -- 수원W
    (181, '2023-09-23', 4),  -- 대전W
    (182, '2023-09-23', 11), -- 제주W
    (183, '2023-09-23', 7),  -- 수원
    (184, '2023-09-24', 2),  -- 광주
    (185, '2023-09-24', 1),  -- 춘천
    (186, '2023-09-24', 3);  -- 대구전
INSERT INTO Game (GameID, Date, LocationID)
VALUES
    (187, '2023-09-30', 12), -- 포항
    (188, '2023-09-30', 7),  -- 수원
    (189, '2023-09-30', 10), -- 전주W
    (190, '2023-09-30', 9),  -- 인천
    (191, '2023-10-01', 1),  -- 춘천
    (192, '2023-10-01', 11), -- 제주W
    (193, '2023-10-08', 8),  -- 문수
    (194, '2023-10-08', 3),  -- 대구전
    (195, '2023-10-08', 5),  -- 서울W
    (196, '2023-10-08', 6),  -- 수원W
    (197, '2023-10-08', 2),  -- 광주
    (198, '2023-10-08', 4),  -- 대전W
    (199, '2023-10-20', 12), -- 포항
    (200, '2023-10-21', 2),  -- 광주
    (201, '2023-10-21', 3),  -- 대구전
    (202, '2023-10-22', 5),  -- 서울W
    (203, '2023-10-22', 11), -- 제주W
    (204, '2023-10-22', 4),  -- 대전W
    (205, '2023-10-28', 10), -- 전주W
    (206, '2023-10-28', 2),  -- 광주
    (207, '2023-10-28', 1);  -- 춘천
INSERT INTO Game (GameID, Date, LocationID)
VALUES
    (208, '2023-10-29', 8),  -- 문수
    (209, '2023-10-29', 6),  -- 수원W
    (210, '2023-10-29', 7),  -- 수원
    (211, '2023-11-11', 4),  -- 대전W
    (212, '2023-11-11', 3),  -- 대구전
    (213, '2023-11-11', 11), -- 제주W
    (214, '2023-11-12', 9),  -- 인천
    (215, '2023-11-12', 7),  -- 수원
    (216, '2023-11-12', 8),  -- 문수
    (217, '2023-11-24', 9),  -- 인천
    (218, '2023-11-25', 10), -- 전주W
    (219, '2023-11-25', 11), -- 제주W
    (220, '2023-11-25', 12), -- 포항
    (221, '2023-11-25', 5),  -- 서울W
    (222, '2023-11-25', 1),  -- 춘천
    (223, '2023-12-02', 4),  -- 대전W
    (224, '2023-12-02', 7),  -- 수원
    (225, '2023-12-02', 6),  -- 수원W
    (226, '2023-12-03', 8),  -- 문수
    (227, '2023-12-03', 2),  -- 광주
    (228, '2023-12-03', 3);  -- 대구전

INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (1, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (1, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (2, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (2, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (3, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (3, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (4, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (4, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (5, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (5, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (6, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (6, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (7, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (7, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (8, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (8, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (9, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (9, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (10, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (10, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (11, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (11, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (12, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (12, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (13, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (13, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (14, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (14, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (15, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (15, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (16, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (16, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (17, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (17, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (18, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (18, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (19, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (19, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (20, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (20, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (21, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (21, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (22, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (22, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (23, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (23, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (24, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (24, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (25, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (25, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (26, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (26, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (27, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (27, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (28, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (28, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (29, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (29, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (30, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (30, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (31, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (31, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (32, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (32, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (33, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (33, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (34, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (34, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (35, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (35, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (36, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (36, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (37, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (37, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (38, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (38, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (39, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (39, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (40, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (40, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (41, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (41, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (42, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (42, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (43, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (43, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (44, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (44, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (45, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (45, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (46, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (46, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (47, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (47, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (48, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (48, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (49, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (49, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (50, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (50, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (51, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (51, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (52, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (52, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (53, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (53, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (54, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (54, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (55, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (55, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (56, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (56, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (57, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (57, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (58, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (58, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (59, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (59, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (60, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (60, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (61, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (61, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (62, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (62, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (63, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (63, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (64, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (64, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (65, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (65, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (66, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (66, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (67, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (67, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (68, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (68, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (69, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (69, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (70, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (70, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (71, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (71, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (72, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (72, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (73, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (73, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (74, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (74, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (75, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (75, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (76, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (76, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (77, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (77, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (78, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (78, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (79, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (79, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (80, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (80, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (81, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (81, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (82, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (82, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (83, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (83, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (84, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (84, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (85, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (85, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (86, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (86, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (87, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (87, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (88, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (88, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (89, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (89, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (90, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (90, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (91, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (91, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (92, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (92, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (93, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (93, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (94, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (94, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (95, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (95, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (96, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (96, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (97, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (97, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (98, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (98, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (99, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (99, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (100, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (100, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (101, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (101, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (102, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (102, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (103, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (103, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (104, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (104, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (105, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (105, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (106, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (106, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (107, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (107, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (108, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (108, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (109, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (109, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (110, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (110, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (111, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (111, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (112, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (112, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (113, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (113, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (114, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (114, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (115, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (115, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (116, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (116, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (117, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (117, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (118, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (118, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (119, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (119, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (120, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (120, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (121, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (121, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (122, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (122, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (123, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (123, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (124, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (124, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (125, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (125, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (126, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (126, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (127, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (127, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (128, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (128, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (129, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (129, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (130, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (130, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (131, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (131, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (132, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (132, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (133, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (133, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (134, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (134, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (135, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (135, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (136, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (136, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (137, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (137, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (138, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (138, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (139, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (139, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (140, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (140, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (141, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (141, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (142, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (142, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (143, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (143, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (144, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (144, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (145, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (145, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (146, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (146, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (147, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (147, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (148, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (148, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (149, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (149, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (150, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (150, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (151, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (151, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (152, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (152, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (153, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (153, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (154, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (154, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (155, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (155, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (156, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (156, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (157, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (157, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (158, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (158, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (159, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (159, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (160, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (160, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (161, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (161, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (162, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (162, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (163, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (163, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (164, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (164, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (165, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (165, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (166, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (166, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (167, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (167, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (168, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (168, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (169, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (169, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (170, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (170, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (171, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (171, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (172, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (172, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (173, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (173, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (174, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (174, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (175, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (175, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (176, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (176, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (177, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (177, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (178, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (178, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (179, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (179, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (180, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (180, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (181, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (181, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (182, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (182, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (183, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (183, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (184, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (184, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (185, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (185, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (186, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (186, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (187, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (187, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (188, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (188, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (189, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (189, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (190, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (190, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (191, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (191, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (192, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (192, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (193, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (193, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (194, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (194, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (195, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (195, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (196, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (196, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (197, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (197, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (198, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (198, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (199, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (199, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (200, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (200, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (201, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (201, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (202, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (202, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (203, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (203, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (204, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (204, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (205, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (205, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (206, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (206, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (207, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (207, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (208, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (208, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (209, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (209, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (210, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (210, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (211, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (211, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (212, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (212, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (213, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (213, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (214, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (214, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (215, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (215, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (216, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (216, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (217, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (217, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (218, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (218, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (219, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (219, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (220, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (220, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (221, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (221, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (222, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (222, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (223, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (223, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (224, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (224, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (225, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (225, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (226, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (226, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (227, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (227, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (228, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (228, 9, 'Away');


INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (1, 8, 2, 2, 10, 11, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (1, 10, 1 ,1 ,14 ,17 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (2, 5, 2, 2, 13, 15, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (2, 9, 1, 1, 15, 12, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (3, 6, 0,0 ,10 ,13 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (3, 2, 1, 1,10 ,11 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (4, 12, 3,3 ,9 ,8 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (4, 3, 2, 2,5 ,13 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (5, 11,0 ,0 ,14 ,13 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (5, 1, 0, 0, 8, 10, 3,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (6, 4, 2, 2,9 ,12 ,5 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (6, 1, 0,0 ,11 ,7 , 1,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (7, 9, 3, 3, 22,10 ,3 ,1 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (7, 4, 2, 2, 7, 10, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (8, 7, 1,1 , 5,13 ,1 ,1 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (8, 12, 2, 2, 9,10 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (9, 3, 1,1 ,11 ,19 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (9, 11, 1, 1,12 ,14 ,3 , 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (10, 10, 1,1 ,8 ,15 ,2 , 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (10, 6, 1, 1, 20, 9, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (11, 1, 0, 0, 9,6 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (11, 8, 1, 1, 10, 8,4 , 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (12, 2, 0,0 ,6 ,12 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (12, 5, 2, 2,7 ,15 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (13, 7, 2,2 ,11 ,10 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (13, 6, 1, 1, 10, 13, 1,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (14, 4, 0, 0, 10, 11,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (14, 12, 0, 0, 3,17 ,1 ,1 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (15, 1, 1, 1,7 ,13 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (15, 3, 1, 1, 10, 14, 1,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (16, 5, 1, 1,3 ,10 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (16, 8, 2,2 ,8 ,11 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (17, 10, 2, 2, 15, 18, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (17, 2, 0, 0, 8,18 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (18, 9, 1,1 ,13 ,12 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (18, 11,0 ,0 ,9 ,5 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (19, 12, 1, 1, 12, 11, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (19, 1, 1, 1, 3,9 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (20, 2, 5, 5, 17, 7,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (20, 9, 0,0 ,9 ,14 , 2,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (21, 11, 1,1 ,10 ,6 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (21, 5, 2, 2, 9,9 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (22, 3, 2, 2, 11,15 ,5 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (22, 10, 0, 0, 11,10 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (23, 6, 1, 1, 15,9 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (23, 4, 3, 3, 11,11 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (24, 8, 3, 3, 16, 12, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (24, 7, 0, 0, 9,9 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (25, 10, 1, 1, 8, 14, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (25, 12, 2, 2, 8,9 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (26, 9, 0,0 ,6 ,8 , 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (26, 3, 0, 0, 5,12 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (27, 2, 2, 2, 17,10 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (27, 7, 0, 0, 6, 12, 4, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (28, 4, 3, 3, 16, 6, 2,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (28, 5, 2, 2, 13, 8, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (29, 11, 1, 1, 15, 12, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (29, 8, 3, 3, 15, 13, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (30, 6, 1, 1, 9, 8, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (30, 1, 1, 1, 12, 9, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (31, 8, 2, 2, 10, 13, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (31, 6, 1, 1, 14, 9, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (32, 5, 3, 3, 14, 8, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (32, 3, 0, 0, 12, 11,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (33, 12, 2, 2, 9, 11,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (33, 2, 0, 0, 3, 9,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (34, 10, 2, 2, 5, 14, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (34, 9, 0, 0, 4, 9, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (35, 1, 0, 0, 11,13 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (35, 11, 1, 1, 8, 13, 2,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (36, 7, 5, 5, 19, 11, 2,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (36, 4, 3, 3, 8, 16, 1, 1);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (37, 6, 2,2 , 11, 17, 1,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (37, 11, 3,3 ,12 ,9 ,5 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (38, 12, 1, 1, 8, 5, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (38, 5, 1, 1, 5, 14, 4, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (39, 7, 1,1 ,16 ,6 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (39, 10, 0, 0, 11,8 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (40, 1,  0, 0 , 5 ,11  ,2  ,0  );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (40, 9,  2, 2 , 7 ,14  ,2  , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (41, 4,  2,  2, 10 , 14 , 0 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (41, 8,  1, 1 , 16 , 7 , 2 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (42, 3,  3, 3 , 11 , 17 , 5 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (42, 2, 4 , 4 , 13 , 14 , 1 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (43, 5,  3, 3 , 15 , 3 , 3 ,0  );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (43, 6, 1 ,1  ,10  ,12  ,1  ,0  );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (44, 8, 2 , 2 , 14 , 5 , 1 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (44, 12,  2, 2 , 13 , 15 , 2 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (45, 3, 1 , 1 , 12 , 13 , 4 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (45, 4,  0,  0,  11,  9, 5 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (46, 9, 2 , 2 , 16 , 10 , 2 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (46, 7,  2, 2 , 12 , 7 , 1 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (47, 2, 0 , 0 , 10 , 8 , 2 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (47, 1, 0 , 0 , 6 , 11 , 2 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (48, 11, 0 , 0 , 12 ,  8,  3, 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (48, 10, 2 , 2 , 9 , 14 , 2 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (49, 12, 1 , 1 , 7 , 14 , 0 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (49, 6,  0, 0 , 4 , 18 ,4  ,0  );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (50, 9,  0,  0,  6, 14 , 0 ,0  );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (50, 8,  1, 1 , 9 , 12 , 2 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (51, 1,  3, 3 , 7 , 9 ,0  ,0  );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (51, 5,  2, 2 , 9 , 5 , 1 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (52, 2,  0, 0 , 16 , 15 , 2 ,0  );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (52, 11, 1 , 1 , 6 , 14 , 4 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (53, 10, 1 , 1 , 9 , 8 , 1 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (53, 4, 2 , 2 , 10 , 17 , 1 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (54, 7, 1 , 1 , 14 , 11, 1 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (54, 3, 1 , 1 , 18 , 8 , 0 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (55, 7,  0,  0,  8, 13 , 0 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (55, 5, 3 , 3 , 13 , 14 , 3 ,0  );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (56, 10, 0 , 0 , 10 , 9 , 3 , 1 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (56, 1, 1 , 1 , 4 , 14 , 3 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (57, 4,  0, 0 , 7 , 12 , 0 ,0  );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (57, 11, 3 , 3 , 15 ,17  ,2  ,0  );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (58, 12, 0 , 0 , 2 , 8 , 4 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (58, 9,  2,  2, 6 , 15 , 3 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (59, 6,  0,  0, 13 , 10 ,4  ,0  );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (59, 3,  1,  1, 6 , 13 , 2 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (60, 8, 2 , 2 , 12 ,  8,  3, 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (60, 2, 1 , 1 , 14 , 15 , 5 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (61, 3, 0 , 0 , 12 , 17 , 3 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (61, 8, 3 , 3 , 8 , 7 , 3 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (62, 5, 1 , 1 , 14 , 8 , 2 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (62, 10, 1 , 1 , 9 , 19 , 3 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (63, 9, 0 , 0 , 13 , 8 , 0 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (63, 6, 1 , 1 , 7 , 26 , 8 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (64, 11, 2 , 2 , 6 , 15 , 2 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (64, 12, 1 , 1 , 13 , 12 ,5  ,0  );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (65, 7, 2 , 2 ,  13,  11, 5 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (65, 1,  0,  0, 11 , 17 , 2 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (66, 2, 0 , 0 , 10 , 10 , 3 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (66, 4,  0,  0, 5 ,  21, 4 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (67, 8,  1, 1 , 11 , 7 ,2  ,0  );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (67, 1,  0, 0 , 6 , 6 , 0 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (68, 3, 1 , 1 , 7 , 14 , 2 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (68, 12,  1, 1 , 12 , 8 , 2 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (69, 5, 3 , 3 , 13 , 10 , 1 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (69, 2, 1 , 1 , 5 , 12 ,  3,  0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (70, 11,  2, 2 , 17 , 7 , 2 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (70, 9, 0 , 0 , 8 , 10 , 1 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (71, 6, 0, 0, 5, 11, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (71, 10, 3, 3, 18, 12,3,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (72, 4, 2, 2, 12, 18,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (72, 7, 1, 1,20 ,11, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (73, 12, 3, 3, 10, 7, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (73, 4, 2, 2, 6, 12, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (74, 2, 0, 0, 7, 12, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (74, 3, 2,2 ,6 ,7 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (75, 1, 0, 0, 11, 11, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (75, 6, 2, 2, 8, 12, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (76, 8, 3, 3, 13, 5, 1,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (76, 5, 2, 2,17 ,11 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (77, 9, 0, 0, 9, 16, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (77, 10, 0, 0, 9, 7, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (78, 7, 0, 0, 11, 12, 1,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (78, 11, 5, 5, 13, 9, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (79, 9, 1, 1, 14, 9, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (79, 2, 1, 1, 11, 12, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (80, 5, 1, 1, 15,8 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (80, 11, 1, 1, 5, 3, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (81, 4, 0, 0,16 ,7 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (81, 3, 1, 1, 8, 16, 6, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (82, 1, 0, 0, 5,16 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (82, 12, 0, 0,11 ,11 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (83, 6, 2, 2, 5, 6, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (83, 8, 3, 3, 21, 10, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (84, 10, 3, 3, 15, 9, 1,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (84, 7, 1, 1, 8, 10, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (85, 11, 2, 2, 10, 12, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (85, 6, 1,1 ,7 ,10 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (86, 3, 2, 2, 13, 7, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (86, 9, 2,2 ,14 ,13 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (87, 5, 1,1 ,12 ,7 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (87, 1, 0, 0, 5, 11, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (88, 7, 0, 0, 8, 6, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (88, 2, 2,2 ,20 , 9, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (89, 8, 3, 3, 16, 10, 2,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (89, 4, 3, 3, 13, 10, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (90, 12, 1,1 ,13 , 7, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (90, 10, 0, 0, 8, 13, 2,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (91, 10,2, 2, 10, 8, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (91, 8, 0, 0,10 ,9 ,1 , 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (92, 6, 1, 1, 18,5 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (92, 7, 2, 2, 7, 15, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (93, 11, 2, 2, 12, 12, 2,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (93, 1, 2, 2, 13, 15,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (94, 2, 4, 4,10 ,8 ,4 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (94, 12, 2, 2, 8, 14, 5,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (95, 4, 1, 1, 13, 6, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (95, 9, 3,3 ,7 ,13 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (96, 3, 1, 1, 10, 13, 2,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (96, 5, 0, 0, 9, 6, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (97, 7, 1, 1, 11,7 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (97, 8, 3, 3, 14, 2, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (98, 12, 2, 2, 11, 10, 4,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (98, 11, 1,1 ,3 ,14 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (99, 10, 1, 1, 10,9 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (99, 3, 0, 0, 9, 8, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (100, 2, 2,2,9,9,1,0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (100, 6, 1,1 ,3 ,13 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (101, 9,1, 1, 10,9 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (101, 5, 0, 0, 9, 8, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (102, 1, 1, 1, 9, 13, 3,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (102, 4, 2, 2, 8, 12, 3,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (103, 3, 3, 3, 9,8 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (103, 7, 1,1 ,17 ,17 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (104, 8, 5 , 5, 13, 11,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (104, 11, 1, 1, 13, 8, 1,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (105, 4,1 ,1 ,13 ,8 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (105, 2, 1, 1, 11, 11,4 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (106, 1, 1, 1,5 ,14 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (106, 10, 2, 2, 15, 9, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (107, 5, 1, 1, 9, 11, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (107, 12, 1,1 ,8 ,6 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (108, 6, 0, 0, 4,14 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (108, 9, 0, 0, 10, 11, 1, 1);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (109, 6, 0,0 ,13 ,7 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (109, 5, 1, 1, 13,8 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (110, 11, 1, 1,10 ,14 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (110, 4, 1, 1,10 ,12 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (111, 2, 2, 2, 10, 5,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (111, 10, 0, 0, 6,9 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (112, 8, 3, 3, 13, 13,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (112, 3, 1, 1,7 ,15 ,1 ,1 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (113, 9, 0, 0, 14,7 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (113, 12, 1,1 ,11 ,11 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (114, 7, 1, 1, 18, 11,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (114, 1, 1, 1, 16, 8, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (115, 10, 2, 2, 8,13 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (115, 11,0 ,0 ,17 ,4 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (116, 3, 1, 1, 13, 11,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (116, 6, 1, 1,9 ,21 , 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (117, 5, 0,0 ,12 ,6 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (117, 4, 0, 0, 1, 11,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (118, 2, 0, 0, 6, 13, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (118, 8, 1, 1, 6, 18, 4, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (119, 12, 3, 3,16 , 8, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (119, 7, 1, 1, 6, 12, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (120, 9, 1, 1, 11,15 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (120, 1, 0, 0, 11, 10, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (121, 11, 1, 1,12 ,12 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (121, 3, 2, 2, 16, 10, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (122, 1, 1, 1, 10, 13, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (122, 2,1 , 1, 11, 12, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (123, 12, 0, 0,13 ,14 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (123, 8, 1, 1, 2, 10,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (124, 7, 2, 2, 16, 4, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (124, 9, 2, 2, 4, 15, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (125, 10, 2 ,2 ,12 ,10 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (125, 5, 1, 1, 14, 5, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (126, 4, 2, 2, 14, 8, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (126, 6, 2, 2, 13, 8, 5, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (127, 3, 0, 0, 11,10 , 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (127, 1, 0, 0,9 ,11 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (128, 11, 0,0 ,12 ,9 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (128, 2, 0, 0, 8, 10, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (129, 8, 1, 1, 18, 4, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (129, 9, 2, 2, 10, 2, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (130, 6, 1, 1, 9, 9, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (130, 12, 1, 1, 7, 7, 2, 1);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (131, 4, 2, 2, 10, 6, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (131, 10, 2, 2, 15, 14, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (132, 5, 7, 7, 22, 10, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (132, 7, 2, 2, 10, 2, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (133, 6, 3, 3, 11, 8,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (133, 8, 1, 1, 10, 7, 4, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (134, 1, 1, 1, 10, 6, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (134, 5, 1, 1, 14, 8, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (135, 2, 1, 1, 7, 9, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (135, 3, 1, 1, 9, 13, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (136, 10, 1, 1, 13, 14, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (136, 7, 0,0 ,14 ,12 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (137, 12, 4, 4, 8, 9, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (137, 11, 2, 2, 8, 2, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (138, 9,2 ,2 ,7 ,9 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (138, 4, 0, 0, 7, 14, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (139, 8, 2, 2, 7, 11,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (139, 11, 1, 1, 14, 12, 4, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (140, 12, 2, 2, 11, 12, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (140, 10, 1, 1, 9,14 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (141, 7, 0, 0,14 ,7 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (141, 2, 1, 1, 14, 14, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (142, 1, 1,1 , 12, 12, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (142, 6, 2, 2, 13, 6, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (143, 5, 0, 0, 11, 7, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (143, 9, 1, 1, 9, 4, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (144, 4, 1, 1, 11, 15, 3,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (144, 3, 0, 0,6 ,14 ,4 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (145, 5, 2, 2, 11, 12, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (145, 12, 2, 2, 8, 4, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (146, 2, 3, 3, 12, 16, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (146, 4, 0, 0, 8, 15, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (147, 6, 0, 0,9 ,9 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (147, 7, 2, 2, 9, 14, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (148, 3, 0, 0,9 ,7 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (148, 8, 0, 0, 15, 8, 4, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (149, 10, 2, 2, 11, 7, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (149, 9, 0, 0, 12, 4,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (150, 11, 1, 1, 14, 8,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (150, 1, 1, 1, 6, 8, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (151, 10, 1, 1, 11, 16, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (151, 6, 1, 1, 4, 4, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (152, 1,2 ,2 ,19 ,8 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (152, 8, 0, 0, 7,10 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (153, 11, 3, 3, 15, 10, 1,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (153, 7, 0, 0, 7, 12, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (154, 4, 4, 4, 17, 11,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (154, 5, 3, 3, 15, 9, 3,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (155, 9, 3, 3, 12, 10, 3,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (155, 3, 1, 1, 8, 9,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (156, 12, 1, 1, 7, 12, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (156, 2,1 ,1 ,4 ,9 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (157, 6, 1, 1, 8,8 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (157, 11,0 ,0 ,12 ,12 ,4 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (158, 9, 2, 2,6 ,7 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (158, 2, 2, 2, 14, 6, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (159, 8, 1, 1, 13, 8, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (159, 10, 0,0 ,15 ,9 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (160, 1, 1, 1, 11, 12, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (160, 7, 2, 2, 11, 12, 4, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (161, 5, 2, 2, 8, 9, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (161, 3, 2, 2, 10, 9, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (162, 12, 4, 4, 12, 8, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (162, 4, 3, 3, 9, 7, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (163, 7, 1, 1, 14, 8, 1, 1);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (163, 9, 2, 2, 9,13 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (164, 10, 1, 1, 10 , 9, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (164, 4, 1, 1, 7,7 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (165, 3, 1,1 , 13, 9, 1,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (165, 11, 0, 0, 14, 8, 1,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (166, 1, 1, 1, 8, 10,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (166, 12, 1, 1, 7, 6, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (167, 5, 2, 2, 16, 15, 4, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (167, 8, 2, 2, 16, 4,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (168, 2, 4, 4,14 ,15 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (168, 6, 0, 0,6 ,12 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (169, 4, 0,0 ,10 ,14 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (169, 7, 1, 1, 10, 5, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (170, 3, 1,1 ,12 ,15 ,7 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (170, 1, 0, 0, 7, 9,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (171, 6, 0, 0, 16, 6, 2, 1);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (171, 5, 1,1 ,13 ,15 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (172, 9, 0, 0,13 ,11 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (172, 12, 2, 2, 10, 6, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (173, 8, 0, 0, 17, 14, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (173, 2, 2, 2, 8, 13, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (174, 11, 0, 0,10 ,9 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (174, 10, 0, 0, 17, 12, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (175, 10, 1, 1, 12, 13, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (175, 1, 3, 3, 18, 13,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (176, 9, 2, 2, 8, 11,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (176, 11, 1, 1, 9,12 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (177, 12, 2,2 ,12 ,9 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (177, 7, 0, 0, 1, 14, 4, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (178, 8, 1, 1, 10, 14, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (178, 4, 1, 1, 5, 9, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (179, 5, 0, 0, 18, 15, 4, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (179, 2, 1, 1, 3, 11, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (180, 6, 0, 0,11 ,8 ,4 , 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (180, 3, 1, 1, 8, 12, 2, 1);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (181, 4, 3, 3, 11, 14, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (181, 6, 1, 1, 12, 12, 4, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (182, 11, 1, 1, 9, 19,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (182, 5, 3, 3, 11,14 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (183, 7, 2, 2, 5, 9, 1, 1);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (183, 8, 3, 3, 10, 8, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (184, 2, 0, 0,15 ,14 ,4 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (184, 10, 1, 1, 5, 10, 3,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (185, 1, 1,1 ,12 ,9 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (185, 9, 1, 1, 13, 9, 4, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (186, 3, 0, 0, 9, 12, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (186, 12, 0, 0, 7, 8, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (187, 12, 0, 0, 12, 11, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (187, 8, 0, 0, 1, 11,5 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (188, 7, 1, 1, 16, 12, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (188, 5, 1,1 ,11 ,10 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (189, 10, 1, 1, 16, 13, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (189, 3, 3, 3, 14, 8, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (190, 9, 2, 2, 10, 11,6 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (190, 6, 0, 0, 12, 6, 1,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (191, 1, 1, 1, 11, 12, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (191, 4, 1, 1, 4, 9,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (192, 11, 1, 1, 10,8 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (192, 2, 2, 2, 7, 10, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (193, 8,0 ,0 ,9 ,7 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (193, 9, 0, 0, 6, 3, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (194, 3,2 ,2 ,12 ,14 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (194, 7, 2, 2, 9, 12, 1,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (195, 5, 0, 0, 15, 5, 1,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (195, 10, 2, 2,9 ,10 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (196, 6, 1, 1, 10, 13, 4, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (196, 12, 0, 0, 15, 13, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (197, 2, 1,1 , 6, 12, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (197, 1, 0, 0, 4, 14, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (198, 4, 1, 1, 12, 8, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (198, 11, 0, 0, 13, 6, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (199, 12, 1, 1, 8, 9, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (199, 9, 1, 1, 7,8 , 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (200, 1, 1,1, 11, 6, 2,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (200, 8, 0, 0, 8, 16, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (201, 3, 1, 1,17 ,6 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (201, 10, 2, 2, 16, 10, 4, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (202, 5, 2,2 ,18 ,7 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (202, 1, 1, 1,5 ,9 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (203, 11, 2,2 ,12 ,10 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (203, 6, 0, 0, 9, 8, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (204, 4, 1, 1,16 ,9 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (204, 7, 1, 1, 12, 9, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (205, 10, 1, 1, 12,16 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (205, 12, 1, 1, 11,9 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (206, 2, 0, 0,11 ,7 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (206, 9, 2, 2, 5, 9, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (207, 1, 1,1 ,10 ,16 ,4 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (207, 11, 1, 1, 9,4 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (208, 8, 2, 2, 10, 7, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (208, 3, 0, 0,6 ,7 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (209, 6, 2,2 ,7 ,8 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (209, 4, 2, 2, 9, 8,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (210, 7, 3,3 ,14 ,9 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (210, 5, 4, 4, 16, 9, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (211, 4, 0, 0, 5, 15, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (211, 1, 1, 1, 17, 9, 1,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (212, 3, 1, 1, 9, 11,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (212, 2, 1, 1, 9, 8, 2,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (213, 11, 0, 0, 11, 13, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (213, 5, 0,0 ,14 ,8 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (214, 9, 1, 1, 14, 11, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (214, 10, 1, 1, 5,11 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (215, 7, 2,2 ,24 ,9 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (215, 6, 3, 3, 13, 6, 2, 1);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (216, 8,3, 3, 12, 8,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (216, 12, 2, 2, 13, 9, 2,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (217, 9, 3,3 ,14 ,9 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (217, 8, 1,1 ,13 ,5 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (218, 10, 2,2 , 11, 10, 1,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (218, 2, 0, 0, 10, 12, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (219, 11, 0, 0, 13, 10, 3,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (219, 4, 2, 2, 12, 14, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (220, 12,1 ,1 ,8 ,12 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (220, 3, 0, 0, 8, 9, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (221, 5, 0, 0, 10, 12, 3, 1);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (221, 6, 1, 1, 14,8 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (222, 1, 2,2 ,7 ,16 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (222, 7, 0, 0, 12, 7, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (223, 4, 2,2 ,17 ,15 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (223, 5, 2, 2, 14, 8, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (224, 7, 1, 1, 14, 9, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (224, 11, 1, 1, 9, 12, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (225, 6, 0, 0, 7,12 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (225, 1, 0, 0, 9, 10, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (226, 8, 1,1 ,16 ,15 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (226, 10, 0, 0, 12, 14, 2,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (227, 2, 0, 0, 17, 10, 3,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (227, 12, 0, 0,3 ,8 ,1 ,1 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (228, 3,2 ,2 ,9 ,12 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (228, 9, 1, 1, 7, 11, 4,0 );

INSERT INTO Player (PlayerID, Name, Weight, Height, Age, Position, TeamID) VALUES
(1, '유상훈', 84, 194, 34, 'GK', 1),
(2, '김영빈', 74, 181, 33, 'DF', 1),
(3, '서민우', 75, 184, 26, 'MF', 1),
(4, '이웅희', 80, 183, 35, 'DF', 1),
(5, '알리바예프', 70, 173, 30, 'MF', 1),
(6, '한국영', 73, 183, 34, 'MF', 1),
(7, '강지훈', 64, 177, 27, 'MF', 1),
(8, '이재원', 66, 170, 27, 'MF', 1),
(9, '유인수', 71, 177, 29, 'DF', 1),
(10, '이정협', 76, 186, 33, 'FW', 1),
(11, '윤석영', 75, 183, 34, 'DF', 1),
(12, '김우석', 74, 189, 28, 'DF', 1),
(13, '김진호', 74, 178, 24, 'DF', 1),
(14, '이광연', 82, 184, 25, 'GK', 1),
(15, '이승원', 66, 173, 20, 'MF', 1),
(16, '이지우', 68, 175, 20, 'DF', 1),
(17, '김현규', 70, 178, 23, 'MF', 1),
(18, '최성민', 75, 179, 21, 'FW', 1),
(19, '권석주', 63, 178, 21, 'DF', 1),
(20, '김해승', 80, 185, 21, 'FW', 1),
(21, '전현병', 84, 188, 24, 'DF', 1),
(22, '이강한', 68, 176, 24, 'DF', 1),
(23, '홍성무', 67, 173, 21, 'MF', 1),
(24, '가브리엘', 80, 187, 24, 'FW', 1),
(25, '윤일록', 67, 178, 32, 'MF', 1);


INSERT INTO Player (PlayerId, Name, Weight, Height, Age, Position, TeamId) VALUES
(26, '김경민', 76, 189, 25, 'GK', 2),
(27, '이준', 79, 190, 28, 'GK', 2),
(28, '노희동', 80, 188, 27, 'GK', 2),
(29, '김태준', 77, 185, 24, 'GK', 2),
(30, '엄지성', 65, 177, 21, 'FW', 2),
(31, '허 율', 72, 179, 24, 'FW', 2),
(32, '아사니', 80, 185, 30, 'FW', 2),
(33, '신창무', 75, 180, 26, 'FW', 2),
(34, '이건희', 73, 176, 28, 'FW', 2),
(35, '하승운', 69, 180, 25, 'FW', 2),
(36, '정지훈', 71, 178, 27, 'FW', 2),
(37, '토마스', 82, 188, 29, 'FW', 2),
(38, '주영재', 74, 183, 26, 'FW', 2),
(39, '베 카', 85, 190, 31, 'FW', 2),
(40, '정호연', 70, 182, 24, 'MF', 2),
(41, '이희균', 70, 172, 26, 'MF', 2),
(42, '최준혁', 73, 178, 27, 'MF', 2),
(43, '이강현', 75, 183, 25, 'MF', 2),
(44, '박한빈', 71, 179, 28, 'MF', 2),
(45, '이순민', 73, 180, 25, 'MF', 2),
(46, '오후성', 72, 176, 27, 'MF', 2),
(47, '이민기', 76, 185, 29, 'DF', 2),
(48, '김승우', 78, 183, 30, 'DF', 2),
(49, '티 모', 80, 188, 28, 'DF', 2),
(50, '안영규', 77, 186, 31, 'DF', 2),
(51, '이으뜸', 75, 180, 27, 'DF', 2),
(52, '김한길', 73, 181, 29, 'DF', 2),
(53, '두현석', 80, 185, 26, 'DF', 2),
(54, '김경재', 75, 187, 30, 'DF', 2),
(55, '이상기', 72, 180, 27, 'DF', 2),
(56, '김동국', 74, 182, 26, 'DF', 2),
(57, '아 론', 78, 187, 28, 'DF', 2);

INSERT INTO Player (PlayerId, Name, Weight, Height, Age, Position, TeamId) VALUES
(58, '최영은', 83, 188, 28, 'GK', 3),
(59, '황재원', 73, 184, 21, 'DF', 3),
(60, '안창민', 68, 176, 25, 'MF', 3),
(61, '장성원', 68, 175, 23, 'MF', 3),
(62, '홍정운', 84, 184, 26, 'DF', 3),
(63, '김진혁', 76, 188, 29, 'FW', 3),
(64, '세라토', 67, 172, 25, 'MF', 3),
(65, '에드가', 81, 190, 32, 'FW', 3),
(66, '세징야', 72, 173, 34, 'FW', 3),
(67, '그라지에', 74, 180, 28, 'MF', 3),
(68, '오승훈', 85, 186, 33, 'GK', 3),
(69, '이근호', 68, 176, 38, 'FW', 3),
(70, '박종진', 73, 175, 27, 'MF', 3),
(71, '서보민', 78, 178, 34, 'MF', 3),
(72, '이진용', 82, 184, 25, 'DF', 3),
(73, '김동현', 75, 182, 26, 'MF', 3),
(74, '최민기', 80, 185, 22, 'DF', 3),
(75, '박재현', 69, 177, 21, 'MF', 3),
(76, '박용희', 83, 190, 23, 'DF', 3),
(77, '한태희', 71, 179, 33, 'MF', 3),
(78, '홍철', 74, 176, 32, 'DF', 3),
(79, '손승우', 65, 172, 24, 'DF', 3),
(80, '윤태민', 76, 180, 24, 'DF', 3),
(81, '김희승', 69, 178, 24, 'MF', 3),
(82, '이종훈', 66, 174, 20, 'MF', 3),
(83, '배수민', 84, 185, 21, 'DF', 3),
(84, '박재혁', 73, 180, 22, 'FW', 3),
(85, '신한결', 78, 183, 23, 'DF', 3),
(86, '정윤성', 71, 175, 19, 'MF', 3),
(87, '유지호', 70, 177, 24, 'MF', 3),
(88, '김리찬', 72, 179, 19, 'MF', 3),
(89, '한지윤', 75, 183, 19, 'DF', 3),
(90, '조진우', 81, 190, 23, 'GK', 3),
(91, '페냐', 74, 176, 26, 'MF', 3),
(92, '이용래', 76, 183, 36, 'MF', 3),
(93, '바셀루스', 80, 187, 30, 'FW', 3);


INSERT INTO Player(PlayerId, Name, Weight, Height, Age, Position, TeamId) VALUES
(94, '이창근', 75, 186, 30, 'GK', 4),
(95, '서영재', 71, 182, 28, 'DF', 4),
(96, '김민덕', 78, 183, 27, 'DF', 4),
(97, '김현우', 74, 183, 25, 'DF', 4),
(98, '임덕근', 77, 183, 23, 'DF', 4),
(99, '임은수', 70, 181, 27, 'MF', 4),
(100, '마사', 68, 180, 28, 'FW', 4),
(101, '주세종', 67, 174, 33, 'MF', 4),
(102, '유강현', 75, 186, 27, 'FW', 4),
(103, '김인균', 66, 173, 26, 'MF', 4),
(104, '전병관', 72, 178, 22, 'FW', 4),
(105, '김영욱', 70, 177, 32, 'MF', 4),
(106, '변준수', 82, 190, 23, 'DF', 4),
(107, '김경환', 73, 180, 20, 'MF', 4),
(108, '이현식', 66, 175, 28, 'MF', 4),
(109, '신상은', 72, 185, 25, 'FW', 4),
(110, '조유민', 79, 182, 27, 'DF', 4),
(111, '오재석', 74, 178, 34, 'DF', 4),
(112, '정산', 86, 191, 35, 'GK', 4),
(113, '배서준', 67, 173, 20, 'DF', 4),
(114, '이준서', 82, 185, 26, 'GK', 4),
(115, '김지훈', 60, 175, 24, 'DF', 4),
(116, '이종현', 71, 176, 27, 'DF', 4),
(117, '티아고', 75, 188, 30, 'FW', 4),
(118, '김도윤', 66, 176, 22, 'MF', 4),
(119, '이은재', 71, 178, 21, 'MF', 4),
(120, '임유석', 83, 190, 23, 'DF', 4),
(121, '김태현', 74, 182, 21, 'DF', 4),
(122, '최재현', 80, 184, 30, 'DF', 4),
(123, '정강민', 67, 175, 19, 'MF', 4),
(124, '안태윤', 78, 186, 23, 'GK', 4),
(125, '정진우', 80, 188, 19, 'MF', 4),
(126, '유선우', 67, 180, 20, 'FW', 4),
(127, '이동원', 66, 180, 22, 'FW', 4),
(128, '정원식', 82, 185, 22, 'DF', 4),
(129, '배상필', 84, 189, 22, 'GK', 4),
(130, '이한빈', 82, 186, 21, 'DF', 4),
(131, '정우빈', 66, 175, 23, 'FW', 4),
(132, '이선호', 68, 175, 21, 'DF', 4),
(133, '레안드로', 65, 178, 29, 'FW', 4),
(134, '강윤성', 65, 172, 27, 'DF', 4),
(135, '이선유', 70, 175, 23, 'FW', 4),
(136, '이진현', 69, 170, 27, 'MF', 4),
(137, '안톤', 76, 186, 26, 'DF', 4),
(138, '구텍', 78, 187, 29, 'FW', 4);

INSERT INTO Player (PlayerId, Name, Weight, Height, Age, Position, TeamId) VALUES
(139, '백종범', 85, 190, 22, 'GK', 5),
(140, '황현수', 80, 183, 28, 'DF', 5),
(141, '권완규', 80, 183, 32, 'DF', 5),
(142, '오스마르', 86, 192, 35, 'MF', 5),
(143, '기성용', 75, 189, 34, 'MF', 5),
(144, '나상호', 70, 173, 27, 'FW', 5),
(145, '이승모', 70, 185, 25, 'MF', 5),
(146, '김신진', 82, 186, 22, 'FW', 5),
(147, '지동원', 81, 188, 32, 'FW', 5),
(148, '강성진', 76, 178, 20, 'FW', 5),
(149, '고요한', 65, 170, 35, 'MF', 5),
(150, '임상협', 74, 180, 35, 'MF', 5),
(151, '김진야', 68, 177, 25, 'DF', 5),
(152, '황성민', 83, 188, 32, 'GK', 5),
(153, '김경민', 81, 186, 26, 'FW', 5),
(154, '김현덕', 75, 183, 19, 'DF', 5),
(155, '최철원', 87, 194, 29, 'GK', 5),
(156, '이시영', 65, 173, 26, 'DF', 5),
(157, '서주환', 79, 190, 24, 'GK', 5),
(158, '정현철', 72, 187, 30, 'MF', 5),
(159, '비욘 존슨', 82, 196, 32, 'FW', 5),
(160, '팔로세비치', 70, 180, 30, 'MF', 5),
(161, '김윤겸', 66, 172, 19, 'MF', 5),
(162, '김주성', 76, 186, 22, 'DF', 5),
(163, '서재민', 73, 178, 20, 'MF', 5),
(164, '조영광', 67, 173, 19, 'DF', 5),
(165, '백상훈', 62, 173, 21, 'MF', 5),
(166, '안재민', 67, 176, 20, 'DF', 5),
(167, '손승범', 65, 180, 19, 'FW', 5),
(168, '이지석', 67, 182, 19, 'DF', 5),
(169, '박성훈', 72, 183, 20, 'DF', 5),
(170, '박장한결', 64, 176, 19, 'MF', 5),
(171, '한승규', 63, 173, 27, 'MF', 5),
(172, '이승준', 61, 170, 19, 'MF', 5),
(173, '김성민', 73, 180, 22, 'MF', 5),
(174, '황도윤', 73, 176, 20, 'MF', 5),
(175, '이태석', 61, 174, 21, 'DF', 5),
(176, '일류첸코', 82, 189, 33, 'FW', 5),
(177, '강상희', 73, 180, 25, 'DF', 5),
(178, '윌리안', 62, 170, 29, 'FW', 5),
(179, '박수일', 68, 178, 27, 'DF', 5),
(180, '아이에쉬', 72, 180, 28, 'FW', 5),
(181, '조영욱', 73, 181, 24, 'FW', 5);

INSERT INTO Player (PlayerId, Name, Weight, Height, Age, Position, TeamId) VALUES
(182, '장호익', 62, 173, 30, 'DF', 6),
(183, '불투이스', 78, 192, 33, 'DF', 6),
(184, '한호강', 80, 186, 30, 'DF', 6),
(185, '한석종', 72, 184, 31, 'MF', 6),
(186, '고승범', 70, 173, 29, 'MF', 6),
(187, '최성근', 73, 183, 32, 'MF', 6),
(188, '안병준', 75, 183, 33, 'FW', 6),
(189, '정승원', 68, 173, 26, 'MF', 6),
(190, '김태환', 74, 174, 23, 'DF', 6),
(191, '김보경', 72, 176, 34, 'MF', 6),
(192, '전진우', 74, 181, 24, 'FW', 6),
(193, '고명석', 90, 189, 28, 'DF', 6),
(194, '이종성', 72, 187, 31, 'MF', 6),
(195, '김경중', 69, 179, 32, 'FW', 6),
(196, '아코스티', 76, 178, 33, 'FW', 6),
(197, '강태원', 68, 175, 23, 'MF', 6),
(198, '박희준', 80, 191, 22, 'FW', 6),
(199, '양형모', 84, 185, 32, 'GK', 6),
(200, '권창훈', 66, 174, 29, 'MF', 6),
(201, '이기제', 68, 175, 32, 'DF', 6),
(202, '허동호', 75, 181, 23, 'MF', 6),
(203, '장석환', 70, 178, 19, 'DF', 6),
(204, '염기훈', 80, 182, 40, 'MF', 6),
(205, '이규석', 77, 182, 22, 'DF', 6),
(206, '이상민', 73, 175, 19, 'FW', 6),
(207, '진현태', 70, 178, 22, 'MF', 6),
(208, '이성주', 85, 192, 25, 'GK', 6),
(209, '서동한', 66, 172, 22, 'FW', 6),
(210, '박대원', 76, 178, 25, 'DF', 6),
(211, '박지민', 88, 189, 24, 'GK', 6),
(212, '명준재', 68, 178, 29, 'MF', 6),
(213, '김주찬', 71, 174, 19, 'FW', 6),
(214, '뮬리치', 84, 203, 29, 'FW', 6),
(215, '웨릭 포포', 88, 190, 22, 'FW', 6),
(216, '김주원', 78, 185, 32, 'DF', 6),
(217, '손호준', 65, 175, 21, 'DF', 6),
(218, '카즈키', 65, 173, 29, 'MF', 6),
(219, '유제호', 72, 178, 23, 'MF', 6),
(220, '바사니', 80, 187, 26, 'FW', 6),
(221, '안찬기', 80, 187, 26, 'GK', 6),
(222, '고무열', 75, 187, 33, 'FW', 6),
(223, '윤서호', 72, 176, 25, 'DF', 6),
(224, '고종현', 88, 191, 18, 'DF', 6),
(225, '곽성훈', 84, 190, 18, 'DF', 6),
(226, '김성주', 63, 168, 17, 'MF', 6),
(227, '박승수', 71, 182, 17, 'MF', 6),
(228, '임현섭', 73, 184, 18, 'MF', 6);

INSERT INTO Player (PlayerId, Name, Weight, Height, Age, Position, TeamId) VALUES
(229, '박배종', 78, 185, 34, 'GK', 7),
(230, '정동호', 68, 174, 33, 'DF', 7),
(231, '박철우', 65, 176, 26, 'MF', 7),
(232, '잭슨', 83, 196, 28, 'DF', 7),
(233, '김현', 87, 190, 30, 'FW', 7),
(234, '정재용', 80, 188, 33, 'MF', 7),
(235, '로페즈', 78, 185, 33, 'FW', 7),
(236, '이승우', 60, 170, 26, 'FW', 7),
(237, '오인표', 63, 177, 26, 'DF', 7),
(238, '윤빛가람', 71, 178, 33, 'MF', 7),
(239, '정재윤', 75, 180, 21, 'MF', 7),
(240, '노동건', 88, 190, 32, 'GK', 7),
(241, '김규형', 63, 168, 24, 'MF', 7),
(242, '황순민', 65, 177, 33, 'MF', 7),
(243, '최보경', 86, 184, 32, 'DF', 7),
(244, '이광혁', 65, 167, 28, 'MF', 7),
(245, '김주엽', 76, 180, 23, 'DF', 7),
(246, '우고 고메스', 80, 187, 28, 'DF', 7),
(247, '이태섭', 70, 177, 23, 'DF', 7),
(248, '이영재', 60, 172, 29, 'MF', 7),
(249, '장재웅', 70, 176, 22, 'FW', 7),
(250, '신세계', 73, 178, 33, 'DF', 7),
(251, '이범영', 93, 197, 34, 'GK', 7),
(252, '곽동준', 68, 176, 23, 'DF', 7),
(253, '김예성', 70, 177, 22, 'MF', 7),
(254, '서승우', 80, 188, 21, 'MF', 7),
(255, '바우테르손', 80, 186, 26, 'FW', 7),
(256, '김선민', 65, 167, 32, 'MF', 7),
(257, '이재훈', 85, 190, 19, 'GK', 7),
(258, '박병현', 65, 176, 30, 'DF', 7),
(259, '김도윤', 62, 171, 19, 'MF', 7),
(260, '정은우', 65, 172, 20, 'FW', 7),
(261, '이용', 76, 180, 37, 'DF', 7),
(262, '안치우', 72, 180, 19, 'MF', 7),
(263, '김재현', 73, 179, 20, 'FW', 7),
(264, '강민성', 73, 180, 19, 'FW', 7);

INSERT INTO Player (PlayerId, Name, Weight, Height, Age, Position, TeamId) VALUES
(265, '조수혁', 83, 188, 36, 'GK', 8),
(266, '장시영', 69, 174, 21, 'DF', 8),
(267, '임종은', 88, 192, 33, 'DF', 8),
(268, '보야니치', 74, 182, 29, 'MF', 8),
(269, '마틴 아담', 87, 190, 29, 'FW', 8),
(270, '바코', 74, 174, 30, 'MF', 8),
(271, '엄원상', 63, 171, 24, 'MF', 8),
(272, '이명재', 68, 182, 30, 'DF', 8),
(273, '이동경', 72, 176, 26, 'MF', 8),
(274, '정승현', 82, 188, 29, 'DF', 8),
(275, '김성준', 68, 174, 35, 'MF', 8),
(276, '루빅손', 75, 182, 30, 'FW', 8),
(277, '주민규', 83, 183, 33, 'FW', 8),
(278, '김영권', 78, 185, 33, 'DF', 8),
(279, '조현우', 75, 189, 32, 'GK', 8),
(280, '김민혁', 71, 183, 31, 'MF', 8),
(281, '김태환', 72, 177, 34, 'DF', 8),
(282, '이규성', 68, 174, 29, 'MF', 8),
(283, '조현택', 65, 182, 22, 'DF', 8),
(284, '이청용', 70, 180, 35, 'MF', 8),
(285, '설현빈', 78, 190, 22, 'GK', 8),
(286, '황재환', 60, 170, 22, 'MF', 8),
(287, '강윤구', 73, 175, 21, 'MF', 8),
(288, '아타루', 68, 175, 31, 'MF', 8),
(289, '이재욱', 65, 170, 22, 'DF', 8),
(290, '김기희', 80, 188, 34, 'DF', 8),
(291, '설영우', 72, 180, 25, 'DF', 8),
(292, '민동환', 78, 187, 22, 'GK', 8),
(293, '박주영', 75, 182, 38, 'FW', 8),
(294, '김지현', 79, 185, 27, 'FW', 8);

INSERT INTO Player (PlayerId, Name, Weight, Height, Age, Position, TeamId) VALUES
(295, '김동헌', 80, 190, 27, 'GK', 9),
(296, '이태희', 85, 192, 29, 'GK', 9),
(297, '민성준', 79, 187, 24, 'GK', 9),
(298, '김유성', 83, 188, 20, 'GK', 9),
(299, '김연수', 75, 180, 23, 'DF', 9),
(300, '오반석', 81, 187, 35, 'DF', 9),
(301, '정동윤', 78, 182, 33, 'DF', 9),
(302, '임종진', 74, 176, 26, 'DF', 9),
(303, '김준엽', 73, 178, 24, 'DF', 9),
(304, '델브리지', 84, 193, 31, 'DF', 9),
(305, '김건희', 76, 181, 25, 'DF', 9),
(306, '김동민', 75, 180, 26, 'DF', 9),
(307, '권한진', 78, 187, 33, 'DF', 9),
(308, '이명주', 70, 175, 33, 'MF', 9),
(309, '문지환', 74, 178, 25, 'MF', 9),
(310, '김도혁', 73, 177, 28, 'MF', 9),
(311, '신진호', 75, 180, 34, 'MF', 9),
(312, '이동수', 68, 173, 22, 'MF', 9),
(313, '여름', 70, 175, 31, 'MF', 9),
(314, '지언학', 70, 175, 25, 'MF', 9),
(315, '박현빈', 72, 178, 22, 'MF', 9),
(316, '민경현', 65, 168, 21, 'MF', 9),
(317, '최준기', 74, 179, 23, 'MF', 9),
(318, '김현석', 68, 172, 23, 'MF', 9),
(319, '홍시후', 72, 175, 22, 'MF', 9),
(320, '박진홍', 77, 180, 25, 'MF', 9),
(321, '김세훈', 70, 175, 24, 'MF', 9),
(322, '에르난데스', 76, 179, 28, 'FW', 9),
(323, '제로소', 81, 184, 26, 'FW', 9),
(324, '송시우', 70, 175, 30, 'FW', 9),
(325, '김민석', 68, 173, 23, 'FW', 9),
(326, '김보섭', 70, 176, 25, 'FW', 9),
(327, '하동호', 78, 185, 22, 'FW', 9),
(328, '음포쿠', 75, 178, 31, 'FW', 9),
(329, '박승호', 73, 177, 26, 'FW', 9),
(330, '천성훈', 72, 175, 23, 'FW', 9);

INSERT INTO Player (PlayerId, Name, Weight, Height, Age, Position, TeamId) VALUES
(331, '이범수', 85, 190, 34, 'GK', 10),
(332, '노윤상', 79, 190, 22, 'DF', 10),
(333, '박진섭', 75, 182, 28, 'MF', 10),
(334, '윤영선', 78, 185, 36, 'DF', 10),
(335, '최보경', 79, 184, 36, 'DF', 10),
(336, '한교원', 73, 182, 34, 'MF', 10),
(337, '백승호', 78, 180, 27, 'MF', 10),
(338, '구스타보', 76, 189, 30, 'FW', 10),
(339, '조규성', 82, 188, 26, 'FW', 10),
(340, '바로우', 60, 177, 32, 'MF', 10),
(341, '김보경', 73, 178, 35, 'MF', 10),
(342, '이승기', 67, 177, 36, 'MF', 10),
(343, '구자룡', 75, 186, 32, 'DF', 10),
(344, '이근호', 85, 185, 28, 'FW', 10),
(345, '송민규', 72, 179, 25, 'FW', 10),
(346, '홍장우', 70, 175, 22, 'MF', 10),
(347, '김진수', 69, 177, 32, 'DF', 10),
(348, '최철순', 70, 173, 37, 'DF', 10),
(349, '홍정호', 82, 187, 35, 'DF', 10),
(350, '문선민', 70, 172, 32, 'FW', 10),
(351, '맹성웅', 72, 180, 26, 'MF', 10),
(352, '류재문', 72, 184, 30, 'MF', 10),
(353, '김준홍', 88, 190, 21, 'GK', 10),
(354, '송범근', 88, 194, 26, 'GK', 10),
(355, '배재익', 70, 175, 23, 'FW', 10),
(356, '박진성', 76, 178, 23, 'DF', 10),
(357, '장윤호', 68, 178, 28, 'MF', 10),
(358, '강영석', 70, 172, 22, 'MF', 10),
(359, '강상윤', 66, 170, 20, 'MF', 10),
(360, '박준범', 78, 183, 23, 'FW', 10),
(361, '박성현', 72, 182, 23, 'DF', 10),
(362, '이우연', 83, 188, 21, 'DF', 10),
(363, '명세진', 72, 176, 23, 'MF', 10),
(364, '김태현', 75, 180, 23, 'MF', 10),
(365, '이준호', 84, 186, 22, 'FW', 10),
(366, '이성민', 83, 187, 24, 'DF', 10),
(367, '박채준', 66, 170, 21, 'FW', 10),
(368, '최현웅', 76, 188, 21, 'DF', 10),
(369, '전지완', 85, 189, 20, 'GK', 10),
(370, '박창우', 69, 178, 21, 'DF', 10),
(371, '이윤권', 68, 174, 24, 'MF', 10),
(372, '박규민', 71, 180, 23, 'FW', 10),
(373, '김문환', 67, 172, 29, 'DF', 10),
(374, '김진규', 68, 177, 27, 'MF', 10);

INSERT INTO Player (PlayerId, Name, Weight, Height, Age, Position, TeamId) VALUES
(375, '김동준', 88, 187, 29, 'GK', 11),
(376, '안태현', 67, 176, 30, 'MF', 11),
(377, '연제운', 78, 185, 29, 'DF', 11),
(378, '송주훈', 83, 190, 30, 'DF', 11),
(379, '최영준', 76, 181, 33, 'MF', 11),
(380, '구자철', 78, 183, 35, 'MF', 11),
(381, '김건웅', 81, 185, 26, 'MF', 11),
(382, '유리 조나탄', 78, 185, 26, 'FW', 11),
(383, '헤이스', 73, 173, 31, 'FW', 11),
(384, '김승섭', 67, 177, 28, 'FW', 11),
(385, '정운', 73, 180, 35, 'DF', 11),
(386, '서진수', 71, 183, 24, 'MF', 11),
(387, '조나탄 링', 72, 183, 33, 'MF', 11),
(388, '임동혁', 86, 190, 31, 'FW', 11),
(389, '김주공', 73, 180, 28, 'FW', 11),
(390, '김오규', 77, 183, 35, 'DF', 11),
(391, '김형근', 78, 188, 30, 'GK', 11),
(392, '임준섭', 80, 194, 21, 'GK', 11),
(393, '이기혁', 76, 184, 24, 'MF', 11),
(394, '한종무', 70, 179, 21, 'MF', 11),
(395, '임채민', 82, 188, 34, 'DF', 11),
(396, '전성진', 66, 176, 23, 'MF', 11),
(397, '임창우', 72, 184, 32, 'DF', 11),
(398, '김대환', 67, 172, 20, 'DF', 11),
(399, '김봉수', 78, 183, 25, 'MF', 11),
(400, '이주용', 78, 180, 32, 'DF', 11),
(401, '권순호', 72, 178, 21, 'MF', 11),
(402, '곽승민', 80, 186, 20, 'DF', 11),
(403, '김근배', 80, 187, 38, 'GK', 11),
(404, '박원재', 66, 176, 30, 'DF', 11),
(405, '홍준호', 77, 190, 31, 'DF', 11);

INSERT INTO Player (PlayerId, Name, Weight, Height, Age, Position, TeamId) VALUES
(406, '윤평국', 88, 189, 32, 'GK', 12),
(407, '심상민', 78, 172, 31, 'DF', 12),
(408, '김용환', 67, 175, 31, 'DF', 12),
(409, '그랜트', 82, 191, 30, 'DF', 12),
(410, '김종우', 70, 181, 30, 'MF', 12),
(411, '김인성', 74, 180, 35, 'FW', 12),
(412, '오베르단', 70, 175, 28, 'MF', 12),
(413, '제카', 83, 192, 26, 'FW', 12),
(414, '백성동', 66, 167, 32, 'MF', 12),
(415, '고영준', 69, 168, 23, 'MF', 12),
(416, '김승대', 64, 175, 33, 'FW', 12),
(417, '신원철', 70, 175, 23, 'DF', 12),
(418, '박승욱', 78, 184, 27, 'DF', 12),
(419, '한찬희', 75, 185, 26, 'MF', 12),
(420, '신광훈', 73, 178, 37, 'DF', 12),
(421, '강현제', 75, 183, 21, 'FW', 12),
(422, '윤민호', 64, 170, 25, 'MF', 12),
(423, '박찬용', 81, 186, 28, 'DF', 12),
(424, '황인재', 80, 188, 30, 'GK', 12),
(425, '박건우', 70, 171, 23, 'DF', 12),
(426, '조재훈', 71, 180, 22, 'MF', 12),
(427, '정재희', 70, 174, 31, 'FW', 12),
(428, '김정현', 73, 183, 20, 'MF', 12),
(429, '박형우', 68, 173, 21, 'FW', 12),
(430, '윤재운', 77, 177, 21, 'FW', 12),
(431, '이승환', 78, 186, 21, 'GK', 12),
(432, '이호재', 84, 192, 23, 'FW', 12),
(433, '이규백', 83, 185, 20, 'DF', 12),
(434, '홍윤상', 68, 178, 21, 'MF', 12),
(435, '조성훈', 85, 189, 26, 'GK', 12),
(436, '송한록', 76, 182, 21, 'MF', 12),
(437, '하창래', 82, 188, 30, 'DF', 12),
(438, '최현웅', 76, 188, 21, 'DF', 12),
(439, '김준호', 70, 182, 22, 'MF', 12),
(440, '완델손', 60, 172, 34, 'FW', 12),
(441, '김규표', 70, 176, 25, 'MF', 12),
(442, '양태렬', 73, 179, 29, 'MF', 12);


INSERT INTO Player_Performance (PlayerID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES
(1, 0, 0, 0, 1, 0, 0),  -- 유상훈 (GK)
(2, 0, 1, 0, 3, 1, 0),  -- 김영빈 (DF)
(4, 0, 0, 0, 4, 1, 0),  -- 이웅희 (DF)
(3, 0, 4, 3, 2, 1, 0), -- 서민우 (MF)
(24, 6, 3, 16, 3, 2, 0), -- 가브리엘 (FW)
(12, 0, 0, 2, 3, 5, 0),  -- 김우석 (DF)
(11, 0, 3, 7, 4, 1, 0),  -- 윤석영 (DF)
(10, 4, 2, 12, 3, 2, 0), -- 이정협 (FW)
(9, 0, 0, 1, 5, 1, 0),  -- 유인수 (DF)
(21, 0, 0, 1, 6, 3, 0),  -- 전현병 (DF)
(20, 2, 1, 15, 2, 0, 0), -- 김해승 (FW)
(19, 0, 0, 0, 4, 0, 0),  -- 권석주 (DF)
(13, 0, 1, 0, 4, 1, 0),  -- 김진호 (DF)
(18, 3, 2, 7, 3, 1, 0);  -- 최성민 (FW)

INSERT INTO Player_Performance (PlayerID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES
(26, 0, 0, 0, 1, 0, 0), 
(27, 0, 0, 0, 2, 0, 0),  
(47, 0, 1, 2, 5, 0, 0),  
(48, 0, 1, 3, 4, 1, 0), 
(49, 0, 0, 2, 3, 0, 0),  
(50, 1, 0, 3, 4, 1, 0),  
(40, 1, 3, 5, 2, 1, 0), 
(41, 0, 1, 3, 4, 0, 0), 
(42, 2, 3, 8, 2, 1, 0),  
(43, 1, 2, 6, 3, 0, 0), 
(30, 7, 2, 18, 3, 1, 0),  
(31, 5, 3, 15, 4, 1, 0), 
(32, 4, 5, 13, 2, 1, 0),  
(33, 2, 4, 9, 3, 1, 0),  
(37, 2, 1, 7, 1, 1, 0);  

INSERT INTO Player_Performance (PlayerID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES
(58, 0, 0, 0, 2, 0, 0),  
(68, 0, 0, 0, 3, 0, 0),  
(59, 0, 1, 3, 4, 1, 0),  
(62, 1, 1, 4, 5, 1, 0),  
(72, 0, 1, 2, 4, 0, 0),  
(74, 1, 0, 3, 3, 1, 0),
(60, 2, 2, 6, 2, 0, 0),  
(61, 2, 3, 7, 3, 0, 0),  
(64, 1, 1, 4, 4, 0, 0),  
(67, 2, 1, 5, 4, 1, 0),  
(70, 1, 2, 5, 2, 0, 0),  
(63, 4, 2, 11, 3, 1, 0),  
(65, 3, 3, 12, 2, 0, 0),  
(84, 2, 1, 6, 4, 0, 0),  
(91, 0, 3, 5, 2, 1, 0);  

INSERT INTO Player_Performance (PlayerID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES
(94, 0, 0, 0, 1, 1, 0),  
(95, 1, 2, 5, 10, 2, 0),
(96, 0, 1, 3, 15, 2, 0), 
(97, 1, 0, 2, 7, 1, 0),  
(99, 0, 0, 1, 8, 1, 0),  
(100, 3, 0, 8, 3, 1, 0), 
(101, 0, 1, 4, 10, 2, 0),
(103, 0, 2, 5, 6, 0, 0),  
(104, 3, 1, 9, 4, 0, 0), 
(105, 0, 0, 2, 7, 1, 0),  
(106, 1, 1, 3, 12, 2, 0), 
(107, 0, 0, 1, 5, 0, 0), 
(108, 0, 1, 3, 9, 1, 0), 
(109, 4, 0, 6, 3, 0, 0); 

INSERT INTO Player_Performance (PlayerID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES
(182, 0, 1, 2, 5, 1, 0),  
(183, 1, 0, 2, 3, 1, 0),   
(184, 0, 0, 2, 6, 1, 0),   
(185, 1, 1, 3, 4, 0, 0),   
(188, 2, 0, 6, 2, 0, 0),   
(189, 1, 3, 3, 3, 0, 0),   
(190, 0, 0, 1, 4, 0, 0),   
(191, 2, 1, 4, 3, 1, 0),   
(192, 2, 0, 7, 2, 1, 0),   
(193, 0, 0, 2, 5, 1, 0),   
(194, 1, 1, 3, 4, 0, 0),  
(195, 4, 0, 12, 3, 0, 0),  
(196, 3, 1, 5, 3, 1, 0);  

INSERT INTO Player_Performance (PlayerID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES
(236, 10, 3, 45, 12, 2, 0), 
(233, 8, 1, 40, 15, 1, 0), 
(238, 2, 5, 25, 9, 1, 0),  
(232, 1, 0, 10, 18, 3, 0),  
(230, 0, 0, 2, 20, 2, 0),  
(237, 0, 0, 3, 10, 1, 0),   
(243, 1, 0, 5, 11, 2, 0),   
(241, 3, 2, 15, 5, 0, 0), 
(240, 0, 0, 0, 1, 1, 0),  
(239, 4, 1, 15, 8, 1, 0),   
(244, 2, 3, 10, 6, 0, 0),   
(245, 0, 0, 2, 14, 1, 0),   
(246, 1, 1, 8, 12, 2, 0),  
(248, 0, 2, 5, 7, 1, 0),    
(249, 4, 1, 15, 10, 1, 0);  

INSERT INTO Player_Performance (PlayerID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES
(265, 0, 0, 0, 0, 0, 0), -- 조수혁 (GK)
(266, 0, 1, 3, 4, 1, 0), -- 장시영 (DF) -> 골은 없고 어시스트와 파울을 조금 높임
(267, 1, 2, 3, 3, 2, 0), -- 임종은 (DF)
(268, 3, 3, 6, 2, 1, 0), -- 보야니치 (MF)
(269, 8, 2, 18, 7, 3, 0), -- 마틴 아담 (FW)
(270, 4, 3, 9, 2, 1, 0), -- 바코 (MF)
(271, 1, 0, 2, 3, 1, 0), -- 엄원상 (MF)
(272, 0, 1, 2, 1, 0, 0), -- 이명재 (DF)
(273, 2, 1, 4, 2, 1, 0), -- 이동경 (MF)
(274, 1, 0, 2, 2, 0, 0), -- 정승현 (DF)
(275, 0, 0, 1, 3, 0, 0), -- 김성준 (MF)
(276, 2, 0, 5, 4, 1, 0), -- 루빅손 (FW)
(277, 4, 1, 9, 5, 2, 0), -- 주민규 (FW)
(278, 1, 2, 4, 2, 1, 0), -- 김영권 (DF)
(279, 0, 0, 0, 0, 0, 0); -- 조현우 (GK)

INSERT INTO Player_Performance (PlayerID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES
(295, 0, 0, 0, 1, 0, 0),  -- 김동헌 (GK)
(300, 0, 1, 0, 8, 1, 0),   -- 오반석 (DF)
(307, 0, 1, 12, 10, 3, 0),  -- 권한진 (DF)
(299, 0, 2, 8, 15, 2, 0),   -- 김연수 (DF)
(316, 0, 2, 0, 4, 1, 0),   -- 민경현 (MF)
(309, 1, 2, 2, 7, 2, 0),   -- 문지환 (MF)
(308, 1, 1, 3, 12, 4, 0),  -- 이명주 (MF)
(303, 0, 3, 0, 5, 2, 0),   -- 김준엽 (DF)
(327, 4, 2, 15, 10, 3, 0),  -- 하동호 (FW)
(328, 1, 0, 6, 6, 2, 0),   -- 음포쿠 (FW)
(323, 0, 3, 9, 15, 5, 0),  -- 제로소 (FW)
(325, 3, 1, 12, 5, 3, 0),   -- 김민석 (FW)
(329, 1, 0, 10, 7, 1, 0),   -- 박승호 (FW)
(324, 4, 1, 8, 5, 1, 0);    -- 송시우 (FW)


INSERT INTO Player_Performance (PlayerID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES
(331, 0, 0, 0, 0, 0, 0),  -- 이범수
(332, 0, 0, 0, 4, 2, 0),  -- 노윤상
(334, 0, 1, 0, 6, 3, 0),  -- 윤영선
(335, 0, 0, 1, 3, 2, 0),  -- 최보경
(343, 0, 0, 0, 5, 2, 0),  -- 구자룡
(347, 0, 1, 2, 3, 1, 0),  -- 김진수
(336, 0, 1, 3, 14, 1, 0),  -- 한교원
(337, 0, 2, 1, 9, 3, 0),  -- 백승호
(340, 0, 1, 3, 12, 2, 0),  -- 바로우
(341, 1, 2, 3, 4, 3, 0),   -- 김보경
(352, 0, 1, 0, 6, 2, 0),  -- 류재문
(338, 3, 2, 5, 10, 2, 0),  -- 구스타보
(339, 5, 3, 12, 7, 3, 0),   -- 조규성
(344, 1, 1, 5, 5, 2, 0),   -- 이근호
(345, 5, 2, 16, 6, 2, 0),    -- 송민규
(350, 2, 2, 6, 8, 3, 0);    -- 문선민


INSERT INTO Player_Performance (PlayerID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES
(375, 0, 0, 0, 0, 0, 0),  -- 김동준
(376, 0, 0, 0, 5, 2, 0),  -- 안태현
(377, 0, 2, 1, 4, 3, 0),  -- 연제운
(378, 0, 0, 0, 6, 2, 0),  -- 송주훈
(385, 0, 1, 0, 5, 2, 0),  -- 정운
(390, 0, 0, 2, 3, 3, 0),  -- 김오규
(379, 1, 3, 1, 4, 2, 0),  -- 최영준
(380, 0, 1, 0, 5, 2, 0),   -- 구자철
(381, 0, 2, 3, 4, 1, 0),  -- 김건웅
(386, 1, 0, 2, 6, 3, 0),  -- 서진수
(387, 0, 2, 5, 4, 2, 0),   -- 조나탄 링
(382, 5, 1, 12, 8, 2, 0),  -- 유리 조나탄
(383, 3, 0, 9, 5, 3, 0),  -- 헤이스
(384, 1, 1, 9, 6, 1, 0),   -- 김승섭
(388, 2, 2, 11, 7, 3, 0);  -- 임동혁



INSERT INTO Player_Performance (PlayerID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES
(424, 0, 0, 0, 1, 0, 0),  -- 황인재
(406, 0, 0, 0, 0, 0, 0),  -- 윤평국
(407, 0, 0, 2, 14, 1, 0),  -- 심상민
(409, 0, 1, 1, 8, 1, 0),  -- 그랜트
(433, 0, 0, 0, 9, 0, 0),  -- 이규백
(437, 0, 0, 0, 7, 1, 0),  -- 하창래
(412, 1, 1, 6, 6, 2, 0),  -- 오베르단
(414, 0, 2, 4, 4, 2, 0),  -- 백성동
(415, 2, 1, 5, 3, 3, 0),  -- 고영준
(426, 0, 2, 5, 3, 1, 0),  -- 조재훈
(411, 4, 1, 12, 2, 2, 0),  -- 김인성
(413, 2, 3, 8, 3, 2, 0),  -- 제카
(440, 1, 1, 5, 3, 1, 0),  -- 완델손
(441, 3, 2, 10, 3, 2, 0);  -- 양태렬