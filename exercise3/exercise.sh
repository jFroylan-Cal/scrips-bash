#!/bin/bash

while true; do
    echo "=== MENÚ DE MONITOREO DE PROCESOS ==="
    echo "1. Mostrar todos los procesos en ejecución"
    echo "2. Buscar un proceso por nombre"
    echo "3. Finalizar un proceso por nombre"
    echo "4. Salir"
    echo -n "Seleccione una opción (1-4): "
    read opcion

    case $opcion in
        1)
            echo "Procesos en ejecución:"
            ps aux
            ;;
        2)
            echo -n "Ingrese el nombre del proceso a buscar: "
            read proceso
            if [ -n "$proceso" ]; then
                ps aux | grep -i "$proceso" | grep -v grep
            else
                echo "No ingresó un nombre válido."
            fi
            ;;
        3)
            echo -n "Ingrese el nombre del proceso a finalizar: "
            read proceso
            if [ -n "$proceso" ]; then
                pids=$(ps aux | grep -i "$proceso" | grep -v grep | awk '{print $2}')
                if [ -z "$pids" ]; then
                    echo "No se encontró el proceso '$proceso'."
                else
                    for pid in $pids; do
                        kill -9 "$pid" 2>/dev/null
                        if [ $? -eq 0 ]; then
                            echo "Proceso $pid finalizado."
                        else
                            echo "No se pudo finalizar el proceso $pid."
                        fi
                    done
                fi
            else
                echo "No ingresó un nombre válido."
            fi
            ;;
        4)
            echo "Saliendo..."
            exit 0
            ;;
        *)
            echo "Opción no válida. Intente nuevamente."
            ;;
    esac
    echo ""
done