

--
-- Company :      UNAM
-- Project :      Pago de cursos en linea
-- Author :       Armando Valderram
-- Target DBMS : PostgreSQL 10.0
--

--
-- TABLE: CURSO
-- This table will store all the courses taught by the unit. 
--

CREATE SEQUENCE IF NOT EXISTS SEQ_CURSO;

CREATE TABLE CURSO(
    CURSO_ID        NUMERIC(5,0)    NOT NULL DEFAULT NEXTVAL('SEQ_CURSO'),
    NOMBRE          VARCHAR(40)     NOT NULL,
    IMAGEN          VARCHAR(300)    NOT NULL,
    HORA_INICIO     TIME            NULL,
    HORA_FIN        TIME            NULL,
    TEMARIO         VARCHAR(200)    NOT NULL,
    ANTECEDENTES    VARCHAR(300)    NOT NULL,
    MATERIAL        VARCHAR(200)    NOT NULL,
    PRECIO          NUMERIC(6,2)    NOT NULL,
    CUPO            NUMERIC(4,0)    NOT NULL,
    FECHA_INICIO    DATE            NOT NULL,
    FECHA_FIN       DATE            NOT NULL,

    CONSTRAINT CURSO_PK PRIMARY KEY (CURSO_ID)
);

--
-- TABLE: STATUS PAGO CURSO
-- This table will store the payment status each course of the users.
--

CREATE SEQUENCE IF NOT EXISTS SEQ_ESTATUS_PAGO_CURSO;

CREATE TABLE ESTATUS_PAGO_CURSO(
    ESTATUS_PAGO_CURSO_ID     NUMERIC(3,0)   NOT NULL DEFAULT NEXTVAL('SEQ_ESTATUS_PAGO_CURSO'),
    NOMBRE              VARCHAR(30)     NOT NULL,
    DESCRIPCION         VARCHAR(200)    NOT NULL,

    CONSTRAINT ESTATUS_PAGO_CURSO_PK PRIMARY KEY (ESTATUS_PAGO_CURSO_ID)
);

--
-- TABLE: FACTURA
--
CREATE SEQUENCE IF NOT EXISTS SEQ_FACTURA;

CREATE TABLE FACTURA(
    FACTURA_ID      NUMERIC(5,0)    NOT NULL DEFAULT NEXTVAL('SEQ_FACTURA'),
    FACTURA         VARCHAR(40)     NOT NULL,

    CONSTRAINT FACTURA_PK PRIMARY KEY (FACTURA_ID)
);

--
-- TABLE: FICHA DE REFERENCIA
--
CREATE SEQUENCE IF NOT EXISTS SEQ_FICHA_REFERENCIA;

CREATE TABLE FICHA_REFERENCIA(
    FICHA_REFERENCIA_ID NUMERIC(5,0)    NOT NULL DEFAULT NEXTVAL('SEQ_FICHA_REFERENCIA'),
    REFERENCIA          NUMERIC(20,0)   NOT NULL,

    CONSTRAINT FICHA_REFERENCIA_PK PRIMARY KEY (FICHA_REFERENCIA_ID)
);

--
-- TABLE: FORMA DE PAGO
--
CREATE SEQUENCE IF NOT EXISTS SEQ_FORMA_PAGO;

CREATE TABLE FORMA_PAGO(
    FORMA_PAGO_ID   NUMERIC(5,0)    NOT NULL DEFAULT NEXTVAL('SEQ_FORMA_PAGO'),
    FORMA_PAGO      VARCHAR(40)     NOT NULL,
    DESCRIPCION     VARCHAR(200)    NOT NULL,

    CONSTRAINT FORMA_PAGO_PK PRIMARY KEY (FORMA_PAGO_ID)
);

--
-- TABLE: PERFIL USUARIO
--
CREATE SEQUENCE IF NOT EXISTS SEQ_PERFIL_USUARIO;

CREATE TABLE PERFIL_USUARIO(
    PERFIL_USUARIO_ID   NUMERIC(5,0)    NOT NULL DEFAULT NEXTVAL('SEQ_PERFIL_USUARIO'),
    PERFIL_USUARIO      VARCHAR(40)     NOT NULL,
    DESCRIPCION         VARCHAR(200)    NOT NULL,
    PORCIENTO_DESCUENTO NUMERIC(5,2)    NOT NULL,

    CONSTRAINT PERFIL_USUARIO_PK PRIMARY KEY (PERFIL_USUARIO_ID)
);

--
-- TABLE: TIPO USUARIO
--
CREATE SEQUENCE IF NOT EXISTS SEQ_TIPO_USUARIO;

CREATE TABLE TIPO_USUARIO(
    TIPO_USUARIO_ID     NUMERIC(5,0)    NOT NULL DEFAULT NEXTVAL('SEQ_TIPO_USUARIO'),
    TIPO_USUARIO        VARCHAR(40)     NOT NULL,
    DESCRIPCION         VARCHAR(200)    NOT NULL,

    CONSTRAINT TIPO_USUARIO_PK PRIMARY KEY (TIPO_USUARIO_ID)
);

--
-- TABLE: USUARIO
--

CREATE SEQUENCE IF NOT EXISTS SEQ_USUARIO;

