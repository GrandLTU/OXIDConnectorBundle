<?php

/*
 *************************************************************************
 * NFQ eXtremes CONFIDENTIAL
 * [2013] - [2014] NFQ eXtremes UAB
 * All Rights Reserved.
 *************************************************************************
 * NOTICE: 
 * All information contained herein is, and remains the property of NFQ eXtremes UAB.
 * Dissemination of this information or reproduction of this material is strictly forbidden
 * unless prior written permission is obtained from NFQ eXtremes UAB.
 *************************************************************************
 */

namespace ONGR\OXIDConnectorBundle\Tests\Unit\DependencyInjection;

use ONGR\OXIDConnectorBundle\DependencyInjection\ONGROXIDConnectorExtension;
use Symfony\Component\DependencyInjection\ContainerBuilder;

class ONGROXIDConnectorExtensionTest extends \PHPUnit_Framework_TestCase
{
    /**
     * Returns sample configuration
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
                'entity_namespace' => 'AcmeDemoBundle'
            ],
        ];
    }

    /**
     * Data provider for triggerLoadingData()
     *
     * @return array
     */
    public function triggerLoadingData()
    {
        // #0 setting non-existent, default true should be loaded
        $config = $this->getDefaultConfig();
        $out [] = [$config, true];

        // #1 setting enabled, should be loaded
        $config = $this->getDefaultConfig();
        $config['ongr_oxid']['use_default_triggers'] = true;
        $out [] = [$config, true];

        // #2 set to false, shouldn't be loaded
        $config = $this->getDefaultConfig();
        $config['ongr_oxid']['use_default_triggers'] = false;
        $out [] = [$config, false];

        return $out;
    }


    /**
     * Test if triggers are loaded when needed
     *
     * @param array $config
     * @param boolean $shouldExist
     * @dataProvider triggerLoadingData()
     */
    public function testTriggerLoading($config, $shouldExist)
    {
        $container = new ContainerBuilder();
        $container->setParameter('ongr_connections.active_shop', 'alpha');

        $extension = new ONGROXIDConnectorExtension();
        $extension->load($config, $container);

        $this->assertEquals($shouldExist, $container->hasDefinition('ongr_oxid.triggers.oxarticles_insert'));
    }


    /**
     * Data provider for testSeoTriggerLoading()
     *
     * @return array
     */
    public function seoTriggerLoadingData()
    {
        // #0 setting non-existent, default true should be loaded
        $config = $this->getDefaultConfig();
        $out [] = [$config, true];

        // #1 setting enabled, should be loaded
        $config = $this->getDefaultConfig();
        $config['ongr_oxid']['use_seo_triggers'] = true;
        $out [] = [$config, true];

        // #2 set to false, shouldn't be loaded
        $config = $this->getDefaultConfig();
        $config['ongr_oxid']['use_seo_triggers'] = false;
        $out [] = [$config, false];

        return $out;
    }

    /**
     * Test if seo triggers are loaded when needed
     *
     * @param array $config
     * @param boolean $shouldExist
     * @dataProvider seoTriggerLoadingData()
     */
    public function testSeoTriggerLoading($config, $shouldExist)
    {
        $container = new ContainerBuilder();
        $container->setParameter('ongr_connections.active_shop', 'alpha');

        $extension = new ONGROXIDConnectorExtension();
        $extension->load($config, $container);

        $this->assertEquals($shouldExist, $container->hasDefinition('ongr_oxid.triggers.oxseo_insert'));
        $this->assertEquals($shouldExist, $container->hasDefinition('ongr_oxid.triggers.oxseo_data_insert'));
        $this->assertEquals($shouldExist, $container->hasDefinition('ongr_oxid.triggers.oxseo_history_insert'));
    }

    /**
     * Checks if expected definitions are loaded
     *
     * @param ContainerBuilder $container Initial container
     * @param array  $config   Configuration to load
     * @param string $expected Expected definition to load
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
     * Data provider for testServiceDefinition()
     *
     * @return array[]
     */
    public function getTestServiceDefinitionData()
    {
        $out = [];
        $defaultConfig = $this->getDefaultConfig();

        // Case #0: default config, DB mapping listener
        $container = new ContainerBuilder();
        $container->setParameter('ongr_connections.active_shop', 'alpha');
        $out[] = [$container, $defaultConfig, 'ongr_oxid.mapping_listener'];

        // Case #1: default config, product document modifier
        $container = new ContainerBuilder();
        $container->setParameter('ongr_connections.active_shop', 'alpha');
        $out[] = [$container, $defaultConfig, 'ongr_oxid.modifier.product'];

        return $out;
    }

    /**
     * Test if 'ongr_oxid.mapping_listener' is defined and has correct replacements
     */
    public function testMappingListenerDefinition()
    {
        $container = new ContainerBuilder();
        $container->setParameter('ongr_connections.active_shop', 'alpha');
        $emptyConfig = ['ongr_oxid' => ['database_mapping' => [], 'entity_namespace' => '']];

        $extension = new ONGROXIDConnectorExtension();
        $extension->load($emptyConfig, $container);

        $definition = $container->getDefinition('ongr_oxid.mapping_listener');
        $this->assertEquals(['@shop_tag' => '', '@lang_tag' => '', '{@view_tag}' => ''], $definition->getArgument(0));
    }

    /**
     * Test if 'ongr_oxid.modifier.product' is not defined when other names are set in configuration
     */
    public function testSkippedProductModifierDefinition()
    {
        $container = new ContainerBuilder();
        $container->setParameter('ongr_connections.active_shop', 'alpha');
        $config = $this->getDefaultConfig();
        $config['ongr_oxid']['modifiers'] = [null];

        $extension = new ONGROXIDConnectorExtension();
        $extension->load($config, $container);
        $this->assertFalse($container->hasDefinition('ongr_oxid.modifier.product'));
    }

    /**
     * Test if exception is thrown when user's configuration is incorrect
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
     * Test if exception is thrown when user's configuration is incorrect
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
     * Tests if it is possible to disable loading of modifiers
     *
     * @param ContainerBuilder  $container      Initial container
     * @param array             $config         Configuration to load
     * @param integer           $expectedCalls  Expected number of calls for 'loadModifiers' method
     *
     * @dataProvider getModifierLoadingData
     */
    public function testModifierLoading($container, $config, $expectedCalls)
    {
        $mock = $this->getMock('ONGR\OXIDConnectorBundle\DependencyInjection\ONGROXIDConnectorExtension', ['loadModifiers']);

        $mock->expects($this->exactly($expectedCalls))
             ->method('loadModifiers');

        $mock->load($config, $container);
    }

    /**
     * Data provider for testModifierLoading()
     *
     * @return array
     */
    public function getModifierLoadingData()
    {
        $out = [];

        $container = new ContainerBuilder();
        $container->setParameter('ongr_connections.active_shop', 'alpha');

        $config = $this->getDefaultConfig();

        // Case #0: with default config
        $out[] = [$container, $config, 1];

        // Case #1: with default config and 'use_modifiers' set to true
        $config['ongr_oxid']['use_modifiers'] = true;
        $out[] = [$container, $config, 1];

        // Case #2: with default config and 'use_modifiers' set to false
        $config['ongr_oxid']['use_modifiers'] = false;
        $out[] = [$container, $config, 0];

        return $out;
    }
}
