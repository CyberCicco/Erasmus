create database Erasmus;
use Erasmus;

/* TABELLE */

create table NAZIONE(
       Nome varchar(50) not null,
       Contributo int not null,
       Primary key (Nome)
) engine=INNODB;

create table UNIVERSITA (
       Unicode int not null AUTO_INCREMENT,
       Nome varchar(50) not null,
       Indirizzo varchar(50) not null,
       Nazione varchar(50) not null,
       primary key (Unicode),
       foreign key (Nazione) references NAZIONE(Nome)
) engine=INNODB;

create table ALLOGGIO(
       Nome varchar(50) not null,
       Sede varchar(50) not null,
       Tipo varchar(50) not null,
       Affitto int not null,
       Valutazione int not null,
       Nazione varchar(50) not null,
       primary key (Nome),
       foreign key (Nazione) references NAZIONE(Nome)
) engine=INNODB;


create table UFFICIO(
       Sede varchar(50) not null,
       Telefono int not null,
       OrarioA Time not null,
       OrarioC Time not null,
       primary key (Sede)
) engine=INNODB;

create table RESPONSABILE(
       CF varchar(16) not null,
       Nome varchar(50) not null,
       Cognome varchar(50) not null,
       Mail varchar(50) not null,
       Ufficio varchar(50) not null,
       primary key(CF),
       foreign key(Ufficio) references UFFICIO(Sede)
) engine=INNODB;

create table FACOLTA(
    Nome varchar(50) not null,
    Sede varchar(50) not null,
    Universita int not null,
    Ufficio varchar(50) not null,
    primary key(Nome, Universita),
    foreign key(Universita) references UNIVERSITA(Unicode),
    foreign key(Ufficio) references UFFICIO(Sede)
) engine=INNODB;

create table CORSO(
       Codice varchar(50) not null,
       Nome varchar(50) not null,
       Facolta varchar(50) not null,
       Universita int not null,
       Tipologia varchar(50) not null,
       primary key(Codice, Facolta, Universita),
       foreign key(Facolta, Universita) references FACOLTA(Nome, Universita)
) engine=INNODB;

create table COLLABORA(
       Corso1 varchar(50) not null,
       Facolta1 varchar(50) not null,
       Universita1 int not null,
       Corso2 varchar(50) not null,
       Facolta2 varchar(50) not null,
       Universita2 int not null,
       Anno int not null,
       Posti int not null,
       Cert varchar(50),
       Durata int not null,
       Livello int not null,
       primary key(Corso1, Facolta1, Universita1, Corso2, Facolta2, Universita2, Anno, Livello),
       foreign key(Corso1, Facolta1, Universita1) references CORSO(Codice, Facolta, Universita),
       foreign key(Corso2, Facolta2, Universita2) references CORSO(Codice, Facolta, Universita)
) engine=INNODB;

create table COMMISSIONE(
       ID int not null,
       Nome varchar(50) not null,
       Facolta varchar(50) not null,
       Universita int not null,
       primary key(ID),
       foreign key(Facolta, Universita) references FACOLTA(Nome, Universita)
) engine=INNODB;

create table PROFESSORE(
       CF varchar(16) not null,
       Nome varchar(50) not null,
       Cognome varchar(50) not null,
       Qualifica varchar(50) not null,
       Mail varchar(50) not null,
       Facolta varchar(50) not null,
       Universita int not null,
       primary key(CF),
      foreign key(Facolta, Universita) references FACOLTA(Nome, Universita)
) engine=INNODB;

create table MATERIA(
       Nome varchar(50) not null,
       CFU int not null,
       Corso varchar(50) not null,
       Facolta varchar(50) not null,
       Universita int not null,
       primary key(Nome),
       foreign key(Corso, Facolta, Universita) references CORSO(Codice, Facolta, Universita)
) engine=INNODB;

create table INSEGNA(
       Professore varchar(16) not null,
       Materia varchar(50) not null,
       Anno int not null,
       primary key(Professore, Materia, Anno),
       foreign key(Professore)references PROFESSORE(CF),
       foreign key(Materia) references MATERIA(Nome)
) engine=INNODB;

create table LEARNINGAGREEMENT(
       ID int not null,
       Corso varchar(50) not null,
       Facolta varchar(50) not null,
       Universita int not null,
       DataInizio Date,
       DataFine Date,
       primary key(ID),
       foreign key(Corso, Facolta, Universita) references CORSO(Codice, Facolta, Universita)
) engine=INNODB;

create table GRADUATORIA(
       ID int not null,
       Posizione int not null,
       Punteggio int not null,
       Anno int not null,
       Risultato varchar(50) not null,
       LearningAgreement int,
       Alloggio varchar(50),
       Commissione int not null,
       primary key(ID, Posizione),
       foreign key(LearningAgreement) references LEARNINGAGREEMENT(ID),
       foreign key(Alloggio) references ALLOGGIO(Nome),
       foreign key(Commissione) references COMMISSIONE(ID)
) engine = INNODB;

create table PUBBLICA(
       Facolta varchar(50) not null,
       Universita int not null,
       Graduatoria int not null,
       Anno int not null,
       primary key(Facolta, Universita, Graduatoria, Anno),
       foreign key(Facolta, Universita) references FACOLTA(Nome, Universita),
       foreign key(Graduatoria) references GRADUATORIA(ID)
) engine = INNODB;

create table ESAME(
       Materia varchar(50) not null,
       LearningAgreement int not null,
       Voto int not null,
       Data Date,
       primary key(Materia, LearningAgreement, Voto, Data),
       foreign key(Materia) references MATERIA(Nome),
       foreign key(LearningAgreement) references LEARNINGAGREEMENT(ID)
) engine = INNODB;


create table STUDENTE(
       CF varchar(16) not null,
       Matricola varchar(7) not null,
       Nome varchar(50) not null,
       Cognome varchar(50) not null,
       Data Date not null,
       Mail varchar(50) not null,
       Isee int not null,
       CertLing varchar(50) not null,
       Media float(2,2) not null,
       Corso varchar(50) not null,
       Facolta varchar(50) not null,
       Universita int not null,
       Erasmus int not null,
       PosizioneErasmus int not null,
       primary key(CF),
       foreign key(Corso, Facolta, Universita) references CORSO(Codice, Facolta, Universita),
       foreign key(Erasmus, PosizioneErasmus) references GRADUATORIA(ID, Posizione)
) engine = INNODB;

