
mkdir -p "/logs"

while true; do
    USO_RAM=$(free | awk 'NR==2 {printf "%.0f", $3/$2 * 100}')
    
    if [ "$USO_RAM" -gt 70 ]; then
        ARCHIVO_LOG="$DIR_LOG/ram_alert_$(date +"%Y%m%d_%H%M%S").log"
        
        echo "Fecha: $(date)" > "$ARCHIVO_LOG"
        echo "Uso RAM: $USO_RAM%" >> "$ARCHIVO_LOG"
        echo "" >> "$ARCHIVO_LOG"
        echo "Procesos:" >> "$ARCHIVO_LOG"
        ps aux --sort=-%mem | head -6 >> "$ARCHIVO_LOG"
        
        echo "Log creado: $ARCHIVO_LOG"
    fi
    
    sleep 10
done