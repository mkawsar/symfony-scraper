## Attendance And Report Application

Web application scraper with symfony

### Setup With Docker
* Clone the repository [Repo](https://github.com/mkawsar/symfony-scraper.git)
* Build the docker images and container with following the command
    * Go to the project directory `cd {projectDir}`
    ```bash
    docker-compose up --build -d
    ```

* Run the following the command for project server run

    ```bash
    docker-compose run --rm application composer install
    ```

    ```bash
    docker-compose run --rm application cp .env.example .env
    ```
    ```bash
    docker-compose run --rm application php bin/console scraper:puppeteer
    ```
* .env file update for database connection

## Support

If you have any questions or confusion please email me at **mkawsarahmed@outlook.com** or open an issue in the repository.