/* INSERT DI PROVA */

-----------------------NAZIONE
Insert into NAZIONE(Nome, Contributo) values ('Spagna',250);

Insert into NAZIONE(Nome, Contributo) values ('Belgio',250);

Insert into NAZIONE(Nome, Contributo) values ('Italia',250);

Insert into NAZIONE(Nome, Contributo) values ('Danimarca',300);

Insert into NAZIONE(Nome, Contributo) values ('Croazia',200);

-----------------------UNIVERSITA
Insert into UNIVERSITA(Unicode, Nome, Indirizzo, Nazione) values (1, 'Università di Roma Tor Vergata', 'Via Cracovia 50', 'Italia');

Insert into UNIVERSITA(Unicode, Nome, Indirizzo, Nazione) values (2, 'Università di Granada', 'Av. Del Hospicio', 'Spagna');

Insert into UNIVERSITA(Unicode, Nome, Indirizzo, Nazione) values (3, 'Università di Roma La Sapienza', 'Piazzale Aldo Moro 5', 'Italia');

Insert into UNIVERSITA(Unicode, Nome, Indirizzo, Nazione) values (4, 'Università di Anversa', 'Prinsstraat 13', 'Belgio');

Insert into UNIVERSITA(Unicode, Nome, Indirizzo, Nazione) values (5, 'Università di Copenhagen', 'Norregade 10', 'Danimarca');

Insert into UNIVERSITA(Unicode, Nome, Indirizzo, Nazione) values (6, 'Università di Zagabria', 'Trg Republike Hrvatske 14', 'Croazia');

-----------------------ALLOGGIO

Insert into ALLOGGIO(Nome, Sede, Tipo, Affitto, Valutazione, Nazione) values ('CampusX Roma', 'Via di Passo Lombardo 341', 'Resort per gli studenti', 500, 9, 'Italia');

Insert into ALLOGGIO(Nome, Sede, Tipo, Affitto, Valutazione, Nazione) values ('Appartamento Granada', 'Calle San Ambrosio', 'Stanza in appartamento condiviso', 200, 7, 'Spagna');

Insert into ALLOGGIO(Nome, Sede, Tipo, Affitto, Valutazione, Nazione) values ('Appartamento Zagabria', 'Pavlinsky prilaz 7', 'Appartamento', 400, 8, 'Croazia');

Insert into ALLOGGIO(Nome, Sede, Tipo, Affitto, Valutazione, Nazione) values ('Copenhagen Hostel', 'Frederkssundsvej 17', 'Ostello', 150, 5, 'Danimarca');

Insert into ALLOGGIO(Nome, Sede, Tipo, Affitto, Valutazione, Nazione) values ('WAW Student room', 'Mertens 27', 'Stanza in appartamento condiviso', 350, 10, 'Belgio');

Insert into ALLOGGIO(Nome, Sede, Tipo, Affitto, Valutazione, Nazione) values ('Stanze Monteverde', 'Via Vitellia 100', 'Stanza in appartamento condiviso', 450, 4, 'Italia');


-----------------------UFFICIO
Insert into UFFICIO(Sede, Telefono, OrarioA, OrarioC) values ('Via della Ricerca Scientifica 1', 0672594498, '09:00:00', '13:00:00');

Insert into UFFICIO(Sede, Telefono, OrarioA, OrarioC) values ('Via Columbia 2', 0672595836, '09:00:00', '13:00:00');

Insert into UFFICIO(Sede, Telefono, OrarioA, OrarioC) values ('Via Cracovia', 0672594002, '09:00:00', '13:00:00');

Insert into UFFICIO(Sede, Telefono, OrarioA, OrarioC) values ('Via del Politecnico 1', 0672597599, '09:00:00', '16:00:00');

Insert into UFFICIO(Sede, Telefono, OrarioA, OrarioC) values ('Piazzale Aldo Moro 5', 0643415062, '09:00:00', '11:00:00');

Insert into UFFICIO(Sede, Telefono, OrarioA, OrarioC) values ('Norregade 10', 123456789, '14:00:00', '18:00:00');

Insert into UFFICIO(Sede, Telefono, OrarioA, OrarioC) values ('Av. Del Hospicio', 11111111, '14:00:00', '20:00:00');


-----------------------RESPONSABILE
Insert into RESPONSABILE(CF, Nome, Cognome, Mail, Ufficio) values ('WKLRLD71C26B062J', 'Walter', 'Erisken', 'waltererisken@gmail.com', 'Norregade 10');

Insert into RESPONSABILE(CF, Nome, Cognome, Mail, Ufficio) values ('JLCCCW29T42I234Y', 'Jane', 'Ciano', 'jeaneciano@gmail.com', 'Via Cracovia');

Insert into RESPONSABILE(CF, Nome, Cognome, Mail, Ufficio) values ('DDHRQX85M06D092S', 'Davide', 'Bianchi', 'davidebianchi@gmail.com', 'Via Cracovia');

Insert into RESPONSABILE(CF, Nome, Cognome, Mail, Ufficio) values ('ZDOPPL97A18I120W', 'Zanna', 'Davide', 'davidebianchi@gmail.com', 'Piazzale Aldo Moro 5');

Insert into RESPONSABILE(CF, Nome, Cognome, Mail, Ufficio) values ('BLCZBJ57P14A038C', 'Gabriella', 'Pallicca', 'gabriellapallicca@libero.it', 'Via del Politecnico 1');

Insert into RESPONSABILE(CF, Nome, Cognome, Mail, Ufficio) values ('LCVFBF78B17F704W', 'Luisa', 'Bucci', 'luisabucci@uniroma2.it', 'Via della Ricerca Scientifica 1');

Insert into RESPONSABILE(CF, Nome, Cognome, Mail, Ufficio) values ('RXFJVN96H47C508T', 'Roberto', 'Moreno', 'robertomoreno@unigranada.com', 'Av. Del Hospicio');


