#!/bin/bash

# Função para validar se o valor inserido foi um numero
function check_is_number {
  re='^[0-9]+$' # REGEX (Expressão regular), forma utilizada para tratar e construir texto

  # =~ é um operador utilizado com regex para validar um texto com base no regex
  if ! [[ $1 =~ $re ]]; then
    return 1
  fi 

  return 0
}

function get_media {
    notas=$1
    sum_nota=0

    for nota in "${notas[@]}"
    do
        sum_nota=$(($sum_nota + $nota))
    done

    return $(( $sum_nota / ${#notas[@]} ))
}

notas=()

contador=0
while [ $contador -lt 4 ]
do
    read -p "Insira a $(($contador + 1)) º nota: " nota

    check_is_number $nota
    if [[ $? -ne 0 ]]; then
      echo "Nota precisa ser um inteiro"
      continue
    fi
    
    notas[$contador]=$nota 
    contador=$(( $contador + 1 ))
done

get_media $notas
media=$?

echo $media

if [ $media -ge 7 ]; then
    echo "Aprovado"
elif [[ $media -ge 5 && $media < 7 ]]; then
    echo "Recuperação"
else
    echo "Reprovado"
fi

