<?php

/*
 * This file is part of the ONGR package.
 *
 * (c) NFQ Technologies UAB <info@nfq.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace ONGR\OXIDConnectorBundle\Tests\Functional\Modifier;

use ONGR\ConnectionsBundle\Pipeline\Event\ItemPipelineEvent;
use ONGR\ConnectionsBundle\Pipeline\Item\ImportItem;
use ONGR\OXIDConnectorBundle\Modifier\ProductModifier;
use ONGR\OXIDConnectorBundle\Tests\Functional\AbstractTestCase;

/**
 * Tests if product modifier works as expected.
 */
class ProductModifierTest extends AbstractTestCase
{
    /**
     * Test modification.
     */
    public function testModify()
    {
        $productItems = $this->getTestElements(
            ['6b698c33118caee4ca0882c33f513d2f', '6b6a6aedca3e438e98d51f0a5d586c0b'],
            'ONGROXIDConnectorBundleTest:Article'
        );
        $this->assertCount(2, $productItems);

        $modifier = new ProductModifier();

        /** @var ItemPipelineEvent|\PHPUnit_Framework_MockObject_MockObject $event */
        $event = $this->getMock('ONGR\ConnectionsBundle\Pipeline\Event\ItemPipelineEvent', [], [], '', false);

        $expectedEntities = [
            [
                'long_description' => null,
                'vendor' => null,
                'manufacturer' => null,
                'categories' => [],
                'variants' => [
                    [
                        '_id' => '6b6a6aedca3e438e98d51f0a5d586c0b',
                        'active' => false,
                        'sku' => '0702-85-853-9-2',
                        'title' => 'PRODUCT NO. 2',
                        'description' => 'Product number two for testing',
                        'price' => 46.6,
                        'old_price' => 35.7,
                        'stock' => 2,
                        'long_description' => 'Product number two description for testing from extension',
                    ],
                ],
            ],
        ];
        foreach ($expectedEntities as $key => $expectedProduct) {
            $event->method('getItem')->willReturn(
                new ImportItem($productItems[$key], [], 'ONGROXIDConnectorBundle:ProductDocument')
            );
            $modifier->onModify($event);
            $this->assertEquals($expectedProduct, $event->getItem()->getDocument());
        }
    }
}