-----------------------FACOLTA
Insert into FACOLTA(Nome, Sede, Universita, Ufficio) values ('Facolta di Economia', 'Via Columbia 2', 1, 'Via Columbia 2');

Insert into FACOLTA(Nome, Sede, Universita, Ufficio) values ('Facolta di Giurisprudenza', 'Via Cracovia', 1, 'Via Cracovia');

Insert into FACOLTA(Nome, Sede, Universita, Ufficio) values ('Facolta di Ingegneria', 'Via  del Politecnico 1', 1, 'Via del Politecnico 1');

Insert into FACOLTA(Nome, Sede, Universita, Ufficio) values ('Facolta di Scienze Matematiche, Fisiche e Naturali', 'Via  della Ricerca Scientifica 1', 1, 'Via della Ricerca Scientifica 1');

Insert into FACOLTA(Nome, Sede, Universita, Ufficio) values ('Facolta di Scienze Matematiche, Fisiche e Naturali', 'Norregade 10', 5, 'Norregade 10');

Insert into FACOLTA(Nome, Sede, Universita, Ufficio) values ('Facolta di Ingegneria', 'Av. Del Hospicio', 2, 'Av. Del Hospicio');

Insert into FACOLTA(Nome, Sede, Universita, Ufficio) values ('Facolta di Economia', 'Via del Castro Laurenziano 9', 3, 'Piazzale Aldo Moro 5');

Insert into FACOLTA(Nome, Sede, Universita, Ufficio) values ('Facolta di Economia', 'Av de calle', 2, 'Av. Del Hospicio');

-----------------------CORSO
Insert into CORSO(Codice, Nome, Facolta, Universita, Tipologia) values ('E01', 'Economia e Finanza', 'Facoltà di Economia', 1, 'Corso di laurea triennale');

Insert into CORSO(Codice, Nome, Facolta, Universita, Tipologia) values ('E02', 'Economia e Management', 'Facoltà di Economia', 1, 'Corso di laurea triennale');

Insert into CORSO(Codice, Nome, Facolta, Universita, Tipologia) values ('B01', 'Business administration and economics', 'Facoltà di Economia', 2, 'Corso di laurea triennale');

Insert into CORSO(Codice, Nome, Facolta, Universita, Tipologia) values ('MAT02', 'Matematica', 'Facoltà di Scienze Matematiche, Fisiche e Naturali', 1, 'Corso di laurea magistrale');

Insert into CORSO(Codice, Nome, Facolta, Universita, Tipologia) values ('MAT02', 'Matematica', 'Facoltà di Scienze Matematiche, Fisiche e Naturali', 5, 'Corso di laurea magistrale');

Insert into CORSO(Codice, Nome, Facolta, Universita, Tipologia) values ('E01','Economia e Finanza', 'Facoltà di Economia', 3, 'Corso di laurea triennale');

Insert into CORSO(Codice, Nome, Facolta, Universita, Tipologia) values ('INF01','Informatica', 'Facoltà di Ingegneria', 1, 'Corso di laurea triennale');

Insert into CORSO(Codice, Nome, Facolta, Universita, Tipologia) values ('INF01','Informatica', 'Facoltà di Ingegneria', 2, 'Corso di laurea triennale');


-----------------------COLLABORA
Insert into COLLABORA(Corso1, Facolta1, Universita1, Corso2, Facolta2, Universita2, Anno, Posti, Cert, Durata, Livello) values ('MAT02', 'Facoltà di Scienze Matematiche, Fisiche e Naturali', 1, 'MAT02', 'Facoltà di Scienze Matematiche, Fisiche e Naturali', 5, 2019, 2, 'B2 Inglese', 6, 2);

Insert into COLLABORA(Corso1, Facolta1, Universita1, Corso2, Facolta2, Universita2, Anno, Posti, Cert, Durata, Livello) values ('MAT02', 'Facoltà di Scienze Matematiche, Fisiche e Naturali', 1, 'MAT02', 'Facoltà di Scienze Matematiche, Fisiche e Naturali', 5, 2017, 2, 'B2 Inglese', 6, 2);

Insert into COLLABORA(Corso1, Facolta1, Universita1, Corso2, Facolta2, Universita2, Anno, Posti, Cert, Durata, Livello) values ('MAT02', 'Facoltà di Scienze Matematiche, Fisiche e Naturali', 1, 'MAT02', 'Facoltà di Scienze Matematiche, Fisiche e Naturali', 5, 2018, 3, 'B2 Inglese', 12, 2);

Insert into COLLABORA(Corso1, Facolta1, Universita1, Corso2, Facolta2, Universita2, Anno, Posti, Cert, Durata, Livello) values ('B01', 'Facoltà di Economia', 2, 'E01', 'Facoltà di Economia', 3, 2018, 2, 'B2 Inglese', 6, 1);

Insert into COLLABORA(Corso1, Facolta1, Universita1, Corso2, Facolta2, Universita2, Anno, Posti, Cert, Durata, Livello) values ('B01', 'Facoltà di Economia', 2, 'E02', 'Facoltà di Economia', 1, 2019, 2, 'B2 Inglese', 6, 1);

Insert into COLLABORA(Corso1, Facolta1, Universita1, Corso2, Facolta2, Universita2, Anno, Posti, Cert, Durata, Livello) values ('B01', 'Facoltà di Economia', 2, 'E02', 'Facoltà di Economia', 1, 2018, 2, 'B2 Inglese', 3, 1);

Insert into COLLABORA(Corso1, Facolta1, Universita1, Corso2, Facolta2, Universita2, Anno, Posti, Cert, Durata, Livello) values ('E01', 'Facoltà di Economia', 3, 'B01', 'Facoltà di Economia', 2, 2016, 4, 'B2 Inglese', 12, 1);

Insert into COLLABORA(Corso1, Facolta1, Universita1, Corso2, Facolta2, Universita2, Anno, Posti, Cert, Durata, Livello) values ('INF01', 'Facoltà di Ingegneria', 1, 'INF01', 'Facoltà di Ingegneria', 2, 2019, 1, 'B2 Inglese', 6, 1);


