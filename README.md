# G.E.N.I.A.L - O 4000 Telegram Bot Lambda Function

Esta LambdaFunction utiliza el entorno de ejecución Ruby 3.2 para alojar y ejecutar el bot de Telegram G.E.N.I.A.L - O 4000.

## Estructura del Repositorio

- **/genial-o-4000**: Este es el directorio principal del repositorio.
- **lambda_function.rb**: Contiene el código de la LambdaFunction en Ruby.
- **Gemfile**: Especifica las gemas de Ruby necesarias para la función.
- **Gemfile.lock**: Bloquea las versiones de las gemas para garantizar la consistencia.
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
   - Sube el código del archivo `lambda_function.rb` y asegúrate de incluir los archivos `Gemfile` y `Gemfile.lock`.

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

The SAM CLI installs dependencies defined in `hello_world/Gemfile`, creates a deployment package, and saves it in the `.aws-sam/build` folder.

Test a single function by invoking it directly with a test event. An event is a JSON document that represents the input that the function receives from the event source. Test events are included in the `events` folder in this project.

Run functions locally and invoke them with the `sam local invoke` command.

```bash
genial-o-4000$ sam local invoke HelloWorldFunction --event events/event.json
```

The SAM CLI can also emulate your application's API. Use the `sam local start-api` to run the API locally on port 3000.

```bash
ruby-serverless-openai$ sam local start-api
ruby-serverless-openai$ curl http://localhost:3000/
```

The SAM CLI reads the application template to determine the API's routes and the functions that they invoke. The `Events` property on each function's definition includes the route and method for each path.

```yaml
      Events:
        HelloWorld:
          Type: Api
          Properties:
            Path: /hello
            Method: get
```

## Add a resource to your application
The application template uses AWS Serverless Application Model (AWS SAM) to define application resources. AWS SAM is an extension of AWS CloudFormation with a simpler syntax for configuring common serverless application resources such as functions, triggers, and APIs. For resources not included in [the SAM specification](https://github.com/awslabs/serverless-application-model/blob/master/versions/2016-10-31.md), you can use standard [AWS CloudFormation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html) resource types.

## Fetch, tail, and filter Lambda function logs

To simplify troubleshooting, SAM CLI has a command called `sam logs`. `sam logs` lets you fetch logs generated by your deployed Lambda function from the command line. In addition to printing the logs on the terminal, this command has several nifty features to help you quickly find the bug.

`NOTE`: This command works for all AWS Lambda functions; not just the ones you deploy using SAM.

```bash
ruby-serverless-openai$ sam logs -n HelloWorldFunction --stack-name ruby-serverless-openai --tail
```

You can find more information and examples about filtering Lambda function logs in the [SAM CLI Documentation](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-logging.html).

## Unit tests

Tests are defined in the `tests` folder in this project.

```bash
ruby-serverless-openai$ ruby tests/unit/test_handler.rb
```

## Cleanup

To delete the sample application that you created, use the AWS CLI. Assuming you used your project name for the stack name, you can run the following:

```bash
sam delete --stack-name ruby-serverless-openai
```

## Resources

See the [AWS SAM developer guide](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html) for an introduction to SAM specification, the SAM CLI, and serverless application concepts.

Next, you can use AWS Serverless Application Repository to deploy ready to use Apps that go beyond hello world samples and learn how authors developed their applications: [AWS Serverless Application Repository main page](https://aws.amazon.com/serverless/serverlessrepo/)
