#!/bin/bash

# Función para mostrar el menú
mostrar_menu() {
    echo "======================================"
    echo "    ENCRIPTADOR/DESENCRIPTADOR GPG    "
    echo "======================================"
    echo "1. Encriptar archivo"
    echo "2. Desencriptar archivo"
    echo "3. Salir"
    echo "======================================"
}

# Función para encriptar archivo
encriptar_archivo() {
    echo ""
    echo "--- ENCRIPTAR ARCHIVO ---"
    
    # Capturar nombre del archivo
    read -p "Ingrese el nombre del archivo a encriptar: " archivo
    
    # Verificar si el archivo existe
    if [ ! -f "$archivo" ]; then
        echo "Error: El archivo '$archivo' no existe."
        return 1
    fi
    
    # Capturar contraseña
    read -sp "Ingrese la contraseña para encriptar: " password
    echo ""
    
    # Encriptar con gpg
    if echo "$password" | gpg --batch --yes --passphrase-fd 0 --symmetric --cipher-algo AES256 -o "${archivo}.gpg" "$archivo" 2>/dev/null; then
        echo "✓ Archivo encriptado correctamente como: ${archivo}.gpg"
    else
        echo "✗ Error al encriptar el archivo."
        return 1
    fi
}

# Función para desencriptar archivo
desencriptar_archivo() {
    echo ""
    echo "--- DESENCRIPTAR ARCHIVO ---"
    
    # Capturar nombre del archivo
    read -p "Ingrese el nombre del archivo a desencriptar (con extensión .gpg): " archivo_encriptado
    
    # Verificar si el archivo existe
    if [ ! -f "$archivo_encriptado" ]; then
        echo "Error: El archivo '$archivo_encriptado' no existe."
        return 1
    fi
    
    # Extraer nombre base sin .gpg
    archivo_salida=$(basename "$archivo_encriptado" .gpg)
    
    # Capturar contraseña
    read -sp "Ingrese la contraseña para desencriptar: " password
    echo ""
    
    # Desencriptar con gpg
    if echo "$password" | gpg --batch --yes --passphrase-fd 0 --decrypt -o "$archivo_salida" "$archivo_encriptado" 2>/dev/null; then
        echo "✓ Archivo desencriptado correctamente como: $archivo_salida"
    else
        echo "✗ Error al desencriptar. Contraseña incorrecta o archivo dañado."
        return 1
    fi
}

# Programa principal
while true; do
    mostrar_menu
    read -p "Seleccione una opción (1-3): " opcion
    
    case $opcion in
        1)
            encriptar_archivo
            ;;
        2)
            desencriptar_archivo
            ;;
        3)
            echo "Saliendo del programa..."
            exit 0
            ;;
        *)
            echo "Opción no válida. Intente de nuevo."
            ;;
    esac
    
    echo ""
    read -p "Presione Enter para continuar..."
done