-----------------------COMMISSIONE
Insert into COMMISSIONE(ID, Nome , Facolta, Universita) values (1, 'Commissione Economia Erasmus', 'Facoltà di Economia', 1);

Insert into COMMISSIONE(ID, Nome , Facolta, Universita) values (2, 'Commissione Economia Erasmus', 'Facoltà di Economia', 1);

Insert into COMMISSIONE(ID, Nome , Facolta, Universita) values (3, 'Commissione Economia Erasmus', 'Facoltà di Economia', 3);

Insert into COMMISSIONE(ID, Nome , Facolta, Universita) values (4, 'Commissione Economia Erasmus', 'Facoltà di Economia', 2);

Insert into COMMISSIONE(ID, Nome , Facolta, Universita) values (5, 'Commissione Scienze Erasmus', 'Facoltà di Scienze Matematiche, Fisiche e Naturali', 1);

Insert into COMMISSIONE(ID, Nome , Facolta, Universita) values (6, 'Commissione Scienze Erasmus', 'Facoltà di Scienze Matematiche, Fisiche e Naturali', 1);

Insert into COMMISSIONE(ID, Nome , Facolta, Universita) values (7, 'Commissione Ingegneria Erasmus', 'Facoltà di Ingegneria', 1);



-----------------------PROFESSORE
Insert into PROFESSORE(CF, Nome, Cognome, Qualifica, Mail, Facolta, Universita, Commissione) values ('BZDMRA85H16A735M', 'Mario', 'Rossi', 'Ordinario', 'mariorossi@uniroma2.com', 'Facoltà di Economia', '1', 1);

Insert into PROFESSORE(CF, Nome, Cognome, Qualifica, Mail, Facolta, Universita, Commissione) values ('NPCBHL95H15I668S', 'Enzo', 'Ferrari', 'Associato', 'enzoferrarii@uniroma1.com', 'Facoltà di Economia', '3', 3);

Insert into PROFESSORE(CF, Nome, Cognome, Qualifica, Mail, Facolta, Universita, Commissione) values ('VNQPSK48E57Z117B', 'Giuseppe', 'Bianchi', 'Ordinario', 'giuseppebianchi@unigranada.com', 'Facoltà di Economia', '2', 4);

Insert into PROFESSORE(CF, Nome, Cognome, Qualifica, Mail, Facolta, Universita, Commissione) values ('CYNTTB76B23H556Z', 'Andrea', 'Gallo', 'Ordinario', 'andreagallo@uniroma2.com', 'Facoltà di Scienze Matematiche, Fisiche e Naturali', '1', 1);

Insert into PROFESSORE(CF, Nome, Cognome, Qualifica, Mail, Facolta, Universita, Commissione) values ('KMRRRD69S68B303W', 'Matteo', 'Fontana', 'Associato', 'matteofontana@unicopenhagen.com', 'Facoltà di Scienze Matematiche, Fisiche e Naturali', '5', NULL);

Insert into PROFESSORE(CF, Nome, Cognome, Qualifica, Mail, Facolta, Universita, Commissione) values ('ZLONNS41A59F498T', 'Carlo', 'Costa', 'Ordinario', 'carlocosta@unicopenhagen.com', 'Facoltà di Scienze Matematiche, Fisiche e Naturali', '5', NULL);

Insert into PROFESSORE(CF, Nome, Cognome, Qualifica, Mail, Facolta, Universita, Commissione) values ('NMFSCJ61A44B527K', 'Sara', 'Romano', 'Ricercatore', 'sararomano@uniroma2.com', 'Facoltà di Giurisprudenza', '1', NULL);

Insert into PROFESSORE(CF, Nome, Cognome, Qualifica, Mail, Facolta, Universita, Commissione) values ('NQDWLG40A14E405R', 'Fabio', 'Zanzotto', 'Ricercatore', 'fabiozanzotto@unigranada.com', 'Facoltà di Ingegneria', '2', NULL);

Insert into PROFESSORE(CF, Nome, Cognome, Qualifica, Mail, Facolta, Universita, Commissione) values ('SRMNVE77S42E412I', 'Armando', 'Stellato', 'Ricercatore', 'armandostellato@uniroma2.com', 'Facoltà di Ingegneria', '1', 7);

-----------------------MATERIA
Insert into MATERIA(Nome, CFU, Corso, Facolta, Universita) values ('Diritto pubblico', 12, 'E01', 'Facoltà di Economia', 1);

Insert into MATERIA(Nome, CFU, Corso, Facolta, Universita) values ('Analisi 1', 12, 'MAT02', 'Facoltà di Scienze Matematiche, Fisiche e Naturali', 5);

Insert into MATERIA(Nome, CFU, Corso, Facolta, Universita) values ('Analisi 1', 12, 'MAT02', 'Facoltà di Scienze Matematiche, Fisiche e Naturali', 1);

Insert into MATERIA(Nome, CFU, Corso, Facolta, Universita) values ('Geometria', 6, 'MAT02', 'Facoltà di Scienze Matematiche, Fisiche e Naturali', 1);

Insert into MATERIA(Nome, CFU, Corso, Facolta, Universita) values ('Algebra', 9, 'MAT02', 'Facoltà di Scienze Matematiche, Fisiche e Naturali', 5);

Insert into MATERIA(Nome, CFU, Corso, Facolta, Universita) values ('Economia Aziendale', 12, 'E02', 'Facoltà di Economia', 1);

Insert into MATERIA(Nome, CFU, Corso, Facolta, Universita) values ('Macroeconomia', 12, 'E01', 'Facoltà di Economia', 3);

Insert into MATERIA(Nome, CFU, Corso, Facolta, Universita) values ('Microeconomics', 9, 'B01', 'Facoltà di Economia', 2);

Insert into MATERIA(Nome, CFU, Corso, Facolta, Universita) values ('Programmazione Java', 12, 'INF01', 'Facoltà di Ingegneria', 2);

Insert into MATERIA(Nome, CFU, Corso, Facolta, Universita) values ('Basi di Dati', 12, 'INF01', 'Facoltà di Ingegneria', 2);

