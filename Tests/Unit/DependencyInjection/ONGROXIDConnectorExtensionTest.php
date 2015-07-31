<?php

/*
 * This file is part of the ONGR package.
 *
 * (c) NFQ Technologies UAB <info@nfq.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace ONGR\OXIDConnectorBundle\Tests\Unit\DependencyInjection;

use ONGR\OXIDConnectorBundle\DependencyInjection\ONGROXIDConnectorExtension;
use Symfony\Component\DependencyInjection\ContainerBuilder;

class ONGROXIDConnectorExtensionTest extends \PHPUnit_Framework_TestCase
{
    /**
     * Returns sample configuration.
     *
     * @return array
     */
    protected function getDefaultConfig()
    {
        return [
            'ongr_oxid' => [
                'database_mapping' => [
                    'alpha' => [
                        'tags' => [
                            '@shop_tag' => '_1',
                            '@lang_tag' => '_1_en',
                        ],
                        'shop_id' => 1,
                        'lang_id' => 0,
                    ],
                    'beta' => [
                        'tags' => [
                            '@shop_tag' => '_2',
                            '@lang_tag' => '_2_en',
                        ],
                        'shop_id' => 1,
                        'lang_id' => 0,
                    ],
                ],
            ],
        ];
    }

    /**
     * Data provider for relationLoadingData().
     *
     * @return array
     */
    public function relationLoadingData()
    {
        // Case #0 setting non-existent, default true should be loaded.
        $config = $this->getDefaultConfig();
        $out[] = [$config, true];

        // Case #1 setting enabled, should be loaded.
        $config = $this->getDefaultConfig();
        $config['ongr_oxid']['use_default_relations'] = true;
        $out[] = [$config, true];

        // Case #2 set to false, shouldn't be loaded.
        $config = $this->getDefaultConfig();
        $config['ongr_oxid']['use_default_relations'] = false;
        $out[] = [$config, false];

        return $out;
    }

    /**
     * Test if relations are loaded when needed.
     *
     * @param array $config
     * @param bool  $shouldExist
     *
     * @dataProvider relationLoadingData()
     */
    public function testRelationLoading($config, $shouldExist)
    {
        $container = new ContainerBuilder();
        $container->setParameter('ongr_connections.active_shop', 'alpha');

        $extension = new ONGROXIDConnectorExtension();
        $extension->load($config, $container);

        $this->assertEquals($shouldExist, $container->hasDefinition('ongr_oxid.relations.oxarticles_insert'));
    }

    /**
     * Checks if expected definitions are loaded.
     *
     * @param ContainerBuilder $container Initial container.
     * @param array            $config    Configuration to load.
     * @param string           $expected  Expected definition to load.
     *
     * @dataProvider getTestServiceDefinitionData()
     */
    public function testServiceDefinition($container, $config, $expected)
    {
        $extension = new ONGROXIDConnectorExtension();
        $extension->load($config, $container);
        $this->assertTrue($container->hasDefinition($expected));
    }

    /**
     * Data provider for testServiceDefinition().
     *
     * @return array[]
     */
    public function getTestServiceDefinitionData()
    {
        $out = [];
        $defaultConfig = $this->getDefaultConfig();

        // Case #0: default config, DB mapping listener.
        $container = new ContainerBuilder();
        $container->setParameter('ongr_connections.active_shop', 'alpha');
        $out[] = [$container, $defaultConfig, 'ongr_oxid.mapping_listener'];

        return $out;
    }

    /**
     * Test if 'ongr_oxid.mapping_listener' is defined and has correct replacements.
     */
    public function testMappingListenerDefinition()
    {
        $container = new ContainerBuilder();
        $container->setParameter('ongr_connections.active_shop', 'alpha');
        $emptyConfig = ['ongr_oxid' => ['database_mapping' => []]];

        $extension = new ONGROXIDConnectorExtension();
        $extension->load($emptyConfig, $container);

        $definition = $container->getDefinition('ongr_oxid.mapping_listener');
        $this->assertEquals(['@shop_tag' => '', '@lang_tag' => '', '{@view_tag}' => ''], $definition->getArgument(0));
    }

    /**
     * Test if exception is thrown when user's configuration is incorrect.
     *
     * @expectedException \LogicException
     * @expectedExceptionMessage Database mapping is defined but active shop ID is not set
     */
    public function testIncorrectConfigException()
    {
        $container = new ContainerBuilder();
        $container->setParameter('ongr_connections.active_shop', null);
        $config = $this->getDefaultConfig();

        $extension = new ONGROXIDConnectorExtension();
        $extension->load($config, $container);
    }

    /**
     * Test if exception is thrown when user's configuration is incorrect.
     *
     * @expectedException \LogicException
     * @expectedExceptionMessage Active shop is set to 'gama' but no DB mapping is defined for it
     */
    public function testIncorrectConfigException2()
    {
        $container = new ContainerBuilder();
        $container->setParameter('ongr_connections.active_shop', 'gama');
        $config = $this->getDefaultConfig();

        $extension = new ONGROXIDConnectorExtension();
        $extension->load($config, $container);
    }

    /**
     * Test extension alias.
     */
    public function testExtensionAlias()
    {
        $extension = new ONGROXIDConnectorExtension();
        $this->assertEquals('ongr_oxid', $extension->getAlias());
    }
}
