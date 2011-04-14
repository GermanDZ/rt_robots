<?php
$estados = str_split($argv[1]);
$jugada = null;
do {
    $posicion = rand(0,8);
    $estado = $estados[$posicion];
    if ($estado == '-') {
        $jugada = $posicion;
    }
} while ($jugada === null);
echo $jugada;
exit(0);
?> 