-----------------------INSEGNA
Insert into INSEGNA(Professore, Materia, Corso, Facolta, Universita, Anno) values ('ZLONNS41A59F498T', 'Analisi 1', 'MAT02', 'Facolta di Scienze Matematiche, Fisiche e Naturali', 5, 2019);

Insert into INSEGNA(Professore, Materia, Corso, Facolta, Universita, Anno) values ('VNQPSK48E57Z117B', 'Microeconomics', 'B01', 'Facolta di Economia', 2, 2019);

Insert into INSEGNA(Professore, Materia, Corso, Facolta, Universita, Anno) values ('NPCBHL95H15I668S', 'Macroeconomia', 'E01', 'Facolta di Economia', 3, 2018);

Insert into INSEGNA(Professore, Materia, Corso, Facolta, Universita, Anno) values ('KMRRRD69S68B303W', 'Algebra', 'MAT02', 'Facolta di Scienze Matematiche, Fisiche e Naturali', 5, 2019);

Insert into INSEGNA(Professore, Materia, Corso, Facolta, Universita, Anno) values ('NPCBHL95H15I668S', 'Macroeconomia', 'E01', 'Facolta di Economia', 3, 2019);

Insert into INSEGNA(Professore, Materia, Corso, Facolta, Universita, Anno) values ('BZDMRA85H16A735M', 'Economia Aziendale', 'E02', 'Facolta di Economia', 1, 2018);

Insert into INSEGNA(Professore, Materia, Corso, Facolta, Universita, Anno) values ('BZDMRA85H16A735M', 'Economia Aziendale', 'E02', 'Facolta di Economia', 1, 2017);

Insert into INSEGNA(Professore, Materia, Corso, Facolta, Universita, Anno) values ('BZDMRA85H16A735M', 'Economia Aziendale', 'E02', 'Facolta di Economia', 1, 2019);

Insert into INSEGNA(Professore, Materia, Corso, Facolta, Universita, Anno) values ('CYNTTB76B23H556Z', 'Geometria', 'MAT02', 'Facolta di Scienze Matematiche, Fisiche e Naturali', 1, 2019);

Insert into INSEGNA(Professore, Materia, Corso, Facolta, Universita, Anno) values ('ZLONNS41A59F498T', 'Analisi 1', 'MAT02', 'Facolta di Scienze Matematiche, Fisiche e Naturali', 5, 2019);

Insert into INSEGNA(Professore, Materia, Corso, Facolta, Universita, Anno) values ('VNQPSK48E57Z117B', 'Microeconomics', 'B01', 'Facolta di Economia', 2, 2019);

Insert into INSEGNA(Professore, Materia, Corso, Facolta, Universita, Anno) values ('NPCBHL95H15I668S', 'Macroeconomia', 'E01', 'Facolta di Economia', 3, 2018);

Insert into INSEGNA(Professore, Materia, Corso, Facolta, Universita, Anno) values ('KMRRRD69S68B303W', 'Algebra', 'MAT02', 'Facolta di Scienze Matematiche, Fisiche e Naturali', 5, 2019);

Insert into INSEGNA(Professore, Materia, Corso, Facolta, Universita, Anno) values ('NPCBHL95H15I668S', 'Macroeconomia', 'E01', 'Facolta di Economia', 3, 2019);

Insert into INSEGNA(Professore, Materia, Corso, Facolta, Universita, Anno) values ('BZDMRA85H16A735M', 'Economia Aziendale', 'E02', 'Facolta di Economia', 1, 2018);

Insert into INSEGNA(Professore, Materia, Corso, Facolta, Universita, Anno) values ('BZDMRA85H16A735M', 'Economia Aziendale', 'E02', 'Facolta di Economia', 1, 2017);

Insert into INSEGNA(Professore, Materia, Corso, Facolta, Universita, Anno) values ('BZDMRA85H16A735M', 'Economia Aziendale', 'E02', 'Facolta di Economia', 1, 2019);

Insert into INSEGNA(Professore, Materia, Corso, Facolta, Universita, Anno) values ('SRMNVE77S42E412I', 'Programmazione Java', 'INF01', 'Facolta di Ingegneria', 2, 2019);



-----------------------LEARNINGAGREEMENT
Insert into LEARNINGAGREEMENT(ID, Corso, Facolta, Universita, DataInizio, DataFine) values (1, 'MAT02', 'Facolta di Scienze Matematiche, Fisiche e Naturali', 5, '2019-09-01', '2020-03-01');

Insert into LEARNINGAGREEMENT(ID, Corso, Facolta, Universita, DataInizio, DataFine) values (2, 'MAT02', 'Facolta di Scienze Matematiche, Fisiche e Naturali', 5, '2019-09-01', '2020-03-01');

Insert into LEARNINGAGREEMENT(ID, Corso, Facolta, Universita, DataInizio, DataFine) values (3, 'E01', 'Facolta di Economia', 3, '2018-09-01', '2019-09-01');

Insert into LEARNINGAGREEMENT(ID, Corso, Facolta, Universita, DataInizio, DataFine) values (3, 'E01', 'Facolta di Economia', 3, '2018-09-01', '2019-09-01');

Insert into LEARNINGAGREEMENT(ID, Corso, Facolta, Universita, DataInizio, DataFine) values (4, 'B01', 'Facolta di Economia', 2, '2018-09-01', '2019-09-01');

Insert into LEARNINGAGREEMENT(ID, Corso, Facolta, Universita, DataInizio, DataFine) values (5, 'E02', 'Facolta di Economia', 1, '2019-09-01', '2020-03-01');

Insert into LEARNINGAGREEMENT(ID, Corso, Facolta, Universita, DataInizio, DataFine) values (6, 'E02', 'Facolta di Economia', 1, '2018-09-01', '2018-12-01');

Insert into LEARNINGAGREEMENT(ID, Corso, Facolta, Universita, DataInizio, DataFine) values (7, 'INF01', 'Facolta di Ingegneria', 2, '2019-08-10', '2020-02-10');



