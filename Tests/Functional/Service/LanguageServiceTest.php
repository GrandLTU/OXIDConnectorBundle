<?php

/*
 * This file is part of the ONGR package.
 *
 * (c) NFQ Technologies UAB <info@nfq.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace ONGR\OXIDConnectorBundle\Tests\Functional\Service;

use ONGR\OXIDConnectorBundle\Service\LanguageService;
use Symfony\Bundle\FrameworkBundle\Test\KernelTestCase;

/**
 * Class ShopServiceTest.
 */
class LanguageServiceTest extends KernelTestCase
{
    /**
     * Tests Shop service.
     */
    public function testService()
    {
        static::bootKernel();
        $container = static::$kernel->getContainer();
        /** @var LanguageService $service */
        $service = $container->get('ongr_oxid.language_service');
        $this->assertInstanceOf('ONGR\OXIDConnectorBundle\Service\LanguageService', $service);
        $this->assertEquals(0, $service->getShopLanguage('test'));
        $this->assertEquals(0, $service->getActiveShopLanguage());
    }
}
