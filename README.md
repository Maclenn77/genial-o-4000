# G.E.N.I.A.L - O 4000 Telegram Bot Lambda Function

G.E.N.I.A.L.-O 4000 es un automatrón computarizado capaz de crear más de mil ideas de películas, ochociento de ellas con Adam Sandler de protagonista. 

Esta implementación funciona desde un un bot de Telegram ([@g_e_nialobot](https://web.telegram.org/k/#@g_e_nialobot)) que dispara eventos a una función Lambda de AWS. La LambdaFunction utiliza el entorno de ejecución Ruby 3.2 para alojar y ejecutar el bot..

## Estructura del Repositorio

- **/genial-o-4000**: Este es el directorio principal del repositorio.
- **lib**: Contiene los archivos necesarios para procesar el evento.
- **app.rb**: Contiene el código de la LambdaFunction en Ruby.
- **Gemfile**: Especifica las gemas de Ruby necesarias para la función.
- **README.md**: Este archivo que estás leyendo ahora.

## Configuración del Bot en Telegram

1. **Crear un bot en Telegram**:
   - Habla con el BotFather en Telegram para obtener un token para tu bot.

2. **Configurar el entorno de ejecución de Lambda**:
   - Asegúrate de configurar correctamente el entorno de ejecución en la consola de AWS Lambda para utilizar Ruby 3.2.

3. **Configurar variables de entorno**:
   - Añade una variable de entorno llamada `TELEGRAM_BOT_TOKEN` en la configuración de la Lambda, con el token proporcionado por BotFather.

## Cómo Implementar la LambdaFunction

1. **Crear la función Lambda**:
   - Crea una función Lambda en la consola de AWS y selecciona Ruby 3.2 como entorno de ejecución.

2. **Subir el código fuente**:
   - Sube el código del archivo `app.rb` y asegúrate de incluir los archivos `Gemfile` y `Gemfile.lock`, así como sus dependencias.

3. **Configurar los permisos**:
   - Asegúrate de que la función Lambda tenga los permisos necesarios para acceder a otros servicios de AWS si es requerido.

## Ejecutar el Bot

Una vez que la LambdaFunction esté configurada y lista, cada vez que se invoque, ejecutará el bot de Telegram G.E.N.I.A.L - O 4000 utilizando el token proporcionado. ¡Disfruta tu bot!

## Deploy

Esta función utilia el _Serverless Application Model Command Line Interface_ (SAM CLI), una extension del AWS CLI que añade funcionalidades al desarrollary probar aplicaciones Lambda. Utiliza Docker para correr las funciones en un ambiente Amazon Linux compatible con Lambda, puede también emular el ambiente de tu aplicación y API.

Para usar SAM CLI, requieres:

* SAM CLI - [Install the SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html)
* Ruby - [Install Ruby 3.2](https://www.ruby-lang.org/en/documentation/installation/)
* Docker - [Install Docker community edition](https://hub.docker.com/search/?type=edition&offering=community)

Para crear y hacer deploy de tu aplicación por primera vez:

```bash
sam build
sam deploy --guided
```
El primer comando construirá a partir del código de tu aplicación, el segund comando empaquetará y deployeará la aplicación a AWS, pidiéndote los siguientes datos.

* **Stack Name**: El nombre del stack para desplegar en CloudFormation. Debe ser único para tu cuenta y región. Un buen punto de partida sería algo que coincida con el nombre de tu proyecto.

* **Región de AWS (AWS Region)**: La región de AWS en la que deseas desplegar tu aplicación.

* **Confirmar cambios antes del despliegue (Confirm changes before deploy)**: Si se establece en sí (yes), cualquier conjunto de cambios se mostrará antes de la ejecución para su revisión manual. Si se establece en no (no), el AWS SAM CLI desplegará automáticamente los cambios en la aplicación.

* **Permitir la creación de roles IAM por SAM CLI (Allow SAM CLI IAM role creation)**: Muchas plantillas de AWS SAM, incluyendo este ejemplo, crean roles IAM de AWS necesarios para que la(s) función(es) de AWS Lambda incluidas accedan a los servicios de AWS. Por defecto, estos roles tienen permisos mínimos requeridos. Para desplegar una pila de AWS CloudFormation que cree o modifique roles IAM, se debe proporcionar el valor `CAPABILITY_IAM` para `capabilities`. Si no se otorga permiso a través de esta indicación, para desplegar este ejemplo, debes pasar explícitamente `--capabilities CAPABILITY_IAM` al comando `sam deploy`.

* **Guardar argumentos en samconfig.toml (Save arguments to samconfig.toml)**: Si se establece en sí (yes), tus elecciones se guardarán en un archivo de configuración dentro del proyecto, para que en el futuro solo tengas que volver a ejecutar `sam deploy` sin parámetros para desplegar cambios en tu aplicación.

Puedes encontrar la URL del punto de conexión de la API Gateway en los valores de salida mostrados después del despliegue.

## Usa el SAM CLI para construir y probar localmente

Construye tu aplicación con el comando `sam build`.

```bash
genial-o-4000$ sam build
```

Prueba tu función desde un ambiente local

```bash
genial-o-4000$ sam local invoke GenialoFunction --event events/event.json
```

La interfaz de SAM también puede emular tu api con `sam local start-api` para correrla localmente desde el puerto 3000.

```bash
genial-o-4000$ sam local start-api
genial-o-4000$ curl http://localhost:3000/
```
