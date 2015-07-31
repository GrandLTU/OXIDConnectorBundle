<?php

/*
 * This file is part of the ONGR package.
 *
 * (c) NFQ Technologies UAB <info@nfq.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace ONGR\OXIDConnectorBundle\Service;

use ONGR\ConnectionsBundle\Service\ShopService;

/**
 * Class LanguageService.
 */
class LanguageService
{
    /**
     * @param ShopService $shopService
     * @param array       $mapping
     */
    public function __construct(ShopService $shopService, $mapping)
    {
        $this->shopService = $shopService;
        $this->mapping = $mapping;
    }

    /**
     * @return int
     */
    public function getActiveShopLanguage()
    {
        return $this->getShopLanguage($this->shopService->getActiveShop());
    }

    /**
     * @param string $shop
     *
     * @return int
     */
    public function getShopLanguage($shop)
    {
        if (!isset($this->mapping[$shop]['lang_id'])) {
            return null;
        }

        return $this->mapping[$shop]['lang_id'];
    }
}
