<?php

namespace App\Command;

use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Process\Process;

class JavaScriptScraperCommand extends Command
{
    protected static $defaultName = 'scraper:puppeteer';

    protected function configure()
    {
        $this->setDescription('Scrape a website with JavaScript rendering');
    }

    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $script = __DIR__ . '/../../scripts/scraper.js';

        $url = 'https://rekvizitai.vz.lt/en/company-search/1/';

        // Use Puppeteer to render JavaScript content
        $process = new Process([
            'node',
            $script, // Create a separate JS file to interact with Puppeteer
            $url,
        ]);

        // Run the Puppeteer script
        $process->run();
        dd($process->getErrorOutput());

        // Get the output of the Puppeteer script
        $output->writeln($process->getOutput());
    }
}