-----------------------GRADUATORIA
Insert into GRADUATORIA(ID, Posizione, Punteggio, Anno, Risultato, LearningAgreement, Alloggio, Commissione) values(1, 1, 100, 2019, 'Vincitore', 1, 'Copenhagen Hostel', 5);

Insert into GRADUATORIA(ID, Posizione, Punteggio, Anno, Risultato, LearningAgreement, Alloggio, Commissione) values(1, 2, 98, 2019, 'Vincitore', 2, 'Copenhagen Hostel', 5);

Insert into GRADUATORIA(ID, Posizione, Punteggio, Anno, Risultato, LearningAgreement, Alloggio, Commissione) values(1, 78, 30, 2019, 'Idoneo', NULL, NULL, 5);

Insert into GRADUATORIA(ID, Posizione, Punteggio, Anno, Risultato, LearningAgreement, Alloggio, Commissione) values(1, 90, 0, 2019, 'Non Idoneo', NULL, NULL, 5);

Insert into GRADUATORIA(ID, Posizione, Punteggio, Anno, Risultato, LearningAgreement, Alloggio, Commissione) values(2, 1, 100, 2018, 'Vincitore', 4, 'Appartamento Granada', 2);

Insert into GRADUATORIA(ID, Posizione, Punteggio, Anno, Risultato, LearningAgreement, Alloggio, Commissione) values(2, 2, 99, 2018, 'Vincitore', 3, 'Appartamento Granada', 2);

Insert into GRADUATORIA(ID, Posizione, Punteggio, Anno, Risultato, LearningAgreement, Alloggio, Commissione) values(3, 1, 90, 2019, 'Vincitore', 7, 'Appartamento Granada', 7);

Insert into GRADUATORIA(ID, Posizione, Punteggio, Anno, Risultato, LearningAgreement, Alloggio, Commissione) values(4, 1, 95, 2018, 'Vincitore', 3, 'Stanze Monteverde', 4);


-----------------------STUDENTE
Insert into STUDENTE(CF, Matricola, Nome, Cognome, Data, Mail, Isee, CertLing, Media, Anno, Corso, Facolta, Universita, Erasmus, PosizioneErasmus) values ('CCCNDR98P07H501O', '0252497', 'Andrea', 'Ciccotti', '1998-09-07', 'ciccoandrea.98@gmail.com', 30000, 'B2 inglese', 25.60, 2, 'MAT02', 'Facolta di Scienze Matematiche, Fisiche e Naturali', 1, 1, 2);

Insert into STUDENTE(CF, Matricola, Nome, Cognome, Data, Mail, Isee, CertLing, Media, Anno, Corso, Facolta, Universita, Erasmus, PosizioneErasmus) values ('RCGTJJ43A45D208B', '0272400', 'Roberta', 'Trovato', '1997-01-17', 'robertatrovato@gmail.com', 17000, 'C1 inglese', 29, 3, 'MAT02', 'Facolta di Scienze Matematiche, Fisiche e Naturali', 1, NULL, NULL);

Insert into STUDENTE(CF, Matricola, Nome, Cognome, Data, Mail, Isee, CertLing, Media, Anno, Corso, Facolta, Universita, Erasmus, PosizioneErasmus) values ('GYKGTS62B64F543K', '0242411', 'Giorgio', 'Crisci', '1997-07-9', 'giorgiocrisci@gmail.com', 60000, 'C1 inglese', 30, 2, 'E01', 'Facolta di Economia', 1, 2, 1);

Insert into STUDENTE(CF, Matricola, Nome, Cognome, Data, Mail, Isee, CertLing, Media, Anno, Corso, Facolta, Universita, Erasmus, PosizioneErasmus) values ('TQNBXE29E24L217S', '0222110', 'Flavia', 'Tomao', '1999-12-25', 'flaviatomao@gmail.com', 27456, 'B2 Inglese', 28.9, 3, 'B01', 'Facolta di Economia', 2, 4, 1);

Insert into STUDENTE(CF, Matricola, Nome, Cognome, Data, Mail, Isee, CertLing, Media, Anno, Corso, Facolta, Universita, Erasmus, PosizioneErasmus) values ('HPGPDJ73M63D677P', '0252399', 'Francesco', 'Frusone', '1999-08-11', 'francescofrusone@gmail.com', 10000, NULL, 21.9, 1, 'MAT02', 'Facolta di Scienze Matematiche, Fisiche e Naturali', 1, 1, 78);

Insert into STUDENTE(CF, Matricola, Nome, Cognome, Data, Mail, Isee, CertLing, Media, Anno, Corso, Facolta, Universita, Erasmus, PosizioneErasmus) values ('WKIBRT80R19H072S', '0213456', 'Martina', 'Tittarelli', '1996-02-24', 'martinatittarelli@gmail.com', 23456, NULL, 18, 2, 'MAT02', 'Facolta di Scienze Matematiche, Fisiche e Naturali', 1, 1, 90);

Insert into STUDENTE(CF, Matricola, Nome, Cognome, Data, Mail, Isee, CertLing, Media, Anno, Corso, Facolta, Universita, Erasmus, PosizioneErasmus) values ('BHTYFZ94L13H643X', '0252525', 'Alessio', 'Frassanito', '1998-07-04', 'alessiofrassanito@gmail.com', 15000, 'B2 Inglese', 26, 2, 'INF01', 'Facolta di Ingegneria', 1, 3, 1);


-----------------------ESAME
Insert into ESAME(Materia, Corso, Facolta, Universita, LearningAgreement, Studente, Voto, Data) values ('Algebra', 'MAT02', 'Facolta di Scienze Matematiche, Fisiche e Naturali', 5, 1, 'CCCNDR98P07H501O', 30, '2019-10-07');

Insert into ESAME(Materia, Corso, Facolta, Universita, LearningAgreement, Studente, Voto, Data) values ('Analisi 1', 'MAT02', 'Facolta di Scienze Matematiche, Fisiche e Naturali', 5, 1, 'CCCNDR98P07H501O', 16, '2019-11-07');

Insert into ESAME(Materia, Corso, Facolta, Universita, LearningAgreement, Studente, Voto, Data) values ('Analisi 1', 'MAT02', 'Facolta di Scienze Matematiche, Fisiche e Naturali', 5, 1, 'CCCNDR98P07H501O', 26, '2019-12-07');

