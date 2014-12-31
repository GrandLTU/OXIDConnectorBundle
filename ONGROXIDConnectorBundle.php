<?php

/*
* This file is part of the ONGR package.
*
* (c) NFQ Technologies UAB <info@nfq.com>
*
* For the full copyright and license information, please view the LICENSE
* file that was distributed with this source code.
*/

namespace ONGR\OXIDConnectorBundle;

use ONGR\OXIDConnectorBundle\DependencyInjection\ONGROXIDConnectorExtension;
use Symfony\Component\HttpKernel\Bundle\Bundle;

/**
 * Class ONGROXIDConnectorBundle.
 *
 * @package ONGR\OXIDConnectorBundle
 */
class ONGROXIDConnectorBundle extends Bundle
{
    /**
     * @return null|ONGROXIDConnectorExtension|\Symfony\Component\DependencyInjection\Extension\ExtensionInterface
     */
    public function getContainerExtension()
    {
        return new ONGROXIDConnectorExtension();
    }
}
