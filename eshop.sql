-- Table: public.cart

-- DROP TABLE IF EXISTS public.cart;

CREATE TABLE IF NOT EXISTS public.cart
(
    user_id bigint NOT NULL,
    CONSTRAINT cart_pkey1 PRIMARY KEY (user_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.cart
    OWNER to postgres;
	
----------------------------------------------------

-- Table: public.discount

-- DROP TABLE IF EXISTS public.discount;

CREATE TABLE IF NOT EXISTS public.discount
(
    id character varying COLLATE pg_catalog."default" NOT NULL,
    status bigint,
    CONSTRAINT discount_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.discount
    OWNER to postgres;
	
------------------------------------------------------

-- Table: public.order_main

-- DROP TABLE IF EXISTS public.order_main;

CREATE TABLE IF NOT EXISTS public.order_main
(
    order_id bigint NOT NULL,
    buyer_address character varying(255) COLLATE pg_catalog."default",
    buyer_email character varying(255) COLLATE pg_catalog."default",
    buyer_name character varying(255) COLLATE pg_catalog."default",
    buyer_phone character varying(255) COLLATE pg_catalog."default",
    create_time timestamp without time zone,
    order_amount numeric(19,2) NOT NULL,
    order_status integer NOT NULL DEFAULT 0,
    update_time timestamp without time zone,
    CONSTRAINT order_main_pkey PRIMARY KEY (order_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.order_main
    OWNER to postgres;
	
------------------------------------------------------

-- Table: public.product_category

-- DROP TABLE IF EXISTS public.product_category;

CREATE TABLE IF NOT EXISTS public.product_category
(
    category_id integer NOT NULL,
    category_name character varying(255) COLLATE pg_catalog."default",
    category_type integer,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    CONSTRAINT product_category_pkey PRIMARY KEY (category_id),
    CONSTRAINT uk_6kq6iveuim6wd90cxo5bksumw UNIQUE (category_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_category
    OWNER to postgres;
	
--------------------------------------------------------

-- Table: public.product_in_order

-- DROP TABLE IF EXISTS public.product_in_order;

CREATE TABLE IF NOT EXISTS public.product_in_order
(
    id bigint NOT NULL,
    category_type integer NOT NULL,
    count integer,
    product_description character varying(255) COLLATE pg_catalog."default" NOT NULL,
    product_icon character varying(255) COLLATE pg_catalog."default",
    product_id character varying(255) COLLATE pg_catalog."default",
    product_name character varying(255) COLLATE pg_catalog."default",
    product_price numeric(19,2) NOT NULL,
    product_stock integer,
    cart_user_id bigint,
    order_id bigint,
    CONSTRAINT product_in_order_pkey PRIMARY KEY (id),
    CONSTRAINT fkt0sfj3ffasrift1c4lv3ra85e FOREIGN KEY (order_id)
        REFERENCES public.order_main (order_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT product_cart_fkey FOREIGN KEY (cart_user_id)
        REFERENCES public.cart (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT product_in_order_count_check CHECK (count >= 1),
    CONSTRAINT product_in_order_product_stock_check CHECK (product_stock >= 0)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_in_order
    OWNER to postgres;
	
------------------------------------------------------------

-- Table: public.product_info

-- DROP TABLE IF EXISTS public.product_info;

CREATE TABLE IF NOT EXISTS public.product_info
(
    product_id character varying(255) COLLATE pg_catalog."default" NOT NULL,
    category_type integer DEFAULT 0,
    create_time timestamp without time zone,
    product_description character varying(255) COLLATE pg_catalog."default",
    product_icon character varying(255) COLLATE pg_catalog."default",
    product_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    product_price numeric(19,2) NOT NULL,
    product_status integer DEFAULT 0,
    product_stock integer NOT NULL,
    update_time timestamp without time zone,
    CONSTRAINT product_info_pkey PRIMARY KEY (product_id),
    CONSTRAINT product_info_product_stock_check CHECK (product_stock >= 0)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_info
    OWNER to postgres;
	
-----------------------------------------------------------------

-- Table: public.tokens



ALTER TABLE IF EXISTS public.tokens
    OWNER to postgres;
	
--------------------------------------------------------------------------

-- Table: public.users

-- DROP TABLE IF EXISTS public.users;

CREATE TABLE IF NOT EXISTS public.users
(
    id bigint NOT NULL,
    active boolean NOT NULL,
    address character varying(255) COLLATE pg_catalog."default",
    email character varying(255) COLLATE pg_catalog."default",
    name character varying(255) COLLATE pg_catalog."default",
    password character varying(255) COLLATE pg_catalog."default",
    phone character varying(255) COLLATE pg_catalog."default",
    role character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT users_pkey PRIMARY KEY (id),
    CONSTRAINT uk_sx468g52bpetvlad2j9y0lptc UNIQUE (email)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.users
    OWNER to postgres;
	
---------------------------------------------------------------------------

-- Table: public.wishlist

-- DROP TABLE IF EXISTS public.wishlist;

CREATE TABLE IF NOT EXISTS public.wishlist
(
    id bigint NOT NULL,
    created_date timestamp without time zone,
    user_id bigint,
    product_id character varying COLLATE pg_catalog."default",
    CONSTRAINT wishlist_pkey PRIMARY KEY (id),
    CONSTRAINT product_wish_fkey FOREIGN KEY (product_id)
        REFERENCES public.product_info (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "user_wish_Fkey" FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.wishlist
    OWNER to postgres;
	
---------------------------------------------------------------------------------------------------






--Product_Info


INSERT INTO "public"."product_category" VALUES (2147483641, 'Home', 0, '2022-07-07 23:03:26', '2022-07-07 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483642, 'Groceries', 1, '2022-07-07 23:03:26', '2022-07-07 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483643, 'Lightings', 2, '2022-07-07 23:03:26', '2022-07-07 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483644, 'Interiors', 3, '2022-07-07 23:03:26', '2022-07-07 23:03:26');


--Product



INSERT INTO "public"."product_info" VALUES ('AB000', 0, '2022-07-25 23:03:26', 'Navy blue sofa', 'https://wakefit-co.s3.ap-south-1.amazonaws.com/img/product-thumbnails/napper-sectional-lifestyle.jpg', 'Sofa', 80.00, 0, 30, '2022-07-25 23:03:26');
INSERT INTO "public"."product_info" VALUES ('CD000', 0, '2022-07-25 23:03:26','ocean blue bean bag, soft and comfortable', 'https://m.media-amazon.com/images/I/617j+a0KeSL._SL1500_.jpg', 'bean bag', 40.00, 0, 24, '2022-07-25 23:03:26');
INSERT INTO "public"."product_info" VALUES ('CD002', 0, '2022-07-25 23:03:26','Home related things', 'https://tse3.mm.bing.net/th?id=OIP.-yOsL4STeqTLxAgBQjGGUQHaE8&pid=Api&P=0', 'Home decore', 150.00, 0, 24, '2022-07-25 23:03:26');



INSERT INTO "public"."product_info" VALUES ('AB002', 1, '2022-07-25 23:03:26', 'Table', 'https://5.imimg.com/data5/JS/OW/HK/SELLER-89741542/wooden-tea-table-500x500.jpg ', 'tea/coffee table', 35.00, 0, 20, '2022-07-25 23:03:26');
INSERT INTO "public"."product_info" VALUES ('CD003', 1, '2022-07-25 23:03:26', 'Hand Craft Lord Ganesha', 'https://cdn.dollsofindia.com/images/p/wood-statues/lord-ganesha-wall-hanging-HK89_l.jpg', 'Wooden Lord Ganesha', 45.00, 0, 9, '2022-07-25 23:03:26');
INSERT INTO "public"."product_info" VALUES ('AB004', 1, '2022-07-25 23:03:26', 'Best wood for outdoor', 'https://tse1.mm.bing.net/th?id=OIP.hisFBEd-5fnDu5OzQy3cygHaFQ&pid=Api&P=0', 'Outdoor furniture', 100.00, 0, 13, '2022-07-25 23:03:26');



INSERT INTO "public"."product_info" VALUES ('EF000', 2, '2022-07-25 23:03:26', '2 study lamps set', 'https://images-na.ssl-images-amazon.com/images/I/71GTVhEEjVL._AC_SX466_.jpg', 'lamp set', 50.00, 0, 45, '2022-07-25 23:03:26');
INSERT INTO "public"."product_info" VALUES ('"EF001"', 2, '2022-07-025 23:03:26', 'Vanity Art Farmhouse Vintahe 4 light', 'https://i5.walmartimages.com/asr/4c784809-1512-4ba6-9318-e83e3fab82b4.7dc9e8d4f291d82fdc8cff892b26354e.jpeg?', ' Vanity art LED light', 80.00, 0, 60, '2022-07-25 23:03:26');
INSERT INTO "public"."product_info" VALUES ('"EF002"', 2, '2022-07-025 23:03:26', 'crystal decor light', 'https://i5.walmartimages.com/asr/f74e90bc-32fe-423f-9d42-5d624a598835.986e6660ab9e514b2047b18560589443.jpeg', 'Mini style Crystal light', 80.00, 0, 60, '2022-07-25 23:03:26');


INSERT INTO "public"."product_info" VALUES ('"GH000"', 3, '2022-07-07 23:03:26', 'Perfect Homes Artificial Flowers with White Pot for Home Décor', 'https://m.media-amazon.com/images/I/71sbSfaGg1L._SL1500_.jpg', 'Homes Artificial Flowers  ', 20.00, 0, 29, '2022-07-25 23:03:26');
INSERT INTO "public"."product_info" VALUES ('"GH001"', 3, '2022-07-07 23:03:26', '4 multi-color set carpet', 'https://m.media-amazon.com/images/I/81W6An71HSL._SX355_.jpg', 'carpet set', 16.00, 0, 55, '2022-07-25 23:03:26');
INSERT INTO "public"."product_info" VALUES ('"GH002"', 3, '2022-07-07 23:03:26', 'Wall hanginh hamdwoven bohemian cotton rope boho tapesty home decor', 'https://i5.walmartimages.com/asr/772fb73e-3efe-42aa-b025-63f5ac79d0e4.e337987318c156fc1432ce073c41e213.jpeg', 'Wall hangings', 49.00, 0, 6, '2022-07-25 23:03:26');



------------------------------------------------------------------------------------------------------------------------

--Users

INSERT INTO "public"."users" VALUES (2147483645, true, 'Plot 2, ram Nagar, hydrabad', 'admin@eshop.com', 'Admin', '$2a$10$LiBwO43TpKU0sZgCxNkWJueq2lqxoUBsX2Wclzk8JQ3Ejb9MWu2Xy', '1234567890', 'ROLE_MANAGER');