Insert into ESAME(Materia, Corso, Facolta, Universita, LearningAgreement, Studente, Voto, Data) values ('Macroeconomia', 'E01', 'Facolta di Economia', 3, 3, 'GYKGTS62B64F543K', 29, '2019-12-07');

Insert into ESAME(Materia, Corso, Facolta, Universita, LearningAgreement, Studente, Voto, Data) values ('Programmazione Java', 'INF01', 'Facolta di Ingegneria', 2, 7, 'BHTYFZ94L13H643X', 28, '2020-01-11');

Insert into ESAME(Materia, Corso, Facolta, Universita, LearningAgreement, Studente, Voto, Data) values ('Macroeconomia', 'E01', 'Facolta di Economia', 3, 3, 'TQNBXE29E24L217S', 16, '2019-01-05');

/* Query */

/* 1)Selezionare le Nazioni con contributo mensile > 250; */
Select Nome, Contributo as ContributoMensile from NAZIONE where Contributo > 250;

/* 2)Selezionare gli studenti che hanno il cognome che inizia per 'C'. */
Select * from STUDENTE where Cognome like 'C%';

/* 3)Selezionare tutti gli studenti che hanno partecipato al progetto Erasmus. */
Select * from STUDENTE where Erasmus is not NULL;

/* 4)Indicare quali sono gli studenti dell'Università di Roma Tor Vergata ad aver partecipato al progetto Erasmus risultandone vincitori. */
Select STUDENTE.Nome, STUDENTE.Cognome, STUDENTE.Universita, STUDENTE.Erasmus, STUDENTE.PosizioneErasmus from STUDENTE,UNIVERSITA,GRADUATORIA where STUDENTE.Universita = UNIVERSITA. Unicode and GRADUATORIA.ID = STUDENTE.Erasmus and GRADUATORIA.Posizione = STUDENTE.PosizioneErasmus and GRADUATORIA.Risultato = 'Vincitore' and UNIVERSITA.Nome = 'Università di Roma Tor Vergata';

/* 5)Selezionare la media dei voti minima tra gli studenti iscritti al secondo anno del corso di Matematica dell'Università di Roma Tor Vergata. */
Select min(STUDENTE.Media) from STUDENTE, UNIVERSITA, CORSO where CORSO.Universita = UNIVERSITA.Unicode and UNIVERSITA.Nome = 'Università di Roma Tor Vergata' and CORSO.Nome = 'Matematica' and CORSO.Codice = STUDENTE.Corso and STUDENTE.Anno = 2;

/* 6)Selezionare il responsabile dell'ufficio Erasmus della Facolta di Scienze Matematiche, Fisiche e Naturali dell'università di Roma Tor Vergata con il relativo orario di apertura dell'ufficio. */
Select RESPONSABILE.Nome, RESPONSABILE.Cognome, UFFICIO.Sede, UFFICIO.OrarioA, UFFICIO.OrarioC from RESPONSABILE, UFFICIO, FACOLTA, UNIVERSITA where UNIVERSITA.Unicode = FACOLTA.Universita and FACOLTA.Ufficio = UFFICIO.Sede and RESPONSABILE.Ufficio = UFFICIO.Sede and UNIVERSITA.Nome = 'Università di Roma Tor Vergata' and FACOLTA.Nome = 'Facoltà di Scienze Matematiche, Fisiche e Naturali';

/* 7)Selezionare la media dei Punteggi della Graduatoria con ID = 1. */
Select avg(Punteggio) as MediaPunteggio from GRADUATORIA where GRADUATORIA.ID = 1;

/* 8)Il numero di Studenti che hanno partecipato all'Erasmus per ogni Università. */
Select count(STUDENTE.CF) as NumeroStudenti, UNIVERSITA.Nome from STUDENTE, GRADUATORIA, UNIVERSITA where GRADUATORIA.ID = STUDENTE.Erasmus and GRADUATORIA.Posizione = STUDENTE.PosizioneErasmus and STUDENTE.Universita = UNIVERSITA.Unicode and GRADUATORIA.Risultato = 'Vincitore' group by STUDENTE.Universita;

/* 9)Indicare il professore con la relativa mail e qualifica che insegna la materia 'Programmazione Java' all'università di Granada nel 2019 indicando quanti CFU ha la materia. */
Select PROFESSORE.Nome, PROFESSORE.Cognome, PROFESSORE.Mail, PROFESSORE.Qualifica, MATERIA.Nome as Materia, MATERIA.CFU from PROFESSORE, MATERIA, INSEGNA, UNIVERSITA where PROFESSORE.Universita = UNIVERSITA.Unicode and PROFESSORE.CF = INSEGNA.Professore and MATERIA.Nome = INSEGNA.Materia and UNIVERSITA.Nome = 'Università di Granada' and MATERIA.Nome = 'Programmazione Java' and INSEGNA.Anno = 2019;

/* 10)Indicare quali professori hanno fatto parte della Commissione Economia Erasmus dell'Università di Roma Tor Vergata */
Select PROFESSORE.Nome, PROFESSORE.Cognome from PROFESSORE, UNIVERSITA, COMMISSIONE where COMMISSIONE.Universita = UNIVERSITA.Unicode and UNIVERSITA.Nome = 'Università di Roma Tor Vergata' and COMMISSIONE.Nome = 'Commissione Economia Erasmus' and PROFESSORE.Commissione = COMMISSIONE.ID;

/* 11)Indicare quali esami con voto e data ha sostenuto lo studente Andrea Ciccotti in Erasmus ordinandoli per data */
Select ESAME.Materia, ESAME.Voto, ESAME.Data from STUDENTE, ESAME where ESAME.Studente = STUDENTE.CF and STUDENTE.Nome = 'Andrea' and STUDENTE.Cognome = 'Ciccotti' order by (ESAME.Data);

