# Intro

In questo **repository** alcuni dati sulle elezioni regionali siciliane del 5 novembre 2017; al momento **soltanto i dati di affluenza**.

Le fonti di dati principali sono:

- il sito regionale ufficiale [http://www.elezioni.regione.sicilia.it/home.html](http://www.elezioni.regione.sicilia.it/home.html);
- la sezione opendata del comune di Palermo [https://www.comune.palermo.it/opendata_menus.php](https://www.comune.palermo.it/opendata_menus.php).

## Note sui dati del sito regionale

Sul sito regionale non vengono pubblicati dati, ma tabelle HTML. È stato creato uno [script bash](https://github.com/SiciliaHub/regionali2017/blob/master/regione/regione.sh) che le trasforma in file `CSV`. La tabella di sotto viene ad esempio trasformata in [questo file CSV](https://github.com/SiciliaHub/regionali2017/blob/master/regione/dati/affluenza12.csv).

![](https://i.imgur.com/cioPPj5.png)

Nella cartella [dati](https://github.com/SiciliaHub/regionali2017/tree/master/regione/dati) verranno pubblicati i dati sulle affluenze provinciali e per ogni provincia i dati comunali. Secondo gli orari previsti che sono le `12:00`, le `19:00` e le `22:00`.

## Note sui dati del sito del comune di Palermo

Quelli del comune di Palermo, invece **sono dati** ([qui](https://www.comune.palermo.it/js/server/uploads/opendata/MetaDatiElezioniRegionali2017.pdf) un file che li descrive)! 

Sono pubblicati in formato `XML` ed è stato creato uno [script bash](https://github.com/SiciliaHub/regionali2017/blob/master/palermo/palermo.sh) che li trasforma (questo è il caso dell'affluenza) da

```XML
<SV NUMERO="1" NOME="SEZIONE 1" NOMEBREVE="SEZ. 1" UBICAZIONE="SCUOLA DELL'INFANZIA"MADRE TERESA DI C." VIA MAQUEDA N.53" NUM_ZONA="111" NUM_ZONA2="244" TOTVOT="126" TOTVOTM="0" TOTVOTF="0" FLZEROVOT="N" ELETTORI="1100" ELETTORIM="557" ELETTORIF="543" CONFERMATO="N" SEZIONI="" SEZSCR=""/>
<SV NUMERO="2" NOME="SEZIONE 2" NOMEBREVE="SEZ. 2" UBICAZIONE="SCUOLA PRIMARIA "MANZONI" VIA PARLATORE FILIPPO N.56" NUM_ZONA="112" NUM_ZONA2="244" TOTVOT="105" TOTVOTM="0" TOTVOTF="0" FLZEROVOT="N" ELETTORI="697" ELETTORIM="322" ELETTORIF="375" CONFERMATO="N" SEZIONI="" SEZSCR=""/>
<SV NUMERO="3" NOME="SEZIONE 3" NOMEBREVE="SEZ. 3" UBICAZIONE="SCUOLA PRIM.E DELL'INF."CASTELLANA" VIA CASTELLANA N.40" NUM_ZONA="113" NUM_ZONA2="244" TOTVOT="111" TOTVOTM="0" TOTVOTF="0" FLZEROVOT="N" ELETTORI="926" ELETTORIM="448" ELETTORIF="478" CONFERMATO="N" SEZIONI="" SEZSCR=""/>
```

a `CSV` (vedi [file di esempio](https://github.com/SiciliaHub/regionali2017/blob/master/palermo/dati/palermoAffluenza12.csv)).

Nella cartella [dati](https://github.com/SiciliaHub/regionali2017/tree/master/palermo/dati) verranno pubblicati i dati di affluenza per sezione, secondo gli orari previsti (sempre le `12:00`, le `19:00` e le `22:00`).