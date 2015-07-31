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
use ONGR\OXIDConnectorBundle\Entity\Category;
use ONGR\OXIDConnectorBundle\Entity\CategoryToAttribute;
use ONGR\OXIDConnectorBundle\Modifier\CategoryModifier;
use ONGR\OXIDConnectorBundle\Tests\Functional\AbstractTestCase;

/**
 * Tests if category modifier works as expected.
 */
class CategoryModifierTest extends AbstractTestCase
{
    /**
     * Test modification.
     */
    public function testModify()
    {
        $expectedCategories = [
            ['parent_id' => 'fad2d80baf7aca6ac54e819e066f24aa'],
            ['parent_id' => 'fad2d80baf7aca6ac54e819e066f24aa'],
        ];

        /** @var Category[] $categoryItems */
        $categoryItems = $this->getTestElements(
            ['fada9485f003c731b7fad08b873214e0', '0f41a4463b227c437f6e6bf57b1697c4'],
            'ONGROXIDConnectorBundleTest:Category'
        );
        $this->assertCount(2, $categoryItems);

        // Test if we have the correct attribute.
        /** @var CategoryToAttribute[] $categoryToAttribute */
        $categoryToAttribute = $categoryItems[0]->getAttributes();
        $this->assertEquals('testAttribute', $categoryToAttribute[0]->getAttribute()->getTitle());

        $modifier = new CategoryModifier();

        /** @var ItemPipelineEvent|\PHPUnit_Framework_MockObject_MockObject $event */
        $event = $this->getMock('ONGR\ConnectionsBundle\Pipeline\Event\ItemPipelineEvent', [], [], '', false);

        foreach ($expectedCategories as $key => $expectedCategory) {
            $event->method('getItem')->willReturn(
                new ImportItem($categoryItems[$key], [], 'ONGROXIDConnectorBundle:CategoryDocument')
            );
            $modifier->onModify($event);
            $this->assertEquals($expectedCategory, $event->getItem()->getDocument());
        }
    }
}
