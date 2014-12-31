<?php

/*
* This file is part of the ONGR package.
*
* (c) NFQ Technologies UAB <info@nfq.com>
*
* For the full copyright and license information, please view the LICENSE
* file that was distributed with this source code.
*/

namespace ONGR\OXIDConnectorBundle\Tests\Functional;

use Doctrine\Common\Annotations\AnnotationRegistry;
use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;
use Symfony\Component\Console\Helper\ProgressHelper;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\DependencyInjection\ContainerInterface;
use Symfony\Bridge\Doctrine\RegistryInterface;
use Doctrine\ORM\EntityManager;
use Doctrine\DBAL\Connection;
use Doctrine\DBAL\DriverManager;

/**
 * Class TriggerConfigTestBase.
 */
abstract class TriggerConfigTestBase extends WebTestCase
{
    /**
     * @var ContainerInterface
     */
    protected $container;

    /**
     * Return a progress helper for testing.
     *
     * @return ProgressHelper
     */
    protected function getProgressHelper()
    {
        $helper = new ProgressHelper();

        return $helper;
    }

    /**
     * Gets mock for output interface, used in testing.
     *
     * @return \PHPUnit_Framework_MockObject_MockObject|OutputInterface
     */
    protected function getConsoleOutput()
    {
        /** @var \PHPUnit_Framework_MockObject_MockObject|OutputInterface $output */
        $output = $this->getMock('Symfony\\Component\\Console\\Output\\OutputInterface');

        return $output;
    }

    /**
     * Compares two sets of records.
     *
     * @param array $expectedRecord
     * @param array $actualRecords
     */
    public function compareRecords(array $expectedRecord, array $actualRecords)
    {
        // Unset the timestamp, after asserting it exists, we don't need to compare it.
        foreach ($actualRecords as &$actualRecord) {
            $this->assertArrayHasKey('timestamp', $actualRecord);
            unset($actualRecord['timestamp']);
        }

        $this->assertEquals($expectedRecord, $actualRecords);
    }

    /**
     * Sets up required info before each test.
     */
    public function setUp()
    {
        AnnotationRegistry::registerFile(
            getcwd() . '/vendor/doctrine/orm/lib/Doctrine/ORM/Mapping/Driver/DoctrineAnnotations.php'
        );
        $container = self::createClient()->getContainer();

        $connection = DriverManager::getConnection(
            [
                'driver' => $container->getParameter('database_driver'),
                'host' => $container->getParameter('database_host'),
                'port' => $container->getParameter('database_port'),
                'user' => $container->getParameter('database_user'),
                'password' => $container->getParameter('database_password'),
                'charset' => 'UTF8',
            ]
        );
        $connection->getSchemaManager()->dropAndCreateDatabase($container->getParameter('database_name'));

        self::executeSqlFile($connection, self::getRootDir($container) . '/data/database.sql');
        self::executeSqlFile($connection, self::getRootDir($container) . '/data/dummyData.sql');

        $connection->close();
    }

    /**
     * Deletes  all data after each test.
     */
    public function tearDown()
    {
        /** @var EntityManager $entityManager */
        $entityManager = $this->getEntityManager();
        $connection = $entityManager->getConnection();
        $name = $connection->getParams()['dbname'];
        $name = $connection->getSchemaManager()->getDatabasePlatform()->quoteSingleIdentifier($name);
        $connection->getSchemaManager()->dropDatabase($name);
    }

    /**
     * Gets entity manager.
     *
     * @return EntityManager
     */
    public function getEntityManager()
    {
        return $this->getServiceContainer()->get('doctrine')->getManager();
    }

    /**
     * Imports sql file for testing.
     *
     * @param string $file
     */
    public function importData($file)
    {
        $this->executeSqlFile($this->getConnection(), getcwd() . '/Tests/Functional/Fixtures/' . $file);
    }

    /**
     * Returns service container, creates new if it does not exist.
     *
     * @return ContainerInterface
     * @throws \Exception
     */
    protected function getServiceContainer()
    {
        if ($this->container) {
            return $this->container;
        }

        try {
            $this->container = self::createClient()->getContainer();

        } catch (\Exception $e) {
            echo $e->getMessage();
        }

        return $this->container;
    }

    /**
     * Gets Connection from container.
     *
     * @return Connection
     */
    protected function getConnection()
    {
        /** @var $doctrine RegistryInterface */
        $doctrine = $this->getServiceContainer()->get('doctrine');

        return $doctrine->getConnection();
    }

    /**
     * Executes an SQL file.
     *
     * @param Connection $conn
     * @param string     $file
     */
    protected function executeSqlFile(Connection $conn, $file)
    {
        $sql = file_get_contents($file);
        $stmt = $conn->prepare($sql);
        $stmt->execute();
    }

    /**
     * Return full path to kernel root dir.
     *
     * @param ContainerInterface $container
     *
     * @return string
     */
    public static function getRootDir($container)
    {
        return $container->get('kernel')->getRootDir();
    }
}
