<?php

/*
 * This file is part of the ONGR package.
 *
 * (c) NFQ Technologies UAB <info@nfq.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace ONGR\OXIDConnectorBundle\Tests\Unit\Modifier;

use ONGR\ConnectionsBundle\Pipeline\Event\ItemPipelineEvent;
use ONGR\ConnectionsBundle\Pipeline\Item\ImportItem;
use ONGR\OXIDConnectorBundle\Entity\Attribute;
use ONGR\OXIDConnectorBundle\Entity\Category;
use ONGR\OXIDConnectorBundle\Entity\CategoryToAttribute;
use ONGR\OXIDConnectorBundle\Entity\Seo;
use ONGR\OXIDConnectorBundle\Modifier\AttributeModifier;
use ONGR\OXIDConnectorBundle\Modifier\UrlModifier;
use ONGR\OXIDConnectorBundle\Service\SeoFinder;

/**
 * Class AttributeModifierTest.
 */
class UrlModifierTest extends \PHPUnit_Framework_TestCase
{
    /**
     * @var SeoFinder|\PHPUnit_Framework_MockObject_MockObject
     */
    private $seoFinder;

    /**
     * @var AttributeModifier
     */
    private $modifier;

    /**
     * Set up services for tests.
     */
    protected function setUp()
    {
        $this->modifier = new UrlModifier();

        /** @var Seo|\PHPUnit_Framework_MockObject_MockObject $seo */
        $seo = $this->getMockForAbstractClass('ONGR\OXIDConnectorBundle\Entity\Seo');
        $seo->setSeoUrl('test');

        $this->seoFinder = $this->getMockBuilder('ONGR\OXIDConnectorBundle\Service\SeoFinder')
            ->disableOriginalConstructor()
            ->getMock();
        $this->seoFinder->expects($this->any())->method('getEntitySeo')->willReturn(new \ArrayIterator([$seo]));
        
        $this->modifier->setSeoFinderService($this->seoFinder);
    }

    /**
     * Test for modify().
     */
    public function testModify()
    {
        /** @var Category $root */
        $root = $this->getMockForAbstractClass('ONGR\OXIDConnectorBundle\Entity\Category');
        $root->setId('testIdRoot');

        /** @var Category $category */
        $category = $this->getMockForAbstractClass('ONGR\OXIDConnectorBundle\Entity\Category');

        // Attribute to be added to Category.
        $attribute = new Attribute();
        $attribute->setId(123);
        $attribute->setPos(1);
        $attribute->setTitle('testAttributeTitle');
        $catToAttr = new CategoryToAttribute();
        $catToAttr->setId(321);
        $catToAttr->setSort(1);
        $catToAttr->setCategory($category);
        $catToAttr->setAttribute($attribute);

        $category
            ->setId('testId')
            ->setActive(true)
            ->setHidden(false)
            ->setTitle('testTitle')
            ->setDesc('testDescription')
            ->setLongDesc('testLongDescription')
            ->setSort(3)
            ->setRoot($root)
            ->setRight(501)
            ->setLeft(102)
            ->addAttribute($catToAttr);

        $expectedDocument = [
            'urls' => [['url' => 'test']],
            'expired_urls' => [],
        ];

        $document = [];

        /** @var ItemPipelineEvent|\PHPUnit_Framework_MockObject_MockObject $event */
        $event = $this->getMock('ONGR\ConnectionsBundle\Pipeline\Event\ItemPipelineEvent', [], [], '', false);
        $event->method('getItem')->willReturn(
            new ImportItem($category, $document, 'ONGROXIDConnectorBundle:CategoryDocument')
        );

        $this->modifier->onModify($event);

        $this->assertEquals($expectedDocument, $event->getItem()->getDocument());
    }
}
