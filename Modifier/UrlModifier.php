<?php

/*
 * This file is part of the ONGR package.
 *
 * (c) NFQ Technologies UAB <info@nfq.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace ONGR\OXIDConnectorBundle\Modifier;

use ONGR\ConnectionsBundle\EventListener\AbstractImportModifyEventListener;
use ONGR\OXIDConnectorBundle\Entity\Seo;
use ONGR\OXIDConnectorBundle\Service\SeoFinder;

/**
 * Converts OXID urls and adds them to ONGR document.
 */
class UrlModifier extends AbstractImportModifyEventListener
{
    /**
     * @var int
     */
    private $languageId;

    /**
     * @var SeoFinder
     */
    private $seoFinderService;

    /**
     * @param SeoFinder $seoFinderService
     * @param int       $languageId
     */
    public function __construct(SeoFinder $seoFinderService = null, $languageId = 0)
    {
        $this->seoFinderService = $seoFinderService;
        $this->languageId = $languageId;
    }

    /**
     * @param SeoFinder $seoFinderService
     *
     * @return $this
     */
    public function setSeoFinderService(SeoFinder $seoFinderService)
    {
        $this->seoFinderService = $seoFinderService;

        return $this;
    }

    /**
     * @return SeoFinder
     */
    public function getSeoFinderService()
    {
        if ($this->seoFinderService === null) {
            throw new \LogicException('SeoFinderService must be set before using \'getSeoFinderService\'');
        }

        return $this->seoFinderService;
    }

    /**
     * @param int $languageId
     *
     * @return $this
     */
    public function setLanguageId($languageId)
    {
        $this->languageId = $languageId;

        return $this;
    }

    /**
     * @return int
     */
    public function getLanguageId()
    {
        return $this->languageId;
    }

    /**
     * Extract category seo urls.
     *
     * @param mixed $entity
     *
     * @return array
     */
    private function extractUrls($entity)
    {
        $urls = [];
        $seoUrls = $this->getSeoFinderService()->getEntitySeo($entity, $this->getLanguageId());
        if (count($seoUrls) > 0) {
            foreach ($seoUrls as $seo) {
                /** @var Seo $seo */
                $urls[]['url'] = $seo->getSeoUrl();
            }
        }

        return $urls;
    }

    /**
     * {@inheritdoc}
     */
    protected function transform(array $document, $documentClass, $entity)
    {
        $document['urls'] = $this->extractUrls($entity);
        $document['expired_urls'] = [];

        return $document;
    }
}
