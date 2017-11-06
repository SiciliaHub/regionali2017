#!/bin/bash

set -x

mkdir -p ./dati

curl "http://www.elezioni.regione.sicilia.it//rep_5/Messina/votiCandidatiProvinciaME.html" > ./dati/votiCandidatiProvinciaME.html

<./dati/votiCandidatiProvinciaME.html pup "body > div:nth-child(1) > table:nth-child(2)  > tbody > tr:nth-child(2) > td:nth-child(3) > table > tbody > tr:nth-child(2) > td > p:nth-child(6)" | scrape -be "//table//tr[position() > 2 and position() < last()]" | sed 's/<br\/>/ /g ; s/  / /g' | xml2json | sed 's/\\n   \\n   / /g' | jq '[.html.body.tr[] | {lista:"1",numero:.td[0]."$t",nome:.td[1]."$t",anagrafica:.td[2]."$t",preferenze:.td[3]."$t"|gsub("\\."; "")}]' | in2csv -f json > ./dati/L1.csv

<./dati/votiCandidatiProvinciaME.html pup "body > div:nth-child(1) > table:nth-child(2)  > tbody > tr:nth-child(2) > td:nth-child(3) > table > tbody > tr:nth-child(2) > td > p:nth-child(10)" | scrape -be "//table//tr[position() > 2 and position() < last()]" | sed 's/<br\/>/ /g ; s/  / /g' | xml2json | sed 's/\\n   \\n   / /g' | jq '[.html.body.tr[] | {lista:"2",numero:.td[0]."$t",nome:.td[1]."$t",anagrafica:.td[2]."$t",preferenze:.td[3]."$t"|gsub("\\."; "")}]' | in2csv -f json > ./dati/L2.csv

<./dati/votiCandidatiProvinciaME.html pup "body > div:nth-child(1) > table:nth-child(2)  > tbody > tr:nth-child(2) > td:nth-child(3) > table > tbody > tr:nth-child(2) > td > p:nth-child(14)" | scrape -be "//table//tr[position() > 2 and position() < last()]" | sed 's/<br\/>/ /g ; s/  / /g' | xml2json | sed 's/\\n   \\n   / /g' | jq '[.html.body.tr[] | {lista:"3",numero:.td[0]."$t",nome:.td[1]."$t",anagrafica:.td[2]."$t",preferenze:.td[3]."$t"|gsub("\\."; "")}]' | in2csv -f json > ./dati/L3.csv

<./dati/votiCandidatiProvinciaME.html pup "body > div:nth-child(1) > table:nth-child(2)  > tbody > tr:nth-child(2) > td:nth-child(3) > table > tbody > tr:nth-child(2) > td > p:nth-child(18)" | scrape -be "//table//tr[position() > 2 and position() < last()]" | sed 's/<br\/>/ /g ; s/  / /g' | xml2json | sed 's/\\n   \\n   / /g' | jq '[.html.body.tr[] | {lista:"4",numero:.td[0]."$t",nome:.td[1]."$t",anagrafica:.td[2]."$t",preferenze:.td[3]."$t"|gsub("\\."; "")}]' | in2csv -f json > ./dati/L4.csv

<./dati/votiCandidatiProvinciaME.html pup "body > div:nth-child(1) > table:nth-child(2)  > tbody > tr:nth-child(2) > td:nth-child(3) > table > tbody > tr:nth-child(2) > td > p:nth-child(22)" | scrape -be "//table//tr[position() > 2 and position() < last()]" | sed 's/<br\/>/ /g ; s/  / /g' | xml2json | sed 's/\\n   \\n   / /g' | jq '[.html.body.tr[] | {lista:"5",numero:.td[0]."$t",nome:.td[1]."$t",anagrafica:.td[2]."$t",preferenze:.td[3]."$t"|gsub("\\."; "")}]' | in2csv -f json > ./dati/L5.csv

