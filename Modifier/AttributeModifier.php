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
use ONGR\OXIDConnectorBundle\Service\AttributesToDocumentsService;

/**
 * Converts OXID attributes and adds them to ONGR document.
 */
class AttributeModifier extends AbstractImportModifyEventListener
{
    /**
     * @var AttributesToDocumentsService
     */
    private $attrToDocService;

    /**
     * Dependency injection.
     *
     * @param AttributesToDocumentsService $attrToDocService
     */
    public function __construct(AttributesToDocumentsService $attrToDocService = null)
    {
        $this->attrToDocService = $attrToDocService;
    }

    /**
     * {@inheritdoc}
     */
    protected function transform(array $document, $documentClass, $category)
    {
        $document['attributes'] = $this->getAttrToDocService()->transform($category->getAttributes());

        return $document;
    }

    /**
     * @return AttributesToDocumentsService
     */
    public function getAttrToDocService()
    {
        if ($this->attrToDocService === null) {
            throw new \LogicException('AttrToDocService must be set before using \'getAttrToDocService\'');
        }

        return $this->attrToDocService;
    }

    /**
     * @param AttributesToDocumentsService $attrToDocService
     *
     * @return $this
     */
    public function setAttrToDocService(AttributesToDocumentsService $attrToDocService)
    {
        $this->attrToDocService = $attrToDocService;

        return $this;
    }
}