CREATE TABLE USUARIO(
    USUARIO_ID          NUMERIC(5,0)    NOT NULL DEFAULT NEXTVAL('SEQ_USUARIO'),
    NOMBRE              VARCHAR(40)     NOT NULL,
    AP_PATERNO          VARCHAR(40)     NOT NULL,
    AP_MATERNO          VARCHAR(40)     NOT NULL,
    EDAD                VARCHAR(40)     NOT NULL,
    SEXO                  CHAR            NOT NULL,
    CORREO_ELECTRONICO  VARCHAR(40)     NOT NULL,
    CONTRASENA          VARCHAR(50)     NOT NULL,
    FECHA_NACIMIENTO    DATE            NOT NULL,
    TELEFONO            NUMERIC(12,0)   NOT NULL,
    RFC                 VARCHAR(13)     NOT NULL,
    FECHA_REGISTRO      DATE            NOT NULL DEFAULT CURRENT_DATE,
    TIPO_USUARIO_ID     NUMERIC(5,0)    NOT NULL,
    PERFIL_USUARIO_ID   NUMERIC(5,0)    NOT NULL,

    CONSTRAINT USUARIO_PK PRIMARY KEY (USUARIO_ID)
);

--
-- TABLE: HISTORICO CURSO
--

CREATE SEQUENCE IF NOT EXISTS SEQ_HISTORICO_CURSO;

CREATE TABLE HISTORICO_CURSO(
    HISTORICO_CURSO_ID  NUMERIC(5,0)    NOT NULL DEFAULT NEXTVAL('SEQ_HISTORICO_CURSO'),
    FECHA_ESTATUS       DATE            NOT NULL DEFAULT CURRENT_DATE,
    ESTATUS_PAGO_CURSO_ID    NUMERIC(5,0)    NOT NULL,
    CURSO_ID            NUMERIC(5,0)    NOT NULL,
    USUARIO_ID          NUMERIC(5,0)    NOT NULL,

    CONSTRAINT HISTORICO_CURSO_PK PRIMARY KEY (HISTORICO_CURSO_ID)
);

--
-- TABLE: CURSO-USUARI
--
CREATE SEQUENCE IF NOT EXISTS SEQ_CURSO_USUARIO;

CREATE TABLE CURSO_USUARIO(
    CURSO_USUARIO_ID    NUMERIC(5,0)    NOT NULL DEFAULT NEXTVAL('SEQ_CURSO_USUARIO'),
    FECHA_ESTATUS_ACTUAL    DATE        NOT NULL DEFAULT CURRENT_DATE,
    CURSO_ID            NUMERIC(5,0)    NOT NULL,
    USUARIO_ID          NUMERIC(5,0)    NOT NULL,
    ESTATUS_PAGO_CURSO_ID    NUMERIC(3,0)    NOT NULL,
    FORMA_PAGO_ID       NUMERIC(5,0)    NOT NULL,
    FACTURA_ID          NUMERIC(5,0)    NOT NULL,
    FICHA_REFERENCIA_ID NUMERIC(5,0)    NOT NULL,
    CONSTRAINT CURSO_USUARIO_PK PRIMARY KEY (CURSO_USUARIO_ID)
);

--
-- ALTER TABLE: USUARIO
--

ALTER TABLE USUARIO
    ADD CONSTRAINT TIPO_USUARIO_FK FOREIGN KEY (TIPO_USUARIO_ID)
    REFERENCES TIPO_USUARIO (TIPO_USUARIO_ID);

ALTER TABLE USUARIO
    ADD CONSTRAINT PERFIL_USUARIO_ID FOREIGN KEY (PERFIL_USUARIO_ID)
    REFERENCES PERFIL_USUARIO (PERFIL_USUARIO_ID);

--
-- ALTER TABLE: HISTORICO CURSO
--

ALTER TABLE HISTORICO_CURSO
    ADD CONSTRAINT ESTATUS_PAGO_CURSO_FK FOREIGN KEY (ESTATUS_PAGO_CURSO_ID)
    REFERENCES ESTATUS_PAGO_CURSO (ESTATUS_PAGO_CURSO_ID);

ALTER TABLE HISTORICO_CURSO
    ADD CONSTRAINT CURSO_FK FOREIGN KEY (CURSO_ID)
    REFERENCES CURSO (CURSO_ID);

ALTER TABLE HISTORICO_CURSO
    ADD CONSTRAINT USUARIO_FK FOREIGN KEY (USUARIO_ID)
    REFERENCES USUARIO (USUARIO_ID);

--
-- ALTER TABLE: CURSO - USUARIO
--

ALTER TABLE CURSO_USUARIO
    ADD CONSTRAINT CURSO_FK FOREIGN KEY (CURSO_ID)
    REFERENCES CURSO (CURSO_ID);

ALTER TABLE CURSO_USUARIO
    ADD CONSTRAINT USUARIO_FK FOREIGN KEY (USUARIO_ID)
    REFERENCES USUARIO (USUARIO_ID);


ALTER TABLE CURSO_USUARIO
    ADD CONSTRAINT FORMA_PAGO_FK FOREIGN KEY (FORMA_PAGO_ID)
    REFERENCES FORMA_PAGO (FORMA_PAGO_ID);

ALTER TABLE CURSO_USUARIO
    ADD CONSTRAINT FACTURA_FK FOREIGN KEY (FACTURA_ID)
    REFERENCES FACTURA (FACTURA_ID);

ALTER TABLE CURSO_USUARIO
    ADD CONSTRAINT FICHA_REFERENCIA_FK FOREIGN KEY (FICHA_REFERENCIA_ID)
    REFERENCES FICHA_REFERENCIA (FICHA_REFERENCIA_ID);

ALTER TABLE CURSO_USUARIO
    ADD CONSTRAINT ESTATUS_PAGO_CURSO_FK FOREIGN KEY (ESTATUS_PAGO_CURSO_ID)
    REFERENCES ESTATUS_PAGO_CURSO (ESTATUS_PAGO_CURSO_ID);