<./dati/votiCandidatiProvinciaME.html pup "body > div:nth-child(1) > table:nth-child(2)  > tbody > tr:nth-child(2) > td:nth-child(3) > table > tbody > tr:nth-child(2) > td > p:nth-child(26)" | scrape -be "//table//tr[position() > 2 and position() < last()]" | sed 's/<br\/>/ /g ; s/  / /g' | xml2json | sed 's/\\n   \\n   / /g' | jq '[.html.body.tr[] | {lista:"6",numero:.td[0]."$t",nome:.td[1]."$t",anagrafica:.td[2]."$t",preferenze:.td[3]."$t"|gsub("\\."; "")}]' | in2csv -f json > ./dati/L6.csv

<./dati/votiCandidatiProvinciaME.html pup "body > div:nth-child(1) > table:nth-child(2)  > tbody > tr:nth-child(2) > td:nth-child(3) > table > tbody > tr:nth-child(2) > td > p:nth-child(30)" | scrape -be "//table//tr[position() > 2 and position() < last()]" | sed 's/<br\/>/ /g ; s/  / /g' | xml2json | sed 's/\\n   \\n   / /g' | jq '[.html.body.tr[] | {lista:"7",numero:.td[0]."$t",nome:.td[1]."$t",anagrafica:.td[2]."$t",preferenze:.td[3]."$t"|gsub("\\."; "")}]' | in2csv -f json > ./dati/L7.csv

<./dati/votiCandidatiProvinciaME.html pup "body > div:nth-child(1) > table:nth-child(2)  > tbody > tr:nth-child(2) > td:nth-child(3) > table > tbody > tr:nth-child(2) > td > p:nth-child(34)" | scrape -be "//table//tr[position() > 2 and position() < last()]" | sed 's/<br\/>/ /g ; s/  / /g' | xml2json | sed 's/\\n   \\n   / /g' | jq '[.html.body.tr[] | {lista:"8",numero:.td[0]."$t",nome:.td[1]."$t",anagrafica:.td[2]."$t",preferenze:.td[3]."$t"|gsub("\\."; "")}]' | in2csv -f json > ./dati/L8.csv

<./dati/votiCandidatiProvinciaME.html pup "body > div:nth-child(1) > table:nth-child(2)  > tbody > tr:nth-child(2) > td:nth-child(3) > table > tbody > tr:nth-child(2) > td > p:nth-child(38)" | scrape -be "//table//tr[position() > 2 and position() < last()]" | sed 's/<br\/>/ /g ; s/  / /g' | xml2json | sed 's/\\n   \\n   / /g' | jq '[.html.body.tr[] | {lista:"9",numero:.td[0]."$t",nome:.td[1]."$t",anagrafica:.td[2]."$t",preferenze:.td[3]."$t"|gsub("\\."; "")}]' | in2csv -f json > ./dati/L9.csv

<./dati/votiCandidatiProvinciaME.html pup "body > div:nth-child(1) > table:nth-child(2)  > tbody > tr:nth-child(2) > td:nth-child(3) > table > tbody > tr:nth-child(2) > td > p:nth-child(42)" | scrape -be "//table//tr[position() > 2 and position() < last()]" | sed 's/<br\/>/ /g ; s/  / /g' | xml2json | sed 's/\\n   \\n   / /g' | jq '[.html.body.tr[] | {lista:"10",numero:.td[0]."$t",nome:.td[1]."$t",anagrafica:.td[2]."$t",preferenze:.td[3]."$t"|gsub("\\."; "")}]' | in2csv -f json > ./dati/L10.csv

<./dati/votiCandidatiProvinciaME.html pup "body > div:nth-child(1) > table:nth-child(2)  > tbody > tr:nth-child(2) > td:nth-child(3) > table > tbody > tr:nth-child(2) > td > p:nth-child(46)" | scrape -be "//table//tr[position() > 2 and position() < last()]" | sed 's/<br\/>/ /g ; s/  / /g' | xml2json | sed 's/\\n   \\n   / /g' | jq '[.html.body.tr[] | {lista:"11",numero:.td[0]."$t",nome:.td[1]."$t",anagrafica:.td[2]."$t",preferenze:.td[3]."$t"|gsub("\\."; "")}]' | in2csv -f json > ./dati/L11.csv

csvstack ./dati/*.csv > ./dati/listeProvncialiMessina.csv

rm ./dati/L*.csv
