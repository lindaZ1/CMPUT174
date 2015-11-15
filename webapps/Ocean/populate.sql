INSERT INTO persons VALUES ('111', 'Abby','Apple','123 Apple St','aa@gmail.com','1234567');
INSERT INTO persons VALUES ('222', 'Brady', 'Bunch', '123 Happy Ave', 'bb@gmail.com','1234568');
INSERT INTO persons VALUES ('333', 'Charlie','Charcoal','107 Tin Rd', 'cc@gmail.com','1234569');
INSERT INTO persons VALUES ('444', 'Dan','Danger','1388 Soma Dr','dd@gmail.com','1234566');

INSERT INTO users VALUES ('user1','pass1','a','111',date'2002-02-02');
INSERT INTO users VALUES ('user12','pass12','d','111',date'2002-02-02');
INSERT INTO users VALUES ('user2','pass2','s','222',date'2003-07-07');
INSERT INTO users VALUES ('user3','pass3','d','333',date'2005-3-13');
INSERT INTO users VALUES ('user4','pass4','s','333',date'2004-09-09');

INSERT INTO sensors VALUES ('1111','ocean','a','oceanssss');
INSERT INTO sensors VALUES ('2222','forest','i','forestssss');
INSERT INTO sensors VALUES ('3333','house','t','housessss');
INSERT INTO sensors VALUES ('4444','fort','o','fortssssss');

INSERT INTO subscriptions VALUES ('1111','222');
INSERT INTO subscriptions VALUES ('2222','222');
INSERT INTO subscriptions VALUES ('2222','333');
INSERT INTO subscriptions VALUES ('3333','222');
INSERT INTO subscriptions VALUES ('4444','333');

CREATE SEQUENCE SEQ_IMAGE_ID START WITH 1 INCREMENT BY 1;
INSERT INTO images(image_id) VALUES (SEQ_IMAGE_ID.nextval);

CREATE SEQUENCE SCALAR_ID START WITH 1 INCREMENT BY 1;