/* 12)Come la precedente solo che questa volta si vogliono indicare solo gli esami superati */
Select ESAME.Materia, ESAME.Voto, ESAME.Data from STUDENTE, ESAME where ESAME.Studente = STUDENTE.CF and STUDENTE.Nome = 'Andrea' and STUDENTE.Cognome = 'Ciccotti' and ESAME.Voto > 17 order by (ESAME.Data);

/* 13)Indicare dove è andato, in che periodo e in quale alloggio ha soggiornato Andrea Ciccotti in Erasmus */
Select STUDENTE.Nome, STUDENTE.Cognome, CORSO.Nome as Corso, CORSO.FACOLTA as Facoltà, UNIVERSITA.Nome as Università,  LEARNINGAGREEMENT.DataInizio, LEARNINGAGREEMENT.DataFine, GRADUATORIA.Alloggio from CORSO, FACOLTA, UNIVERSITA, LEARNINGAGREEMENT, GRADUATORIA, STUDENTE where GRADUATORIA.ID = STUDENTE.Erasmus and GRADUATORIA.Posizione = STUDENTE.PosizioneErasmus and GRADUATORIA.LearningAgreement = LEARNINGAGREEMENT.ID and LEARNINGAGREEMENT.Corso = CORSO.Codice and LEARNINGAGREEMENT.Facolta = FACOLTA.Nome and LEARNINGAGREEMENT.Universita = UNIVERSITA.Unicode and CORSO.Facolta = FACOLTA.Nome and CORSO.Universita = UNIVERSITA.Unicode and FACOLTA.Universita = UNIVERSITA.Unicode and STUDENTE.Nome = 'Andrea' and STUDENTE.Cognome = 'Ciccotti';

/* 14)Selezionare tutti gli studenti che sono iscritti allo stesso corso dello Studente con CF = ' CCCNDR98P07H501O' */
Select A.CF, A.Nome, A.Cognome from STUDENTE as A, STUDENTE as B where B.CF = 'CCCNDR98P07H501O' and B.Corso = A.Corso and A.CF != 'CCCNDR98P07H501O';

/* 15)Selezionare tutti i professori che hanno la stessa qualifica di Mario Rossi e lavorano per la stessa università. */
Select A.CF, A.Nome, A.Cognome from PROFESSORE as A, PROFESSORE as B where B.Nome = 'Mario' and B.Cognome = 'Rossi' and B.Qualifica = A.Qualifica and B.Universita = A.Universita;

/* 16)Selezionare la media degli affitti degli alloggi per ogni nazione */
Select avg(Affitto) as MediaAffitto, Nazione from ALLOGGIO group by Nazione;

/* 17)Contare i corsi per ogni università con il totale finale */
Select count(CORSO.Codice) as NumeroCorsiErogati, coalesce(CORSO.Universita, 'Totale Corsi') as Università from CORSO, UNIVERSITA where CORSO.Universita = UNIVERSITA.Unicode group by CORSO.Universita with rollup;

/* 18)Selezionare le collaborazioni Erasmus che l'Università di Roma Tor Vergata ha fatto sia in entrata che in uscita con altre Università prendendo in considerazione una sola volta le collaborazioni uguali. */
Select distinct Corso1, CORSO1.Nome, UNI1.Nome as Università1, Corso2, CORSO2.Nome, UNI2.Nome as Università2 from COLLABORA, UNIVERSITA as UNI1, UNIVERSITA as UNI2, CORSO as CORSO1, CORSO as CORSO2 where COLLABORA.Universita1 = UNI1.Unicode and COLLABORA.Universita2 = UNI2.Unicode and COLLABORA.Corso1 = CORSO1.Codice and COLLABORA.Corso2 = CORSO2.COdice and  CORSO1.Universita = UNI1.Unicode and CORSO2.Universita = UNI2.Unicode and  (UNI1.Nome = 'Università di Roma Tor Vergata' or UNI2.Nome = 'Università di Roma Tor Vergata');

/* 19)Selezionare le collaborazioni Erasmus di livello 1 che ci sono state tra le varie università nel 2019 */
Select Corso1, CORSO1.Nome, UNI1.Nome as Università1, Corso2, CORSO2.Nome, UNI2.Nome as Università2 from COLLABORA, UNIVERSITA as UNI1, UNIVERSITA as UNI2, CORSO as CORSO1, CORSO as CORSO2 where COLLABORA.Universita1 = UNI1.Unicode and COLLABORA.Universita2 = UNI2.Unicode and COLLABORA.Corso1 = CORSO1.Codice and COLLABORA.Corso2 = CORSO2.COdice and  CORSO1.Universita = UNI1.Unicode and CORSO2.Universita = UNI2.Unicode and COLLABORA.Anno = 2019 and COLLABORA.Livello = 1;


/* 20)Selezionare per ogni Università quante volte è stata scelta dagli studenti Erasmus */
Select UNIVERSITA.Nome, count(LEARNINGAGREEMENT.Universita) as NumeroVolteScelta from UNIVERSITA, STUDENTE, LEARNINGAGREEMENT, GRADUATORIA where STUDENTE.Erasmus = GRADUATORIA.ID and STUDENTE.PosizioneErasmus = GRADUATORIA.Posizione and GRADUATORIA.LearningAgreement = LEARNINGAGREEMENT.ID and LEARNINGAGREEMENT.Universita = UNIVERSITA.Unicode group by (UNIVERSITA.Unicode);


/* 21)Il numero di studenti che hanno fatto domanda per partecipare al bando Erasmus tra il 2016 e il 2018 */
Select count(STUDENTE.CF) as NumeroStudenti from STUDENTE,GRADUATORIA where STUDENTE.Erasmus = GRADUATORIA.ID and STUDENTE.PosizioneErasmus = GRADUATORIA.Posizione and GRADUATORIA.Anno between 2016 and 2018;

/* 22)Indicare quali sono gli studenti ad aver superato almeno 1 esame in Erasmus */
Select count(ESAME.Materia) as NumeroEsamiSuperati ,STUDENTE.CF, STUDENTE.Nome, STUDENTE.Cognome from ESAME, STUDENTE where STUDENTE.CF = ESAME.Studente and ESAME.Voto > 17 group by STUDENTE.CF having NumeroEsamiSuperati >= 1;
