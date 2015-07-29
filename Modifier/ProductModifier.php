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

use Doctrine\ORM\EntityNotFoundException;
use ONGR\ConnectionsBundle\EventListener\AbstractImportModifyEventListener;
use ONGR\ConnectionsBundle\Pipeline\Event\ItemPipelineEvent;
use ONGR\ConnectionsBundle\Pipeline\Item\AbstractImportItem;
use ONGR\ConnectionsBundle\Pipeline\ItemSkipper;
use ONGR\OXIDConnectorBundle\Entity\Article;
use ONGR\OXIDConnectorBundle\Entity\ObjectToCategory;

/**
 * Converts OXID article to ONGR product document.
 */
class ProductModifier extends AbstractImportModifyEventListener
{
    /**
     * {@inheritdoc}
     */
    public function modify(AbstractImportItem $eventItem, ItemPipelineEvent $event)
    {
        /** @var Article $article */
        $article = $eventItem->getEntity();

        $parent = $article->getParent();
        if ($parent && $parent->getId()) {
            ItemSkipper::skip($event, 'Ignore item variants');

            return;
        }

        parent::modify($eventItem, $event);
    }

    /**
     * {@inheritdoc}
     */
    protected function transform(array $document, $documentClass, $article)
    {
        if (!($article instanceof Article)) {
            throw new \InvalidArgumentException('Invalid article provided');
        }

        $document['long_description'] = $this->extractExtensionData($article);
        $document['vendor'] = $this->extractVendor($article);
        $document['manufacturer'] = $this->extractManufacturer($article);
        $document['categories'] = $this->extractCategories($article);
        $document['variants'] = $this->extractVariants($article);

        return $document;
    }

    /**
     * Retrieves article extension data.
     *
     * @param Article $entity
     *
     * @return null|string
     */
    protected function extractExtensionData(Article $entity)
    {
        try {
            return $entity->getExtension()->getLongDesc();
        } catch (EntityNotFoundException $exception) {
            return null;
        }
    }

    /**
     * Retrieves vendor title.
     *
     * @param Article $entity
     *
     * @return null|string
     */
    protected function extractVendor(Article $entity)
    {
        try {
            return $entity->getVendor()->getTitle();
        } catch (EntityNotFoundException $exception) {
            return null;
        }
    }

    /**
     * Retrieves manufacturer title.
     *
     * @param Article $entity
     *
     * @return null|string
     */
    protected function extractManufacturer(Article $entity)
    {
        try {
            return $entity->getManufacturer()->getTitle();
        } catch (EntityNotFoundException $exception) {
            return null;
        }
    }

    /**
     * Converts Article categories to Product categories.
     *
     * @param Article $entity
     *
     * @return array
     */
    protected function extractCategories(Article $entity)
    {
        $categories = [];

        try {
            /** @var ObjectToCategory $relation */
            foreach ($entity->getCategories() as $relation) {
                if ($relation->getCategory()->isActive()) {
                    $categories[] = $relation->getCategory()->getId();
                }
            }
        } catch (EntityNotFoundException $exception) {
            // No categories. Just ignore.
        }

        return $categories;
    }

    /**
     * Converts Article variants to Product model variants.
     *
     * @param Article $entity
     *
     * @return array
     */
    protected function extractVariants(Article $entity)
    {
        $variantDocuments = [];
        $variants = $entity->getVariants();
        if (!$variants) {
            return $variantDocuments;
        }

        foreach ($variants as $variant) {
            $variantDocuments[] = [
                '_id' => $variant->getId(),
                'active' => $variant->isActive(),
                'sku' => $variant->getArtNum(),
                'title' => $variant->getTitle(),
                'description' => $variant->getShortDesc(),
                'price' => $variant->getPrice(),
                'old_price' => $variant->getTPrice(),
                'stock' => $variant->getStock(),
                'long_description' => $this->extractExtensionData($variant),
            ];
        }

        return $variantDocuments;
    }
}
