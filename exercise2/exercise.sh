
mkdir -p "./logs"

touch "./logs/log.txt"

while true; do
    USE_RAM=$(free | awk 'NR==2 {printf "%.0f", $3/$2 * 100}')
    
    if [ "$USE_RAM" -gt 10 ]; then
        FILE_LOG="./log.txt"
        echo "Fecha: $(date)" > "$FILE_LOG"
        echo "Uso RAM: $USE_RAM%" >> "$FILE_LOG"
        echo "" >> "$FILE_LOG"
        echo "Procesos:" >> "$FILE_LOG"
        ps aux --sort=-%mem | head -6 >> "$FILE_LOG"
        
        echo "Log creado: $FILE_LOG"
    fi
    
    sleep 10
done
