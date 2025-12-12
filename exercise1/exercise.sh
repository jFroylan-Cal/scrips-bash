
echo "Ingrese la ruta del directorio:"
read file


if [ ! -d "$file" ]; then
    echo "Error: El directorio '$file' no existe."
    exit 1
fi

cd "$file" || exit 1

echo "Ingrese el prefijo"
read prefix

if [ ${#prefix} -ne 3 ]; then
    echo "Error: El prefijo debe tener 3 caracteres."
    exit 1
fi

for file in *; do
    if [ -f "$file" ]; then
        mv "$file" "$prefix$file"
    fi
done

echo "Todos los archivos fueron renombrados con el prefijo $prefix."