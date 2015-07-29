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
use ONGR\OXIDConnectorBundle\Entity\Category;

/**
 * Converts OXID category to ONGR category document.
 */
class CategoryModifier extends AbstractImportModifyEventListener
{
    /**
     * {@inheritdoc}
     */
    protected function transform(array $document, $documentClass, $category)
    {
        /** @var Category $category */
        if (!($category instanceof Category)) {
            throw new \InvalidArgumentException('Invalid category provided');
        }

        $parent = $category->getParent();
        $parentId = $parent ? $parent->getId() : null;
        if (empty($parentId) === false) {
            $document['parent_id'] = $parentId;
        } else {
            $document['parent_id'] = 'oxrootid';
        }

        return $document;
    }
}
