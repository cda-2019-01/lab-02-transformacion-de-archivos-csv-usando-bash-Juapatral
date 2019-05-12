mkdir resultados
csvstack -d ";" --filenames --group-name ESTACION estaciones/est*.csv > consolidado.csv
sed -e 's/.csv//' -e 's/,/./5' -e 's/\"//g' consolidado.csv > consolidado2.csv
rm consolidado.csv

# velocidad por mes

sed 's/\([0-9]*\)\/\([0-9][0-9]\)\/\([0-9][0-9]\)/\2/' consolidado2.csv > prepmes.csv
#head prepmes.csv > pruebames.csv
#csvsql --query 'select ESTACION,FECHA as MES,avg(VEL) as VEL from pruebames group by ESTACION,MES' pruebames.csv > resultados/pruebavelocidadm.csv
csvsql --query 'select ESTACION,FECHA as MES,avg(VEL) as VEL from prepmes group by ESTACION,MES' prepmes.csv > resultados/velocidad-por-mes.csv
rm prepmes.csv
#rm prueba*.csv

# velocidad por año

sed 's/\([0-9]*\)\/\([0-9][0-9]\)\/\([0-9][0-9]\)/\3/' consolidado2.csv > prepanio.csv
#head prepanio.csv > pruebaanio.csv
#csvsql --query 'select ESTACION,FECHA as ANIO,avg(VEL) as VEL from pruebaanio group by ESTACION,ANIO' pruebaanio.csv > resultados/pruebavelocidada.csv
csvsql --query 'select ESTACION,FECHA as ANIO,avg(VEL) as VEL from prepanio group by ESTACION,ANIO' prepanio.csv > resultados/velocidad-por-ano.csv
rm prepanio.csv
#rm prueba*.csv


# velocidad por hora

sed 's/\([0-9]*\):\([0-9][0-9]\):\([0-9][0-9]\)/\1/' consolidado2.csv > prephora.csv
#head prephora.csv > pruebahora.csv
#csvsql --query 'select ESTACION,HHMMSS as HORA,avg(VEL) as VEL from pruebahora group by ESTACION,HORA' pruebahora.csv > resultados/pruebavelocidadh.csv
csvsql --query 'select ESTACION,HHMMSS as HORA,avg(VEL) as VEL from prephora group by ESTACION,HORA' prephora.csv > resultados/velocidad-por-hora.csv
rm prephora.csv
#rm prueba*.csv

rm consolidado2.csv
mv resultados $(echo resultados-$(date -I))


